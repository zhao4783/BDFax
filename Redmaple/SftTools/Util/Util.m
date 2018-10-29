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

#import "Util.h"
#import "BDSiOSConstant.h"
#import "UserInfo.h"
#import "DeliveryVO.h"
#import "DocumentVO.h"
#import "JSON.h"
#import "NSData+CommonCrypto.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "GetDelivery.h"

#define CONNECTION_ERROR_TAG 1
#define DOWNLOAD_ERROR_TAG 2

static BOOL connectionErrorAlert = true;

@implementation Util

UserInfo *userInfo;
UserFilesInfo *userFilesInfo;

NSMutableDictionary *savedData;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (NSString*) getDirectoryPath {
    NSString *path = nil;
    
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        path = [documentsDirectory stringByAppendingPathComponent:@"BDSPropertyList.plist"]; //3
    }
    @catch (NSException *exception) {
        
        NSLog(@"An error occured while trying to get the directory path; %@: %@", [exception name], [exception reason]);
    }
    
    return path;
}


+ (NSString*) getDirectoryPath :(NSString*) propertyFile {
    NSString *path = nil;
    
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        path = [documentsDirectory stringByAppendingPathComponent:propertyFile]; //3
    }
    @catch (NSException *exception) {
        
        NSLog(@"An error occured while trying to get the directory path; %@: %@", [exception name], [exception reason]);
    }
    
    return path;
}


+(UserInfo *) getSettingInfo {
    
    //userInfo = [[[UserInfo alloc] init] retain];
    userInfo = [[UserInfo alloc] init];
    
    @try {
        NSError *error;
        NSString *path = [self getDirectoryPath];

        NSFileManager *fileManager = [NSFileManager defaultManager];

        if (![fileManager fileExistsAtPath: path]) //4
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"BDSPropertyList" ofType:@"plist"];//5
            
            [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
        }
        else
      {
            savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
            
            NSString *userName = (NSString*)[savedData objectForKey: USERNAME];
            NSString *passwd = [savedData objectForKey: PASSWORD];
            NSString *domain = [savedData objectForKey: DOMAIN_NAME];
            NSString *serverName = [savedData objectForKey: SERVER];
            NSString *sessionId = [savedData objectForKey: SESSION_ID];
            BOOL rs = NO;;
            BOOL rr = NO;
            BOOL rCol = NO;
            BOOL ssl = NO;
            BOOL tos = NO;
            
            NSString *useSSlStr = [savedData objectForKey: USE_SSL];
            if(![self isEmpty:useSSlStr]) {
                if([useSSlStr isEqualToString:@"YES"]) {
                    ssl = YES;
                }
            }
            
            // Is user accepted the terms of service
            NSString *useTOSStr = [savedData objectForKey: TOS_ACCEPTED];
            if(![self isEmpty:useTOSStr]) {
                if([useTOSStr isEqualToString:@"true"]) {
                    tos = YES;
                }
            }
            
            
            // user roles
            rs = NO;
            @try {
                NSDictionary *userRoles = [savedData objectForKey: USER_ROLES];
                NSObject *roles = [userRoles objectForKey:@"roles"];
                if([roles isKindOfClass:[NSArray class]]){
                    for (NSDictionary* role in (NSArray*)roles) {
                        if([[role objectForKey:@"name"] isEqualToString:@"SENDER"]){
                            rs = YES;
                        }
                        if([[role objectForKey:@"name"] isEqualToString:@"RECIPIENT"]){
                            rr = YES;
                        }
                        if([[role objectForKey:@"name"] isEqualToString:@"SENDER_RST"]){
                            rCol = YES;
                        }
                    }
                } else if([roles isKindOfClass:[NSDictionary class]]){
                    if([[(NSDictionary*)roles objectForKey:@"name"] isEqualToString:@"SENDER"]){
                        rs = YES;
                    }
                    if([[(NSDictionary*)roles objectForKey:@"name"] isEqualToString:@"RECIPIENT"]){
                        rr = YES;
                    }
                    if([[(NSDictionary*)roles objectForKey:@"name"] isEqualToString:@"SENDER_RST"]){
                        rCol = YES;
                    }
                }
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
            
            //NSLog(@"sender role: %d", rs);
            //NSLog(@"recipient role: %d", rr);
            
            [userInfo setUserName:userName];
            [userInfo setPassword:passwd];
            [userInfo setDomain:domain];
            [userInfo setServerName:serverName];
            [userInfo setSessionId:sessionId];
            [userInfo setSender:rs];
            [userInfo setRecipient:rr];
            [userInfo setCollaborator:rCol];
            [userInfo setUseSSL:ssl];
            [userInfo setAcceptedTOS:tos];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get data from property list; %@: %@", [exception name], [exception reason]);
    }
    
    return userInfo;
}


+ (UserFilesInfo*) getUserFilesInfo {
    NSError *error;
    userFilesInfo = [[UserFilesInfo alloc] init];
    
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"DownloadedFiles.plist"]; //3
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath: path]) {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"DownloadedFiles" ofType:@"plist"];
            [fileManager copyItemAtPath:bundle toPath: path error:&error];
        }
        
        //NSMutableDictionary *data = [[[NSMutableDictionary alloc] initWithContentsOfFile: path] autorelease];
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        documentsDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_FILES];
        //NSLog(@"documentsDirectory: %@", documentsDirectory);
        
        // Covert old plist property values to core data
        for(NSString *idKey in dataDic) {
            // Store the value in the core data
            [Util getDocumentInfo:idKey];
        }
        
        int count = 0;
        long long totalSize = 0;
        
        NSArray *docList = [Document fetchAll];
        for(int i=0; i< [docList count]; i++){
            Document *doc = [docList objectAtIndex:i];
            totalSize += [doc.downloadedSize longLongValue];
            count++;
        }
        
        userFilesInfo.usedSpace = totalSize;
        userFilesInfo.numberOfFiles = count;
        
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get data from property list; %@: %@", [exception name], [exception reason]);
    }
    
    return userFilesInfo;
    
}


+(NSMutableArray *) getObjectArray:(NSString*)key {
    NSMutableArray *object = nil;
    
    @try {
        NSError *error;
        NSString *path = [self getDirectoryPath];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path]) //4
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"BDSPropertyList" ofType:@"plist"];//5
            
            [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
        } else {
            NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:path];
            NSString *errorDesc = nil;
            NSPropertyListFormat format;
            // convert static property liost into dictionary object
            NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
            if (!temp)
            {
                NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
            }
            
            //NSMutableArray *test = [temp objectForKey: key];
            object = [NSMutableArray arrayWithArray:[temp objectForKey: key]];
            
            /*
             savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
             object = (NSMutableArray*)[savedData objectForKey: DELIVERY_VOS];  */
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get data from property list; key: %@, %@: %@", key, [exception name], [exception reason]);
    }
    
    return object;
}

+ (BOOL)isSignedIn {
    BOOL signedIn = NO;
    
    @try {
        UserInfo *userInfo = [self getSettingInfo];
        
        if([self isEmpty:[userInfo getUserName]] || [self isEmpty:[userInfo getPassword]] || [self isEmpty:[userInfo getServerName]] || [self isEmpty:[userInfo getSessionId]]) {
            signedIn = NO;
        }else {
            signedIn = YES;
        }
    }
    @catch (NSException *exception) {
        signedIn = NO;
        NSLog(@"An error occured while trying to get data from property list; %@: %@", [exception name], [exception reason]);
    }
    
    return signedIn;
}

+ (BOOL) saveDataToProperty:(NSString*)key:(NSString*)value {
    BOOL saved = NO;
    
    @try {
        NSString *path = [self getDirectoryPath];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        [data setValue:value forKey:key];
        [data writeToFile: path atomically:YES];
        //[data release];
        
        saved = YES;
    }
    @catch (NSException *exception) {
        saved = NO;
        NSLog(@"An error occured while trying to save data to property list; %@: %@", [exception name], [exception reason]);
    }
    
    return saved;
}


+ (BOOL) saveDataToProperty:(NSString*)key:(NSString*)value :(NSString*) propertyFile {
    BOOL saved = NO;
    
    @try {
        NSString *path = [self getDirectoryPath :propertyFile];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        [data setValue:value forKey:key];
        [data writeToFile: path atomically:YES];
        //[data release];
        
        saved = YES;
    }
    @catch (NSException *exception) {
        saved = NO;
        NSLog(@"An error occured while trying to save data to property list; %@: %@", [exception name], [exception reason]);
    }
    
    return saved;
}


+ (BOOL) removeDataFromProperty:(NSString*)key {
    BOOL saved = NO;
    
    @try {
        NSString *path = [self getDirectoryPath];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        [data removeObjectForKey:key];
        [data writeToFile: path atomically:YES];
        //[data release];
        
        saved = YES;
    }
    @catch (NSException *exception) {
        saved = NO;
        NSLog(@"An error occured while trying to save data to property list; %@: %@", [exception name], [exception reason]);
    }
    
    return saved;
}


+ (BOOL) removeDataFromProperty:(NSString*)key :(NSString*) propertyFile {
    BOOL saved = NO;
    
    @try {
        NSString *path = [self getDirectoryPath :propertyFile];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        [data removeObjectForKey:key];
        [data writeToFile: path atomically:YES];
        //[data release];
        
        saved = YES;
    }
    @catch (NSException *exception) {
        saved = NO;
        NSLog(@"An error occured while trying to save data to property list; %@: %@", [exception name], [exception reason]);
    }
    
    return saved;
}


+(NSString *) getStringValue: (NSString*) forKey {
    NSString *responseStr = nil;
    
    @try {
        NSError *error;
        NSString *path = [self getDirectoryPath];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path]) //4
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"BDSPropertyList" ofType:@"plist"];//5
            
            [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
        } else {
            savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
            
            responseStr = (NSString*)[savedData objectForKey: forKey];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get data from property list; property name: %@ %@: %@", forKey, [exception name], [exception reason]);
    }
    
    return responseStr;
}


+(NSString *) getStringValue: (NSString*) forKey :(NSString *) propertyFile{
    NSString *responseStr = nil;
    
    @try {
        //        NSError *error;
        NSString *path = [self getDirectoryPath :propertyFile];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path]) //4
        {
            //            NSString *bundle = [[NSBundle mainBundle] pathForResource:[propertyFile stringByDeletingPathExtension] ofType:@"plist"];//5
            //
            //            [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
        } else {
            savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
            
            responseStr = (NSString*)[savedData objectForKey: forKey];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get data from property list; property name: %@ %@: %@", forKey, [exception name], [exception reason]);
    }
    
    return responseStr;
}


+ (BOOL) saveArrayToProperty:(NSString*)key:(NSMutableArray*)value {
    BOOL saved = NO;
    
    @try {
        NSString *path = [self getDirectoryPath];
        NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: value, nil] forKeys:[NSArray arrayWithObjects: key, nil]];
        
        NSString *error = nil;
        // create NSData from dictionary
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
        
        [plistData writeToFile:path atomically:YES];
        /*
         NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
         [data setValue:value forKey:key];
         [data writeToFile: path atomically:YES];
         [data release];*/
        
        saved = YES;
    }
    @catch (NSException *exception) {
        saved = NO;
        NSLog(@"An error occured while trying to save data to property list; %@: %@", [exception name], [exception reason]);
    }
    
    return saved;
}


+ (NSMutableDictionary*) getSavedDocumentsDictionary {
    NSMutableDictionary *docInfo = nil;
    NSError *error;
    
    @try {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"DownloadedFiles.plist"]; //3
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath: path]) {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"DownloadedFiles" ofType:@"plist"];
            [fileManager copyItemAtPath:bundle toPath: path error:&error];
        }
        
        //docInfo = [[[NSMutableDictionary alloc] initWithContentsOfFile: path] autorelease];
        docInfo = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get saved documents dcitionary; %@: %@", [exception name], [exception reason]);
    }
    
    return docInfo;
}


+ (NSString*) saveExternalDocumentInfo:(NSString*) documentId : (NSString*) documentName {
    NSString *savedFileName = nil;
    NSError *error;
    
    @try {
        //        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        //        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        //        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"DownloadedFiles.plist"]; //3
        //
        //        NSFileManager *fileManager = [NSFileManager defaultManager];
        //        if (![fileManager fileExistsAtPath: path]) {
        //            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"DownloadedFiles" ofType:@"plist"];
        //            [fileManager copyItemAtPath:bundle toPath: path error:&error];
        //        }
        
        //NSMutableDictionary *data = [[[NSMutableDictionary alloc] initWithContentsOfFile: path] autorelease];
        //        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        
        savedFileName = [self getGivenFileName:documentId :documentName];
        
//        savedFileName = [self getGivenExternalFileName:documentId :documentName :data];
//        
//        [data writeToFile:path atomically:YES];
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to save data to property list; %@: %@", [exception name], [exception reason]);
    }
    
    return savedFileName;
}


+ (NSString*) getGivenFileName:(NSString *) documentId : (NSString*) documentName {
    NSString *givenFileName = nil;
    
    // Get the file name without extension and fily type of CURRENT FILE
    NSString *newDocNameWithoutExt = documentName;
    NSRange range = [documentName rangeOfString:@"." options:NSBackwardsSearch];
    NSString *fileTypeOfCurrentFile = nil;
    if(range.location != NSNotFound) {
        NSInteger index = range.location;
        newDocNameWithoutExt = [documentName substringToIndex:index];
        fileTypeOfCurrentFile = [documentName substringFromIndex:index];
    }
    
    int lastFileNumber = 0;
    int assignFileNUmber = 0;
    
    Document *doc = [Util getDocumentInfo:documentId];
    
    if(doc == nil) { //File is not in the list
        
        //        doc = [Document newEntity];
        //        doc.docId = [NSNumber numberWithInt:documentId];
        
        // Get all the file names
        NSArray *docArray = [Document fetchAll];
        for(int i =0; i<[docArray count]; i++){
            Document *iDoc = [docArray objectAtIndex:i];
            
            // Get the file name without extension and fily type of SAVED FILE
            NSString *fileTypeOfSavedFile = nil;
            NSString *nameWithoutExt = iDoc.docName;
            NSRange range = [iDoc.docName rangeOfString:@"." options:NSBackwardsSearch];
            if(range.location != NSNotFound) {
                NSInteger index = range.location;
                nameWithoutExt = [iDoc.docName substringToIndex:index];
                fileTypeOfSavedFile = [iDoc.docName substringFromIndex:index];
            }
            
            // File naming policy applies for same fily type.
            if(fileTypeOfCurrentFile != nil && fileTypeOfSavedFile != nil && ![fileTypeOfCurrentFile isEqualToString:fileTypeOfSavedFile]) {
                continue;
            }
            
            // Check whether the same file name exists or not
            range = [nameWithoutExt rangeOfString:newDocNameWithoutExt];
            if(range.location != NSNotFound) {
                //lastMatchedFileName = nameWithoutExt;
                if([nameWithoutExt isEqualToString:newDocNameWithoutExt]) {
                    if(lastFileNumber == 0) {
                        assignFileNUmber = 1;
                    }
                } else if([nameWithoutExt characterAtIndex:[nameWithoutExt length] - 1] == ')') {
                    
                    NSString *fileNumberStr = @"";
                    NSRange range = [nameWithoutExt rangeOfString:@"(" options:NSBackwardsSearch];
                    if(range.location != NSNotFound) {
                        NSInteger index = range.location;
                        int len = [nameWithoutExt length] - range.location -2;
                        fileNumberStr = [nameWithoutExt substringWithRange:NSMakeRange(index + 1, len)];
                        NSLog(@"File no: %@", fileNumberStr);
                    }
                    
                    int fileNumber = [fileNumberStr intValue];
                    if(fileNumber > lastFileNumber) {
                        lastFileNumber = fileNumber;
                        assignFileNUmber = lastFileNumber + 1;
                    }
                }
            }
            
        }
        
        // Calculate the file name
        if(assignFileNUmber == 0) {
            givenFileName = documentName;
        } else {
            NSMutableString *params = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@(%d)", newDocNameWithoutExt, assignFileNUmber]];
            if(![self isEmpty:fileTypeOfCurrentFile]) {
                [params appendString: fileTypeOfCurrentFile];
            }
            
            givenFileName = params;
        }
    }
    
    [Util saveDocumentInfo:documentId :givenFileName :0 :0 :0];
    
    return givenFileName;
}


