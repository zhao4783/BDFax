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

#import "ReceivedDelivery.h"
#import "Util.h"
#import "JSON.h"
#import "BDSiOSConstant.h"
#import "GetDelivery.h"
#import "PageViewController.h"

extern UserInfo *userInfo;

@implementation ReceivedDelivery
@synthesize src;

extern DeliveryVO *delV;
int _selectedIndex = 0;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithDeliveryIndex :(int) index
{
    deliveryIndex  = index;
    self = [self init];
    return self;
}


- (void)getDeliveries
{
    @try {
        
        NSMutableString *url = [Util buildUrl: [userInfo getServerName] : GET_DELIVERIES_URL : [userInfo isUseSSL]];
        NSLog(@"Server URL: %@", url);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
        int start = 1;
        NSMutableString *params = [[NSMutableString alloc] initWithString:@""];
        [params appendString: @"sessionId="];
        [params appendString: [userInfo getSessionId]];
        [params appendString: @"&s="];
        [params appendString: [NSString stringWithFormat:@"%d", start]];
        [params appendString: @"&ipp="];
        [params appendString: [NSString stringWithFormat:@"%d", ITEM_PER_PAGE]];
        [params appendString: @"&sa=dc"];
        [params appendString: @"&so=d"];
        [params appendString: @"&src="];
        [params appendString: src];
        
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
    @catch (NSException *exception)
    {
        NSLog(@"An error occured while trying to get received deliveries; %@: %@", [exception name], [exception reason]);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"ReceivedDelivery: Received response: %@", response);
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [Util handleConnectionFailure:nil :error :self :connection :webData];
    NSLog(@"An error occured while trying to get received deliveries: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %ld bytes of data to get received deliveries:",[webData length]);
    
    NSString *responseStr = [[NSString alloc] initWithBytes:[webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSDictionary *responseDictionary = [responseStr JSONValue];
    //NSString *returnCode = [responseDictionary objectForKey:@"returnCode"];
    int returnCode = RC_ERR_SYSTEM_ERROR;
    if(responseDictionary != NULL) {
        returnCode = [[responseDictionary objectForKey:@"returnCode"] intValue];
    }
    
    NSLog(@"Return code to get received deliveries: %d", returnCode) ;
    if(returnCode != RC_SUCCESS) {
        if(returnCode == RC_SESSION_TIME_OUT)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error occured while trying to signin" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Getting received deliveries was not successful." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        return;
    }
    
    // release the connection, and the data object
    [Util releaseConnection:conn];
    
    
    if(returnCode == RC_SUCCESS)
    {
        if( [src isEqualToString:@"rd"] )
        {
            listOfMeta = [Util parseDeliveries:responseDictionary];
            int unread = 0;
            for(int i=0; i<[listOfMeta count]; i++)
            {
                DeliveryVO *delV = [listOfMeta objectAtIndex:i];
                if(![delV getReadStatus]) {
                    unread += 1;
                }
            }
            [inboxPage updateViewWithUnreadNumber:unread];
            [inboxPage showSpinner:NO];
        }
        else
        {
            statusPage.sentLogArray = [Util parseDeliveries:responseDictionary];
            [statusPage showSpinner:NO];
            [statusPage.tableView reloadData];
        }
    }
}

-(void) showNoDeliveryAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No delivery found." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
}

-(void) showDeliveryListUnsuccessfulAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Getting received deliveries was not successful." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] ;
    [alert show];
}

-(void) deliveryRC :(int) code {
    
    if(code != RC_SUCCESS){
        delV = nil;
    } else {
        
        /*if(![delV getReadStatus]) {
            
            // Make the delivery read
            [delV setReadStatus:YES];
            
            // Remove the unread image
            [deliveryCell.readStatus removeFromSuperview];
            
            [Util updateDeliveryCountBadge:delV];
            
        }*/
    }
    [Util setDeliveryDetailView:delV :_selectedIndex];
}

@end
