//
//  UploadInChunks.m
//  BDSiPadApp
//
//  Created by Lion User on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UploadByChunks.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ChunkSizeHandler.h"
#import "UserInfo.h"
#import "Util.h"
#import "BDSiOSConstant.h"
#import "JSON.h"

extern UserInfo *userInfo;

@implementation UploadByChunks

@synthesize delegate;

@synthesize request;

@synthesize dataFileIdList;
@synthesize fileSizeList;
@synthesize aKeyList;
@synthesize fileNameList;
@synthesize tempFilePathList;

- (id) init {
    self = [super init];

    filesCount = 0;
    currentFileIndex = 0;
    transferredSize = 0;
    i = 0;
    fileSize = @"";
    dataFileIdStr = @"";
    offsetStr = @"";
    lengthStr = @"";
    aKey = @"";
    
    info = userInfo;
    
    csh = [[ChunkSizeHandler alloc] init];
    [csh ChunkSizeHandler:DEFAULT_CHUNK_SIZE];
    
    return self;
}

#pragma mark - Initiate Data File Upload

- (IBAction)initiateDataFileUpload
{
    transferredSize = 0;
    aKey = [aKeyList objectAtIndex:currentFileIndex];
    fileSize = [fileSizeList objectAtIndex:currentFileIndex];
    filesCount = [fileSizeList count];
    
    NSMutableString *url = [Util buildUrl: [info getServerName] : INITIATE_DATA_FILE_UPLOAD : [info isUseSSL]];
    
	[request cancel];
	[self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
    [request setRequestMethod: @"POST"];
	[request setPostValue:[info getSessionId] forKey:@"sessionId"];
	[request setPostValue:fileSize forKey:@"uploadFileSize"];
	[request setTimeOutSeconds:20];
    
	[request setShouldContinueWhenAppEntersBackground:YES];
	[request setUploadProgressDelegate:progressIndicator];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(initiateUploadFailed:)];
	[request setDidFinishSelector:@selector(initiateUploadFinished:)];
    [request startAsynchronous];
}


- (void)initiateUploadFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"initiate Upload failed. Error: %@", [theRequest error]);
    [delegate uploadFailed:theRequest];
}

- (void)initiateUploadFinished:(ASIHTTPRequest *)theRequest
{
    NSString* responseStr = theRequest.responseString;
    NSLog(@"%@",responseStr);
    
    NSDictionary *responseDictionary = [responseStr JSONValue];
    int returnCode = [[responseDictionary objectForKey:@"returnCode"] intValue];
    NSLog(@"initiateUploadFinished - RC: %d", returnCode);
    
    if(returnCode == RC_SUCCESS) {
        dataFileIdStr = [responseDictionary objectForKey:@"dataFileId"];
        
        // update data file upload
        
        unsigned long long size = [fileSize longLongValue];
        if(transferredSize <= size) {
            
            // get length of bytes to be read
            int chunkSize = [Util getAvailableSize:transferredSize :DEFAULT_CHUNK_SIZE :size];
            NSLog(@"Filesize:%llu; Transferred size: %llu; chunksize: %d", size, transferredSize, chunkSize);
            
            offsetStr = [[NSString alloc]initWithFormat:@"%llu", transferredSize];
            lengthStr = [[NSString alloc]initWithFormat:@"%d", chunkSize];
            
            transferredSize += chunkSize;
            
            [self updateDataFileUpload];
        }
        
    } else {
    }
}

#pragma mark - Update Data File Upload


