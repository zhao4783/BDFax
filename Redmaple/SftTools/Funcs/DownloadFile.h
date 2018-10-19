//
//  downloadFile.h
//  MobileFax
//
//  Created by Zhao                                                     on 8/1/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#ifndef downloadFile_h
#define downloadFile_h

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "GetDelivery.h"
#import "DocumentVO.h"

/**
 This class implements the getDeliveries web service.
 @author Mahfuzul Amin
 */
@interface DownloadFile : NSObject
{
    NSURLConnection *fileDownloadConn;
    NSMutableData *fileWebData;
    NSMutableData *targetData;
    NSDictionary *jsonDictionary;
    NSString *savedDocumentName;
    DocumentVO *documentVO;
    DeliveryVO *deliveryVO;
    int dataFileId;
    NSString *documentId;
    NSString *filePath;
    long chunkIndex;
    long chunkSize;
    unsigned long dataFileSize;
    unsigned long fileOffset;
}

- (id)initWithDeliveryVO:(DeliveryVO *)delV filePath:(NSString *)path;
- (void)getDataFile;

@end

#endif /* downloadFile_h */
