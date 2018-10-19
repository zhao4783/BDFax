//
//  AddContact.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 10/16/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "AddContact.h"
#import "UserInfo.h"
#import "Util.h"
#import "JSON.h"
#import "BDSiOSConstant.h"
#import "ASIHTTPRequest.h"
#import "PageViewController.h"

@implementation AddContact

@synthesize request;

extern UserInfo *userInfo;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)addContactWithName:(NSString *)name address:(NSString *)address company:(NSString *)company
{
    @try
    {
        name = [name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
        NSArray *arr = [name componentsSeparatedByString:@" "];
        NSString *firstName = [arr firstObject];
        NSString *lastNamr = [arr count] <= 1 ? @"" : [arr lastObject];
        NSString *email = [sendPage isEmailAddres:address] ? address : @"";
        NSString *fax = [sendPage isFaxNumber:address] ? address : @"";
        NSMutableString *url = [Util buildUrl: [userInfo getServerName] : @"/addContact" : [userInfo isUseSSL]];
        
        [request cancel];
        [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
        [request setRequestMethod: @"POST"];
        [request setPostValue:[userInfo getSessionId] forKey:@"sessionId"];
        [request setPostValue:firstName forKey:@"firstName"];
        [request setPostValue:lastNamr forKey:@"lastName"];
        [request setPostValue:company forKey:@"company"];
        [request setPostValue:email forKey:@"emailAddress"];
        [request setPostValue:fax forKey:@"faxNumber"];
        [request setTimeOutSeconds:20];
        
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setDelegate:self];
        [request setDidFailSelector:@selector(addContactFailed:)];
        [request setDidFinishSelector:@selector(addContactFinished:)];
        
        [request startSynchronous];
    }
    @catch (NSException *exception)
    {
        NSLog(@"An error occured while trying to add a contact; %@: %@", [exception name], [exception reason]);
    }
}

- (void)addContactFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Error: %@", theRequest.error);
}

- (void)addContactFinished:(ASIHTTPRequest *)theRequest
{
    NSString *responseStr = theRequest.responseString;
    NSDictionary *responseDictionary = [responseStr JSONValue];
    NSString *returnCode = [responseDictionary objectForKey:@"returnCode"];
    
    if( [returnCode isEqualToString:@"0"] )
    {
        [sendPage performSelector:@selector(resetContactList:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.1];
    }
    else
    {
        NSLog(@"Adding contact was not successful; returnCode: %@", returnCode);
    }
}

@end