- (IBAction)updateDataFileUpload
{
    
    NSMutableString *url = [Util buildUrl: [info getServerName] : UPDATE_DATA_FILE_UPLOAD : [info isUseSSL]];
    
    start = [[NSDate date] timeIntervalSince1970];
    
	[request cancel];
	[self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
    [request setRequestMethod: @"POST"];
	[request setPostValue:[info getSessionId] forKey:@"sessionId"];
	[request setPostValue:dataFileIdStr forKey:@"dataFileId"];
	[request setPostValue:offsetStr forKey:@"offset"];
	[request setPostValue:lengthStr forKey:@"length"];
    
    // Decrypt the file and attach it
    long offset = [offsetStr longLongValue];
    int length = [lengthStr intValue];
    
    // create a temporary file of chunk size
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:[tempFilePathList objectAtIndex:currentFileIndex]];
    [handle seekToFileOffset:offset];
    
    NSData *data = [handle readDataOfLength:length];
    [request setData:data forKey:aKey];
    
	[request setTimeOutSeconds:20];
    
	[request setShouldContinueWhenAppEntersBackground:YES];
	[request setUploadProgressDelegate:progressIndicator];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(updateUploadFailed:)];
	[request setDidFinishSelector:@selector(updateUploadFinished:)];
    [request startAsynchronous];
}


- (void)updateUploadFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"initiate Upload failed. Error: %@", [theRequest error]);
    [delegate uploadFailed:theRequest];
}

- (void)updateUploadFinished:(ASIHTTPRequest *)theRequest
{
    interval = [[NSDate date] timeIntervalSince1970] - start;
    int chunkSize = [csh computeChunkSize:interval];
    
    NSString* responseStr = theRequest.responseString;
    NSLog(@"%@",responseStr);
    
    NSDictionary *responseDictionary = [responseStr JSONValue];
    int returnCode = [[responseDictionary objectForKey:@"returnCode"] intValue];
    NSLog(@"updateUploadFinished - RC: %d", returnCode);
    
    if(returnCode == RC_SUCCESS) {
        
        unsigned long long size = [fileSize longLongValue];
        if(transferredSize < size) {
            
            // get length of bytes to be read
            chunkSize = [Util getAvailableSize:transferredSize :chunkSize :size];
            NSLog(@"Filesize:%llu; Transferred size: %llu; chunksize: %d", size, transferredSize, chunkSize);
            
            offsetStr = [[NSString alloc]initWithFormat:@"%llu", transferredSize];
            lengthStr = [[NSString alloc]initWithFormat:@"%d", chunkSize];
            transferredSize += chunkSize;
            
            [self updateDataFileUpload];
        } else {
            // if nothing to update, complete data file upload
            [self completeDataFileUpload];
        }
        
    } else {
    }
}

#pragma mark - Complete Data File Upload


- (IBAction)completeDataFileUpload
{
    NSMutableString *url = [Util buildUrl: [info getServerName] : COMPLETE_DATA_FILE_UPLOAD : [info isUseSSL]];
    
	[request cancel];
	[self setRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]]];
    [request setRequestMethod: @"POST"];
	[request setPostValue:[info getSessionId] forKey:@"sessionId"];
	[request setPostValue:dataFileIdStr forKey:@"dataFileId"];
	[request setTimeOutSeconds:20];
    
	[request setShouldContinueWhenAppEntersBackground:YES];
	[request setUploadProgressDelegate:progressIndicator];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(completeUploadFailed:)];
	[request setDidFinishSelector:@selector(completeUploadFinished:)];
    [request startAsynchronous];
}


- (void)completeUploadFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"completeUploadFailed. Error: %@", [theRequest error]);
    [delegate uploadFailed:theRequest];
}

- (void)completeUploadFinished:(ASIHTTPRequest *)theRequest
{
    NSString* responseStr = theRequest.responseString;
    NSLog(@"%@",responseStr);
    
    NSDictionary *responseDictionary = [responseStr JSONValue];
    int returnCode = [[responseDictionary objectForKey:@"returnCode"] intValue];
    NSLog(@"completeUploadFinished - RC: %d", returnCode);
    
    if(returnCode == RC_SUCCESS) {
        currentFileIndex++;
        
        // Store the dataFileIds
        [dataFileIdList addObject:dataFileIdStr];
        [fileNameList addObject:aKey];
        
        if(currentFileIndex < filesCount){
            fileSize = [fileSizeList objectAtIndex:currentFileIndex];
            [self initiateDataFileUpload];
            
        } else {
            // call the add files api 
            [delegate uploadFinished:theRequest];
        }
    } else {
    }
}


- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{
}

- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
}



@end
