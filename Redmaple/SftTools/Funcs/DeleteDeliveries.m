//
//  DeleteRecipientDeliveries.m
//  BDSiPadApp
//
//  Created by Lion User on 13/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeleteDeliveries.h"
#import "UserInfo.h"
#import "Util.h"
#import "JSON.h"
#import "BDSiOSConstant.h"

extern UserInfo *userInfo;

@implementation DeleteDeliveries
@synthesize src;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        src = @"rd";
    }
    
    return self;
}


- (void)deleteDelivery:(int) deliveryId
{
    dlvId = deliveryId;
    @try {       
        NSString *deliveryIdString = @"";
        deliveryIdString = [deliveryIdString stringByAppendingFormat:@"%d", deliveryId];
        NSLog(@"deliveryIdsString: %@", deliveryIdString);
        
        NSString *mode = [src isEqualToString:@"rd"] ? DELETE_RECIPIENT_DELIVERY_URL : @"/deleteDelivery";
        NSMutableString *url = [Util buildUrl: [userInfo getServerName] : mode : [userInfo isUseSSL]];
        NSLog(@"Server URL: %@", url);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] 
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0]; 
        NSMutableString *params = [[NSMutableString alloc] initWithString:@""];
        [params appendString: @"sessionId="];
        [params appendString: [userInfo getSessionId]];
        [params appendString: @"&deliveryId="];
        [params appendString: [NSString stringWithFormat:@"%@", deliveryIdString]];
        
        
        NSLog(@"POSt data: %@", params);
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        // Create the connection with the request and start loading the data
        conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (conn) {
            webData = [[NSMutableData alloc] init];
        } else {
            NSLog(@"Connection failed");
        }
    } 
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to delete delivery; %@: %@", [exception name], [exception reason]);
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [Util handleConnectionFailure:nil :error :self :connection :webData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseStr = [[NSString alloc] initWithBytes:[webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSDictionary *responseDictionary = [responseStr JSONValue];
    NSLog(@"DeleteRecipientDeliveries responseStr: %@", responseStr);
    int returnCode = [[responseDictionary objectForKey:@"returnCode"] intValue];
    NSLog(@"Delete Deliveries return code: %d", returnCode) ;
    
    //BOOL deleteFiles = YES;
    if(returnCode != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to delete deliveries." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        // Insufficient privilege
        if(returnCode == -1) {
            //deleteFiles = NO;
            [alert setMessage:@"You don't have privilege to delete the deliveries."];
        } else if(returnCode == -2) {
            //deleteFiles = NO;
            [alert setMessage:@"Can't find the delivery."];
        }
        
        [alert show];
        
        NSLog(@"Delete deliveries was not successful; returnCode: %d", returnCode);

        
    } else {
        
        if( [src isEqualToString:@"rd"] )
        {
            [Util deleteDeliveryFiles:dlvId];
        }
    }
}

@end
