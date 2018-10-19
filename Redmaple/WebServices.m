//
//  WebServices.m
//  MobileFax
//
//  Created by Zhao                                                     on 3/20/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import "WebServices.h"
#import "PageViewController.h"


@implementation WebServicesMobile

- (id)init
{
    self = [super init];
    if( self )
    {
        binding = nil;
        bAccessing = false;
    }
    
    return self;
}

// To allow the server to accept any certificate including an untrusted one, we need add a function
// -(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
// {
//    BOOL ok = [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
//    return ok;
// }
// in FAXCOM_x0020_Service.m
//
- (BOOL)login:(BOOL)inSilent
{
    if( [sWebService isEqualToString:@""] || [sUsername isEqualToString:@""] )
        return NO;
    
    if( binding != nil )
        return YES;
    
    bAccessing = true;
    @try
    {
        NSString *ws = [sWebService lowercaseString];
        NSRange range = [ws rangeOfString:@"http://"];
        NSRange range1 = [ws rangeOfString:@"https://"];
        if( range.location == NSNotFound && range1.location == NSNotFound )
        {
            NSString *str = [NSString stringWithFormat:@"https://%@/faxcom_ws/faxcomservice.asmx",ws];
            ws = str;
        }
        
        binding = [[FAXCOM_x0020_ServiceSoapBinding alloc] initWithAddress:ws];
        FAXCOM_x0020_Service_SetLegacyMode *req0 = [[FAXCOM_x0020_Service_SetLegacyMode alloc] init];
        req0.legacyMode = [NSNumber numberWithInt:1];
        [binding SetLegacyModeUsingParameters:req0];
        
        FAXCOM_x0020_Service_LogOn *req = [[FAXCOM_x0020_Service_LogOn alloc] init];
        req.userName = sUsername;
        req.password = sPassword;
        req.userType = [NSNumber numberWithInt:-1];
        FAXCOM_x0020_ServiceSoapBindingResponse *resp = [binding LogOnUsingParameters:req];
        
        FAXCOM_x0020_Service_LogOnResponse *body = [resp.bodyParts objectAtIndex:0];
        if( body == nil )
        {
            if( !inSilent )
            {
                [viewerPage ShowAlertTitle:@"Login failed" message:[resp.error localizedDescription]];
                [viewerPage writeLog:[NSString stringWithFormat:@"Login failed: %@", [resp.error localizedDescription]]];
            }
            binding = nil;
            bAccessing = false;
            return NO;
        }
        
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            if( !inSilent )
            {
                SOAPFault *error = (SOAPFault *)body;
                [viewerPage ShowAlertTitle:@"Login failed" message:error.faultstring];
                [viewerPage writeLog:[NSString stringWithFormat:@"Login failed: %@", error.faultstring]];
            }
            binding = nil;
            bAccessing = false;
            return NO;
        }
        
        FAXCOM_x0020_Service_ResultMessage *ret = body.LogOnResult;
        if ( ret.Result.boolValue == NO )
        {
            if( !inSilent )
            {
                [viewerPage ShowAlertTitle:@"Login failed" message:ret.Detail];
                [viewerPage writeLog:[NSString stringWithFormat:@"Login failed: %@", ret.Detail]];
            }
            binding = nil;
            bAccessing = false;
            return NO;
        }
        [viewerPage writeLog:@"Login successfully"];
    }
    @catch (NSException *ex)
    {
        [viewerPage ShowAlertTitle:@"Error" message:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
        [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in login): %@", ex.reason]];
        [viewerPage writeLog:@"Login failed"];
    }
    
    bAccessing = false;
    return YES;
}

- (BOOL)canAccess
{
    NSInteger tim = 0;
    while( bAccessing )
    {
        sleep(1.0);
        tim += 1;
        if( tim > 5 )
        {
            return NO;
        }
    }
    return YES;
}

