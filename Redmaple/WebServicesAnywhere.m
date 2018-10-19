//
//  WebServices.m
//  MobileFax
//
//  Created by Zhao                                                     on 1/26/16.
//  Copyright © 2016 Zhao                                                    . All rights reserved.
//

#import <AudioToolbox/AudioServices.h>
#import "WebservicesAnywhere.h"
#import "PageViewController.h"


@implementation WebServicesAnywhere

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
        NSString *sws = [sWebService lowercaseString];
        NSRange range = [sws rangeOfString:@"http://"];
        NSRange range1 = [sws rangeOfString:@"https://"];
        if( range.location == NSNotFound && range1.location == NSNotFound )
        {
            NSString *str = [NSString stringWithFormat:@"https://%@/FAWebService/FAWebService.asmx", sws];
            sws = str;
        }
        binding = [[FAWebServiceMainSoapBinding alloc] initWithAddress:sws];
        
        FAWebServiceMain_LogIn *req = [[FAWebServiceMain_LogIn alloc] init];
        req.userName = sUsername;
        req.password = sPassword;
        FAWebServiceMainSoapBindingResponse *resp = [binding LogInUsingParameters:req];
        
        FAWebServiceMain_LogInResponse *body = [resp.bodyParts objectAtIndex:0];
        if( body == nil )
        {
            if( !inSilent )
            {
                [viewerPage ShowAlertTitle:@"Login failed" message:[resp.error localizedDescription]];
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
            }
            binding = nil;
            bAccessing = false;
            return NO;
        }
        
        FAWebServiceMain_ResultMessage *ret = body.LogInResult;
        if ( ret.Result.boolValue == NO )
        {
            if( !inSilent )
            {
                [viewerPage ShowAlertTitle:@"Login failed" message:ret.Detail];
            }
            binding = nil;
            bAccessing = false;
            return NO;
        }
    }
    @catch (NSException *ex)
    {
        if( !inSilent )
        {
            [viewerPage ShowAlertTitle:@"Error" message:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
        }
    }
    
    bAccessing = false;
    return YES;
}

- (void)terminateSession
{
    if( binding )
    {
        FAWebServiceMain_ReleaseSession *req = [[FAWebServiceMain_ReleaseSession alloc] init];
        [binding ReleaseSessionUsingParameters:req];
        binding = nil;
    }
}