+ (NSString*) getGivenExternalFileName:(NSString*) documentId : (NSString*) documentName: (NSMutableDictionary*) docInfo {
    NSString *givenFileName = nil;
    
    // Get the file name without extension and fily type of CURRENT FILE
    NSString *newDocNameWithoutExt = documentName;
    NSRange range = [documentName rangeOfString:@"." options:NSBackwardsSearch];
    NSString *fileTypeOfCurrentFile = nil;
    if(range.location != NSNotFound) {
        NSInteger index = range.location;
        newDocNameWithoutExt = [documentName substringToIndex:index];
        fileTypeOfCurrentFile = [documentName substringFromIndex:index];
    }
    
    int lastFileNumber = 0;
    int assignFileNUmber = 0;
    NSString *docIdStr = [NSString stringWithFormat:@"%@", documentId];
    if(![docInfo objectForKey:docIdStr]) { //File is not in the list
        
        // Get all the file names
        NSEnumerator *enumerator = [docInfo keyEnumerator];
        for(NSString *idKey in enumerator) {
            
            NSString *docName = [docInfo objectForKey:idKey];
            //NSLog(@"Current docname: %@", docName);
            
            // Get the file name without extension and fily type of SAVED FILE
            NSString *fileTypeOfSavedFile = nil;
            NSString *nameWithoutExt = docName;
            NSRange range = [docName rangeOfString:@"." options:NSBackwardsSearch];
            if(range.location != NSNotFound) {
                NSInteger index = range.location;
                nameWithoutExt = [docName substringToIndex:index];
                fileTypeOfSavedFile = [docName substringFromIndex:index];
            }
            
            // File naming policy applies for same fily type.
            if(fileTypeOfCurrentFile != nil && fileTypeOfSavedFile != nil && ![fileTypeOfCurrentFile isEqualToString:fileTypeOfSavedFile]) {
                continue;
            }
            
            // Check whether the same file name exists or not
            range = [nameWithoutExt rangeOfString:newDocNameWithoutExt];
            if(range.location != NSNotFound) {
                //lastMatchedFileName = nameWithoutExt;
                if([nameWithoutExt isEqualToString:newDocNameWithoutExt]) {
                    if(lastFileNumber == 0) {
                        assignFileNUmber = 1;
                    }
                } else if([nameWithoutExt characterAtIndex:[nameWithoutExt length] - 1] == ')') {
                    
                    NSString *fileNumberStr = @"";
                    NSRange range = [nameWithoutExt rangeOfString:@"(" options:NSBackwardsSearch];
                    if(range.location != NSNotFound) {
                        NSInteger index = range.location;
                        int len = [nameWithoutExt length] - range.location -2;
                        fileNumberStr = [nameWithoutExt substringWithRange:NSMakeRange(index + 1, len)];
                        NSLog(@"File no: %@", fileNumberStr);
                    }
                    
                    int fileNumber = [fileNumberStr intValue];
                    if(fileNumber > lastFileNumber) {
                        lastFileNumber = fileNumber;
                        assignFileNUmber = lastFileNumber + 1;
                    }
                }
            }
            
        }
        
        // Calculate the file name
        if(assignFileNUmber == 0) {
            givenFileName = documentName;
        } else {
            NSMutableString *params = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@(%d)", newDocNameWithoutExt, assignFileNUmber]];
            if(![self isEmpty:fileTypeOfCurrentFile]) {
                [params appendString: fileTypeOfCurrentFile];
            }
            
            givenFileName = params;
        }
        
        //Save the file name
        NSMutableDictionary *docDict = [[Util getStringValue:docIdStr :@"DownloadedFiles.plist"] JSONValue];
        [docDict setObject:givenFileName forKey:@"name"];
        [docInfo setValue:[docDict JSONRepresentation] forKey:docIdStr];
    } else {
        NSMutableDictionary *docDict = [[docInfo objectForKey:docIdStr] JSONValue];
        givenFileName = [docDict objectForKey:@"name"];
    }
    
    return givenFileName;
}



+ (BOOL) deleteDownloadedFileName:(NSString *) documentId {
    BOOL deleted = NO;
    
    // Check for the entry
    Document *doc = [Util getDocumentInfo:documentId];
    if(doc != nil){
        [doc delete];
        deleted = YES;
        [Document commit];
    }
    
    return deleted;
}


+ (BOOL) deleteAllDownloadedFileNames {
    BOOL deleted = NO;
    
    @try {
        [Document deleteAll];
        [Document commit];
        deleted = YES;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"DownloadedFiles.plist"]; //3
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath: path]) {
            if(![fileManager removeItemAtPath:path error:nil]){
                NSLog(@"Couldn't remove property file for downloaded files");
            }
        }
    }
    @catch (NSException *exception) {
        deleted = NO;
        NSLog(@"An error occured while trying to delete old downloadedFiles.plist; %@: %@", [exception name], [exception reason]);
    }
    
    return deleted;
}


+ (BOOL)isEmpty:(NSString*) value {
    BOOL empty = NO;
    
    if(value == nil || [value isEqualToString:@""]) {
        empty = YES;
    }
    
    return empty;
}

+(NSString*) getDateStringFromDate:(NSDate*) dateValue {
    NSString *dateString = nil;
    
    @try {
        /* NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
         [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
         [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss z"];
         [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
         dateString = [dateFormatter stringFromDate:dateValue];*/
        //NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        dateString = [dateFormatter stringFromDate:dateValue];
        NSLog(@"%@", dateString);
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to parse date string from date the date; %@: %@", [exception name], [exception reason]);
    }
    
    return dateString;
}

+(NSDate*) getDateFromDateString:(NSString*) dateStr {
    NSDate *date = nil;
    
    @try {
        /*dateStr = [dateStr stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange(dateStr.length-3, 1)];
         NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
         [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
         [dateFormatter setDateFormat:@"EEE, "yyyy-MM-dd HH:mm:ss z"];
         [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
         date = [dateFormatter dateFromString:dateStr];*/
        
        //NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        date = [dateFormatter dateFromString:dateStr];
        //[dateFormatter release];
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to parse date from date string the date; %@: %@", [exception name], [exception reason]);
    }
    
    return date;
}

+(NSMutableArray*) parseDeliveries: (NSDictionary*) responseDictionary {
    NSMutableArray *deliveryVOs = [[NSMutableArray alloc] init];
    
    @try {
        int rowCount = [[responseDictionary objectForKey:@"totalRowCount"] intValue];
        
        if(rowCount == 1) {
            [deliveryVOs addObject: [self createVO:[responseDictionary objectForKey:@"extDeliveryVOWSs"]]];
        } else {
            NSArray* deliveryArray = [responseDictionary objectForKey:@"extDeliveryVOWSs"];
            for (NSDictionary* internalDict in deliveryArray) {
                [deliveryVOs addObject: [self createVO:internalDict]];
            }
        }
    }
    @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse received deliveries." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse received deliveries." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occured while trying to signin; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"parseDeliveries: Delivery count: %d", [deliveryVOs count]]);
    
    //return [deliveryVOs autorelease];
    return deliveryVOs;
}


+(NSMutableArray*) parseWorkspaces: (NSDictionary*) responseDictionary {
    NSMutableArray *workspaceVOs = [[NSMutableArray alloc] init];
    
    @try {
        int rowCount = [[responseDictionary objectForKey:@"totalRowCount"] intValue];
        NSLog(@"%@",[NSString stringWithFormat:@"workspace totalRowCount: %d", rowCount]);
        
        if(rowCount > 0) {
            // Process the workspaces
            NSObject *workspaces = [responseDictionary objectForKey:@"workspaceVOWSs"];
            if([workspaces isKindOfClass:[NSArray class]]) {
                for (NSDictionary* workspacelDict in (NSArray*)workspaces) {
                    WorkspaceVO *wrkspceVO = [self createWorkspaceVO:workspacelDict];
                    if(wrkspceVO != nil) {
                        [workspaceVOs addObject: wrkspceVO];
                    }
                }
            } else {
                WorkspaceVO *wrkspceVO = [self createWorkspaceVO:(NSDictionary*)workspaces];
                if(wrkspceVO != nil) {
                    [workspaceVOs addObject: wrkspceVO];
                }
            }
        }
    }
    @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occured while trying to signin; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"Workspaces count: %d", [workspaceVOs count]]);
    
    //return [workspaceVOs autorelease];
    return workspaceVOs;
}


+(DeliveryVO*) createVO: (NSDictionary*) internalDict {
    DeliveryVO *delVO = [[DeliveryVO alloc] init];
    NSMutableArray *documentVOs = [[NSMutableArray alloc] init];
    
    @try {
        if(internalDict == nil) {
            return delVO;
        }
        double amnt =  [[internalDict objectForKey:@"amount"] doubleValue];
        int crtdBy = [[internalDict objectForKey:@"createdBy"] intValue];
        //NSLog([internalDict objectForKey:@"dateAvailable"]);
        //NSDate *availableDate = [[internalDict objectForKey:@"dateAvailable"] date];
        NSString *availableDate = [internalDict objectForKey:@"dateAvailable"];
        //NSLog([Util getDateStringFromDate:availableDate]);
        NSString *createdDate = [internalDict objectForKey:@"dateCreated"];
        NSString *lastUpdatedDate = [internalDict objectForKey:@"dateLastUpdated"];
        int dlvId = [[internalDict objectForKey:@"deliveryId"] intValue];
        NSString *dsc = [internalDict objectForKey:@"description"];
        NSString *encPasswd = [internalDict objectForKey:@"encodedPassword"];
        BOOL exp = [[internalDict objectForKey:@"express"] boolValue];
        NSString *lastActivity = [internalDict objectForKey:@"lastActivityDate"];
        int lastUpdtBy = [[internalDict objectForKey:@"lastUpdatedBy"] intValue];
        BOOL limited = [[internalDict objectForKey:@"limited"] boolValue];
        NSString *msg = [internalDict objectForKey:@"message"];
        NSString *name = [internalDict objectForKey:@"name"];
        NSString *notifiEmails = [internalDict objectForKey:@"notificationEmails"];
        //NSString *notifyOnAcsSettng = [internalDict objectForKey:@"notifyOnAccessSetting"];
        NSString *notifyOnDlvViewSetting = [internalDict objectForKey:@"notifyOnDeliveryViewSetting"];
        //BOOL notifyOnFileAcs = [[internalDict objectForKey:@"notifyOnFileAccess"] boolValue];
        NSString *notifyOnFileDLSetng = [internalDict objectForKey:@"notifyOnFileDownloadSetting"];
        //NSString *notifyWhenRecipientDel = [internalDict objectForKey:@"notifyWhenRecipientDeletes"];
        int pId = [[internalDict objectForKey:@"packageId"] intValue];
        BOOL readStat = [[internalDict objectForKey:@"read"] boolValue];
        //NSString *reminderDays = [internalDict objectForKey:@"remindDaysAfterSendingDelivery"];
        //NSString *reminderDaysDlvExpire = [internalDict objectForKey:@"remindDaysBeforeDeliveryExpires"];
        NSString *replyToAddr = [internalDict objectForKey:@"replyToAddress"];
        BOOL requireSignIn = [[internalDict objectForKey:@"requireSignIn"] boolValue];
        BOOL requiresPayment = [[internalDict objectForKey:@"requiresPayment"] boolValue];
        BOOL safeHtml = [[internalDict objectForKey:@"safeHtml"] boolValue];
        NSString *scanStatus = [internalDict objectForKey:@"scanStatus"];
        NSString *secureMessage = [internalDict objectForKey:@"secureMessage"];
        int senderId = [[internalDict objectForKey:@"senderId"] intValue];
        NSString *status = [internalDict objectForKey:@"status"];
        NSString *trackingNumber = [internalDict objectForKey:@"trackingNumber"];
        //int unreadReplyCount = [[internalDict objectForKey:@"unreadReplyCount"] intValue];
        //NSString *packageName = [internalDict objectForKey:@"packageName"];
        NSString *senderEmailAddress = [internalDict objectForKey:@"senderEmailAddress"];
        //NSString *senderFirstName = [internalDict objectForKey:@"senderFirstName"];
        //NSString *senderLastName = [internalDict objectForKey:@"senderLastName"];
        //NSString *senderStatus = [internalDict objectForKey:@"senderStatus"];
        NSString *dateExpires = [internalDict objectForKey:@"dateExpires"];
        NSString *parsedDateCreated = [internalDict objectForKey:@"parsedDateCreated"];
        NSString *parsedDateAvailable = [internalDict objectForKey:@"parsedDateAvailable"];
        NSString *parsedDateExpires = [internalDict objectForKey:@"parsedDateExpires"];
        NSString *parsedDateLastUpdated1 = [internalDict objectForKey:@"parsedDateLastUpdated"];
        NSString *parsedLastActivityDate1 = [internalDict objectForKey:@"parsedLastActivityDate"];
        NSString *receivedAs = [internalDict objectForKey:@"receivedAs"];
        NSString *sentToGroupName = [internalDict objectForKey:@"sentToGroupName"];
        
        // Process the recipients
        NSDictionary* recipientsDict = [internalDict objectForKey:@"recipients"];
        NSMutableString *toList = [[NSMutableString alloc] initWithString:@""];
        toList = [self parseRecipients:toList :recipientsDict :@"toAddressListEntries"];
        
        NSMutableString *ccList = [[NSMutableString alloc] initWithString:@""];
        ccList = [self parseRecipients:ccList :recipientsDict :@"ccAddressListEntries"];
        
        NSMutableString *bccList = [[NSMutableString alloc] initWithString:@""];
        bccList = [self parseRecipients:bccList :recipientsDict :@"bccAddressListEntries"];
        
        // Process the documents
        NSObject *documents = [internalDict objectForKey:@"documentVOList"];
        if([documents isKindOfClass:[NSArray class]]) {
            for (NSDictionary* documentlDict in (NSArray*)documents) {
                DocumentVO *docVO = [self parseDocument:documentlDict];
                if(docVO != nil) {
                    [documentVOs addObject: docVO];
                }
            }
        } else {
            DocumentVO *docVO = [self parseDocument:(NSDictionary*)documents];
            if(docVO != nil) {
                [documentVOs addObject: docVO];
            }
        }
        
        [delVO setDeliveryId:dlvId];
        [delVO setStatus:status];
        [delVO setTrackingNumber:trackingNumber];
        [delVO setPackageId:pId];
        [delVO setSenderId:senderId];
        [delVO setReplyToAddress:replyToAddr];
        [delVO setName:name];
        [delVO setDescription:dsc];
        [delVO setMessage:msg];
        [delVO setSecureMessage:secureMessage];
        [delVO setDateAvailable:availableDate];
        [delVO setDateExpires:dateExpires];
        [delVO setRequireSignIn:requireSignIn];
        [delVO setEncodedPassword:encPasswd];
        [delVO setNotificationEmails:notifiEmails];
        [delVO setCreatedBy:crtdBy];
        [delVO setDateCreated:createdDate];
        [delVO setLastUpdatedBy:lastUpdtBy];
        [delVO setDateLastUpdated:lastUpdatedDate];
        [delVO setLastActivityDate:lastActivity];
        [delVO setReadStatus:readStat];
        [delVO setNotifyOnDeliveryViewSetting:notifyOnDlvViewSetting];
        [delVO setNotifyOnFileDownloadSetting:notifyOnFileDLSetng];
        [delVO setLimited:limited];
        [delVO setSafeHtml:safeHtml];
        [delVO setAmount:amnt];
        [delVO setRequiresPayment:requiresPayment];
        [delVO setIsExpress:exp];
        [delVO setScanStatus:scanStatus];
        [delVO setSenderEmailAddress:senderEmailAddress];
        [delVO setParsedDateCreated:parsedDateCreated];
        [delVO setParsedDateAvailable:parsedDateAvailable];
        [delVO setParsedDateExpires:parsedDateExpires];
        [delVO setParsedDateLastUpdated:parsedDateLastUpdated1];
        [delVO setParsedLastActivityDate:parsedLastActivityDate1];
        [delVO setReceivedAs:receivedAs];
        [delVO setSentToGroupName:sentToGroupName];
        [delVO setDocumentVOs:documentVOs];
        [delVO setToAddressList:toList];
        [delVO setCcAddressList:ccList];
        [delVO setBccAddressList:bccList];
        
    }
    @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse received deliveries." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse received deliveries." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occured while trying to parse received deliveries; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return delVO;
}


