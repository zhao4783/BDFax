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

#import <Foundation/Foundation.h>

/**
 This class is the value object of Document.
 @author Mahfuzul Amin
 */
@interface DocumentVO : NSObject {
    int documentCreatedBy;
    int dataFileId;
    NSString *documentDateCreated;
    NSString *documentDateLastUpdated;
    NSString *documentDescription;
    int directoryId;
    int displayOrder;
    int documentId;
    int pageCount;
    BOOL encrypted;
    NSString *hashValue;
    BOOL downloadable;
    int documentLastUpdatedBy;
    NSString *documentName;
    long size;
    
    BOOL isDirectory;
}

- (void) setDocumentCreatedBy : (int) docCreatedBy;
- (int) getDocumentCreatedBy;

- (void) setDataFileId : (int) fileId;
- (int) getDataFileId;

- (void) setPageCount : (int) pgs;
- (int) getPageCount;

- (void) setDocumentDateCreated: (NSString*) dateCreated;
- (NSString*) getDocumentDateCreated;

- (void) setDocumentDateLastUpdated: (NSString*) dateLastUpdated;
- (NSString*) getDocumentDateLastUpdated;

- (void) setDocumentDescription: (NSString*) description;
- (NSString*) getDocumentDescription;

- (void) setDirectoryId : (int) dirId;
- (int) getDirectoryId;

- (void) setDisplayOrder : (int) displayOrdr;
- (int) getDisplayOrder;

- (void) setDocumentId : (int) docId;
- (int) getDocumentId;

- (BOOL) isEncrypted;
- (void) setEncrypted : (BOOL) encrptd;

- (void) setHashValue: (NSString*) hashVal;
- (NSString*) getHashValue;

- (BOOL) isDownloadable;
- (void) setDownloadable : (BOOL) downloadable;

- (void) setDocumentLastUpdatedBy : (int) lastUpdatedBy;
- (int) getDocumentLastUpdatedBy;

- (void) setDocumentName: (NSString*) name;
- (NSString*) getDocumentName;

- (void) setSize : (long) fileSize;
- (long) getSize;

- (BOOL) isDirectory;
- (void) setIsDirectory : (BOOL) isdis;

@end
