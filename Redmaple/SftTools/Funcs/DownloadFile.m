//
//  downloadFile.m
//  MobileFax
//
//  Created by Zhao                                                     on 8/1/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadFile.h"
#import "Util.h"
#import "JSON.h"
#import "BDSiOSConstant.h"
#import "NSData+CommonCrypto.h"
#import "GetDelivery.h"
#import "PageViewController.h"

extern UserInfo *userInfo;

@implementation DownloadFile

- (id)initWithDeliveryVO:(DeliveryVO *)delV filePath:(NSString *)path
{
    self = [super init];
    if (self)
    {
        // Initialization code here.
        fileOffset = 0;
        deliveryVO = delV;
        filePath = path;
        targetData = [NSMutableData data];
    }
    
    return self;
}

- (void)getDataFile
{
    @try
    {
        documentVO = [deliveryVO.getDocumentVOs objectAtIndex:0];
        dataFileId = [documentVO getDataFileId];
        documentId = [NSString stringWithFormat:@"%d", [documentVO getDocumentId]];
        dataFileSize = [documentVO getSize];
        
        //chunkSize =[handler computeChunkSize:interval];
        chunkSize = 3 * 1024 * 1024;
        NSLog(@"Chunk size: %ld", chunkSize);
        
        //Build the URL
        NSMutableString *url = [Util buildUrl: [userInfo getServerName]: CHUNK_FILE_DL_URL : [userInfo isUseSSL]];
        NSLog(@"Server URL: %@", url);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
        
        //Populate the parameters
        NSMutableString *params = [[NSMutableString alloc] initWithString:@""];
        [params appendString: @"sessionId="];
        [params appendString: [userInfo getSessionId]];
        [params appendString: @"&dataFileId="];
        [params appendString: [NSString stringWithFormat:@"%d", dataFileId]];
        [params appendString: @"&referenceDocumentId="];
        [params appendString: documentId];
        [params appendString: @"&referenceDocumentType="];
        [params appendString: [NSString stringWithFormat:@"%d", DOCUMENT_TYPE_REGULAR]];
        [params appendString: @"&offset="];
        [params appendString: [NSString stringWithFormat:@"%ld", fileOffset]];
        [params appendString: @"&chunkSize="];
        [params appendString: [NSString stringWithFormat:@"%ld", chunkSize]];
        [params appendString: @"&checksumFlag="];
        [params appendString: [NSString stringWithFormat:@"%@", @"true"]];
        [params appendString: @"&deliveryId="];
        [params appendString: [NSString stringWithFormat:@"%d", deliveryVO.getDeliveryId]];
        
        NSLog(@"POSt data: %@", params);
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        //Create the connection with the request and start loading the data
        fileDownloadConn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (fileDownloadConn )
        {
            fileWebData = [[NSMutableData alloc] init];
        }
        else
        {
            NSLog(@"Connection failed");
            return;
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"An error occured while trying to get file; %@: %@", [exception name], [exception reason]);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Received response: %@", response);
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"status: %ld", [httpResponse statusCode]);
    
    NSDictionary *dict = [httpResponse allHeaderFields];
    NSString *jsonStr = [dict objectForKey:@"responseString"];
    if(![Util isEmpty:jsonStr])
    {
        jsonDictionary = [jsonStr JSONValue];
    }
    NSLog(@"header info: %@", jsonStr);
    
    [fileWebData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [fileWebData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Failed to download the fax file.");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Downloaded %ld bytes of data", (unsigned long)[fileWebData length]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File download was not successful." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    if(jsonDictionary == nil)
    {
        [alert show];
        return;
    }

    int returnCode = [[jsonDictionary objectForKey:@"returnCode"] intValue];
    NSLog(@"RC: %d", returnCode);
    int bytes = [[jsonDictionary objectForKey:@"bytesRead"] intValue];
    NSLog(@"bytes read: %d", bytes);
    
    if(returnCode == RC_ERR_INSUFFICIENT_PRIVILEGE) {
        [alert setMessage:@"You don't have privilege to download the file."];
        [alert show];
        return;
    } else if(returnCode == RC_ERR_DATA_FILE_NOT_FOUND) {
        [alert setMessage:@"File not found."];
        [alert show];
        return;
    } else if(returnCode == RC_ERR_INVALID_CHUNK_SIZE) {
        [alert setMessage:@"Invalid chunk size to download file."];
        return;
    } else if(returnCode == RC_ERR_INVALID_OFFSET) {
        [alert setMessage:@"Invalid offset size to download file."];
        [alert show];
        return;
    } else if(returnCode == RC_ERR_SYSTEM_ERROR) {
        [alert show];
        return;
    }

    @try
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath])
        {
            // Count the number of chunks already downloaded to determine the chunkIndex
            NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:nil];
            chunkIndex = [directoryContent count];
        }
        
        NSData *destinationData = [NSData dataWithData:fileWebData];
        [targetData appendData:destinationData];
        fileOffset += [destinationData length];
        NSLog(@"Read: %ld of %ld", fileOffset, dataFileSize);
        
        if(fileOffset != dataFileSize)
        {
            // Not the last chunk, check the chunk size
            if([destinationData length] != chunkSize){
                return;
            }
        }
        
        if (fileOffset == dataFileSize)
        {
            // File download is completed
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:targetData attributes:nil];
            [inboxPage openDocumentForSft:filePath];
            chunkIndex = 0;
            fileDownloadConn = nil;
            return;
        }
        else
        {
            // More bytes to fetch
            [self getDataFile];
            return;
        }
        
        if (fileOffset > dataFileSize)
        {
            // Stop the activity indicator
            NSLog(@"Offset cannot be greater than the file size");
            return;
        }
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"An error occured while trying to get file; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    // release the connection, and the data object
    fileDownloadConn = nil;
    fileWebData = nil;
}

- (void) writeDataInChunks:(NSData *) data{
    
    // Encrypt the data
    NSData *encryptedData = [data AES256EncryptedDataUsingKey:AESEncryptionKey error:nil];
    
    // Write in file - Create encrypted chunks
    NSString *chunkFile  = [filePath stringByAppendingPathComponent: [[NSString alloc] initWithFormat:@"data-%d", chunkIndex]];
    
    NSLog(@"Chunk File: %@", chunkFile);
    
    [[NSFileManager defaultManager] createFileAtPath:chunkFile contents:encryptedData attributes:nil];
}

@end