- (BOOL)setStatusLogs
{
    if( ![self canAccess] )
    {
        return NO;
    }
    
    [self terminateSession];
    if( ![self login:NO] )
    {
        return NO;
    }
    
    bAccessing = true;
    @try
    {
        FAWebServiceMain_GetMessageStatuses *req = [[FAWebServiceMain_GetMessageStatuses alloc] init];
        req.sortColumn = [NSNumber numberWithInt:2]; // sort by date and time
        req.ascending = [[USBoolean alloc] initWithBool:NO];
        FAWebServiceMainSoapBindingResponse *resp = [binding GetMessageStatusesUsingParameters:req];
        FAWebServiceMain_GetMessageStatusesResponse *body = [resp.bodyParts objectAtIndex:0];
        if( body == nil )
        {
            bAccessing = false;
            return NO;
        }
        FAWebServiceMain_ArrayOfMessageStatus *ret = body.GetMessageStatusesResult;
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding GetMessageStatusesUsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
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
        for(int i=0; i<[ret.MessageStatus count]; i++)
        {
            FAWebServiceMain_MessageStatus *data = [ret.MessageStatus objectAtIndex:i];
            [statusPage.sentLogArray insertObject:data atIndex:0];
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
        bAccessing = false;
        return NO;
    }
    
    bAccessing = false;
    return YES;
}

- (BOOL)removeStatusMessage:(UITableView *)aTableView forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( ![self canAccess] )
    {
        return NO;
    }
    
    if( [self login:NO] )
    {
        bAccessing = true;
        FAWebServiceMain_MessageStatus *sts = [statusPage.sentLogArray objectAtIndex:indexPath.row];
        FAWebServiceMain_RemoveMessageStatusbyUniqueID *req = [[FAWebServiceMain_RemoveMessageStatusbyUniqueID alloc] init];
        req.uniqueID = sts.UniqueJobID;
        req.recipientIndex = 0;
        FAWebServiceMainSoapBindingResponse *resp = [binding RemoveMessageStatusbyUniqueIDUsingParameters:req];
        FAWebServiceMain_RemoveMessageStatusbyUniqueIDResponse *body = [resp.bodyParts objectAtIndex:0];
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding RemoveMessageStatusbyUniqueIDUsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
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
        
        FAWebServiceMain_ResultMessage *ret = body.RemoveMessageStatusbyUniqueIDResult;
        if ( ret.Result.boolValue == YES )
        {
            [statusPage.sentLogArray removeObjectAtIndex:indexPath.row];
            [aTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        bAccessing = false;
    }
    
    return YES;
}

- (bool)doSendFax:(NSArray *)recipientSet pack:(NSDictionary *)pack
{
    if( ![self canAccess] )
    {
        return false;
    }
    
    bAccessing = true;
    bool ret = false;
    @try
    {
        FAWebServiceMain_SetSenderInformation *req1 = [[FAWebServiceMain_SetSenderInformation alloc] init];
        req1.name = [pack valueForKey:@"SenderName"];
        req1.faxNumber = [pack valueForKey:@"SenderAddr"];
        req1.voiceNumber = [pack valueForKey:@"SenderPhon"];
        req1.company = [pack valueForKey:@"SenderComp"];
        req1.email = @"";
        req1.address1 = @"";
        req1.address2 = @"";
        req1.address3 = @"";
        FAWebServiceMainSoapBindingResponse *resp1 = [binding SetSenderInformationUsingParameters:req1];
        FAWebServiceMain_SetSenderInformationResponse *body1 = [resp1.bodyParts objectAtIndex:0];
        if( [body1 isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp1 = [binding SetSenderInformationUsingParameters:req1];
                body1 = [resp1.bodyParts objectAtIndex:0];
                if( [body1 isKindOfClass:[SOAPFault class]] )
                {
                    [viewerPage writeLog:@"Failed to set the sender information with the web service"];
                    bAccessing = false;
                    return ret;
                }
            }
            else
            {
                [viewerPage writeLog:@"Login failed when sending fax"];
                bAccessing = false;
                return ret;
            }
        }
        
        NSDictionary *dic = [recipientSet objectAtIndex:0];
        NSString *recipientName = [dic objectForKey:KEY_NAME];
        NSString *faxNumber = [dic objectForKey:KEY_ADDRESS];
        NSString *company = [dic objectForKey:KEY_COMPANY];
        
        FAWebServiceMain_NewFaxMessage *req2 = [[FAWebServiceMain_NewFaxMessage alloc] init];
        req2.priority = [NSNumber numberWithInt:1];
        req2.sendTime = @"0.0";
        req2.resolution = [NSNumber numberWithInt:1];
        req2.subject = [pack valueForKey:@"Subject"];
        req2.coverpage = [[pack valueForKey:@"CoverPageOn"] boolValue] ? @"" : @"(none)";
        req2.memo = [pack valueForKey:@"Memo"];
        req2.senderName = @"";
        req2.senderFax = @"";
        req2.recipientName = recipientName;
        req2.recipientCompany = company;
        req2.recipientFax = faxNumber;
        req2.recipientVoice = @"";
        req2.recipientAccount = @"";
        [binding NewFaxMessageUsingParameters:req2];
        
        for(int i=1; i<[recipientSet count]; i++)
        {
            NSDictionary *dic = [recipientSet objectAtIndex:i];
            recipientName = [dic objectForKey:KEY_NAME];
            faxNumber = [dic objectForKey:KEY_ADDRESS];
            company = [dic objectForKey:KEY_COMPANY];
            
            FAWebServiceMain_AddRecipient *req2 = [[FAWebServiceMain_AddRecipient alloc] init];
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
            
            if( range.location == NSNotFound )
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
                FAWebServiceMain_AddAttachment *req3 = [[FAWebServiceMain_AddAttachment alloc] init];
                NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:file];
                req3.attachment = [fh readDataToEndOfFile];
                req3.attname = attname;
                FAWebServiceMainSoapBindingResponse *resp3 = [binding AddAttachmentUsingParameters:req3];
                FAWebServiceMain_AddAttachmentResponse *body3 = [resp3.bodyParts objectAtIndex:0];
                if( [body3 isKindOfClass:[SOAPFault class]] )
                {
                    SOAPFault *err = (SOAPFault *)body3;
                    [viewerPage ShowAlertTitle:[NSString stringWithFormat:@"Cannot attach #%d item",i+1] message:err.faultstring];
                    [viewerPage writeLog:@"Failed to attach an image"];
                    bAccessing = false;
                    return ret;
                }
            }
        }
        
        FAWebServiceMain_SendFax *req4 = [[FAWebServiceMain_SendFax alloc] init];
        FAWebServiceMainSoapBindingResponse *resp4 = [binding SendFaxUsingParameters:req4];
        FAWebServiceMain_SendFaxResponse *body4 = [resp4.bodyParts objectAtIndex:0];
        FAWebServiceMain_ResultMessage *ret4 = body4.SendFaxResult;
        
        if( ret4.Result.boolValue )
        {
            ret = true;
        }
        else
        {
            [viewerPage ShowAlertTitle:@"Error" message:[NSString stringWithFormat:@"Detail: %@\nData: %@", ret4.Detail, ret4.Data]];
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
        [self terminateSession];
        [self login:YES];
    }
    
    bAccessing = false;
    return ret;
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
        FAWebServiceMain_GetReceivedMessagesCount *req0 = [[FAWebServiceMain_GetReceivedMessagesCount alloc] init];
        FAWebServiceMainSoapBindingResponse *resp0 = [binding GetReceivedMessagesCountUsingParameters:req0];
        FAWebServiceMain_GetReceivedMessagesCountResponse *body0 = [resp0.bodyParts objectAtIndex:0];
        if( [body0 isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp0 = [binding GetReceivedMessagesCountUsingParameters:req0];
                body0 = [resp0.bodyParts objectAtIndex:0];
                if( [body0 isKindOfClass:[SOAPFault class]] )
                {
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
        
        FAWebServiceMain_GetReceivedMessages *req1 = [[FAWebServiceMain_GetReceivedMessages alloc] init];
        req1.loadImage = [[USBoolean alloc] initWithBool:NO];
        req1.sortColumn = [NSNumber numberWithInt:3];
        req1.ascending = [[USBoolean alloc] initWithBool:NO];
        FAWebServiceMainSoapBindingResponse *resp1 = [binding GetReceivedMessagesUsingParameters:req1];
        FAWebServiceMain_GetReceivedMessagesResponse *body1 = [resp1.bodyParts objectAtIndex:0];
        
        FAWebServiceMain_ArrayOfRxStatus *ret1 = body1.GetReceivedMessagesResult;
        if( body1 == nil || ret1 == nil )
        {
            bAccessing = false;
            return;
        }
        
        NSInteger num = [ret1.RxStatus count] - [listOfMeta count];
        if( num > 0 )
        {
            NSInteger count = [ret1.RxStatus count];
            for(NSInteger i = 0; i < num; i++)
            {
                FAWebServiceMain_RxStatus *meta = [ret1.RxStatus objectAtIndex:count-1-i];
                meta.Status = [NSNumber numberWithInt:1]; // Not read yet
                [listOfMeta insertObject:meta atIndex:i];
            }
            [inboxPage performSelector:@selector(deselectFaxTable) withObject:nil afterDelay:0.2];
            
            int cnt = 0;
            for(NSInteger i = 0; i < [listOfMeta count]; i++)
            {
                FAWebServiceMain_RxStatus *meta = [listOfMeta objectAtIndex:i];
                if( meta.Status.intValue == 1 )
                    cnt += 1;
            }
            [inboxPage setApplicationBadgeNumber:cnt];
            AudioServicesPlaySystemSound(1007);
        }
    }
    @catch (NSException *ex)
    {
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
        FAWebServiceMain_GetReceivedMessages *req = [[FAWebServiceMain_GetReceivedMessages alloc] init];
        req.loadImage = [[USBoolean alloc] initWithBool:NO];
        req.sortColumn = [NSNumber numberWithInt:3];
        req.ascending = [[USBoolean alloc] initWithBool:NO];
        FAWebServiceMainSoapBindingResponse *resp = [binding GetReceivedMessagesUsingParameters:req];
        FAWebServiceMain_GetReceivedMessagesResponse *body = [resp.bodyParts objectAtIndex:0];
        if( [body isKindOfClass:[SOAPFault class]] )
        {
            [self terminateSession];
            if( [self login:YES] )
            {
                resp = [binding GetReceivedMessagesUsingParameters:req];
                body = [resp.bodyParts objectAtIndex:0];
                if( [body isKindOfClass:[SOAPFault class]] )
                {
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
        
        FAWebServiceMain_ArrayOfRxStatus *ret = body.GetReceivedMessagesResult;
        [listOfMeta removeAllObjects];
        for(int i=0; i<[ret.RxStatus count]; i++)
        {
            FAWebServiceMain_RxStatus *meta = [ret.RxStatus objectAtIndex:i];
            meta.Status = [NSNumber numberWithInt:0]; // Read already
            [listOfMeta insertObject:meta atIndex:0];
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
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
        FAWebServiceMain_GetReceivedMessagesEx *req = [[FAWebServiceMain_GetReceivedMessagesEx alloc] init];
        req.loadImage = [[USBoolean alloc] initWithBool:YES];
        req.sortColumn = [NSNumber numberWithInt:3];
        req.ascending = [[USBoolean alloc] initWithBool:NO];
        req.start = [NSNumber numberWithInt:[listOfMeta count] - 1 - nSelectedIndex];
        req.count = [NSNumber numberWithInt:1];
        FAWebServiceMainSoapBindingResponse *resp = [binding GetReceivedMessagesExUsingParameters:req];
        FAWebServiceMain_GetReceivedMessagesExResponse *body = [resp.bodyParts objectAtIndex:0];
        if( body==nil || [body isKindOfClass:[SOAPFault class]] )
        {
            [viewerPage ShowAlertTitle:@"Error" message:[resp.error localizedDescription]];
            bAccessing = false;
            return @"";
        }
        FAWebServiceMain_ArrayOfRxStatus *ret = body.GetReceivedMessagesExResult;
        
        if( ret != nil && [ret.RxStatus count] > 0 )
        {
            FAWebServiceMain_RxStatus *data = [ret.RxStatus objectAtIndex:0];
            NSError *error;
            if( [data.Image writeToFile:tempFile options:0 error:&error] )
            {
                filename = tempFile;
            }
            else
            {
                [viewerPage ShowAlertTitle:@"Error" message: error.description];
                NSLog(@"writeToFile failed with error %@", error);
            }
        }
    }
    @catch (NSException *ex)
    {
        [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
    }
    bAccessing = false;
    
    return filename;
}

- (BOOL)removeFax:(NSIndexPath *)indexPath
{
    if( [self login:NO] )
    {
        bAccessing = true;
        @try
        {
            FAWebServiceMain_RxStatus *meta = [listOfMeta objectAtIndex:indexPath.row];
            FAWebServiceMain_RemoveReceivedMessagebyName *req1 = [[FAWebServiceMain_RemoveReceivedMessagebyName alloc] init];
            req1.name = meta.ImageFileName;
            FAWebServiceMainSoapBindingResponse *resp1 = [binding RemoveReceivedMessagebyNameUsingParameters:req1];
            FAWebServiceMain_RemoveReceivedMessagebyNameResponse *body1 = [resp1.bodyParts objectAtIndex:0];
            if( [body1 isKindOfClass:[SOAPFault class]] )
            {
                [self terminateSession];
                if( [self login:YES] )
                {
                    resp1 = [binding RemoveReceivedMessagebyNameUsingParameters:req1];
                    body1 = [resp1.bodyParts objectAtIndex:0];
                    if( [body1 isKindOfClass:[SOAPFault class]] )
                    {
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
            
            FAWebServiceMain_ResultMessage *ret1 = body1.RemoveReceivedMessagebyNameResult;
            if ( ret1.Result.boolValue == NO )
            {
                [viewerPage ShowAlertTitle:@"Cannot delete" message:ret1.Detail];
                bAccessing = false;
                return NO;
            }
            else
            {
                NSString *file = [FaxFolder stringByAppendingPathComponent:meta.ImageFileName];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:file error:nil];
                
                [listOfMeta removeObjectAtIndex:indexPath.row];
                [inboxPage.tableView reloadData];
                [inboxPage.faxTable reloadData];
                if( [meta.ImageFileName isEqualToString:theFaxID] )
                {
                    theFaxID = @"";
                }
            }
        }
        @catch (NSException *ex)
        {
            [viewerPage writeLog:[NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, ex.reason]];
        }
        bAccessing = false;
    }
    
    return YES;
}

#ifdef __IPHONE_8_0

- (BOOL)checkNotificationType:(UIUserNotificationType)type
{
    UIUserNotificationSettings *currentSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    return (currentSettings.types & type);
}

#endif

@end
