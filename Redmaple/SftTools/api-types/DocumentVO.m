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

#import "DocumentVO.h"

@implementation DocumentVO

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) setDocumentCreatedBy : (int) docCreatedBy {
    documentCreatedBy = docCreatedBy;
}

- (int) getDocumentCreatedBy {
    return documentCreatedBy;
}

- (void) setDataFileId : (int) fileId {
    dataFileId = fileId;
}

- (int) getDataFileId {
    return dataFileId;
}

- (void) setDocumentDateCreated: (NSString*) dateCreated {
    documentDateCreated = dateCreated;
}

- (NSString*) getDocumentDateCreated {
    return documentDateCreated;
}

- (void) setDocumentDateLastUpdated: (NSString*) dateLastUpdated {
    documentDateLastUpdated = dateLastUpdated;
}

- (NSString*) getDocumentDateLastUpdated {
    return documentDateLastUpdated;
}

- (void) setDocumentDescription: (NSString*) description {
    documentDescription = description;
}

- (NSString*) getDocumentDescription {
    return documentDescription;
}

- (void) setDirectoryId : (int) dirId {
    directoryId = dirId;
}

- (int) getDirectoryId {
    return directoryId;
}

- (void) setPageCount : (int) pgs {
    pageCount = pgs;
}

- (int) getPageCount {
    return pageCount;
}

- (void) setDisplayOrder : (int) displayOrdr {
    displayOrder = displayOrdr;
}

- (int) getDisplayOrder {
    return displayOrder;
}

- (void) setDocumentId : (int) docId {
    documentId = docId;
}

- (int) getDocumentId {
    return documentId;
}

- (BOOL) isEncrypted {
    return encrypted;
}

- (void) setEncrypted : (BOOL) encrptd {
    encrypted = encrptd;
}

- (void) setHashValue: (NSString*) hashVal; {
    hashValue = hashVal;
}

- (NSString*) getHashValue {
    return hashValue;
}

- (BOOL) isDownloadable {
    return downloadable;
}

- (void) setDownloadable : (BOOL) download {
    downloadable = download;
}

- (void) setDocumentLastUpdatedBy : (int) lastUpdatedBy {
    documentLastUpdatedBy = lastUpdatedBy;
}

- (int) getDocumentLastUpdatedBy {
    return documentLastUpdatedBy;
}

- (void) setDocumentName: (NSString*) name {
    documentName = name;
}

- (NSString*) getDocumentName {
    return documentName;
}

- (void) setSize : (long) fileSize {
    size = fileSize;
}

- (long) getSize {
    return size;
}


- (BOOL) isDirectory {
    return isDirectory;
}

- (void) setIsDirectory : (BOOL) isdis {
    isDirectory = isdis;
}

@end