+(WorkspaceVO*) createWorkspaceVO: (NSDictionary*) internalDict {
    WorkspaceVO *workspaceVO = [[WorkspaceVO alloc] init];
    NSMutableArray *documentVOs = [[NSMutableArray alloc] init];
    NSMutableArray *commentVOs = [[NSMutableArray alloc] init];
    NSMutableArray *activityVOs = [[NSMutableArray alloc] init];
    
    @try {
        if(internalDict == nil) {
            return workspaceVO;
        }
        
        int pId = [[internalDict objectForKey:@"packageId"] intValue];
        //NSLog(@"%@",[NSString stringWithFormat:@"package id: %d", pId]);
        NSString *name = [internalDict objectForKey:@"name"];
        //NSLog(@"%@",[NSString stringWithFormat:@"workspace name: %@", name]);
        NSString *dsc = [internalDict objectForKey:@"description"];
        NSString *tags = [internalDict objectForKey:@"tags"];
        NSString *size = [internalDict objectForKey:@"size"];
        long sz = [size longLongValue];
        //NSLog(@"%@",[NSString stringWithFormat:@"size: %li", sz]);
        BOOL hideWorkspaceActivity = [[internalDict objectForKey:@"hideWorkspaceActivity"] boolValue];
        
        NSDictionary* wrkspcUsers = [internalDict objectForKey:@"workspaceUsers"];
        NSMutableString *managersList = [[NSMutableString alloc] initWithString:@""];
        NSMutableString *collaboratorsList = [[NSMutableString alloc] initWithString:@""];
        NSMutableString *viewersList = [[NSMutableString alloc] initWithString:@""];
        
        // process the managers
        NSObject *managerArray = [wrkspcUsers objectForKey:@"managers"];
        managersList = [self parseWorkspaceUsers:managersList :managerArray];
        //NSLog(@"%@",[NSString stringWithFormat:@"managersList: %@", managersList]);
        
        // process the collaborators
        NSObject *collaboratorArray = [wrkspcUsers objectForKey:@"collaborators"];
        collaboratorsList = [self parseWorkspaceUsers:collaboratorsList :collaboratorArray];
        //NSLog(@"%@",[NSString stringWithFormat:@"collaboratorsList: %@", collaboratorsList]);
        
        // process the viewers
        NSObject *viewerArray = [wrkspcUsers objectForKey:@"viewers"];
        viewersList = [self parseWorkspaceUsers:viewersList :viewerArray];
        //NSLog(@"%@",[NSString stringWithFormat:@"viewersList: %@", viewersList]);
        
        // Process the documents
        NSObject *documents = [internalDict objectForKey:@"documentVOs"];
        if([documents isKindOfClass:[NSArray class]]) {
            for (NSDictionary* documentlDict in (NSArray*)documents) {
                DocumentVO *docVO = [self parseDocument:documentlDict];
                if(docVO != nil) {
                    [documentVOs addObject: docVO];
                }
            }
        } else {
            DocumentVO *docVO = [self parseDocument:(NSDictionary*)documents];
            if(docVO != nil) {
                [documentVOs addObject: docVO];
            }
        }
        
        // Process the comments
        NSObject *comments = [internalDict objectForKey:@"commentInfoList"];
        if([comments isKindOfClass:[NSArray class]]) {
            for (NSDictionary* commentlDict in (NSArray*)comments) {
                CommentVO *commentVO = [self parseComment:commentlDict];
                if(commentVO != nil) {
                    [commentVOs addObject: commentVO];
                }
            }
        } else {
            CommentVO *commentVO = [self parseComment:(NSDictionary*)comments];
            if(commentVO != nil) {
                [commentVOs addObject: commentVO];
            }
        }
        
        // Process the activities
        NSObject *activities = [internalDict objectForKey:@"workspaceTransactions"];
        if([activities isKindOfClass:[NSArray class]]) {
            for (NSDictionary* activitylDict in (NSArray*)activities) {
                ActivityVO *activityVO = [self parseActivity:activitylDict];
                if(activityVO != nil) {
                    [activityVOs addObject: activityVO];
                }
            }
        } else {
            ActivityVO *activityVO = [self parseActivity:(NSDictionary*)activities];
            if(activityVO != nil) {
                [activityVOs addObject: activityVO];
            }
        }
        //NSLog(@"%@",[NSString stringWithFormat:@"activityVOs.count: %d", activityVOs.count]);
        
        NSString *status = [internalDict objectForKey:@"status"];
        NSString *latestVersion = [internalDict objectForKey:@"latestVersion"];
        NSString *latestPublishedVersion = [internalDict objectForKey:@"latestPublishedVersion"];
        int crtdBy = [[internalDict objectForKey:@"createdBy"] intValue];
        NSString *autoDelDate = [internalDict objectForKey:@"autoDelDate"];
        NSString *autoDelReminderDate = [internalDict objectForKey:@"autoDelReminderDate"];
        NSString *autoDelReminderSentDate = [internalDict objectForKey:@"autoDelReminderSentDate"];
        NSString *createdDate = [internalDict objectForKey:@"dateCreated"];
        int lastUpdtBy = [[internalDict objectForKey:@"lastUpdatedBy"] intValue];
        NSString *lastUpdatedDate = [internalDict objectForKey:@"dateLastUpdated"];
        NSString *lastActivity = [internalDict objectForKey:@"lastActivityDate"];
        NSString *parsedDateCreated = [internalDict objectForKey:@"parsedDateCreated"];
        NSString *parsedDateLastUpdated = [internalDict objectForKey:@"parsedDateLastUpdated"];
        BOOL manager = [[internalDict objectForKey:@"manager"] boolValue];
        BOOL collaborator = [[internalDict objectForKey:@"collaborator"] boolValue];
        BOOL viewer = [[internalDict objectForKey:@"viewer"] boolValue];
        BOOL locked = [[internalDict objectForKey:@"locked"] boolValue];
        int totalComment = [[internalDict objectForKey:@"totalComment"] intValue];
        int totalActivity = [[internalDict objectForKey:@"totalTransaction"] intValue];
        
        NSString *parsedAutoDelDate = [internalDict objectForKey:@"parsedAutoDelDate"];
        NSString *parsedAutoDelReminderDate = [internalDict objectForKey:@"parsedAutoDelReminderDate"];
        //NSLog(@"parsedAutoDelDate: %@", parsedAutoDelDate);
        //NSLog(@"parsedAutoDelReminderDate: %@", parsedAutoDelReminderDate);
        
        int rootDirectoryId = [[internalDict objectForKey:@"rootDirectoryId"] intValue];
        NSLog(@"rootDirectoryId: %d", rootDirectoryId);
        
        [workspaceVO setPackageId:pId];
        [workspaceVO setName:name];
        [workspaceVO setDescription:dsc];
        [workspaceVO setTags:tags];
        [workspaceVO setSize:sz];
        [workspaceVO setHideWorkspaceActivity:hideWorkspaceActivity];
        //[workspaceVO setWorkspaceUsers:workspaceUsers];
        [workspaceVO setDocumentVOs:documentVOs];
        [workspaceVO setCommentVOs:commentVOs];
        [workspaceVO setActivityVOs:activityVOs];
        [workspaceVO setStatus:status];
        [workspaceVO setLatestVersion:latestVersion];
        [workspaceVO setLatestPublishedVersion:latestPublishedVersion];
        [workspaceVO setCreatedBy:crtdBy];
        [workspaceVO setAutoDelDate:autoDelDate];
        [workspaceVO setAutoDelReminderDate:autoDelReminderDate];
        [workspaceVO setAutoDelReminderSentDate:autoDelReminderSentDate];
        [workspaceVO setDateCreated:createdDate];
        [workspaceVO setLastUpdatedBy:lastUpdtBy];
        [workspaceVO setDateLastUpdated:lastUpdatedDate];
        [workspaceVO setLastActivityDate:lastActivity];
        [workspaceVO setParsedDateCreated:parsedDateCreated];
        [workspaceVO setParsedDateLastUpdated:parsedDateLastUpdated];
        [workspaceVO setManagersAddressList:managersList];
        [workspaceVO setCollaboratorsAddressList:collaboratorsList];
        [workspaceVO setViewersAddressList:viewersList];
        [workspaceVO setRequesterManager:manager];
        [workspaceVO setRequesterCollaborator:collaborator];
        [workspaceVO setRequesterViewer:viewer];
        [workspaceVO setLocked:locked];
        [workspaceVO setTotalComment:totalComment];
        [workspaceVO setTotalActivity:totalActivity];
        [workspaceVO setParsedAutoDelDate:parsedAutoDelDate];
        [workspaceVO setParsedAutoDelReminderDate:parsedAutoDelReminderDate];
        [workspaceVO setRootDirectoryId:rootDirectoryId];
        
    }
    @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occured while trying to parse workspaces; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return workspaceVO;
}


+ (DirectoryVO *) createDirectoryVO: (NSDictionary*) responseDictionary {
    
    DirectoryVO *directoryVO = [[DirectoryVO alloc] init];
    NSMutableArray *childrenWorkspaceFileArray = [[NSMutableArray alloc] init];
    
    int returnCode = [[responseDictionary objectForKey:@"returnCode"] intValue];
    NSLog(@"Get Directory: return code: %d", returnCode);
    [directoryVO setReturnCode:returnCode];
    
    int bdsFileId = [[responseDictionary objectForKey:@"id"] intValue];
    NSLog(@"Get Directory: bdsFileId: %d", bdsFileId);
    [directoryVO setBdsFileId:bdsFileId];
    
    NSString *name = [responseDictionary objectForKey:@"name"];
    NSLog(@"Get Directory: name: %@", name);
    [directoryVO setName:name];
    
    NSString *description = [responseDictionary objectForKey:@"description"];
    NSLog(@"Get Directory: description: %@", description);
    [directoryVO setDescription:description];
    
    long size = [[responseDictionary objectForKey:@"size"] longLongValue];
    NSLog(@"Get Directory: size: %ld", size);
    [directoryVO setSize:size];
    
    BOOL isDirectory = [[responseDictionary objectForKey:@"isDirectory"] boolValue];
    NSLog(@"Get Directory: isDirectory: %d", (int)isDirectory);
    [directoryVO setIsDirectory:isDirectory];
    
    int parentDirectoryId = [[responseDictionary objectForKey:@"parentDirectoryId"] intValue];
    NSLog(@"Get Directory: parentDirectoryId: %d", parentDirectoryId);
    [directoryVO setParentDirectoryId:parentDirectoryId];
    
    int rootDirectoryId = [[responseDictionary objectForKey:@"rootDirectoryId"] intValue];
    NSLog(@"Get Directory: rootDirectoryId: %d", rootDirectoryId);
    [directoryVO setRootDirectoryId:rootDirectoryId];
    
    NSString *dateCreated = [responseDictionary objectForKey:@"dateCreated"];
    NSLog(@"Get Directory: dateCreated: %@", dateCreated);
    [directoryVO setDateCreated:dateCreated];
    
    
    // parent is nil
    [directoryVO setParent:nil];
    
    
    //children
    NSArray *childrenArray = (NSArray*)[responseDictionary objectForKey:@"children"];
    //int arrCount = [(NSArray*)childrenArray count];
    //NSLog(@"Get Directory: childrenArray: arrCount: %d", arrCount);
    
    for (NSDictionary* workspaceFileDict in childrenArray) {
        BDSFile *workspaceFileVO = [self createWorkspaceFileVO:workspaceFileDict];
        // set parent
        [workspaceFileVO setParent:directoryVO];
        [childrenWorkspaceFileArray addObject:workspaceFileVO];
    }
    [directoryVO setChildren:childrenWorkspaceFileArray];
    
    
    return directoryVO;
}


