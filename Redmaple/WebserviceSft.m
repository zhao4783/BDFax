//
//  WebserviceSft.m
//  MobileFax
//
//  Created by Zhao                                                     on 7/27/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "PageViewController.h"
#import "WebServices.h"
#import "WebserviceSft.h"
#import "ReceivedDelivery.h"
#import "DownloadFile.h"
#import "SendDelivery.h"
#import "DeleteDeliveries.h"
#import "GetContacts.h"
#import "AddContact.h"
#import "DeleteContacts.h"

#import "Util.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "BDSiOSConstant.h"

@implementation WebServicesSft
@synthesize request, bAccessing, deliveryVO;

extern UserInfo *userInfo;

- (id)init
{
    self = [super init];
    if( self )
    {
        bAccessing = false;
        deliveryVO = nil;
    }
    
    return self;
}

- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

- (BOOL)login:(BOOL)inSilent
{
    BOOL success = YES;
    
    @try
    {
        NSString *url = [NSString stringWithFormat:@"https://%@bdsrestws/signin", sWebService];
        NSString *domain = @"";
        NSString *username = @"";
        NSArray *arr = [sUsername componentsSeparatedByString:@"/"];
        if( [arr count] == 2 )
        {
            domain = [arr objectAtIndex:0];
            username = [arr objectAtIndex:1];
        }
        else
        {
            username = sUsername;
        }
        
        [request cancel];
        [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
        [request setRequestMethod: @"POST"];
        [request setPostValue:username forKey:@"username"];
        [request setPostValue:sPassword forKey:@"password"];
    
        if (nDeviceType == DEVICE_IPAD)
        {
            [request setPostValue:@"BDSiPadApp" forKey:@"channelType"];
        }
        else
        {
            [request setPostValue:@"BDSiPhoneApp" forKey:@"channelType"];
        }
        [request setPostValue:[self getIPAddress] forKey:@"ipAddress"];
        
        if( ![domain isEqualToString:@""] )
        {
            [request setPostValue:domain forKey:@"domain"];
        }
        [request setTimeOutSeconds:10];
        
        [request setShouldContinueWhenAppEntersBackground:YES];
        [request setDelegate:self];
        [request setDidFailSelector:@selector(signinFailed:)];
        [request setDidFinishSelector:@selector(signinFinished:)];
        [request startSynchronous];
    }
    @catch (NSException *exception)
    {
        success = NO;
        if( !inSilent )
        {
            [viewerPage ShowAlertTitle:@"Error" message:@"An error occured while trying to signin"];
        }
    }
    
    return success;
}

- (void)signinFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"signinFailed. Error: %@", [theRequest error]);
    [request setDelegate:nil];
    [request cancel];
    
    [viewerPage ShowAlertTitle:@"Error" message:@"Signin was not successful. Please try again or contact your system administrator."];
}