- (NSString *)getWebServiceVersion
{
    if( ![self canAccess] )
    {
        return @"";
    }
    
    if( ![self login:NO] )
    {
        return @"";
    }
    
    bAccessing = true;
    NSString *ret = @"";
    @try
    {
        FAXCOM_x0020_Service_WebServiceVersion *req = [[FAXCOM_x0020_Service_WebServiceVersion alloc] init];
        FAXCOM_x0020_ServiceSoapBindingResponse *resp = [binding WebServiceVersionUsingParameters:req];
        FAXCOM_x0020_Service_WebServiceVersionResponse *body = [resp.bodyParts objectAtIndex:0];
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding WebServiceVersionUsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in getWebServiceVersion): %@", [resp.error localizedDescription]]];
                    bAccessing = false;
                    return @"";
                }
            }
            else
            {
                bAccessing = false;
                return @"";
            }
        }
        ret = body.WebServiceVersionResult;
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in getWebServiceVersion): %@", ex.reason]];
    }
    bAccessing = false;
    return ret;
}

- (void)terminateSession
{
    if( binding )
    {
        FAXCOM_x0020_Service_ReleaseSession *req = [[FAXCOM_x0020_Service_ReleaseSession alloc] init];
        [binding ReleaseSessionUsingParameters:req];
        binding = nil;
    }
}

- (void)updateReceivedIPFaxes
{
    if( ![self canAccess] )
    {
        return;
    }
    
    bAccessing = true;
    @try
    {
        FAXCOM_x0020_Service_GetReceivedMessagesCount *req0 = [[FAXCOM_x0020_Service_GetReceivedMessagesCount alloc] init];
        FAXCOM_x0020_ServiceSoapBindingResponse *resp0 = [binding GetReceivedMessagesCountUsingParameters:req0];
        FAXCOM_x0020_Service_GetReceivedMessagesCountResponse *body0 = [resp0.bodyParts objectAtIndex:0];
        if( [body0 isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp0 = [binding GetReceivedMessagesCountUsingParameters:req0];
                body0 = [resp0.bodyParts objectAtIndex:0];
                if( [body0 isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in updateReceivedIPFaxes): %@", [resp0.error localizedDescription]]];
                    bAccessing = false;
                    return;
                }
            }
            else
            {
                bAccessing = false;
                return;
            }
        }
        
        NSInteger Count = [body0.GetReceivedMessagesCountResult intValue];
        NSInteger cnt = [listOfMeta count];
        if( Count == cnt )
        {
            bAccessing = false;
            return;
        }
        
        FAXCOM_x0020_Service_GetReceivedMessages3 *req1 = [[FAXCOM_x0020_Service_GetReceivedMessages3 alloc] init];
        req1.returnImagedata = [[USBoolean alloc] initWithBool:NO];
        req1.sortColumn = [NSNumber numberWithInt:3];
        req1.ascending = [[USBoolean alloc] initWithBool:NO];
        req1.start = [NSNumber numberWithInt:0];
        req1.count = [NSNumber numberWithInt:-1];
        req1.format = FAX_FORMAT;
        FAXCOM_x0020_ServiceSoapBindingResponse *resp1 = [binding GetReceivedMessages3UsingParameters:req1];
        FAXCOM_x0020_Service_GetReceivedMessages3Response *body1 = [resp1.bodyParts objectAtIndex:0];
        
        FAXCOM_x0020_Service_ArrayOfReceivedMessageData2 *ret1 = body1.GetReceivedMessages3Result;
        if( body1 == nil || ret1 == nil )
        {
            bAccessing = false;
            return;
        }
        
        NSInteger num = [ret1.ReceivedMessageData2 count];
        for(NSInteger i = 0; i < num; i++)
        {
            FAXCOM_x0020_Service_ReceivedMessageData2 *data = [ret1.ReceivedMessageData2 objectAtIndex:i];
            FAXCOM_x0020_Service_ReceivedMessageMetadata2 *meta = data.Metadata;
            if( [meta.IsRead boolValue] )
                meta.Status = [NSNumber numberWithInt:0];
            else
                meta.Status = [NSNumber numberWithInt:1];
        }
        
        nSelectedIndex = -1;
        NSIndexPath *pt = [inboxPage.faxTable indexPathForSelectedRow];
        if( pt != nil )
        {
            FAXCOM_x0020_Service_ReceivedMessageMetadata2 *SelectedFax = [listOfMeta objectAtIndex:pt.row];
            for(NSInteger k = 0; k < num; k++)
            {
                FAXCOM_x0020_Service_ReceivedMessageData2 *data = [ret1.ReceivedMessageData2 objectAtIndex:k];
                FAXCOM_x0020_Service_ReceivedMessageMetadata2 *mt = data.Metadata;
                if( [SelectedFax.FaxIDInFolder isEqualToString:mt.FaxIDInFolder] )
                {
                    nSelectedIndex = k;
                    break;
                }
            }
        }
        
        [listOfMeta removeAllObjects];
        for(NSInteger k = 0; k < num; k++)
        {
            FAXCOM_x0020_Service_ReceivedMessageData2 *data = [ret1.ReceivedMessageData2 objectAtIndex:k];
            FAXCOM_x0020_Service_ReceivedMessageMetadata2 *mt = data.Metadata;
            [listOfMeta addObject:mt];
        }
        [inboxPage performSelector:@selector(deselectFaxTable) withObject:nil afterDelay:0.2];
        
        [ret1.ReceivedMessageData2 removeAllObjects];
        NSInteger newOnes = 0;
        cnt = [listOfMeta count];
        for(NSInteger i = 0; i < cnt; i++)
        {
            FAXCOM_x0020_Service_ReceivedMessageMetadata2 *meta = [listOfMeta objectAtIndex:i];
            if( ![meta.IsRead boolValue] )
                newOnes += 1;
        }
        [inboxPage setApplicationBadgeNumber:newOnes];
        AudioServicesPlaySystemSound(1007);
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in updateReceivedIPFaxes): %@", ex.reason]];
        [self terminateSession];
        [self login:YES];
    }
    
    bAccessing = false;
}

