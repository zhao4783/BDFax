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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "DeliveryVO.h"
#import "DocumentVO.h"
#import "UserVO.h"
#import "WorkspaceVO.h"
#import "CommentVO.h"
#import "ActivityVO.h"
#import "UserFilesInfo.h"
#import "Document.h"

#import "BDSFile.h"
#import "DirectoryVO.h"

/**
 This class contains util methods of the app.
 @author Mahfuzul Amin
 */
@interface Util : NSObject {
}

+ (NSMutableDictionary*) getSavedDocumentsDictionary;
+ (NSString*) getDirectoryPath;
+ (NSString*) getDirectoryPath :(NSString*) propertyFile;
+ (UserInfo*) getSettingInfo;
+ (BOOL)isSignedIn;
+ (BOOL) saveDataToProperty:(NSString*)key:(NSString*)value;
+ (BOOL) saveDataToProperty:(NSString*)key:(NSString*)value :(NSString*) propertyFile;
+ (BOOL) removeDataFromProperty:(NSString*)key;
+ (BOOL) removeDataFromProperty:(NSString*)key :(NSString*) propertyFile;
+ (BOOL) saveArrayToProperty:(NSString*)key:(NSMutableArray*)value;
+ (NSString*) getGivenFileName:(NSString*) documentId : (NSString*) documentName;
+ (BOOL) deleteDownloadedFileName:(NSString*) documentId;
+ (BOOL) deleteAllDownloadedFileNames;
+ (BOOL)isEmpty:(NSString*) value;
+ (NSString*) getDateStringFromDate:(NSDate*) dateValue;
+ (NSDate*) getDateFromDateString:(NSString*) dateStr;
+(NSMutableArray *) getObjectArray:(NSString*)key;
+(NSString *) getStringValue: (NSString*) forKey;
+(NSString *) getStringValue: (NSString*) forKey :(NSString *) propertyFile;
//+(NSObject *) getObject: (NSString*) forKey;
+(NSMutableArray*) parseDeliveries: (NSDictionary*) responseDictionary;
+(DocumentVO*) parseDocument: (NSDictionary*) documentlDict;
+(DeliveryVO*) createVO: (NSDictionary*) internalDict;
+(int) getUnreadDeliveryCount:(NSString*) deliveryList;
+(NSMutableString*) parseRecipients: (NSMutableString*) addressList: (NSDictionary*) recipientsDict:(NSString*) key;
+(NSMutableArray*) getDocumentsFromDeliveryId:(int) deliveryId;
+(NSMutableArray*) getDocumentsFromWorkspaceId:(int) workspaceId;

+(NSMutableArray*) parseWorkspaces: (NSDictionary*) responseDictionary;
+(WorkspaceVO*) getWorkspace: (NSURLConnection*) conn :(int) workspaceId;
+(WorkspaceVO*) createWorkspaceVO: (NSDictionary*) internalDict;
+(UserVO*) parseUser: (NSDictionary*) userlDict;
+(CommentVO*) parseComment: (NSDictionary*) commentlDict;
+(ActivityVO*) parseActivity: (NSDictionary*) activitylDict;
+(NSMutableString*) parseWorkspaceUsers: (NSMutableString* )addressList: (NSObject *)userArray;
+(NSMutableString*) parsedWorkspaceUsersDisplayList: (NSMutableString* )formattedString :(NSString* )addressList;

+ (BOOL) startActivityIndicator;
+ (BOOL) stopActivityIndicator;
+ (BOOL) startActivityInWorkspaceIndicator;
+ (BOOL) stopActivityInWorkspaceIndicator;
+ (BOOL) startLeftActivityIndicator;
+ (BOOL) stopLeftActivityIndicator;
+ (void) hideLeftActivityIndicator;

+ (BOOL) startWorkspaceLeftActivityIndicator;
+ (BOOL) stopWorkspaceLeftActivityIndicator;

