//
//  DeleteContacts.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 10/16/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "DeleteContacts.h"
#import "UserInfo.h"
#import "Util.h"
#import "JSON.h"
#import "BDSiOSConstant.h"
#import "ASIHTTPRequest.h"
#import "PageViewController.h"

@implementation DeleteContact

@synthesize request;

extern UserInfo *userInfo;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        bEnd = NO;
    }
    
    return self;
}

- (void)deleteContact:(NSString *)contactId
{
    @try
    {
        NSMutableString *url = [Util buildUrl: [userInfo getServerName] : @"/deleteContact" : [userInfo isUseSSL]];
        
        [request cancel];
        [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
        [request setRequestMethod: @"POST"];
        [request setPostValue:[userInfo getSessionId] forKey:@"sessionId"];
        [request setPostValue:contactId forKey:@"contactId"];
        [request setTimeOutSeconds:20];
        
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setDelegate:self];
        [request setDidFailSelector:@selector(deleteContactFailed:)];
        [request setDidFinishSelector:@selector(deleteContactFinished:)];
        
        [request startSynchronous];
    }
    @catch (NSException *exception)
    {
        NSLog(@"An error occured while trying to delete a contact; %@: %@", [exception name], [exception reason]);
    }
}

- (void)deleteContactFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Error: %@", theRequest.error);
    bEnd = YES;
}

- (void)deleteContactFinished:(ASIHTTPRequest *)theRequest
{
    NSString *responseStr = theRequest.responseString;
    NSDictionary *responseDictionary = [responseStr JSONValue];
    NSString *returnCode = [responseDictionary objectForKey:@"returnCode"];
    
    if( [returnCode isEqualToString:@"0"] )
    {
        NSLog(@"Successfully deleting a contact.");
    }
    else
    {
        NSLog(@"Deleting contact was not successful; returnCode: %@", returnCode);
    }
    bEnd = YES;
}

@end

