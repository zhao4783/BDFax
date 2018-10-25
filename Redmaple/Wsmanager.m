//
//  Wsmanager.m
//  MobileFax
//
//  Created by Zhao                                                     on 8/15/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wsmanager.h"
#import "PageViewController.h"

extern int nWebService;

@implementation WSManager
@synthesize wsSft;

- (id)init
{
    self = [super init];
    if( self )
    {
        wsAnywhere = nil;
        wsMobile = nil;
        wsSft = nil;
        if( nWebService == WEB_SERVICE_MOBILE )
        {
            wsMobile = [[WebServicesMobile alloc] init];
        }
        else  if( nWebService == WEB_SERVICE_ANYWHER )
        {
            wsAnywhere = [[WebServicesAnywhere alloc] init];
        }
        else if( nWebService == WEB_SERVICE_SFT )
        {
            wsSft = [[WebServicesSft alloc] init];
        }
    }
    
    return self;
}

- (BOOL)login:(BOOL)inSilent
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        return [wsMobile login:inSilent];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        return [wsAnywhere login:inSilent];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        return [wsSft login:inSilent];
    }
    return NO;
}

- (void)terminateSession
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        [wsMobile terminateSession];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        [wsAnywhere terminateSession];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        [wsSft terminateSession];
    }
}

- (BOOL)setStatusLogs
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        return [wsMobile setStatusLogs];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        return [wsAnywhere setStatusLogs];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        return [wsSft setStatusLogs];
    }
    return NO;
}

- (void)deletePendingLog
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        [wsMobile deletePendingLog];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
    }
}

- (void)removeStatusMessage:(UITableView *)aTableView forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        [wsMobile removeStatusMessage:aTableView forRowAtIndexPath:indexPath];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        [wsAnywhere removeStatusMessage:aTableView forRowAtIndexPath:indexPath];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        [wsSft removeStatusMessage:aTableView forRowAtIndexPath:indexPath];
    }
}

- (void)addContact:(NSDictionary *)dic
{
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        [wsSft addContact:dic];
    }
}

- (void)deleteContacts:(NSArray *)contacts
{
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        [wsSft deleteContacts:contacts];
    }
}

- (NSArray *)getContacts
{
    NSArray *contacts = nil;
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        contacts = [wsSft getContacts:NO];
    }
    return contacts;
}

- (void)getReceivedIPFaxes
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        [wsMobile getReceivedIPFaxes];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        [wsAnywhere getReceivedIPFaxes];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        [wsSft getReceivedIPFaxes:NO];
    }
}

- (void)updateReceivedIPFaxes
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        [wsMobile updateReceivedIPFaxes];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        [wsAnywhere updateReceivedIPFaxes];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        [wsSft updateReceivedIPFaxes];
    }
}

- (NSString *)receiveIPFaxByFaxID:(NSString *)faxID
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        return [wsMobile receiveIPFaxByFaxID:faxID];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        return [wsAnywhere receiveIPFaxByFaxID:faxID];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        return [wsSft receiveIPFaxByFaxID];
    }
    return @"";
}

- (NSString *)getWebServiceVersion
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        return [wsMobile getWebServiceVersion];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
    }
    return @"";
}

- (void)removeFaxWithIndex:(NSIndexPath *)indexPath
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        [wsMobile removeFaxWithIndex:indexPath];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        [wsAnywhere removeFax:indexPath];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        [wsSft removeFaxWithIndex:indexPath];
    }
}

- (void)setReadFlag
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        [wsMobile setReadFlag];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
    }
}

- (bool)sendFax:(NSArray *)recipientSet pack:(NSDictionary *)pack index:(int)index
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        return [wsMobile sendFax:recipientSet pack:pack index:index];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        return [wsAnywhere doSendFax:recipientSet pack:pack];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        return [wsSft sendFax:recipientSet pack:pack index:index];
    }
    return false;
}

- (BOOL)canAccess
{
    if( nWebService == WEB_SERVICE_MOBILE && wsMobile != nil )
    {
        return [wsMobile canAccess];
    }
    if( nWebService == WEB_SERVICE_ANYWHER && wsAnywhere != nil )
    {
        return [wsAnywhere canAccess];
    }
    if( nWebService == WEB_SERVICE_SFT && wsSft != nil )
    {
        return [wsSft canAccess];
    }
    return NO;
}

@end