+ (NSMutableDictionary*) getFileListFromSnadbox;
+ (void) deleteFile :(NSString *) documentName;
+ (void) deleteDeliveryFiles:(int) deliveryId;
+ (void) deleteWorkspaceFiles:(int) workspaceId;
+(void) deleteFilesAndDeliveries;
+(void) deleteFilesAndWorkspaces;
+ (void) markDeliveryRead:(int) deliveryId;
+ (BOOL) isValidFileToShow: (NSString*) fileName;
+(NSString*) getLoginServerURL: (NSString*) server;
+ (void) releaseConnection:(NSURLConnection *) conn;
+ (void) releaseWebData:(NSMutableData *) webData;
+ (void) releaseString:(NSString *) str;
+ (NSMutableString *)buildUrl:(NSString *)server:(NSString *)target:(BOOL)isUseSSL;
+ (BOOL) validateSignIn;
+ (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString;
+ (void) loadSettingModalWindow: (UIViewController*) parentWindow;
+ (void) loadFileSettingModalWindow: (UIViewController*) parentWindow;
+ (NSString*) formatDate: (NSDate *) date;
+ (void) handleConnectionFailure:(UIActivityIndicatorView*) activity :(NSError *)error : (id) caller : (NSURLConnection *)connection: (NSMutableData *)webData;
+ (void) handleConnectionFailureForARC:(UIActivityIndicatorView*) activity :(NSError *)error : (id) caller;
+ (NSString*) getFormatedSizeText:(long) size;
+ (NSString*) getSizeText:(long) size;
+ (void) setDeliveryDetailView:(DeliveryVO*) deliveryVO:(int) currentIndex;

+ (void) setWorkspaceDetailView:(WorkspaceVO*) workspaceVO:(int) currentIndex;
+ (void) setWorkspaceDetailView:(WorkspaceVO*) workspaceVO Index:(int)currentIndex AndDirLevel:(BDSFile *) dirLevel;

+ (void) forceUpdateInactiveUIs;
+ (NSString*) decryptAndCopyFile:(NSString*) filePath :(NSString*) documentName;
+ (NSString*) decryptChunkByChunkAndCopyFile:(NSString*) documentId;

+ (UIColor *) getColorFromHexCode: (int) hexCode;
+(NSMutableDictionary*) parseNotificationSettings: (NSDictionary*) responseDictionary;
+ (UIInterfaceOrientation)getDeviceToInterfaceOrientation: (UIDeviceOrientation) deviceOrientation;

+ (BOOL)isRetina;
+ (UIColor *) getColorFromHexString: (NSString *) hexString;
+ (UserFilesInfo*) getUserFilesInfo;
+ (NSString *) getTruncatedString :(NSString *) str :(int) len;
+ (NSString *)getIPAddress;
+ (int) getAvailableSize :(unsigned long long) offset :(unsigned long long) chunkSize :(unsigned long long) fileSize;

+ (NSString *)getFormattedDateString:(NSDate *)date;
+ (NSDate *)getDefaultAutoDeleteDate;
+ (NSDate *)getDefaultAutoDeleteReminderDate;
+ (BOOL)isDate1:(NSDate *)date1 smallerThanDate2:(NSDate *)date2;
+ (unsigned long long) decryptAndGetSize:(NSString*) filePath :(NSString*) documentName;
+ (UIImage *) imageFromColor:(UIColor *)color;

+ (BOOL) checkTermsOfService:(UserInfo *)userInfo;

+ (NSString*) replacePercentEscapes:(NSString*) str;

+ (long long) getNumberOfPhotos;

+ (NSString*) saveExternalDocumentInfo:(NSString*) documentId : (NSString*) documentName;
+ (NSString*) getGivenExternalFileName:(NSString*) documentId : (NSString*) documentName : (NSMutableDictionary*) docInfo;

+ (BOOL) isFileNameExists:(NSString *)fileName;
+ (void) deleteOldDecryptedFiles;

+ (Document *)saveDocumentInfo :(NSString*)docId :(NSString *) docName :(unsigned long long) actualSize :(unsigned long long) downloadedSize :(unsigned long long) sizeOnDisk;
+ (Document *)getDocumentInfo :(NSString*)docId;
+ (Document *)getDocumentInfoFromName :(NSString*) docName;

+ (void) convertOldFilesToNewFormat;

+ (void) updateDeliveryCountBadge :(DeliveryVO *) delV;

+ (BOOL) isiPhone;
+ (BOOL) isiPad;

+ (NSString*) getNotAllowedFilePath:(NSString *)fileName;

+ (BOOL) iOS6orLess;
+ (BOOL) iOS8;

+ (DirectoryVO *) createDirectoryVO: (NSDictionary*) responseDictionary;
+ (BDSFile *) createWorkspaceFileVO: (NSDictionary*) internalDict;
+ (UIWebView *) createWebViewWithHTML :(NSString *) html :(id)delegate;
+ (UILabel *) createHTMLLabel :(NSString *) htmlString;
+ (NSAttributedString *) getAttributedString :(NSString *) htmlString;
+ (NSString *) stringByStrippingHTML :(NSString *) s;
@end