+ (BDSFile *) createWorkspaceFileVO: (NSDictionary*) internalDict {
    
    //NSLog(@"*** parse a child ***");
    
    BDSFile *workspaceFileVO =  [[BDSFile alloc] init];
    NSMutableArray *childrenWorkspaceFileArray = [[NSMutableArray alloc] init];
    
    int bdsFileId = [[internalDict objectForKey:@"id"] intValue];
    //NSLog(@"createWorkspaceFileVO: bdsFileId: %d", bdsFileId);
    [workspaceFileVO setBdsFileId:bdsFileId];
    
    int datafileId = [[internalDict objectForKey:@"datafileId"] intValue];
    //NSLog(@"createWorkspaceFileVO: datafileId: %d", datafileId);
    [workspaceFileVO setDatafileId:datafileId];
    
    NSString *name = [internalDict objectForKey:@"name"];
    //NSLog(@"createWorkspaceFileVO: name: %@", name);
    [workspaceFileVO setName:name];
    
    NSString *description = [internalDict objectForKey:@"description"];
    //NSLog(@"createWorkspaceFileVO: description: %@", description);
    [workspaceFileVO setDescription:description];
    
    long size = [[internalDict objectForKey:@"size"] longLongValue];
    //NSLog(@"createWorkspaceFileVO: size: %ld", size);
    [workspaceFileVO setSize:size];
    
    BOOL isDirectory = [[internalDict objectForKey:@"isDirectory"] boolValue];
    //NSLog(@"createWorkspaceFileVO: isDirectory: %d", (int)isDirectory);
    [workspaceFileVO setIsDirectory:isDirectory];
    
    int parentDirectoryId = [[internalDict objectForKey:@"parentDirectoryId"] intValue];
    //NSLog(@"createWorkspaceFileVO: parentDirectoryId: %d", parentDirectoryId);
    [workspaceFileVO setParentDirectoryId:parentDirectoryId];
    
    int rootDirectoryId = [[internalDict objectForKey:@"rootDirectoryId"] intValue];
    //NSLog(@"createWorkspaceFileVO: rootDirectoryId: %d", rootDirectoryId);
    [workspaceFileVO setRootDirectoryId:rootDirectoryId];
    
    NSString *dateCreated = [internalDict objectForKey:@"dateCreated"];
    //NSLog(@"createWorkspaceFileVO: dateCreated: %@", dateCreated);
    [workspaceFileVO setDateCreated:dateCreated];
    
    
    //children
    NSArray *childrenArray = (NSArray*)[internalDict objectForKey:@"children"];
    //int arrCount = [(NSArray*)childrenArray count];
    //NSLog(@"createWorkspaceFileVO: childrenArray: arrCount: %d", arrCount);
    
    for (NSDictionary* workspaceFileDict in childrenArray) {
        BDSFile *workspaceFileVO2 = [self createWorkspaceFileVO:workspaceFileDict];
        // set parent
        [workspaceFileVO2 setParent:workspaceFileVO];
        [childrenWorkspaceFileArray addObject:workspaceFileVO2];
    }
    [workspaceFileVO setChildren:childrenWorkspaceFileArray];
    
    
    return workspaceFileVO;
}