- (void)getReceivedIPFaxes
{
    if( ![self canAccess] )
    {
        return;
    }
    
    if( ![self login:NO] )
    {
        return;
    }
    
    bAccessing = true;
    int unread = 0;
    @try
    {
        FAXCOM_x0020_Service_GetReceivedMessages3 *req = [[FAXCOM_x0020_Service_GetReceivedMessages3 alloc] init];
        req.returnImagedata = [[USBoolean alloc] initWithBool:NO];
        req.sortColumn = [NSNumber numberWithInt:3];
        req.ascending = [[USBoolean alloc] initWithBool:NO];
        req.start = [NSNumber numberWithInt:0];
        req.count = [NSNumber numberWithInt:-1];
        req.format = FAX_FORMAT;
        FAXCOM_x0020_ServiceSoapBindingResponse *resp = [binding GetReceivedMessages3UsingParameters:req];
        FAXCOM_x0020_Service_GetReceivedMessages3Response *body = [resp.bodyParts objectAtIndex:0];
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding GetReceivedMessages3UsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in getReceivedIPFaxes): %@", [resp.error localizedDescription]]];
                    bAccessing = false;
                    return;
                }
            }
            else
            {
                bAccessing = false;
                return;
            }
        }
        
        [listOfMeta removeAllObjects];
        FAXCOM_x0020_Service_ArrayOfReceivedMessageData2 *ret = body.GetReceivedMessages3Result;
        NSInteger num = [ret.ReceivedMessageData2 count];
        for(NSInteger i = 0; i < num; i++)
        {
            FAXCOM_x0020_Service_ReceivedMessageData2 *data = [ret.ReceivedMessageData2 objectAtIndex:i];
            FAXCOM_x0020_Service_ReceivedMessageMetadata2 *meta = data.Metadata;
            if( ![meta.IsRead boolValue] )
            {
                unread += 1;
            }
            [listOfMeta addObject:meta];
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in getReceivedIPFaxes): %@", ex.reason]];
    }
    bAccessing = false;
    
    [inboxPage setApplicationBadgeNumber:unread];
    [inboxPage.faxTable reloadData];
    [inboxPage.tableView reloadData];
    
    if( urlSaved != nil )
    {
        [self performSelector:@selector(onAttach) withObject:nil afterDelay:0.1];
    }
}

