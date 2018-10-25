//
//  SendDelivery.m
//  MobileFax
//
//  Created by Zhao                                                     on 8/3/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SendDelivery.h"
#import "Util.h"
#import "JSON.h"
#import "BDSiOSConstant.h"
#import "UploadByChunks.h"
#import "ASIHTTPRequest.h"
#import "PageViewController.h"

extern UserInfo *userInfo;

@implementation SendDelivery
@synthesize request;

UploadByChunks *ubc;

- (id)initWithPackage:(NSDictionary *)pack recipientList:(NSArray *)list index:(int)index
{
    self = [super init];
    if (self)
    {
        // Initialization code here.
        delvPackage = pack;
        recipientList = list;
        recipientIndex = index;
    }
    
    return self;
}

- (void)sendDelivery
{
    ubc = [[UploadByChunks alloc] init];
    ubc.delegate = self;
    
    //NSMutableDictionary *filesDict;
    //filesDict = [self getFilesDictionary];
    
    ubc.fileSizeList =  [[NSMutableArray alloc] init];
    ubc.aKeyList = [[NSMutableArray alloc] init];
    ubc.dataFileIdList = [[NSMutableArray alloc] init];
    ubc.fileNameList = [[NSMutableArray alloc] init];
    ubc.tempFilePathList = [[NSMutableArray alloc] init];
    
    NSArray *arr = [delvPackage valueForKey:@"Attachments"];
    for(int i=0; i<[arr count]; i++)
    {
        NSString *filePath = [arr objectAtIndex:i];
        NSArray *sr = [filePath componentsSeparatedByString:@"/"];
        NSString *fileName = [sr lastObject];

        unsigned long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
        NSString *fileSizeStr = [NSString stringWithFormat:@"%llu", fileSize];
        
        [ubc.fileSizeList addObject:fileSizeStr];
        [ubc.aKeyList addObject:fileName];
        [ubc.tempFilePathList addObject:filePath];
    }
    
    long totalFiles = [ubc.fileSizeList count];
    
    if(totalFiles > 0){
        [ubc initiateDataFileUpload];
    } else {
        [self uploadFinished:nil];
    }
}

- (void)sendFinished:(ASIHTTPRequest *)theRequest
{
    NSString* responseStr = theRequest.responseString;
    
    NSString *message = nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    NSDictionary *responseDictionary = [responseStr JSONValue];
    int returnCode = [[responseDictionary objectForKey:@"returnCode"] intValue];
    NSLog(@"RC: %d", returnCode);

    if(returnCode == RC_SUCCESS)
    {
        NSLog(@"Finished sending to the recipient.");
    }
    NSMutableArray *arrAtach = [delvPackage valueForKey:@"Attachments"];
    [viewerPage removeFilesfromArray:arrAtach];
    sendPage.bSendSftfax = NO;
}

- (void)sendFailed:(ASIHTTPRequest *)theRequest
{
    NSMutableArray *arrAtach = [delvPackage valueForKey:@"Attachments"];
    [viewerPage removeFilesfromArray:arrAtach];
    NSLog(@"Failed to send to recipient %d", recipientIndex+1);
    sendPage.bSendSftfax = NO;
}

- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{
    [self sendFailed:theRequest];
}

- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
    NSString *dataFileIdsStr = @"";
    NSString *fileNamesStr = @"";
    
    long totalFiles = [ubc.dataFileIdList count];
    
    for(int i=0; i< totalFiles; i++){
        if(i == 0){
            dataFileIdsStr = [dataFileIdsStr stringByAppendingFormat:@"%@", [ubc.dataFileIdList objectAtIndex:i]];
        } else {
            dataFileIdsStr = [dataFileIdsStr stringByAppendingFormat:@":%@", [ubc.dataFileIdList objectAtIndex:i]];
        }
    }
    
    for(int i=0; i<totalFiles; i++){
        if(i==0){
            fileNamesStr = [fileNamesStr stringByAppendingFormat:@"%@", [ubc.fileNameList objectAtIndex:i]];
        }else {
            fileNamesStr = [fileNamesStr stringByAppendingFormat:@":%@", [ubc.fileNameList objectAtIndex:i]];
        }
    }
    
    
    NSMutableString *url = [Util buildUrl: [userInfo getServerName] : CREATE_DELIVERY_WITH_DATA_FILES_URL : [userInfo isUseSSL]];
    
    NSString *delvTo = @"";
    if( recipientIndex >= 0 )
    {
        NSDictionary *dic = [recipientList objectAtIndex:recipientIndex];
        delvTo = [dic valueForKey:KEY_ADDRESS];
    }
    else
    {
        for(int i=0; i<[recipientList count]; i++)
        {
            NSDictionary *dic = [recipientList objectAtIndex:i];
            NSString *recip = [dic valueForKey:KEY_ADDRESS];
            delvTo = [delvTo stringByAppendingString:recip];
            if( i+1 < [recipientList count] )
            {
                delvTo = [delvTo stringByAppendingString:@", "];
            }
        }
    }
    [request cancel];
    [self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
    [request setRequestMethod: @"POST"];
    [request setPostValue:[userInfo getSessionId] forKey:@"sessionId"];
    [request setPostValue:[delvPackage valueForKey:@"Subject"] forKey:@"deliveryName"];
    [request setPostValue:delvTo forKey:@"deliveryTo"];
    [request setPostValue:@"" forKey:@"deliveryCc"];
    [request setPostValue:@"" forKey:@"deliveryBcc"];
    [request setPostValue:@"" forKey:@"secureMessage"];
    [request setPostValue:[delvPackage valueForKey:@"Memo"] forKey:@"message"];
    [request setPostValue:@"true" forKey:@"sendNotificationEmail"];
    [request setPostValue:delvTo forKey:@"notificationEmailList"];
    [request setPostValue:@"false" forKey:@"requireSignIn"];
    [request setPostValue:fileNamesStr forKey:@"documentNameList"];
    [request setPostValue:dataFileIdsStr forKey:@"dataFileIdList"];
    if( recipientIndex >= 0 )
    {
        NSNumber *pages = [delvPackage valueForKey:@"CountOfPages"];
        NSArray *arr = [delvPackage valueForKey:@"Attachments"];
        NSString *filename = [arr objectAtIndex:0];
        NSArray *arr2 = [filename componentsSeparatedByString:@"."];
        NSString *cmd = [NSString stringWithFormat:@"{\"noTranslating\": \"true\", \"pageCount\": \"%d\",\"extension\": \"%@\"}", pages.intValue, [arr2 objectAtIndex:1]];
        [request setPostValue:cmd forKey:@"translationSettings"];
    }
    [request setTimeOutSeconds:3*60];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(sendFailed:)];
    [request setDidFinishSelector:@selector(sendFinished:)];
    
    [request startAsynchronous];
}

@end

