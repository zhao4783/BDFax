//
//  UploadInChunks.h
//  BDSiPadApp
//
//  Created by Lion User on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ChunkSizeHandler.h"
#import "UserInfo.h"

@class ASIFormDataRequest;

//delegate to return amount entered by the user
@protocol UploadByChunksDelegate <NSObject>

- (void)uploadFailed:(ASIHTTPRequest *)theRequest;
- (void)uploadFinished:(ASIHTTPRequest *)theRequest;

@end

@interface UploadByChunks : NSObject {
    ASIFormDataRequest *request;
    IBOutlet UIProgressView *progressIndicator;
    id<UploadByChunksDelegate> delegate;
    
    int filesCount;
    NSMutableArray *fileSizeList;
    NSMutableArray *aKeyList;
    NSMutableArray *dataFileIdList;
    NSMutableArray *fileNameList;
    NSMutableArray *tempFilePathList;
    
    int currentFileIndex;
    unsigned long long transferredSize;
    unsigned long long interval;
    unsigned long long start;
    
    ChunkSizeHandler *csh;
    
    //Files
    UILabel *filesLabel;
    UIButton *attachButton;
    int i;
    UserInfo *info;
    
    NSString *fileSize;
    NSString *dataFileIdStr;
    NSString *offsetStr;
    NSString *lengthStr;
    NSString *aKey;
}

@property (retain, nonatomic) ASIFormDataRequest *request;

- (IBAction)initiateDataFileUpload;
- (void)initiateUploadFailed:(ASIHTTPRequest *)theRequest;
- (void)initiateUploadFinished:(ASIHTTPRequest *)theRequest;

- (IBAction)updateDataFileUpload;
- (void)updateUploadFailed:(ASIHTTPRequest *)theRequest;
- (void)updateUploadFinished:(ASIHTTPRequest *)theRequest;

- (IBAction)completeDataFileUpload;
- (void)completeUploadFailed:(ASIHTTPRequest *)theRequest;
- (void)completeUploadFinished:(ASIHTTPRequest *)theRequest;

@property (retain, nonatomic) id delegate;


@property (nonatomic, retain) NSMutableArray *fileSizeList;
@property (nonatomic, retain) NSMutableArray *aKeyList;
@property (nonatomic, retain) NSMutableArray *dataFileIdList;
@property (nonatomic, retain) NSMutableArray *fileNameList;
@property (nonatomic, retain) NSMutableArray *tempFilePathList;

@end