- (void)setReadFlag
{
    if( ![self canAccess] )
    {
        return;
    }
    
    if( ![self login:NO] )
    {
        return;
    }
    
    bAccessing = true;
    @try
    {
        FAXCOM_x0020_Service_MarkAsReadByIDs *req = [[FAXCOM_x0020_Service_MarkAsReadByIDs alloc] init];
        FAXCOM_x0020_Service_ArrayOfString *cont = [[FAXCOM_x0020_Service_ArrayOfString alloc] init];
        [cont.string addObject:theFaxID];
        req.faxIDs = cont;
        req.readFlag = [[USBoolean alloc] initWithBool:YES];
        FAXCOM_x0020_ServiceSoapBindingResponse *resp = [binding MarkAsReadByIDsUsingParameters:req];
        FAXCOM_x0020_Service_MarkAsReadByIDsResponse *body = [resp.bodyParts objectAtIndex:0];
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding MarkAsReadByIDsUsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in setReadFlag): %@", [resp.error localizedDescription]]];
                    bAccessing = false;
                    return;
                }
            }
            else
            {
                bAccessing = false;
                return;
            }
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in setReadFlag): %@", ex.reason]];
    }
    bAccessing = false;
}

- (NSString *)receiveIPFaxByFaxID:(NSString *)faxID
{
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
    
    if( ![self canAccess] )
    {
        return @"";
    }
    
    if( ![self login:NO] )
    {
        return @"";
    }
    
    bAccessing = true;
    NSString *filename = @"";
    @try
    {
        FAXCOM_x0020_Service_ArrayOfString *cont = [[FAXCOM_x0020_Service_ArrayOfString alloc] init];
        [cont.string addObject:faxID];
        FAXCOM_x0020_Service_ArrayOfReceivedMessageData *ret = nil;
        FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 *req = [[FAXCOM_x0020_Service_GetReceivedMessagesByIDs2 alloc] init];
        req.faxIDsInFolder = cont;
        req.format = FAX_FORMAT;
        FAXCOM_x0020_ServiceSoapBindingResponse *resp = [binding GetReceivedMessagesByIDs2UsingParameters:req];
        FAXCOM_x0020_Service_GetReceivedMessagesByIDs2Response *body = [resp.bodyParts objectAtIndex:0];
        if( body==nil || [body isKindOfClass:[SOAPFault class]] )
        {
            [viewerPage writeLog:[NSString stringWithFormat:@"Error (in receiveIPFaxByFaxID): %@", [resp.error localizedDescription]]];
            bAccessing = false;
            return @"";
        }
        ret = body.GetReceivedMessagesByIDs2Result;

        if( ret != nil && [ret.ReceivedMessageData count] > 0 )
        {
            FAXCOM_x0020_Service_ReceivedMessageData *data = [ret.ReceivedMessageData objectAtIndex:0];
            filename = [inboxPage getFileName];
            if( ![data.Imagedata writeToFile:filename atomically:YES] )
            {
                filename = @"";
            }
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in receiveIPFaxByFaxID): %@", ex.reason]];
    }
    bAccessing = false;
    
    return filename;
}