+(WorkspaceVO*) getWorkspace: (NSURLConnection*) conn :(int) workspaceId {
    @try {
        
        UserInfo *userInfo = [Util getSettingInfo];
        
        NSMutableString *url = [Util buildUrl: [userInfo getServerName] : GET_WORKSPACE_URL : [userInfo isUseSSL]];
        NSLog(@"Server URL: %@", url);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
        NSMutableString *params = [[NSMutableString alloc] initWithString:@""];
        [params appendString: @"sessionId="];
        [params appendString: [userInfo getSessionId]];
        [params appendString: @"&packageId="];
        [params appendString: [NSString stringWithFormat:@"%d", workspaceId]];
        
        NSLog(@"POST data: %@", params);
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        if (conn) {
            NSMutableData *webData = [NSMutableData data];
            NSString *responseStr = [[NSString alloc] initWithBytes:[webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
            NSLog(@"response string: %@", responseStr);
            NSDictionary *responseDictionary = [responseStr JSONValue];
            
            NSDictionary *workspacelDict = [responseDictionary objectForKey:@"workspaceVOWS"];
            WorkspaceVO *wrkspceVO = [self createWorkspaceVO:workspacelDict];
            return wrkspceVO;
        } else {
            NSLog(@"Connection failed");
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get workspace from id; %@: %@", [exception name], [exception reason]);
    }
}


+(NSMutableDictionary*) parseNotificationSettings: (NSDictionary*) responseDictionary {
    NSMutableDictionary *settingMap = [[NSMutableDictionary alloc] init];
    @try {
        int returnCode = [[responseDictionary objectForKey:@"returnCode"] intValue];
        NSLog(@"%@",[NSString stringWithFormat:@"workspace returnCode: %d", returnCode]);
        NSDictionary *settingsDictionary = [responseDictionary objectForKey:@"settingMap"];
        NSObject *entries = [settingsDictionary objectForKey:@"entry"];
        
        for (NSDictionary* entrylDict in (NSArray*)entries) {
            NSString *key = [entrylDict objectForKey:@"key"];
            NSString *value = [entrylDict objectForKey:@"value"];
            [settingMap setValue:value forKey:key];
        }
    }
    @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse notification settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse notification settings." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occured while getting notification settings; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return settingMap;
}


+(DocumentVO*) parseDocument: (NSDictionary*) documentlDict {
    DocumentVO * documentVO = [[DocumentVO alloc] init];
    
    @try {
        if(documentlDict == nil) {
            return nil;
        }
        
        [documentVO setDocumentCreatedBy:[[documentlDict objectForKey:@"createdBy"] intValue]];
        [documentVO setDataFileId:[[documentlDict objectForKey:@"dataFileId"] intValue]];
        [documentVO setDocumentDateCreated:[documentlDict objectForKey:@"dateCreated"]];
        [documentVO setDocumentDateLastUpdated:[documentlDict objectForKey:@"dateLastUpdated"]];
        [documentVO setDocumentDescription:[documentlDict objectForKey:@"description"]];
        [documentVO setDisplayOrder:[[documentlDict objectForKey:@"displayOrder"] intValue]];
        [documentVO setDocumentId:[[documentlDict objectForKey:@"documentId"] intValue]];
        [documentVO setPageCount:[[documentlDict objectForKey:@"pageCount"] intValue]];
        [documentVO setEncrypted:[[documentlDict objectForKey:@"encrypted"] boolValue]];
        [documentVO setHashValue:[documentlDict objectForKey:@"hashValue"]];
        [documentVO setDocumentCreatedBy:[[documentlDict objectForKey:@"createdBy"] intValue]];
        [documentVO setDownloadable:[[documentlDict objectForKey:@"isDownloadable"] boolValue]];
        [documentVO setDocumentLastUpdatedBy:[[documentlDict objectForKey:@"lastUpdatedBy"] intValue]];
        [documentVO setDocumentName:[documentlDict objectForKey:@"name"]];
        [documentVO setSize:[[documentlDict objectForKey:@"size"] longLongValue]];
        
    }   @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse documents of received deliveries." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse documents of received deliveries." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] ;
        NSLog(@"An error occured while trying to  parse documents of received deliveries; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return documentVO;
}


+(UserVO*) parseUser: (NSDictionary*) userlDict {
    UserVO * userVO = [[UserVO alloc] init];
    
    @try {
        if(userlDict == nil) {
            return nil;
        }
        
        [userVO setDisplayName:[userlDict objectForKey:@"displayName"]];
        [userVO setEmailAddress:[userlDict objectForKey:@"emailAddress"]];
        /*
         [userVO setUsername:[userlDict objectForKey:@"username"]];
         [userVO setAuthenticationMethod:[userlDict objectForKey:@"authenticationMethod"]];
         [userVO setUserId:[[userlDict objectForKey:@"userId"] intValue]];
         [userVO setEmailAddress:[userlDict objectForKey:@"emailAddress"]];
         [userVO setFirstName:[userlDict objectForKey:@"firstName"]];
         [userVO setMiddleName:[userlDict objectForKey:@"middleName"]];
         [userVO setLastName:[userlDict objectForKey:@"lastName"]];
         [userVO setCreatedBy:[[userlDict objectForKey:@"createdBy"] intValue]];
         [userVO setDateCreated:[userlDict objectForKey:@"dateCreated"]];
         [userVO setLastUpdatedBy:[[userlDict objectForKey:@"lastUpdatedBy"] intValue]];
         [userVO setDateLastUpdated:[userlDict objectForKey:@"dateLastUpdated"]];
         [userVO setSignupCompletedDate:[userlDict objectForKey:@"signupCompletedDate"]];
         [userVO setLastSignInDate:[userlDict objectForKey:@"lastSignInDate"]];
         [userVO setCompany:[userlDict objectForKey:@"company"]];
         [userVO setAddressLine1:[userlDict objectForKey:@"addressLine1"]];
         [userVO setAddressLine2:[userlDict objectForKey:@"addressLine2"]];
         [userVO setCity:[userlDict objectForKey:@"city"]];
         [userVO setZipCode:[userlDict objectForKey:@"zipCode"]];
         [userVO setWorkPhoneNumber:[userlDict objectForKey:@"workPhoneNumber"]];
         [userVO setHomePhoneNumber:[userlDict objectForKey:@"homePhoneNumber"]];
         [userVO setMobilePhoneNumber:[userlDict objectForKey:@"mobilePhoneNumber"]];
         [userVO setOtherPhoneNumber:[userlDict objectForKey:@"otherPhoneNumber"]];
         [userVO setFaxNumber:[userlDict objectForKey:@"faxNumber"]];
         [userVO setSecretQuestions:[userlDict objectForKey:@"secretQuestions"]];
         [userVO setSignInLocked:[[userlDict objectForKey:@"signInLocked"] boolValue]];
         [userVO setSignInFailureCount:[[userlDict objectForKey:@"signInFailureCount"] intValue]];
         [userVO setSignInTotalFailureCount:[[userlDict objectForKey:@"signInTotalFailureCount"] intValue]];
         [userVO setSignInLastFailureDate:[userlDict objectForKey:@"signInLastFailureDate"]];
         [userVO setSignInFailureCount:[[userlDict objectForKey:@"resetPasswordFailureCount"] intValue]];
         [userVO setResetPasswordTotalFailureCount:[[userlDict objectForKey:@"resetPasswordTotalFailureCount"] intValue]];
         [userVO setResetPasswordLastFailureDate:[userlDict objectForKey:@"resetPasswordLastFailureDate"]];
         [userVO setRecipientInclusionList:[userlDict objectForKey:@"recipientInclusionList"]];
         [userVO setRecipientExclusionList:[userlDict objectForKey:@"recipientExclusionList"]];
         [userVO setAllowSMTPInput:[[userlDict objectForKey:@"allowSMTPInput"] boolValue]];
         [userVO setInactive:[[userlDict objectForKey:@"inactive"] boolValue]];
         [userVO setLastPasswordResetDate:[userlDict objectForKey:@"lastPasswordResetDate"]];
         [userVO setPasswordExpires:[[userlDict objectForKey:@"passwordExpires"] boolValue]];
         [userVO setForcePasswordReset:[[userlDict objectForKey:@"forcePasswordReset"] boolValue]];
         [userVO setState:[userlDict objectForKey:@"state"]];
         [userVO setCountry:[userlDict objectForKey:@"country"]];
         [userVO setActive:[[userlDict objectForKey:@"active"] boolValue]];
         [userVO setTitle:[userlDict objectForKey:@"title"]];
         [userVO setStatus:[userlDict objectForKey:@"status"]];
         */
        
    }   @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse users of workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse users of workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        NSLog(@"An error occured while trying to parse users of workspaces; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return userVO;
}

+(CommentVO*) parseComment: (NSDictionary*) commentlDict {
    CommentVO *commentVO = [[CommentVO alloc] init];
    
    @try {
        if(commentlDict == nil) {
            return nil;
        }
        
        [commentVO setCreatedBy:[commentlDict objectForKey:@"createdBy"]];
        [commentVO setParsedDateCreated:[commentlDict objectForKey:@"parsedDateCreated"]];
        [commentVO setReplyMessage:[commentlDict objectForKey:@"replyMessage"]];
        
    }   @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse comments of workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse comments of workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occured while trying to parse comments of workspaces; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return commentVO;
}

+(ActivityVO*) parseActivity: (NSDictionary*) activitylDict {
    ActivityVO *activityVO = [[ActivityVO alloc] init];
    
    @try {
        if(activitylDict == nil) {
            return nil;
        }
        
        [activityVO setParsedEventDate:[activitylDict objectForKey:@"parsedTransactionDate"]];
        [activityVO setMessage:[activitylDict objectForKey:@"logEntry"]];
        
    }   @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse activities of workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse activities of workspaces." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occured while trying to parse activities of workspaces; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return activityVO;
}

+(int) getUnreadDeliveryCount:(NSString*) deliveryList {
    int count = 0;
    
    if(![self isEmpty:deliveryList]) {
        NSDictionary *responseDictionary = [deliveryList JSONValue];
        NSMutableArray *deliveryVOList = [Util parseDeliveries:responseDictionary];
        for (DeliveryVO* deliveryVO in deliveryVOList) {
            if(![deliveryVO getReadStatus]) {
                count++;
            }
        }
    }
    
    return count;
}

+(NSMutableString*) parseRecipients: (NSMutableString*) addressList: (NSDictionary*) recipientsDict:(NSString*) key {
    int count = 0;
    
    if([key isEqualToString:@"toAddressListEntries"]) {
        count = [[recipientsDict objectForKey:@"totalToRecipients"] intValue];
        
    } else if([key isEqualToString:@"ccAddressListEntries"]) {
        count = [[recipientsDict objectForKey:@"totalCcRecipients"] intValue];
        
    } else if([key isEqualToString:@"bccAddressListEntries"]) {
        count = [[recipientsDict objectForKey:@"totalBccRecipients"] intValue];
    }
    
    if(count == 1) {
        addressList = [recipientsDict objectForKey:key];
    } else {
        NSArray* addressArray = [recipientsDict objectForKey:key];
        
        int i, arrCount = [addressArray count];
        for (i =0; i < arrCount; i++) {
            [addressList appendString: [addressArray objectAtIndex:i]];
            if(i < arrCount -1) {
                [addressList appendString: @", "];
            }
        }
    }
    
    return addressList;
}


+(NSMutableString*) parseWorkspaceUsers: (NSMutableString* )addressList: (NSObject *)userArray {
    
    NSString *userDisplay;
    if([userArray isKindOfClass:[NSArray class]]) {
        int i = 0, arrCount = [(NSArray*)userArray count];
        
        for (NSDictionary* userDict in (NSArray*)userArray) {
            UserVO *userVO = [self parseUser:userDict];
            if(userVO != nil) {
                userDisplay = [userVO getDisplayName];
                if([Util isEmpty :userDisplay]) {
                    userDisplay = [userVO getEmailAddress];
                }
                [addressList appendString: userDisplay];
                [addressList appendString:DISPLAY_NAME_EMAIL_SEPARATION_STRING];
                [addressList appendString: [userVO getEmailAddress]];
            }
            if(i < arrCount-1) {
                [addressList appendString: @"; "];
            }
            i++;
        }
        
    } else {
        UserVO *userVO = [self parseUser:(NSDictionary*)userArray];
        if(userVO != nil) {
            [addressList appendString: [userVO getDisplayName]];
            [addressList appendString:DISPLAY_NAME_EMAIL_SEPARATION_STRING];
            [addressList appendString: [userVO getEmailAddress]];
        }
    }
    
    return addressList;
}


+(NSMutableString*) parsedWorkspaceUsersDisplayList: (NSMutableString* )formattedString :(NSString* )addressList {
    
    //NSLog(@"AddressList: %@", addressList);
    
    
    [formattedString setString:@""];
    NSArray *items;
    NSEnumerator *e;
    NSString *userDisplayName;
    NSString *userEmail;
    
    items = [addressList componentsSeparatedByString:@";"];
    
    // sort the list alphabetically
    items = [items sortedArrayUsingSelector: @selector(localizedCaseInsensitiveCompare:)];
    
    e = [items objectEnumerator];
    
    BOOL multipleItems = FALSE;
    
    NSString * displayPlusEmailStr;
    NSArray * displayPlusEmail;
    
    while(displayPlusEmailStr = [e nextObject]){
        if(multipleItems) {
            [formattedString appendString:@"; "];
        }
        displayPlusEmail = [displayPlusEmailStr componentsSeparatedByString:DISPLAY_NAME_EMAIL_SEPARATION_STRING];
        if([displayPlusEmail count] > 1){
            userDisplayName = [displayPlusEmail objectAtIndex:0];
            userEmail = [displayPlusEmail objectAtIndex:1];
        }
        if(![Util isEmpty:userDisplayName]){
            [formattedString appendString:userDisplayName];
        } else if(![Util isEmpty:userEmail]){
            [formattedString appendString:userEmail];
        }
        multipleItems = TRUE;
    }
    
    formattedString = [NSString stringWithFormat:@"%@", [formattedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];

    return formattedString;
}



+(NSMutableArray*) getDocumentsFromDeliveryId:(int) deliveryId  {
    NSMutableArray *documentVOs = [[NSMutableArray alloc] init];
    
    NSString *respStr = [self getStringValue:DELIVERY_VOS];
    
    if(![Util isEmpty:respStr]) {
        //NSDictionary *responseDictionary = [[respStr JSONValue] retain];
        NSDictionary *responseDictionary = [respStr JSONValue];
        NSMutableArray *deliveryVOs = [Util parseDeliveries:responseDictionary];
        
        for (DeliveryVO *delV in deliveryVOs) {
            if([delV getDeliveryId] == deliveryId) {
                documentVOs = [delV getDocumentVOs];
            }
        }
    }
    
    return documentVOs;
}


+(NSMutableArray*) getDocumentsFromWorkspaceId:(int) workspaceId  {
    NSMutableArray *documentVOs = [[NSMutableArray alloc] init];
    
    NSString *respStr = [self getStringValue:WORKSPACE_VOS];
    
    if(![Util isEmpty:respStr]) {
        //NSDictionary *responseDictionary = [[respStr JSONValue] retain];
        NSDictionary *responseDictionary = [respStr JSONValue];
        NSMutableArray *workspaceVOs = [Util parseWorkspaces:responseDictionary];
        
        for (WorkspaceVO *wsV in workspaceVOs) {
            if([wsV getPackageId] == workspaceId) {
                documentVOs = [wsV getDocumentVOs];
            }
        }
    }
    
    return documentVOs;
}

/*
+ (BOOL) startActivityIndicator {
    BOOL started = NO;
    
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //appDelegate.detailViewController.activity = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        appDelegate.detailViewController.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        appDelegate.detailViewController.activity.frame=CGRectMake(300, 300, 25, 25);
        appDelegate.detailViewController.activity.tag  = 1;
        [appDelegate.detailViewController.detailView addSubview:appDelegate.detailViewController.activity];
        //[appDelegate.detailViewController.activity retain];
        [appDelegate.detailViewController.activity startAnimating];
        
        started = YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Could not start the activity indicator; %@: %@", [exception name], [exception reason]);
    }
    
    return started;
}

+ (BOOL) stopActivityIndicator {
    BOOL stoped = NO;
    
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.detailViewController.activity!= nil && [appDelegate.detailViewController.activity isAnimating]) {
            [appDelegate.detailViewController.activity stopAnimating];
            //[appDelegate.detailViewController.activity release];
            stoped = YES;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Could not stop the activity indicator; %@: %@", [exception name], [exception reason]);
    }
    
    return stoped;
}


+ (BOOL) startActivityInWorkspaceIndicator {
    BOOL started = NO;
    
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if (appDelegate.workspaceDetailViewController.activity == nil) {
            appDelegate.workspaceDetailViewController.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            appDelegate.workspaceDetailViewController.activity.color = [UIColor grayColor];
        }
        if([Util isiPad]) {
            appDelegate.workspaceDetailViewController.activity.frame = CGRectMake(400, 150, 25, 25);
        } else {
            appDelegate.workspaceDetailViewController.activity.frame = CGRectMake(150, 150, 25, 25);
        }
        appDelegate.workspaceDetailViewController.activity.tag  = 1;
        [appDelegate.workspaceDetailViewController.view addSubview:appDelegate.workspaceDetailViewController.activity];
        [appDelegate.workspaceDetailViewController.activity startAnimating];
        
        started = YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Could not start the activity indicator; %@: %@", [exception name], [exception reason]);
    }
    
    return started;
}

+ (BOOL) stopActivityInWorkspaceIndicator {
    BOOL stoped = NO;
    
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.workspaceDetailViewController.activity stopAnimating];
        [appDelegate.workspaceDetailViewController.activity removeFromSuperview];
        appDelegate.workspaceDetailViewController.activity = nil;
        stoped = YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Could not stop the activity indicator; %@: %@", [exception name], [exception reason]);
    }
    
    return stoped;
}


+ (BOOL) startLeftActivityIndicator {
    BOOL started = NO;
    
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        appDelegate.activityContainer.customView = appDelegate.activityIndicator;
        
        appDelegate.activityDescriptionContainer.customView = appDelegate.updateTimeLabel;
        appDelegate.updateTimeLabel.font = [UIFont boldSystemFontOfSize:12];
        appDelegate.updateTimeLabel.text = @"Checking for deliveries";
        [appDelegate.activityIndicator startAnimating];
        started = YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Could not start the activity indicator; %@: %@", [exception name], [exception reason]);
    }
    
    return started;
}

+ (BOOL) stopLeftActivityIndicator {
    BOOL stoped = NO;
    
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.activityDescriptionContainer.customView = appDelegate.activityDescription;
        appDelegate.activityContainer.customView = appDelegate.updatedLabel;
        appDelegate.activityDescription.font = [UIFont systemFontOfSize:12];
        //appDelegate.activityDescription.text = [Util formatDate:[[[NSDate alloc] init] autorelease]];
        appDelegate.activityDescription.text = [Util formatDate:[[NSDate alloc] init]];
        [appDelegate.activityIndicator stopAnimating];
        stoped = YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Could not stop the activity indicator; %@: %@", [exception name], [exception reason]);
    }
    
    return stoped;
}


+ (BOOL) startWorkspaceLeftActivityIndicator {
    BOOL started = NO;
    
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        UIBarButtonItem *barItem1 = [[appDelegate.listViewController.toolbar items] objectAtIndex:2];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        barItem1.customView = spinner;
        [spinner startAnimating];
        
        UIBarButtonItem *barItem2 = [[appDelegate.listViewController.toolbar items] objectAtIndex:3];
        CGRect labelFrame2 = CGRectMake(0, 0, 150, 30);
        UILabel* label2 = [[UILabel alloc] initWithFrame: labelFrame2];
        //label2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        label2.textColor = [UIColor darkGrayColor];
        label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        label2.text = @"Checking for workspaces";
        barItem2.customView = label2;
        started = YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Could not start the activity indicator; %@: %@", [exception name], [exception reason]);
    }
    
    return started;
}

+ (BOOL) stopWorkspaceLeftActivityIndicator {
    BOOL stoped = NO;
    
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        UIBarButtonItem *barItem1 = [[appDelegate.listViewController.toolbar items] objectAtIndex:2];
        CGRect labelFrame1 = CGRectMake(0, 0, 45, 30);
        UILabel* label1 = [[UILabel alloc] initWithFrame: labelFrame1];
        //label1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        label1.textColor = [UIColor darkGrayColor];
        label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
        label1.text = @"Updated";
        barItem1.customView = label1;
        
        UIBarButtonItem *barItem2 = [[appDelegate.listViewController.toolbar items] objectAtIndex:3];
        CGRect labelFrame2 = CGRectMake(0, 0, 100, 30);
        UILabel* label2 = [[UILabel alloc] initWithFrame: labelFrame2];
        //label2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        label2.textColor = [UIColor darkGrayColor];
        label2.font = [UIFont systemFontOfSize:12];
        label2.text = [Util formatDate:[[NSDate alloc] init]];
        barItem2.customView = label2;
        stoped = YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Could not stop the activity indicator; %@: %@", [exception name], [exception reason]);
    }
    
    return stoped;
}


+ (void) hideLeftActivityIndicator {
    @try {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.activityDescriptionContainer.customView = appDelegate.activityDescription;
        if (![Util isEmpty:appDelegate.activityDescription.text]) {
            appDelegate.activityContainer.customView = appDelegate.updatedLabel;
        }
        
        [appDelegate.activityIndicator stopAnimating];
    }
    @catch (NSException *exception) {
        NSLog(@"Could not stop the activity indicator; %@: %@", [exception name], [exception reason]);
    }
}


 + (void) setDeliveryDetailView:(DeliveryVO*) deliveryVO:(int) currentIndex {
 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 
 NSMutableArray *deliveryView = nil;
 if(deliveryVO == nil) {
 deliveryView = [[[NSMutableArray alloc] initWithObjects: @"", @"", @"", @"", @"", @"", @"", @"0", nil] autorelease];
 }else {
 deliveryView = [[[NSMutableArray alloc] initWithObjects: deliveryVO.getSenderEmailAddress, deliveryVO.getToAddressList, deliveryVO.getCCAddressList, deliveryVO.getDeliveryName, deliveryVO.getParsedDateLastUpdated, deliveryVO.getSecureMessage, deliveryVO.getNotificationMessage, [NSString stringWithFormat:@"%d", [deliveryVO getDeliveryId]], nil] autorelease];
 }
 
 // Release the previously created detail table view
 if(appDelegate.detailViewController.deliveryViewTable != nil) {
 [appDelegate.detailViewController.deliveryViewTable release];
 }
 
 appDelegate.detailViewController.deliveryViewTable = [[DeliveryViewTable alloc] initWithNibName: @"DeliveryViewTable" bundle:nil andDeliveryVO:deliveryView];
 
 // Save the current delivery id and index for deletion perpose.
 if(deliveryVO != nil) {
 [appDelegate.detailViewController setCurrentViewedDeliveryId: [deliveryVO getDeliveryId]];
 }
 [appDelegate.detailViewController setCurrentDeliveryIndex:currentIndex];
 
 [appDelegate.detailViewController.detailView addSubview:appDelegate.detailViewController.deliveryViewTable.view];
 NSLog(@"Util.setDeliveryDetailView: count: %d", [appDelegate.detailViewController.detailView.subviews count]);
 }



+ (void) setDeliveryDetailView:(DeliveryVO*) deliveryVO:(int) currentIndex {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Release the previously created detail table view
    if(appDelegate.detailViewController.deliveryView != nil) {
        [appDelegate.detailViewController.deliveryView.view removeFromSuperview];
        appDelegate.detailViewController.deliveryView = nil;
    }
    
    appDelegate.detailViewController.deliveryView = [[DeliveryView alloc] initWithDeliveryVo:deliveryVO];
    
    // Save the current delivery id and index for deletion perpose.
    if(deliveryVO != nil) {
        [appDelegate.detailViewController setCurrentViewedDeliveryId: [deliveryVO getDeliveryId]];
        //NSLog(@"delivery id: %d", [deliveryVO getDeliveryId]);
        //NSLog(@"delivery name: %@", [deliveryVO getDeliveryName]);
    }
    [appDelegate.detailViewController setCurrentDeliveryIndex:currentIndex];
    
    [appDelegate.detailViewController.detailView addSubview:appDelegate.detailViewController.deliveryView.view];
    
}


+ (void) setWorkspaceDetailView:(WorkspaceVO*) workspaceVO:(int) currentIndex {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Release the previously created detail table view
    if(appDelegate.workspaceDetailViewController.workspaceView != nil) {
        //[appDelegate.workspaceDetailViewController.workspaceView release];
        [appDelegate.workspaceDetailViewController.workspaceView.view removeFromSuperview];
        appDelegate.workspaceDetailViewController.workspaceView = nil;
    }
    
    // Save the current workspace id and index for deletion purpose.
    if(workspaceVO != nil) {
        appDelegate.workspaceDetailViewController.workspaceView = [[WorkspaceView alloc] initWithWorkspaceVO:workspaceVO :currentIndex];
        [appDelegate.workspaceDetailViewController setCurrentViewedWorkspaceId:[workspaceVO getPackageId]];
        [appDelegate.workspaceDetailViewController setCurrentWorkspaceIndex:currentIndex];
        
        [appDelegate.workspaceDetailViewController.workspaceDetailView addSubview: appDelegate.workspaceDetailViewController.workspaceView.view];
        
    } else {
        // Release the previously created detail table view
        if(appDelegate.workspaceDetailViewController.emptyView != nil) {
            //[appDelegate.workspaceDetailViewController.emptyView release];
            appDelegate.workspaceDetailViewController.emptyView = nil;
        }
        
        [appDelegate.workspaceDetailViewController setCurrentWorkspaceIndex:-1];
        
        appDelegate.workspaceDetailViewController.emptyView = [[EmptyView alloc] init];
        [appDelegate.workspaceDetailViewController.workspaceDetailView addSubview: appDelegate.workspaceDetailViewController.emptyView.view];
    }
    
}


+ (void) setWorkspaceDetailView:(WorkspaceVO*) workspaceVO Index:(int)currentIndex AndDirLevel:(BDSFile *) dirLevel {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Release the previously created detail table view
    if(appDelegate.workspaceDetailViewController.workspaceView != nil) {
        //[appDelegate.workspaceDetailViewController.workspaceView release];
        [appDelegate.workspaceDetailViewController.workspaceView.view removeFromSuperview];
        appDelegate.workspaceDetailViewController.workspaceView = nil;
    }
    
    // Save the current workspace id and index for deletion purpose.
    if(workspaceVO != nil) {
        appDelegate.workspaceDetailViewController.workspaceView = [[WorkspaceView alloc] initWithWorkspaceVO:workspaceVO AndDirLevel:dirLevel];
        [appDelegate.workspaceDetailViewController setCurrentViewedWorkspaceId:[workspaceVO getPackageId]];
        [appDelegate.workspaceDetailViewController setCurrentWorkspaceIndex:currentIndex];
        
        [appDelegate.workspaceDetailViewController.workspaceDetailView addSubview: appDelegate.workspaceDetailViewController.workspaceView.view];
        
    } else {
        // Release the previously created detail table view
        if(appDelegate.workspaceDetailViewController.emptyView != nil) {
            //[appDelegate.workspaceDetailViewController.emptyView release];
            appDelegate.workspaceDetailViewController.emptyView = nil;
        }
        
        [appDelegate.workspaceDetailViewController setCurrentWorkspaceIndex:-1];
        
        appDelegate.workspaceDetailViewController.emptyView = [[EmptyView alloc] init];
        [appDelegate.workspaceDetailViewController.workspaceDetailView addSubview: appDelegate.workspaceDetailViewController.emptyView.view];
    }

}
*/

+ (void) convertOldFilesToNewFormat {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *homeDirectory = [paths objectAtIndex:0];
    
    // bdsFiles
    NSString *bdsFilesDirectory = [homeDirectory stringByAppendingPathComponent:BDS_FILES];
    
    
    @try {
        // Get all the old downloaded files by previous version
        NSString *pathPlist = [homeDirectory stringByAppendingPathComponent:@"DownloadedFiles.plist"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath: pathPlist]) {
            NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile: pathPlist];
            NSEnumerator *enumerator = [dataDic keyEnumerator];
            
            for(NSString *idKey in enumerator) {
                
                NSString *docName = [Util getStringValue:idKey :@"DownloadedFiles.plist"];
                NSString *docId = idKey;
                
                if(![Util isEmpty:docId]) {
                    NSString *filePath = [bdsFilesDirectory stringByAppendingPathComponent:docName];
                    unsigned long long docSize = [Util decryptAndGetSize:filePath :docName];
                    [Util saveDocumentInfo:docId :docName :docSize :docSize :0];
                }
                
                // Move the file in directory format
                // bdsFiles/Dir-File_Name
                NSString *fileDir = [[NSString alloc] initWithFormat:@"Dir-%@", docName];
                // bdsFiles/Dir-File_Name
                fileDir  = [bdsFilesDirectory stringByAppendingPathComponent: fileDir];
                
                if(![fileManager fileExistsAtPath:fileDir]){
                    // This might be a old file which was not downloaded by chunks - bdsFiles/File_Name.
                    NSString* oldFile = [bdsFilesDirectory stringByAppendingPathComponent:docName];
                    NSLog(@"old File: %@", oldFile);
                    BOOL fileExists = [fileManager fileExistsAtPath:oldFile];
                    if(fileExists){
                        // Rename the file to data-0 and store in the fileDir - bdsFiles/Dir-File_Name
                        if (![fileManager createDirectoryAtPath:fileDir
                                    withIntermediateDirectories:NO
                                                     attributes:nil
                                                          error:nil])
                        {
                            NSLog(@"Create directory error");
                        }
                        
                        // Rename the file, by moving the file - bdsFiles/Dir-File_Name/data-0
                        NSString *data0 = [fileDir stringByAppendingPathComponent:@"data-0"];
                        // Attempt the move
                        if ([fileManager moveItemAtPath:oldFile toPath:data0 error:nil] != YES){
                            NSLog(@"Unable to move file.");
                        } else {
                            // Delete data from directory
                            [Util removeDataFromProperty:idKey :@"DownloadedFiles.plist"];
                        }
                    }
                } // if ends
                
            } // for ends
            
        } // if ends
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to convert plist data to core data; %@: %@", [exception name], [exception reason]);
    }
}

NSMutableDictionary *fileDictionary;

+ (NSMutableDictionary*) getFileListFromSnadbox{
    
    [Util convertOldFilesToNewFormat];
    NSArray *docArray = [Document fetchAll];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *homeDirectory = [paths objectAtIndex:0];
    // bdsFiles
    NSString *bdsFilesDirectory = [homeDirectory stringByAppendingPathComponent:BDS_FILES];
    // bdsFiles/bdsTempToDecrypt
    NSString *bdsTempDirecotry = [bdsFilesDirectory stringByAppendingPathComponent:BDS_TEMP_FILES];
    
    @try {
        fileDictionary = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [docArray count]; i++) {
            Document *doc = [docArray objectAtIndex:i];
            NSString *docName = [NSString stringWithFormat:@"%@", doc.docName];
            NSString * absPath = [bdsTempDirecotry stringByAppendingPathComponent:docName];
            [fileDictionary setObject:absPath forKey:docName];
            NSLog(@"filesDictonary: %@", fileDictionary);
            NSLog(@"---name: %@", docName);
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get files from core data; %@: %@", [exception name], [exception reason]);
    }
    
    return fileDictionary;
}

+ (void) deleteFile :(NSString *) documentName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_FILES];
    NSString *tempDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_TEMP_FILES];
    
    // Remove the file from storage
    NSString * fileDir = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"Dir-%@" , documentName]];
    NSString * tempFilePath = [tempDirectory stringByAppendingPathComponent:documentName];
    // for old file (not saved in Dir-FileName format
    NSString * oldFile = [documentsDirectory stringByAppendingPathComponent: documentName];
    
    NSError *error;
    if([[NSFileManager defaultManager] fileExistsAtPath: tempFilePath]) {
        if ([[NSFileManager defaultManager] removeItemAtPath:tempFilePath error:&error] != YES) {
            NSLog(@"Could not able to delete downloaded file from temp directory; fileName: %@", documentName);
        }
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath: fileDir]) {
        if ([[NSFileManager defaultManager] removeItemAtPath:fileDir error:&error] != YES) {
            NSLog(@"Could not able to delete downloaded directory to hold file chunks; fileName: %@", documentName);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not able to delete downloaded directory to hold file chunks." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    
    // For files downloaded via old version
    if([[NSFileManager defaultManager] fileExistsAtPath: oldFile]) {
        if ([[NSFileManager defaultManager] removeItemAtPath:oldFile error:&error] != YES) {
            NSLog(@"Could not able to delete downloaded file (via old version); fileName: %@", documentName);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not able to delete downloaded file (via old version)." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
}



+ (void) deleteDeliveryFiles:(int) deliveryId {
    int count = 0;
    
    @try {
        NSMutableArray* documentVOs = [self getDocumentsFromDeliveryId: deliveryId];
        
        for(DocumentVO *docVO in documentVOs) {
            
            NSString *docId = [NSString stringWithFormat:@"%d", [docVO getDocumentId]];
            
            Document *doc = [Util getDocumentInfo:docId];
            
            if(doc != nil) {
                [Util deleteFile:doc.docName];
                [doc delete];
            }
            count ++;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to delete files from delivery; deliveryId: %d %@: %@", deliveryId, [exception name], [exception reason]);
    }
    
    NSLog(@"Deleted delivery file count: %d", count);
}


+ (void) deleteWorkspaceFiles:(int) workspaceId {
    int count = 0;
    NSError *error;
    
    @try {
        NSMutableArray* documentVOs = [self getDocumentsFromWorkspaceId: workspaceId];
        
        
        for(DocumentVO *docVO in documentVOs) {
            
            NSString *docId = [NSString stringWithFormat:@"%d", [docVO getDocumentId]];
            
            Document *doc = [Util getDocumentInfo:docId];
            
            if(doc != nil) {
                [Util deleteFile:doc.docName];
                [doc delete];
            }
            count ++;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to delete files from workspace; workspace: %d %@: %@", workspaceId, [exception name], [exception reason]);
    }
    
    NSLog(@"Deleted workspace file count: %d", count);
}

+(void) deleteFilesAndDeliveries {
    int count = 0;
    
    @try {
        //Delete deleveries
        [self saveDataToProperty: DELIVERY_VOS : @""];
        NSLog(@"Delivery VOs: %@",  [Util getStringValue:DELIVERY_VOS]);
        
        NSMutableDictionary *dict = [Util getFileListFromSnadbox];
        NSEnumerator *enumerator = [dict keyEnumerator];
        for(NSString *fileName in enumerator) {
            [Util deleteFile:fileName];
        }
        
        [self deleteAllDownloadedFileNames];
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to delete user files and deliveries; %@: %@", [exception name], [exception reason]);
    }
    
    NSLog(@"deleted files: %d", count);
}


+(void) deleteFilesAndWorkspaces {
    int count = 0;
    
    @try {
        //Delete workspaces
        [self saveDataToProperty: WORKSPACE_VOS : @""];
        NSLog(@"Workspace VOs: %@",  [Util getStringValue:WORKSPACE_VOS]);
        
        NSMutableDictionary *dict = [Util getFileListFromSnadbox];
        NSEnumerator *enumerator = [dict keyEnumerator];
        for(NSString *fileName in enumerator) {
            [Util deleteFile:fileName];
        }
        
        [self deleteAllDownloadedFileNames];
        
    }  @catch (NSException *exception) {
        NSLog(@"An error occured while trying to delete user files and workspaces; %@: %@", [exception name], [exception reason]);
    }
    
    NSLog(@"deleted files: %d", count);
}

+ (BOOL) isValidFileToShow: (NSString*) fileName {
    BOOL valid = YES;
    
    //if ([fileName hasSuffix:@".nib"] || [fileName hasSuffix:@".plist"] || [fileName hasSuffix:@".lproj"] || [fileName isEqualToString:@"BDS"] || [fileName isEqualToString:@"bds-change-log.txt"] || [fileName isEqualToString:@"bdsTempToDecrypt"]) {
    if ([fileName isEqualToString:@"bdsTempToDecrypt"]) {
        valid = NO;
    }
    
    return valid;
}

+ (void) markDeliveryRead:(int) deliveryId {
    GetDelivery *getDel = [[GetDelivery alloc] init];
    [getDel getDelivery:deliveryId :nil];
    //[getDel release];
}

+ (void) getDelivery:(int) deliveryId :(NSString*) password {
    GetDelivery *getDel = [[GetDelivery alloc] init];
    if(![Util isEmpty:password]){
        [getDel getDelivery:deliveryId :password];
    } else {
        [getDel getDelivery:deliveryId :nil];
    }
}

+(NSString*) getLoginServerURL: (NSString*) server {
    NSString *loginServer = nil;
    
    NSRange range = [server rangeOfString:@"/" options:NSBackwardsSearch range:NSMakeRange(0, server.length)];
    if(range.location != NSNotFound) {
        loginServer = [NSString stringWithFormat:@"%@%@", server, BDS_REST_WEB_SERVICE];
    }else {
        loginServer = [NSString stringWithFormat:@"%@/%@", server, BDS_REST_WEB_SERVICE];
    }
    
    return loginServer;
}

+ (void) releaseConnection:(NSURLConnection *) conn {
    if(conn != nil) {
        //[conn release];
        conn = nil;
    }
}

+ (void) releaseWebData:(NSMutableData *) webData {
    if(webData != nil) {
        //[webData release];
        webData = nil;
    }
}

+ (void) releaseString:(NSString *) str {
    //[str release];
    str = nil;
}

+ (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString
// Returns a user-visible date time string that corresponds to the
// specified RFC 3339 date time string. Note that this does not handle
// all possible RFC 3339 date time strings, just one of the most common
// styles.
{
    NSString *          userVisibleDateTimeString;
    NSDateFormatter *   rfc3339DateFormatter;
    NSLocale *          enUSPOSIXLocale;
    NSDate *            date;
    NSDateFormatter *   userVisibleDateFormatter;
    
    userVisibleDateTimeString = nil;
    
    // Convert the RFC 3339 date time string to an NSDate.
    
    //rfc3339DateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    
    //enUSPOSIXLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];
    enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [rfc3339DateFormatter setLocale:enUSPOSIXLocale];
    [rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    [rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    date = [rfc3339DateFormatter dateFromString:rfc3339DateTimeString];
    if (date != nil) {
        
        // Convert the NSDate to a user-visible date string.
        
        //userVisibleDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        userVisibleDateFormatter = [[NSDateFormatter alloc] init];
        assert(userVisibleDateFormatter != nil);
        
        [userVisibleDateFormatter setDateStyle:NSDateFormatterShortStyle];
        [userVisibleDateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        userVisibleDateTimeString = [userVisibleDateFormatter stringFromDate:date];
    }
    return userVisibleDateTimeString;
}

+ (NSMutableString *)buildUrl:(NSString *)server:(NSString *)target:(BOOL)isUseSSL {
    NSString *loginServer = [Util getLoginServerURL:server];
    
    NSMutableString *url = [[NSMutableString alloc] initWithString:@""];
    if (!isUseSSL) {
        [url appendString:HTTP];
    } else {
        [url appendString:HTTPS];
    }
    
    [url appendString: loginServer];
    [url appendString: target];
    
    return url;
}

+ (BOOL) validateSignIn {
    BOOL validate = YES;
    
    if(![Util isSignedIn]) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert setMessage:@"Please sign in to your BDS account first."];
        [alert show];
        
        validate = NO;
    }
    
    return  validate;
}
/*
+ (void) loadSettingModalWindow: (UIViewController*) parentWindow {
    
    @try {
        //SettingsTableView *settingTable = [[[SettingsTableView alloc]initWithNibName:@"SettingsTableView" bundle:nil] autorelease];
        SettingsTableView *settingTable = [[SettingsTableView alloc]initWithNibName:@"SettingsTableView" bundle:nil];
        [settingTable setDelegate:parentWindow];
        
        UINavigationController *modal = [[UINavigationController alloc] initWithRootViewController:settingTable];
        modal.modalPresentationStyle = UIModalPresentationFormSheet;
        modal.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [parentWindow presentModalViewController:modal animated:YES];
        
    }@catch (NSException *exception) {
        NSLog(@"An error occured while trying to show setting modal window; %@: %@", [exception name], [exception reason]);
    }
    
}


+ (void) loadFileSettingModalWindow: (UIViewController*) parentWindow {
    
    @try {
        UserFilesInfo *userFilesInfo = [Util getUserFilesInfo];
        if(userFilesInfo.numberOfFiles > 0) {
            ManageUserFiles *settingTable = [[ManageUserFiles alloc] init];
            [settingTable setDelegate:parentWindow];
            
            UINavigationController *modal = [[UINavigationController alloc] initWithRootViewController:settingTable];
            if ([Util iOS6orLess]) {
                modal.modalPresentationStyle = UIModalPresentationFormSheet;
            } else {
                modal.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            modal.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [parentWindow presentModalViewController:modal animated:YES];
            
        } else {
            NSString *alertTitle =  @"";
            NSString *alertMsg =  @"There is no downloaded file.";
            NSString *btnOkTitle = @"OK";
            NSString *btnCancelTitle = nil;
            UIAlertView *configAlert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                                  message:alertMsg
                                                                 delegate:self
                                                        cancelButtonTitle:btnCancelTitle
                                                        otherButtonTitles:btnOkTitle, nil];
            [configAlert show];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"An error occured while trying to show setting modal window; %@: %@", [exception name], [exception reason]);
    }
    
}
*/
/*- (void)dealloc
 {
 [userInfo release];
 [savedData release];
 [super dealloc];
 }*/

/**
 * This method converts NSDate to NSString with short date and time format.
 */
+(NSString*) formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    //[dateFormatter release];
    return formattedDateString;
}
/*
+ (void) handleConnectionFailure:(UIActivityIndicatorView*) activity :(NSError *)error : (id) caller : (NSURLConnection *)connection: (NSMutableData *)webData {
    
    // Stop the activity indicator
    if([caller isKindOfClass:[ReceivedDelivery class]]) { // For received delivery
        [Util hideLeftActivityIndicator];
    } else if([caller isKindOfClass:[SettingsTableView class]]) {
        [activity stopAnimating];
    } else if(![caller isKindOfClass:[DeliveryViewTable class]]) { // Activities other than the delivery view
        [Util stopActivityIndicator];
    } else if(activity != nil){ // Acivity of the delivery view
        [activity stopAnimating];
    }
    
    NSString *failureMessage = [NSString stringWithFormat:@"Connection failure description: %@", [error description]];
    NSLog(@"%@", failureMessage);
    NSLog(@"\n");
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.detailViewController.fileDownloadConn cancel];
    [appDelegate.detailViewController.workspaceFileDownloadConn cancel];
    
    appDelegate.detailViewController.fileDownloadConn = nil;
    appDelegate.detailViewController.workspaceFileDownloadConn = nil;
    
    appDelegate.connectionErrorFound = YES;
    if(connectionErrorAlert) {
        connectionErrorAlert = false;
        UserInfo *userInfo = [Util getSettingInfo];
        NSString *alertMsg = [NSString stringWithFormat:@"Could not connect to the Biscom SFT server: %@", [userInfo getServerName]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag = CONNECTION_ERROR_TAG;
        [alert setMessage: alertMsg];
        [alert show];
    }
    
    // Release the resources
    [Util releaseConnection:connection];
    [Util releaseWebData:webData];
}


+ (void) handleConnectionFailureForARC:(UIActivityIndicatorView*) activity :(NSError *)error : (id) caller {
    
    // Stop the activity indicator
    if([caller isKindOfClass:[ReceivedDelivery class]]) { // For received delivery
        [Util hideLeftActivityIndicator];
    } else if([caller isKindOfClass:[SettingsTableView class]]) {
        [activity stopAnimating];
    } else if ([caller isKindOfClass:[Workspaces class]]) {
        [Util stopWorkspaceLeftActivityIndicator];
    } else if(![caller isKindOfClass:[DeliveryViewTable class]]) { // Activities other than the delivery view
        [Util stopActivityInWorkspaceIndicator];
    } else if(activity != nil){ // Acivity of the delivery view
        [activity stopAnimating];
    }
    
    NSString *failureMessage = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
    NSLog(@"%@", failureMessage);
    
    if(connectionErrorAlert) {
        connectionErrorAlert = false;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] ;
        alert.tag = CONNECTION_ERROR_TAG;
        [alert setMessage:@"Could not connect to the Biscom SFT server."];
        [alert show];
    }
}
*/
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == CONNECTION_ERROR_TAG){
        connectionErrorAlert = true;
    }
}


+ (NSString*) getFormatedSizeText:(long) size {
    double s = size;
    NSMutableArray *sizeArr = [[NSMutableArray alloc] initWithObjects:@"B", @"KB", @"MB", @"GB", @"TB", @"PB", @"EB", nil];
    
    int i = 0;
    while (i < sizeArr.count && s >= 1024)
    {
        s = (int)(100 * s / 1024) / 100.0;
        i++;
    }
    
    //NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"0.0"];
    NSNumber *fileSize = [NSNumber numberWithFloat:s];
    
    NSString *sizeText = [NSString stringWithFormat:@"%@ %@",[numberFormatter stringFromNumber:fileSize], [sizeArr objectAtIndex:i]];
    return sizeText;
}


+ (NSString*) getSizeText:(long) size {
    double s = size;
    NSMutableArray *sizeArr = [[NSMutableArray alloc] initWithObjects:@"B", @"KB", @"MB", @"GB", @"TB", @"PB", @"EB", nil];
    
    int i = 0;
    while (i < sizeArr.count && s >= 1024)
    {
        s = (int)(100 * s / 1024) / 100.0;
        i++;
    }
    
    //NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"0.0"];
    NSNumber *fileSize = [NSNumber numberWithFloat:s];
    
    NSString *sizeText = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:fileSize]];
    return sizeText;
}

/*
+ (void) forceUpdateInactiveUIs {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.rootViewController.tableView.userInteractionEnabled = NO;
    appDelegate.detailViewController.detailView.userInteractionEnabled = NO;
    appDelegate.detailViewController.tabBarController.tabBar.userInteractionEnabled = NO;
}
*/

+ (NSString*) decryptAndCopyFile:(NSString*) filePath :(NSString*) documentName {
    NSString *tempFile = nil;
    
    @try {
        // Get the file content and decrypt it
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData * fileData = [fileManager contentsAtPath:filePath];
        
        NSError * __autoreleasing *err;
        //NSError ** ;
        NSError *error;
        fileData = [fileData decryptedAES256DataUsingKey:AESEncryptionKey error:err];
        
        // Copy the decrypted file to the temp location
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        documentsDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_FILES];
        documentsDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_TEMP_FILES];
        if (![fileManager fileExistsAtPath: documentsDirectory])
        {
            if(![fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&error]) {
                NSLog(@"Error: Delivery creation failed; directory name: %@; directory path: %@", BDS_TEMP_FILES, documentsDirectory);
            }
        }
        tempFile  = [documentsDirectory stringByAppendingPathComponent: documentName];
        [fileData writeToFile:tempFile atomically:YES];
    }
    @catch (NSException *exception) {
        //UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"File view processing was not successful." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File view processing was not successful." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occurred while decryping file; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return tempFile;
}

+ (NSString*) decryptChunkByChunkAndCopyFile :(NSString *) documentId {
    
    UIAlertView *megaAlert = [[UIAlertView alloc] initWithTitle:@"Please wait..."
                                                        message:nil delegate:self cancelButtonTitle:nil
                                              otherButtonTitles: nil];
    [megaAlert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    indicator.center = CGPointMake(megaAlert.bounds.size.width / 2,
                                   megaAlert.bounds.size.height - 45);
    [indicator startAnimating];
    [megaAlert addSubview:indicator];
    
    NSString *tempDecryptedFile;
    
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    
    //NSError *err;
    NSError * __autoreleasing *err;
    
    NSFileHandle *fileWriteHandle = nil;
    
    @try {
        
        // Read the chunk of files
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        // bdsFiles
        NSString *documentsTempDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_FILES];
        
        Document *doc = [Util getDocumentInfo:documentId];
        
        NSString *documentName = doc.docName;
        
        // bdsFiles/Dir-File_Name
        NSString *fileDir = [[NSString alloc] initWithFormat:@"Dir-%@", documentName];
        // bdsFiles/Dir-File_Name
        fileDir  = [documentsTempDirectory stringByAppendingPathComponent: fileDir];
        
        // This portion is for already downloaded files from the pervious version of iPad
        if(![fileManager fileExistsAtPath:fileDir]){
            // This might be a old file which was not downloaded by chunks - bdsFiles/File_Name.
            NSString* oldFile = [documentsTempDirectory stringByAppendingPathComponent:documentName];
            NSLog(@"old File: %@", oldFile);
            BOOL fileExists = [fileManager fileExistsAtPath:oldFile];
            if(fileExists){
                // Rename the file to data-0 and store in the fileDir - bdsFiles/Dir-File_Name
                if (![fileManager createDirectoryAtPath:fileDir
                            withIntermediateDirectories:NO
                                             attributes:nil
                                                  error:err])
                {
                    NSLog(@"Create directory error");
                }
                
                // Rename the file, by moving the file - bdsFiles/Dir-File_Name/data-0
                NSString *data0 = [fileDir stringByAppendingPathComponent:@"data-0"];
                
                // Attempt the move
                if ([fileManager moveItemAtPath:oldFile toPath:data0 error:err] != YES){
                    NSLog(@"Unable to move file.");
                } else {
                    doc.downloadedSize = doc.actualSize;
                    [Document commit];
                }
            }
        }
        
        
        // bdsFiles/bdsTempToDecrypt
        documentsTempDirectory = [documentsTempDirectory stringByAppendingPathComponent:BDS_TEMP_FILES];
        
        if(![fileManager fileExistsAtPath:documentsTempDirectory]){
            if (![fileManager createDirectoryAtPath:documentsTempDirectory
                        withIntermediateDirectories:NO
                                         attributes:nil
                                              error:err]) {
                NSLog(@"Create directory error, direcotry name: bdsTempToDecrypt");
            }
        }
        
        tempDecryptedFile  = [documentsTempDirectory stringByAppendingPathComponent: documentName];
        
        bool fileNeedsDecryption = true;
        
        // Check whether file is already decrypted
        if([fileManager fileExistsAtPath:tempDecryptedFile]) {
            // check whether the file is fully decrypted
            NSDictionary *fileDict = [fileManager attributesOfItemAtPath:tempDecryptedFile error:err];
            
            if([fileDict fileSize] == [doc.downloadedSize longLongValue]){
                fileNeedsDecryption = false;
            }
        }
        
        if(fileNeedsDecryption)
        {
            NSLog(@"tempDecryptedFile: %@", tempDecryptedFile);
            // Create the file to store original data - bdsFiles/bdsTempToDecrypt/File_Name
            if([fileManager createFileAtPath:tempDecryptedFile contents:nil attributes:nil]){
                fileWriteHandle = [NSFileHandle fileHandleForWritingAtPath:tempDecryptedFile];
                NSLog(@"File was created!");
            } else {
                NSLog(@"File was not created.");
            }
            
            NSArray *filelist= [fileManager contentsOfDirectoryAtPath:fileDir error:err];
            
            NSLog(@"Total number of chunks: %d", [filelist count]);
            
            for(int i = 0; i < [filelist count]; i++) {
                
                // Read the chunk of file
                NSString *fileName = [[NSString alloc] initWithFormat:@"data-%d", i];
                NSLog(@"---File Name: %@", fileName);
                NSString *filePath = [fileDir stringByAppendingPathComponent:fileName];
                NSFileHandle *fileReadHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
                
                // Write the data
                [fileWriteHandle seekToEndOfFile];
                
                @autoreleasepool {
                    [fileWriteHandle writeData:[[fileReadHandle readDataToEndOfFile] decryptedAES256DataUsingKey:AESEncryptionKey error:err]];
                }
                
                // No longer using the file
                [fileReadHandle closeFile];
            }
            [fileWriteHandle closeFile];
        }
        
    } @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File view processing was not successful." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occurred while decryping file; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    [megaAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    return tempDecryptedFile;
}


+ (unsigned long long) decryptAndGetSize:(NSString*) filePath :(NSString*) documentName {
    unsigned long long fileSize = 0;
    
    @try {
        // Get the file content and decrypt it
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData * fileData = [fileManager contentsAtPath:filePath];
        
        NSError * __autoreleasing *err;
        //NSError ** ;
        //NSError *error;
        fileData = [fileData decryptedAES256DataUsingKey:AESEncryptionKey error:err];
        
        fileSize = [fileData length];
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"File view processing was not successful." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        NSLog(@"An error occurred while decryping file; %@: %@", [exception name], [exception reason]);
        [alert show];
    }
    
    return fileSize;
    //    return formattedSize;
}

+ (void) deleteOldDecryptedFiles {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDate *now = [NSDate new];
    
    // number of seconds for 4 days
    long oldTimeSpan = 4 * 24 * 60 * 60;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // bdsFiles
    NSString *documentsTempDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_FILES];
    // bdsFiles/bdsTempToDecrypt
    documentsTempDirectory = [documentsTempDirectory stringByAppendingPathComponent:BDS_TEMP_FILES];
    NSArray *filelist = [fileManager contentsOfDirectoryAtPath:documentsTempDirectory error:nil];
    
    for(int i = 0; i < [filelist count]; i++) {
        NSString *filePath = [documentsTempDirectory stringByAppendingPathComponent:[filelist objectAtIndex:i]];
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:filePath error:nil];
        NSDate *fileDate = [fileDict fileCreationDate];
        
        if([now timeIntervalSinceDate:fileDate] > oldTimeSpan) {
            [fileManager removeItemAtPath:filePath error:nil];
        }
    }
}