- (void)signinFinished:(ASIHTTPRequest *)theRequest
{
    
    [request setDelegate:nil];
    [request cancel];
    
    int returnCode = 0;
    NSString* responseStr = theRequest.responseString;
    NSLog(@"Signin RESPONSE STRING: %@",responseStr);
    NSDictionary *responseDictionary;
    @try
    {
        responseDictionary = [responseStr JSONValue];
        NSString *returnCodeStr = [responseDictionary objectForKey:@"returnCode"];
        NSLog(@"signinFinished - RC: %@", returnCodeStr);
        
        if (returnCodeStr!=nil && ![returnCodeStr isEqualToString:@""]) {
            returnCode = [returnCodeStr intValue];
        } else {
            returnCode = RC_ERR_SYSTEM_ERROR;
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"An error occured while trying to signin; %@: %@", [exception name], [exception reason]);
        returnCode = RC_ERR_SYSTEM_ERROR;
    }
        
    if(returnCode != RC_SUCCESS)
    {
        NSString *errMsg = @"Sign in was not successful";
        
        if(returnCode == RC_ERR_INVALID_LICENSE) {
            errMsg = @"Valid license not found. Product is disabled.";
        } else if (returnCode == RC_ERR_USERNAME || returnCode == RC_ERR_PASSWORD){
            errMsg = @"Invalid sign in information provided. Please try again.";
        } else if (returnCode == RC_ERR_ACCOUNT_NOT_ACTIVATED){
            errMsg = @"The user has not activated his account yet.";
        } else if (returnCode == RC_ERR_ACCOUNT_NAME){
            errMsg = @"The account you entered is not valid. Please try again.";
        } else if (returnCode == RC_ERR_TOO_MANY_INVALID_ATTEMPTS){
            errMsg = @"You have exceeded the maximum number of sign in attempts.";
        } else if (returnCode == RC_ERR_SIGN_IN_LOCKED){
            errMsg = @"Invalid username or password, or the account has been locked. Please try again later or contact a system administrator.";
        } else if (returnCode == RC_ERR_PASSWORD_EXPIRED){
            errMsg = @"Your current password has expired. Please change your password.";
        } else if (returnCode == RC_ERR_PASSWORD_CHANGE_REQUIRED){
            errMsg = @"Password change required by system. Please contact your administrator for more information.";
        } else if (returnCode == RC_ERR_EXTERNAL_USER_EMAIL_NOT_FOUND){
            errMsg = @"Your account must have a valid email address associated with it. Please contact your administrator for more information.";
        } else if (returnCode == RC_ERR_CONNECTOR_COMMUNICATION){
            errMsg = @"Could not communicate with connector. Please contact to your system administrator.";
        } else if (returnCode == RC_ERR_ACCOUNT_DISABLED){
            errMsg = @"Your account has been disabled. Please contact your system administrator.";
        } else if (returnCode ==RC_ERR_ACCOUNT_REGISTRATION_NOT_APPROVED){
            errMsg = @"Your registration request has not been processed yet. Please contact the system administrator for more information.";
        } else if (returnCode == RC_ERR_ACCOUNT_REGISTRATION_DENIED){
            errMsg = @"Your registration request has been denied. Please contact the system administrator for more information.";
        } else if (returnCode == RC_ERR_ACCOUNT_EXPIRED){
            errMsg = @"Your account has expired. Please contact your system administrator.";
        } else if (returnCode == RC_ERR_MAXIMUM_SENDER_LIMIT_EXCEEDED){
            errMsg = @"Maximum sender limit exceeded.";
        } else if (returnCode == RC_ERR_INVALID_TOKEN){
            errMsg = @"Invalid token provided. Please try again with a valid token.";
        } else if (returnCode == RC_ERR_TOKEN_AUTHENTICATION_NOT_ALLOWED_FOR_USER){
            errMsg = @"You are not allowed to sign in with a token. Please contact your system administrator.";
        } else if (returnCode == RC_ERR_AUTHENTICATION_RESTRICTED_FOR_IP_ADDRESS){
            errMsg = @"Your account is restricted from accessing this server from your current location. Please contact an administrator for assistance.";
        }
        
        [viewerPage ShowAlertTitle:@"Error" message:errMsg];
        return;
    }
    
    if(returnCode == RC_SUCCESS)
    {
        NSString *domain = @"";
        NSString *username = @"";
        NSArray *arr = [sUsername componentsSeparatedByString:@"/"];
        if( [arr count] == 2 )
        {
            domain = [arr objectAtIndex:0];
            username = [arr objectAtIndex:1];
        }
        else
        {
            username = sUsername;
        }
        userInfo = [[UserInfo alloc] init];
        [userInfo setSessionId:[responseDictionary objectForKey:@"sessionId"]];
        [userInfo setUserName:username];
        [userInfo setDomain:domain];
        [userInfo setServerName:sWebService];
        [userInfo setPassword:sPassword];
        [userInfo setUseSSL:YES];
        [userInfo setSender:YES];
        [userInfo setRecipient:YES];
    }
    else
    {
        [viewerPage ShowAlertTitle:@"Error" message:@"Signin was not successful."];
        NSLog(@"Signin was not successful.; %d", returnCode);
    }
    
}

- (BOOL)removeStatusMessage:(UITableView *)aTableView forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( ![self canAccess] )
    {
        return NO;
    }
    
    bAccessing = true;
    @try
    {
        DeliveryVO *delV = [statusPage.sentLogArray objectAtIndex:indexPath.row];
        DeleteDeliveries *rd = [[DeleteDeliveries alloc] init];
        rd.src = @"sd";
        [rd deleteDelivery:[delV getDeliveryId]];
        
        [statusPage.sentLogArray removeObjectAtIndex:indexPath.row];
        [statusPage.tableView reloadData];
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
    return YES;
}