- (void)removeFaxWithIndex:(NSIndexPath *)indexPath
{
    if( ![self canAccess] )
    {
        return;
    }
    
    if( [self login:NO] )
    {
        bAccessing = true;
        @try
        {
            NSString *FaxIDInFolder = @"";
            FAXCOM_x0020_Service_ReceivedMessageMetadata2 *meta = [listOfMeta objectAtIndex:indexPath.row];
            FaxIDInFolder = meta.FaxIDInFolder;
            FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs *req1 = [[FAXCOM_x0020_Service_RemoveReceivedMessagesByIDs alloc] init];
            req1.faxIDsInFolder = [[FAXCOM_x0020_Service_ArrayOfString alloc] init];
            [req1.faxIDsInFolder.string addObject:FaxIDInFolder];
            FAXCOM_x0020_ServiceSoapBindingResponse *resp1 = [binding RemoveReceivedMessagesByIDsUsingParameters:req1];
            FAXCOM_x0020_Service_RemoveReceivedMessagesByIDsResponse *body1 = [resp1.bodyParts objectAtIndex:0];
            if( [body1 isKindOfClass:[SOAPFault class]] )
            {
                [self terminateSession];
                if( [self login:YES] )
                {
                    resp1 = [binding RemoveReceivedMessagesByIDsUsingParameters:req1];
                    body1 = [resp1.bodyParts objectAtIndex:0];
                    if( [body1 isKindOfClass:[SOAPFault class]] )
                    {
                        [viewerPage writeLog:[NSString stringWithFormat:@"Error (in RemoveReceivedMessagesByIDs): %@", resp1.description]];
                        bAccessing = false;
                        return;
                    }
                }
                else
                {
                    bAccessing = false;
                    return;
                }
            }
            
            FAXCOM_x0020_Service_ResultMessage *ret1 = body1.RemoveReceivedMessagesByIDsResult;
            if ( ret1.Result.boolValue == NO )
            {
                [viewerPage ShowAlertTitle:@"Cannot delete" message:ret1.Detail];
                bAccessing = false;
                return;
            }
            else
            {
                NSString *file = [FaxFolder stringByAppendingPathComponent:FaxIDInFolder];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:file error:nil];
                
                [listOfMeta removeObjectAtIndex:indexPath.row];
                if( nSelectedIndex == indexPath.row )
                {
                    [inboxPage clearThumbnailView];
                    nSelectedIndex = -1;
                }
                if( nSelectedIndex > indexPath.row )
                    nSelectedIndex -= 1;
                [inboxPage.faxTable reloadData];
                [inboxPage.tableView reloadData];
                if( [FaxIDInFolder isEqualToString:theFaxID] )
                {
                    [viewerPage displayLogoImage];
                    theFaxID = @"";
                }
            }
        }
        @catch (NSException *ex)
        {
            [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in deleting fax): %@", ex]];
        }
        bAccessing = false;
    }
}

