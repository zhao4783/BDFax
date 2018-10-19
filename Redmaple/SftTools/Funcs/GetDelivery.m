/*
 * Copyright (c) 2012 Biscom, Inc.
 * Chelmsford, MA, 01824 U.S.A.
 * All rights reserved.
 *
 * This source code is considered Confidential Information and
 * property of Biscom, Inc. This source code may not be copied,
 * shared, distributed, or used in any other software application
 * or derivative work without the express written permission
 * from Biscom, Inc.
 * This header must be included in all source code that contains
 * any or all of the code or documentation included in this file.
 * You agree not to remove this proprietary rights legend from
 * this or any derivative source code file. Any derivative source
 * code file that contains any or all of the source code contained
 * in this file, whether or not this legend appears in such
 * derivative source code file, shall remain the exclusive property
 * of Biscom, Inc. and shall be treated as Confidential Information.
 */

#import "GetDelivery.h"
#import "UserInfo.h"
#import "Util.h"
#import "JSON.h"
#import "BDSiOSConstant.h"
#import "ASIHTTPRequest.h"

@implementation GetDelivery

@synthesize request;

DeliveryVO *delV;
extern UserInfo *userInfo;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithDeliveryVO: (DeliveryVO*) deliveryVO :(id) delegate
{
    self = [super init];
    if (self) {
        // Initialization code here.
        delV = deliveryVO;
        _delegate = delegate;
    }
    
    return self;
}

- (void)getDelivery:(int) deliveryId :(NSString*) password {
    
    @try {
        dlvId = deliveryId;
        
        NSMutableString *url = [Util buildUrl: [userInfo getServerName] : GET_DELIVERY_URL : [userInfo isUseSSL]];
        NSLog(@"Server URL: %@", url);
        
        [request cancel];
        [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
        [request setRequestMethod: @"POST"];
        [request setPostValue:[userInfo getSessionId] forKey:@"sessionId"];
        [request setPostValue:[NSString stringWithFormat:@"%d", deliveryId] forKey:@"deliveryId"];
        [request setPostValue:@"true" forKey:@"accessByRecipient"];
        [request setPostValue:@"true" forKey:@"trackRequest"];
        if(![Util isEmpty:password]){
            [request setPostValue:password forKey:@"password"];
        }
        [request setTimeOutSeconds:20];
        
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setDelegate:self];
        [request setDidFailSelector:@selector(getDeliveryFailed:)];
        [request setDidFinishSelector:@selector(getDeliveryFinished:)];
        
        [request startSynchronous];
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get received deliveries; %@: %@", [exception name], [exception reason]);
    }
    
}

- (void)getDeliveryFailed:(ASIHTTPRequest *)theRequest {
    NSLog(@"Error: %@", theRequest.error);
}

- (void)getDeliveryFinished:(ASIHTTPRequest *)theRequest {
    NSString *responseStr = theRequest.responseString;
    NSDictionary *responseDictionary = [responseStr JSONValue];
    NSString *returnCode = [responseDictionary objectForKey:@"returnCode"];
    NSLog(@"Get Delivery return code: %@", returnCode) ;
    
    if(![returnCode isEqualToString:@"0"]) {
        NSLog(@"Getting delivery was not successful; returnCode: %@; deliveryId: %d", returnCode, [delV getDeliveryId]);
        
        // Delivery requires password and incorrect password
        if([@"-3" isEqualToString:returnCode] || [@"-4" isEqualToString:returnCode]){
            // Remove the password from property list
            NSString *s = [[NSString alloc] initWithFormat:@"user%@delivery%d", userInfo.getUserName, [delV getDeliveryId]];
            
            if([delV getDeliveryId] != 0) {
                [Util removeDataFromProperty:s];
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The password you entered is incorrect" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    [_delegate deliveryRC :[returnCode intValue]];
}


@end