+ (UIColor *) getColorFromHexString: (NSString *) hexString {
    NSRange range = NSMakeRange(0, 2);
    NSString *redString = [hexString substringWithRange:range];
    NSScanner* redScanner = [NSScanner scannerWithString: redString];
    unsigned int red;
    [redScanner scanHexInt: &red];
    //NSLog(@"red: %d", red);
    
    NSRange range2 = NSMakeRange(2, 2);
    NSString *greenString = [hexString substringWithRange:range2];
    NSScanner *greenScanner = [NSScanner scannerWithString: greenString];
    unsigned int green;
    [greenScanner scanHexInt: &green];
    //NSLog(@"green: %d", green);
    
    NSRange range3 = NSMakeRange(4, 2);
    NSString *blueString = [hexString substringWithRange:range3];
    NSScanner *blueScanner = [NSScanner scannerWithString: blueString];
    unsigned int blue;
    [blueScanner scanHexInt: &blue];
    //NSLog(@"blue: %d", blue);
    
    UIColor *color = [[UIColor alloc] initWithRed:red/255.0 green:green/255.0  blue:blue/255.0 alpha:1.0];
    return color;
}


+ (UIColor *) getColorFromHexCode: (int) hexCode {
    int red = (hexCode >> 16);
    int green = ((hexCode >> 8) & 0xFF);
    int blue = (hexCode & 0xFF);
    //NSLog(@"red: %d", red);
    //NSLog(@"green: %d", green);
    //NSLog(@"blue: %d", blue);
    UIColor *color = [[UIColor alloc] initWithRed:red/255.0 green:green/255.0  blue:blue/255.0 alpha:1.0];
    return color;
}