- (bool)sendFax:(NSArray *)recipientSet pack:(NSDictionary *)pack index:(int)index
{
    if( ![self canAccess] )
    {
        return false;
    }
    
    bAccessing = true;
    bool ret = false;
    @try
    {
        FAXCOM_x0020_Service_SetSenderInformation *req1 = [[FAXCOM_x0020_Service_SetSenderInformation alloc] init];
        req1.name = [pack valueForKey:@"SenderName"];
        req1.faxNumber = [pack valueForKey:@"SenderAddr"];
        req1.voiceNumber = [pack valueForKey:@"SenderPhon"];
        req1.company = [pack valueForKey:@"SenderComp"];
        req1.email = @"";
        req1.address1 = @"";
        req1.address2 = @"";
        req1.address3 = @"";
        FAXCOM_x0020_ServiceSoapBindingResponse *resp1 = [binding SetSenderInformationUsingParameters:req1];
        FAXCOM_x0020_Service_SetSenderInformationResponse *body1 = [resp1.bodyParts objectAtIndex:0];
        if( [body1 isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp1 = [binding SetSenderInformationUsingParameters:req1];
                body1 = [resp1.bodyParts objectAtIndex:0];
                if( [body1 isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in SetSenderInformation): %@", [resp1.error localizedDescription]]];
                    bAccessing = false;
                    return ret;
                }
            }
            else
            {
                bAccessing = false;
                return ret;
            }
        }
        
        NSDictionary *dic = [recipientSet objectAtIndex:(index < 0 ? 0 : index)];
        NSString *recipientName = [dic objectForKey:KEY_NAME];
        NSString *faxNumber = [dic objectForKey:KEY_ADDRESS];
        NSString *company = [dic objectForKey:KEY_COMPANY];
        
        FAXCOM_x0020_Service_NewFaxMessage *req2 = [[FAXCOM_x0020_Service_NewFaxMessage alloc] init];
        req2.priority = [NSNumber numberWithInt:1];
        req2.sendTime = @"0.0";
        req2.resolution = [NSNumber numberWithInt:1];
        req2.subject = [pack valueForKey:@"Subject"];
        req2.coverpage = [[pack valueForKey:@"CoverPageOn"] boolValue] && index == -1 ? @"" : @"(none)";
        req2.memo = [pack valueForKey:@"Memo"];
        req2.senderName = @"";
        req2.senderFax = @"";
        req2.recipientName = recipientName;
        req2.recipientCompany = company;
        req2.recipientFax = faxNumber;
        req2.recipientVoice = @"";
        req2.recipientAccount = @"";
        [binding NewFaxMessageUsingParameters:req2];
        
        if( index == -1 ) // This is a regular fax
        {
            for(int i=1; i<[recipientSet count]; i++)
            {
                NSDictionary *dic = [recipientSet objectAtIndex:i];
                recipientName = [dic objectForKey:KEY_NAME];
                faxNumber = [dic objectForKey:KEY_ADDRESS];
                company = [dic objectForKey:KEY_COMPANY];
                
                FAXCOM_x0020_Service_AddRecipient *req2 = [[FAXCOM_x0020_Service_AddRecipient alloc] init];
                req2.name = recipientName;
                req2.company = company;
                req2.faxNumber = faxNumber;
                req2.voiceNumber = @"";
                req2.address1 = @"";
                req2.address2 = @"";
                req2.address3 = @"";
                req2.account = @"";
                [binding AddRecipientUsingParameters:req2];
            }
        }
        
        NSInteger numAttachments = [sendPage.attachmentArray count];
        for(int i=0; i<numAttachments; i++)
        {
            NSString *file = [sendPage.attachmentArray objectAtIndex:i];
            NSString *attname = [NSString stringWithFormat:@"Image-%d.jpg", i+1];
            NSRange range = [file rangeOfString:FILE_ATTACHMENT];
            if( range.location != NSNotFound )
            {
                NSArray *arr = [file componentsSeparatedByString:@"."];
                attname = [NSString stringWithFormat:@"File-%d.%@", i+1, [arr objectAtIndex:[arr count]-1]];
            }
            
            if( index == -1 && range.location == NSNotFound )
            {
                NSString *fname = [inboxPage getFileName];
//                if( [sendPage saveTiffFile:fname image:[UIImage imageWithContentsOfFile:file]] == 0 )
                {
                    file = fname;
                    attname = [NSString stringWithFormat:@"Image-%d.tif", i+1];
                }
            }
            
            @autoreleasepool
            {
                FAXCOM_x0020_Service_AddAttachment *req3 = [[FAXCOM_x0020_Service_AddAttachment alloc] init];
                NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:file];
                req3.attachment = [fh readDataToEndOfFile];
                req3.attname = attname;
                FAXCOM_x0020_ServiceSoapBindingResponse *resp3 = [binding AddAttachmentUsingParameters:req3];
                FAXCOM_x0020_Service_AddAttachmentResponse *body3 = [resp3.bodyParts objectAtIndex:0];
                if( [body3 isKindOfClass:[SOAPFault class]] )
                {
                    SOAPFault *err = (SOAPFault *)body3;
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in AddAttachment): %@", [resp3.error localizedDescription]]];
                    bAccessing = false;
                    return ret;
                }
            }
        }
        
        FAXCOM_x0020_Service_ResultMessage *ret4;
        FAXCOM_x0020_Service_SendFax *req4 = [[FAXCOM_x0020_Service_SendFax alloc] init];
        req4.IDTag = @"fromipad";
        FAXCOM_x0020_ServiceSoapBindingResponse *resp4 = [binding SendFaxUsingParameters:req4];
        FAXCOM_x0020_Service_SendFaxResponse *body4 = [resp4.bodyParts objectAtIndex:0];
        ret4 = body4.SendFaxResult;
        if( ret4.Result.boolValue )
        {
            ret = true;
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in sendClicked): %@", ex.reason]];
        [self terminateSession];
        [self login:YES];
    }
    
    bAccessing = false;
    return ret;
}