- (BOOL)setStatusLogs
{
    if( userInfo == nil )
    {
        if( ![self login:YES] )
        {
            [self terminateSession];
            return NO;
        }
    }
    
    BOOL ret = NO;
    bAccessing = true;
    @try
    {
        if([userInfo isSender])
        {
            ReceivedDelivery *rd = [[ReceivedDelivery alloc] init];
            rd.src = @"sd";
            [rd getDeliveries];
            ret = YES;
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
    return ret;
}

- (void)getReceivedIPFaxes:(BOOL)silent
{
    if( userInfo == nil )
    {
        if( ![self login:silent] )
        {
            [self terminateSession];
            return;
        }
    }
    
    bAccessing = true;
    @try
    {
        if([userInfo isRecipient])
        {
            ReceivedDelivery *rd = [[ReceivedDelivery alloc] init];
            rd.src = @"rd";
            [rd getDeliveries];
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
}

- (NSArray *)getContacts:(BOOL)silent
{
    if( userInfo == nil )
    {
        if( ![self login:silent] )
        {
            [self terminateSession];
            return nil;
        }
    }
    
    NSArray *list = nil;
    bAccessing = true;
    @try
    {
        GetContacts *rd = [[GetContacts alloc] init];
        [rd getContacts];
        list = rd.returnList;
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
    return list;
}

- (void)addContact:(NSDictionary *)contact
{
    if( userInfo == nil )
    {
        if( ![self login:YES] )
        {
            [self terminateSession];
            return;
        }
    }
    
    bAccessing = true;
    @try
    {
        NSString *name = [contact objectForKey:KEY_NAME];
        NSString *address = [contact objectForKey:KEY_ADDRESS];
        NSString *company = [contact objectForKey:KEY_COMPANY];
        AddContact *rd = [[AddContact alloc] init];
        [rd addContactWithName:name address:address company:company];
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
}

- (void)deleteContacts:(NSArray *)contacts
{
    if( userInfo == nil )
    {
        if( ![self login:YES] )
        {
            [self terminateSession];
            return;
        }
    }
    
    bAccessing = true;
    @try
    {
        for(NSString* cid in contacts)
        {
            DeleteContact *rd = [[DeleteContact alloc] init];
            [rd deleteContact:cid];
        }
        [sendPage performSelector:@selector(resetContactList:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.1];
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
}

- (void)updateReceivedIPFaxes
{
    if( !bAccessing )
    {
        [self getReceivedIPFaxes:YES];
    }
}

- (bool)sendFax:(NSArray *)recipientSet pack:(NSDictionary *)pack index:(int)index
{
    bool ret = true;
    bAccessing = true;
    @try
    {
        SendDelivery *sd = [[SendDelivery alloc] initWithPackage:pack recipientList:recipientSet index:index];
        [sd sendDelivery];
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
        ret = false;
    }
    bAccessing = false;
    return ret;
}

- (void)removeAllTempFiles
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *arr = [fileManager contentsOfDirectoryAtPath:FaxFolder error:nil];
    for(NSInteger i=0; i<[arr count]; i++)
    {
        NSString *file = [FaxFolder stringByAppendingPathComponent:[arr objectAtIndex:i]];
        [fileManager removeItemAtPath:file error:nil];
    }
}

- (NSString *)receiveIPFaxByFaxID
{
    DeliveryVO *delV = deliveryVO == nil ? [listOfMeta objectAtIndex:nSelectedIndex] : deliveryVO;
    NSString* faxID = [NSString stringWithFormat:@"%d", delV.getDeliveryId];
    NSString *tempFile = [FaxFolder stringByAppendingPathComponent:faxID];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *arr = [fileManager contentsOfDirectoryAtPath:FaxFolder error:nil];
    for(NSInteger i=0; i<[arr count]; i++)
    {
        NSString *file = [FaxFolder stringByAppendingPathComponent:[arr objectAtIndex:i]];
        if( [file isEqualToString:tempFile] )
        {
            return tempFile;
        }
    }
    
    bAccessing = true;
    @try
    {
        DownloadFile *rd = [[DownloadFile alloc] initWithDeliveryVO:delV filePath:tempFile];
        [rd getDataFile];
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
    
    return @"";
}

- (void)removeFaxWithIndex:(NSIndexPath *)indexPath
{
    if( ![self canAccess] )
    {
        return;
    }
    
    bAccessing = true;
    @try
    {
        DeliveryVO *delV = [listOfMeta objectAtIndex:indexPath.row];
        DeleteDeliveries *rd = [[DeleteDeliveries alloc] init];
        rd.src = @"rd";
        [rd deleteDelivery:[delV getDeliveryId]];
        
        [listOfMeta removeObjectAtIndex:indexPath.row];
        [inboxPage.tableView reloadData];
        [inboxPage.faxTable reloadData];
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
}

- (void)terminateSession
{
    userInfo = nil;
}

- (BOOL)canAccess
{
    NSInteger tim = 0;
    while( bAccessing )
    {
        sleep(1.0);
        tim += 1;
        if( tim > 10 )
        {
            return NO;
        }
    }
    return YES;
}

@end