+ (UIInterfaceOrientation)getDeviceToInterfaceOrientation: (UIDeviceOrientation) deviceOrientation {
    UIInterfaceOrientation orientation;
    
    if (deviceOrientation == UIInterfaceOrientationLandscapeLeft) {
        orientation = UIInterfaceOrientationLandscapeLeft;
    } else if (deviceOrientation == UIInterfaceOrientationLandscapeRight){
        orientation = UIInterfaceOrientationLandscapeRight;
    } else if (deviceOrientation == UIInterfaceOrientationPortrait){
        orientation = UIInterfaceOrientationPortrait;
    } else if (deviceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        orientation = UIInterfaceOrientationPortraitUpsideDown;
    } /*else if (deviceOrientation == UIDeviceOrientationFaceUp || deviceOrientation == UIDeviceOrientationFaceDown){
       if(UIDeviceOrientationIsPortrait(deviceOrientation)) {
       orientation = UIInterfaceOrientationPortrait;
       } else {
       orientation = UIInterfaceOrientationLandscapeLeft;
       }
       }    */
    
    return orientation;
}

+ (BOOL)isRetina
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        return YES;
    }
    return NO;
}

+(NSString *) getTruncatedString :(NSString *) str :(int) len
{
    NSString *msg = str;
    
    NSInteger numOfLine = [[msg componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]count];
    
    if(numOfLine > 1) {
        NSRange rangeOfNewLine = [msg rangeOfString:@"\n"];
        msg = [msg substringToIndex:rangeOfNewLine.location];
        msg = [[NSString alloc] initWithFormat:@"%@...", msg];
        return msg;
    }
    
    if(msg.length > len) {
        msg = [msg substringToIndex:len];
        msg = [[NSString alloc] initWithFormat:@"%@...", msg];
        return msg;
    }
    
    return msg;
}