- (void)removeStatusMessage:(UITableView *)aTableView forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( ![self canAccess] )
    {
        return;
    }
    
    if( [self login:NO] )
    {
        bAccessing = true;
        FAXCOM_x0020_Service_MessageStatus *sts = [statusPage.sentLogArray objectAtIndex:indexPath.row];
        FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID *req = [[FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueID alloc] init];
        req.uniqueID = sts.UniqueJobID;
        req.recipientIndex = 0;
        FAXCOM_x0020_ServiceSoapBindingResponse *resp = [binding RemoveMessageStatusbyUniqueIDUsingParameters:req];
        FAXCOM_x0020_Service_RemoveMessageStatusbyUniqueIDResponse *body = [resp.bodyParts objectAtIndex:0];
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding RemoveMessageStatusbyUniqueIDUsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in RemoveMessageStatus): %@", [resp.error localizedDescription]]];
                    bAccessing = false;
                    return;
                }
            }
            else
            {
                bAccessing = false;
                return;
            }
        }
        
        FAXCOM_x0020_Service_ResultMessage *ret = body.RemoveMessageStatusbyUniqueIDResult;
        if ( ret.Result.boolValue == YES )
        {
            [statusPage.sentLogArray removeObjectAtIndex:indexPath.row];
            [aTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            [viewerPage writeLog:[NSString stringWithFormat:@"Failed to RemoveMessageStatus: %@", ret.Detail]];
        }
        bAccessing = false;
    }
}

- (BOOL)setStatusLogs
{
    if( ![self canAccess] )
    {
        return NO;
    }
    
    if( ![self login:NO] )
    {
        return NO;
    }
    
    bAccessing = true;
    @try
    {
        FAXCOM_x0020_Service_GetMessageStatuses *req = [[FAXCOM_x0020_Service_GetMessageStatuses alloc] init];
        req.sortColumn = [NSNumber numberWithInt:2]; // sort by date and time
        req.ascending.boolValue = NO;
        FAXCOM_x0020_ServiceSoapBindingResponse *resp = [binding GetMessageStatusesUsingParameters:req];
        FAXCOM_x0020_Service_GetMessageStatusesResponse *body = [resp.bodyParts objectAtIndex:0];
        if( body == nil )
        {
            bAccessing = false;
            return NO;
        }
        FAXCOM_x0020_Service_ArrayOfMessageStatus *ret = body.GetMessageStatusesResult;
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding GetMessageStatusesUsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in setStatusLogs): %@", [resp.error localizedDescription]]];
                    bAccessing = false;
                    return NO;
                }
            }
            else
            {
                bAccessing = false;
                return NO;
            }
        }
        
        [statusPage.sentLogArray removeAllObjects];
        statusPage.sentLogArray = ret.MessageStatus;
        NSInteger num = [statusPage.sentLogArray count];
        for(NSInteger i=num-1; i>=0; i--) // If the fax is a saved template (flag is 0x400), remove it from list.
        {
            FAXCOM_x0020_Service_MessageStatus *sts = [statusPage.sentLogArray objectAtIndex:i];
            if( [sts.FaxStateFlags intValue] & 0x400 )
                [statusPage.sentLogArray removeObjectAtIndex:i];
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"Exception (in setStatusLogs): %@", ex.reason]];
    }
    
    bAccessing = false;
    return YES;
}

- (void)deletePendingLog
{
    if( ![self canAccess] )
    {
        return;
    }
    
    bAccessing = true;
    if( [self login:NO] )
    {
        FAXCOM_x0020_Service_CancelPendingMessage *req = [[FAXCOM_x0020_Service_CancelPendingMessage alloc] init];
        req.uid = ptsMobile.UniqueID;
        req.recipientIndex = ptsMobile.RecipientIndex;
        FAXCOM_x0020_ServiceSoapBindingResponse *resp = [binding CancelPendingMessageUsingParameters:req];
        FAXCOM_x0020_Service_CancelPendingMessageResponse *body = [resp.bodyParts objectAtIndex:0];
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding CancelPendingMessageUsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:[NSString stringWithFormat:@"Error (in CancelPendingMessage): %@", [resp.error localizedDescription]]];
                    bAccessing = false;
                    return;
                }
            }
            else
            {
                bAccessing = false;
                return;
            }
        }
        FAXCOM_x0020_Service_ResultMessage *ret = body.CancelPendingMessageResult;
        if ( ret.Result.boolValue == YES )
        {
            [self performSelector:@selector(setStatusLogs) withObject:nil afterDelay:0.2];
        }
        else
        {
            [viewerPage writeLog:[NSString stringWithFormat:@"Failed to delete: %@", ret.Detail]];
        }
    }
    bAccessing = false;
}

@end
