//
//  GetContacts.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 10/16/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "GetContacts.h"
#import "UserInfo.h"
#import "Util.h"
#import "JSON.h"
#import "BDSiOSConstant.h"
#import "ASIHTTPRequest.h"
#import "PageViewController.h"

@implementation GetContacts

@synthesize request, returnList;

extern UserInfo *userInfo;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        returnList = nil;
    }
    
    return self;
}

- (void)getContacts
{
    @try
    {
        NSMutableString *url = [Util buildUrl: [userInfo getServerName] : @"/getUserContacts" : [userInfo isUseSSL]];
        
        [request cancel];
        [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
        [request setRequestMethod: @"POST"];
        [request setPostValue:[userInfo getSessionId] forKey:@"sessionId"];
        [request setTimeOutSeconds:20];
        
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setDelegate:self];
        [request setDidFailSelector:@selector(getContactsFailed:)];
        [request setDidFinishSelector:@selector(getContactsFinished:)];
        
        [request startSynchronous];
    }
    @catch (NSException *exception)
    {
        NSLog(@"An error occured while trying to get contacts; %@: %@", [exception name], [exception reason]);
    }
}

- (void)getContactsFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Error: %@", theRequest.error);
}

- (void)getContactsFinished:(ASIHTTPRequest *)theRequest
{
    NSString *responseStr = theRequest.responseString;
    NSDictionary *responseDictionary = [responseStr JSONValue];
    NSString *returnCode = [responseDictionary objectForKey:@"returnCode"];
    
    if( [returnCode isEqualToString:@"0"] )
    {
        returnList = [responseDictionary objectForKey:@"contactVOs"];
    }
    else
    {
        if(returnCode.intValue == RC_SESSION_TIME_OUT)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error occured while trying to signin" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Getting contacts was not successful." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end