// Get IP Address
+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

+ (int) getAvailableSize :(unsigned long long) offset :(unsigned long long) chunkSize :(unsigned long long) fileSize {
    int bytesToRead = 0;
    unsigned long long tempChunkSize = chunkSize;
    if ((fileSize - offset) < chunkSize) {
        tempChunkSize = fileSize - offset;
    }
    bytesToRead = (int) tempChunkSize;
    return bytesToRead;
}
/*
+ (NSString *)getFormattedDateString:(NSDate *)date {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm aa"];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:appDelegate.serverTimeZoneId]];
    [formatter setCalendar:cal];
    [formatter setLocale:[NSLocale currentLocale]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


+ (NSDate *)getDefaultAutoDeleteDate {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //NSLog(@"autoDeleteDays: %d", appDelegate.autoDeleteDays);
    
    NSDate *now = [NSDate date];
    NSDate *autoDeleteDate = [NSDate dateWithTimeInterval:60*60*24*appDelegate.autoDeleteDays sinceDate:now];
    return autoDeleteDate;
}


+ (NSDate *)getDefaultAutoDeleteReminderDate {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //NSLog(@"autoDeleteReminderDays: %d", appDelegate.autoDeleteReminderDays);
    
    NSDate *now = [NSDate date];
    int intervalDays = appDelegate.autoDeleteDays - appDelegate.autoDeleteReminderDays;
    NSDate *autoDeleteRemDate = [NSDate dateWithTimeInterval:60*60*24*intervalDays sinceDate:now];
    return autoDeleteRemDate;
}
*/

+ (BOOL)isDate1:(NSDate *)date1 smallerThanDate2:(NSDate *)date2
{
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInMinute = 60;
    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
    
    if (secondsBetweenDates == 0)
        return YES;
    else if (secondsBetweenDates < 0)
        return YES;
    else
        return NO;
}


+ (UIImage *) imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (BOOL) checkTermsOfService:(UserInfo *)userInfo {
    BOOL tosAccepted = NO;
    if([userInfo isAcceptedTOS]){
        NSLog(@"TOS Accepted!!!");
        tosAccepted = YES;
    } else {
        NSLog(@"TOS Denied!!!");
        tosAccepted = NO;
    }
    return tosAccepted;
}


/**
 * This method converts percent escapes to space.
 **/
+ (NSString*) replacePercentEscapes:(NSString*) str {
    NSString *body = [NSString stringWithString:str];
    
    body = [body stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return body;
}


+ (long long) getNumberOfPhotos {
    
    long long numPhotos = 0;
    @try {
        NSError *error;
        NSString *path = [self getDirectoryPath];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path]) {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"BDSPropertyList" ofType:@"plist"];
            [fileManager copyItemAtPath:bundle toPath: path error:&error];
            
        } else {
            NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
            NSString *numPhotosStr = (NSString*)[savedData objectForKey: NUM_PHOTOS];
            NSLog(@"numPhotos = %@", numPhotosStr);
            
            if([self isEmpty:numPhotosStr]) {
                numPhotos = 1;
            } else {
                numPhotos = [numPhotosStr longLongValue];
                numPhotos += 1;
            }
            
            numPhotosStr = [NSString stringWithFormat:@"%lld", numPhotos];
            NSLog(@"updated numPhotos = %@", numPhotosStr);
            
            [self saveDataToProperty:NUM_PHOTOS :numPhotosStr];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get data from property list; %@: %@", [exception name], [exception reason]);
    }
    
    return numPhotos;
    
}


+ (BOOL) isFileNameExists:(NSString *)fileName {
    
    BOOL exists = NO;
    NSError *error;
    @try {
        
        Document *doc = [Document getWithPredicate:[NSPredicate predicateWithFormat:@"docName=%@", fileName]];
        if(doc != nil){
            exists = YES;
            return exists;
        }
        
        // This portion is for the old values
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
        NSString *documentsDirectory = [paths objectAtIndex:0]; //2
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"DownloadedFiles.plist"]; //3
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath: path]) {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"DownloadedFiles" ofType:@"plist"];
            [fileManager copyItemAtPath:bundle toPath: path error:&error];
        }
        
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        documentsDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_FILES];
        //NSLog(@"documentsDirectory: %@", documentsDirectory);
        
        // Get all the file names
        NSEnumerator *enumerator = [dataDic keyEnumerator];
        for(NSString *idKey in enumerator) {
            NSDictionary *docDict = [dataDic objectForKey:idKey];
            NSString *docName = [docDict objectForKey:@"name"];
            //NSString *file  = [documentsDirectory stringByAppendingPathComponent: docName];
            //NSLog(@"Current doc: %@, exists: %d", file, [fileManager fileExistsAtPath: file]);
            
            if([fileName isEqualToString:docName]) {
                exists = YES;
                break;
            }
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"An error occured while trying to get data from property list; %@: %@", [exception name], [exception reason]);
    }
    
    return exists;
    
}


+(Document *)saveDocumentInfo :(NSString *) docId :(NSString *) docName :(unsigned long long) actualSize :(unsigned long long) downloadedSize :(unsigned long long) sizeOnDisk {
    if ([docId isEqualToString:@"0"]) {
        return nil;
    } else {
        Document *doc = [Document getWithPredicate: [NSPredicate predicateWithFormat:@"docId=%@", docId]];
        if (doc == nil) {
            doc = [Document newEntity];
            doc.docId =  docId;
        }
        if(![Util isEmpty:docName]){
            doc.docName = docName;
        }
        doc.actualSize = [NSNumber numberWithLongLong:actualSize];
        doc.downloadedSize = [NSNumber numberWithLongLong:downloadedSize];
        doc.sizeOnDisk = [NSNumber numberWithLongLong:sizeOnDisk];
        
        [Document commit];
        return doc;
    }
}


+(Document *)getDocumentInfo :(NSString *)docId {
    if ([Util isEmpty:docId]) {
        return nil;
    } else {
        Document *doc = [Document getWithPredicate: [NSPredicate predicateWithFormat:@"docId=%@", docId]];
        
        if(doc == nil) {
            // Old document - might be stored in plist
            NSString *docName = [Util getStringValue:docId :@"DownloadedFiles.plist"];
            
            if([Util isEmpty:docName]){
                return nil;
            }
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            documentsDirectory = [documentsDirectory stringByAppendingPathComponent:BDS_FILES];
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:docName];
            
            if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                unsigned long long docSize = [Util decryptAndGetSize:filePath :docName];
                [Util saveDocumentInfo:docId :docName :docSize :docSize :0];
                [Util removeDataFromProperty: docId :@"DownloadedFiles.plist"];
            }
        }
        
        return doc;
    }
}


+(Document *)getDocumentInfoFromName :(NSString*) docName {
    if ([Util isEmpty:docName]) {
        return nil;
    } else {
        Document *doc = [Document getWithPredicate: [NSPredicate predicateWithFormat:@"docName=%@", docName]];
        return doc;
    }
}
/*
+ (void) updateDeliveryCountBadge :(DeliveryVO *) delV {
    
    long unreadDeliveryCount = [[UIApplication sharedApplication] applicationIconBadgeNumber] - 1;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unreadDeliveryCount];
    NSLog(@"unreadDeliveryCount: %ld", unreadDeliveryCount);
    
    // Update the unread delivery count on tab
    UITabBarItem *tbi = [appDelegate.splitViewController tabBarItem];
    if([[UIApplication sharedApplication] applicationIconBadgeNumber] > 0) {
        NSString *badgeVale = [NSString stringWithFormat:@"%ld", unreadDeliveryCount];
        [tbi setBadgeValue:badgeVale];
    } else {
        [tbi setBadgeValue:nil];
    }
}
*/

+ (BOOL) isiPhone {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return YES;
    } else {
        return NO;
    }
}


+ (BOOL) isiPad {
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return NO;
    }
}


+ (NSString*) getNotAllowedFilePath:(NSString *)fileName {
    NSLog(@"fileName: %@", fileName);

    // Get the file name without extension and fily type of SAVED FILE
    NSString *fileType = nil;
    NSRange range = [fileName rangeOfString:@"." options:NSBackwardsSearch];
    if(range.location != NSNotFound) {
        NSInteger index = range.location;
        fileType = [fileName substringFromIndex:index];
    }
    
    //NSString *extensionList = @".pdf .png .jpeg .jpg .bmp .tiff .gif .ico .doc .docx .ppt .pptx .xls .xlsx .rtf .txt";
    NSLog(@"fileType: %@", fileType);
    NSString *noneFilePath;
    if ([fileType isEqualToString:@".png"]
        || [fileType isEqualToString:@".jpeg"]
        || [fileType isEqualToString:@".jpg"]
        || [fileType isEqualToString:@".bmp"]
        || [fileType isEqualToString:@".tiff"]
        || [fileType isEqualToString:@".gif"]
        || [fileType isEqualToString:@".ico"])
    {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"png" inDirectory:@""];

    } else if ([fileType isEqualToString:@".pdf"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"pdf" inDirectory:@""];
        
    } else if ([fileType isEqualToString:@".doc"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"doc" inDirectory:@""];
        
    } else if ([fileType isEqualToString:@".docx"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"docx" inDirectory:@""];

    } else if ([fileType isEqualToString:@".ppt"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"ppt" inDirectory:@""];
        
    } else if ([fileType isEqualToString:@".pptx"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"pptx" inDirectory:@""];
    
    } else if ([fileType isEqualToString:@".xls"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"xls" inDirectory:@""];
        
    } else if ([fileType isEqualToString:@".xlsx"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"xlsx" inDirectory:@""];
        
    } else if ([fileType isEqualToString:@".rtf"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"rtf" inDirectory:@""];
        
    } else if ([fileType isEqualToString:@".txt"]) {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"txt" inDirectory:@""];
        
    } else {
        noneFilePath = [[NSBundle mainBundle] pathForResource:@"not_allowed" ofType:@"pdf" inDirectory:@""];    
    }
    
    return noneFilePath;
}


+ (BOOL) iOS6orLess {
    NSString *os_version = [[UIDevice currentDevice] systemVersion];
    //NSLog(@"iOS version: %@", os_version);
    char majorVersion = [os_version characterAtIndex:0];
    //NSLog(@"majorVersion: %c", majorVersion);
    
    if(majorVersion >= '7') {
        return NO;
    } else {
        return YES;
    }
}


+ (BOOL) iOS8 {
    NSString *os_version = [[UIDevice currentDevice] systemVersion];
    NSLog(@"iOS version: %@", os_version);
    char majorVersion = [os_version characterAtIndex:0];
    NSLog(@"majorVersion: %c", majorVersion);
    
    if(majorVersion >= '8') {
        return YES;
    } else {
        return NO;
    }
}


+ (UIWebView *) createWebViewWithHTML :(NSString *) html :(id)delegate{
    
    //instantiate the web view
    UIWebView *webView = [[UIWebView alloc] init];
    
    [webView setDelegate:delegate];
    
    //make the background transparent
    [webView setBackgroundColor:[UIColor clearColor]];
    
    //pass the string to the webview
    [webView loadHTMLString:[html description] baseURL:nil];
    
    //return the subview
    return webView;
    
}

+ (NSAttributedString *) getAttributedString :(NSString *) htmlString {
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    
    return attributedString;
}


+ (UILabel *) createHTMLLabel :(NSString *) htmlString{
    
    UILabel  *textLabel = [[UILabel alloc] init];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    textLabel.attributedText = attributedString;
    return textLabel;
    
}

+ (NSString *) stringByStrippingHTML :(NSString *) s {
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}



@end
