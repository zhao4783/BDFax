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

#import "BDSiOSConstant.h"

@implementation BDSiOSConstant

//Basic user informations
NSString * const USERNAME = @"Username";
NSString * const PASSWORD = @"Password";
NSString * const SERVER = @"Server";
NSString * const DOMAIN_NAME = @"Domain";
NSString * const USER_ROLES = @"userRoles";
NSString * const ROLES = @"roles";
NSString * const USE_SSL = @"Use SSL";
NSString * const TOS_ACCEPTED = @"tosAccepted";
NSString * const SESSION_ID = @"SessionId";  
NSString * const SELECTED_FILES = @"SelectedFiles";
NSString * const FORCE_UPDATE = @"ForceUpdate";
NSString * const DOWNLOADED_FILES = @"DownloadedFiles";
NSString * const USED_SPACE = @"Used Space";
NSString * const NUM_DWN_FILES = @"Number of files";
NSString * const NUM_PHOTOS = @"NumberOfPhotos";

//Web service names
NSString * const HTTP = @"http://"; 
NSString * const HTTPS = @"https://"; 
NSString * const BDS_REST_WEB_SERVICE = @"bdsrestws";
NSString * const SIGNIN_URL = @"/signin"; 
NSString * const FILE_URL = @"/getFileStream";
NSString * const CHUNK_FILE_DL_URL = @"/getDataFileChunkIS";
NSString * const GET_DELIVERIES_URL = @"/getDeliveries";
NSString * const GET_DELIVERY_URL = @"/getDelivery";
NSString * const DELETE_RECIPIENT_DELIVERY_URL = @"/deleteRecipientDelivery";
NSString * const DELETE_RECIPIENT_DELIVERIES_URL = @"/deleteRecipientDeliveries";
NSString * const CREATE_DELIVERY_URL = @"/addExpressDelivery";
NSString * const CREATE_DELIVERY_WITH_DATA_FILES_URL = @"/addExpressDeliveryWithDataFileIds";
NSString * const ADD_WORKSPACE_WITH_DATA_FILES_URL = @"/addWorkspaceWithDataFileIds";
NSString * const REGISTER_APP_URL = @"/registerApp";
NSString * const GET_USER_WORKSPACES_URL = @"/getUserWorkspaces";
NSString * const GET_WORKSPACE_URL = @"/getWorkspace";
NSString * const GET_WORKSPACE_COMMENTS_URL = @"/getWorkspaceComments";
NSString * const GET_WORKSPACE_ACTIVITIES_URL = @"/getWorkspaceTransactions";
//NSString * const GET_WORKSPACE_ACTIVITIES_URL = @"/getWorkspaceActivities";
NSString * const ADD_WORKSPACE_URL = @"/addWorkspace";
NSString * const DELETE_WORKSPACE_URL = @"/deleteWorkspace";
NSString * const LOCK_WORKSPACE_URL = @"/lockWorkspace";
NSString * const ADD_FILES_IN_WORKSPACE_URL = @"/addDocumentsInWorkspace";
NSString * const ADD_FILES_IN_WORKSPACE_WITH_DATA_FILE_IDS_URL = @"/addDocumentsInWorkspaceWithDataFileIds";
NSString * const ADD_WORKSPACE_COMMENT_URL = @"/addWorkspaceComment";
NSString * const EDIT_WORKSPACE_URL = @"/editWorkspace";
NSString * const GET_WORKSPACE_USER_SETTINGS = @"/getWorkspaceUserSettings";
NSString * const SAVE_WORKSPACE_USER_SETTINGS = @"/saveWorkspaceUserSettings";
NSString * const GET_INIT_PROPERTY = @"/getInitProperty";
NSString * const GET_ALLOWED_TO_OVERRIDE_AUTO_DELETE = @"/allowedToOverrideAutoDelete";
NSString * const ACCEPT_TERMS_OF_SERVICE = @"/acceptTermsOfService";

NSString * const INITIATE_DATA_FILE_UPLOAD = @"/initiateDataFileUpload";
NSString * const UPDATE_DATA_FILE_UPLOAD = @"/updateDataFileUpload";
NSString * const COMPLETE_DATA_FILE_UPLOAD = @"/completeDataFileUpload";

NSString * const GET_DIRECTORY_URL = @"/getDirectory";
NSString * const RESET_PASSWORD_URL = @"/resetPassword";
NSString * const ADD_FOLDER = @"/addDirectory";

NSString * const DISPLAY_NAME_EMAIL_SEPARATION_STRING = @"/*displayname-Email-Separation-String*/";

//Get 100 received deliveries at a time
int const ITEM_PER_PAGE = 100;

//Delivery info
NSString * const DELIVERY_VOS = @"DeliveryVOs"; 

//Workspace info
NSString * const WORKSPACE_VOS = @"WorkspaceVOs";
NSString * const WORKSPACE_VO = @"WorkspaceVO";

NSString * const WORKSPACE_COMMENTS = @"WorkspaceComments";
NSString * const WORKSPACE_ACTIVITIES = @"WorkspaceActivities";

//Create delivery field names
NSString * const TO = @"To:";
NSString * const CC = @"Cc:";
NSString * const BCC = @"Bcc:";
NSString * const SUBJECT = @"Subject:";
NSString * const FILES = @"Files:";
NSString * const SECURE_MESSAGE = @"Secure Message:";
NSString * const NOTIFICATION_MESSAGE = @"Notification Message:";
NSString * const SELECT_FILE = @"Select File...";

NSString * const ADDITIONAL_MANAGERS = @"Additional Managers:";
NSString * const COLLABORATORS = @"Collaborators:";
NSString * const VIEWERS =  @"Viewers:";
NSString * const WORKSPACE_NAME = @"Workspace Name:";
NSString * const TAGS = @"Tags:";
NSString * const  DESCRIPTION =  @"Description:";
NSString * const AUTO_DEL_DATE = @"Auto Delete Date:";
NSString * const AUTO_DEL_REM_DATE = @"Deletion Reminder Date:";
NSString * const COMMENT = @"Comment";
NSString * const NEW_FILE = @"New file uploaded";
NSString * const FILE_UPDATED = @"File updated(replaced, renamed, note updated)";
NSString * const NEW_COMMENT = @"New workspace comment added";
NSString * const WRK_DEL = @"Workspace deleted";
NSString * const FL_DWN = @"File downloaded";
NSString * const FL_DEL = @"File deleted";
NSString * const OTH_CHNG = @"Workspace details updated";
NSString * const USR_ADD = @"User added";
NSString * const USR_DEL = @"User deleted";
NSString * const SLF_REM = @"User removes self from workspace";

NSString * const TXT_CLR = @"Title color";
NSString * const TXT_BGD_CLR = @"Title background color";
NSString * const TITLE_COLOR = @"titleColor";
NSString * const TITLE_BACKGD_COLOR = @"titleBackgroundColor";

//Directory name to save files
NSString * const BDS_FILES = @"bdsFiles";
NSString * const BDS_TEMP_FILES = @"bdsTempToDecrypt";
NSString * const CURRENT_DOCUMENT_ID = @"CurrentDocumentId";
NSString * const CURRENT_WORKSPACE_DOCUMENT_ID = @"CurrentWorkspaceDocumentId";


//File naming policy
NSString * const FILE_NAME_POLICY_MARKER = @"06/05/2012";

//Notification name
NSString * const SIGNIN_NOTIFICATION = @"SigninNotification";
NSString * const ADD_WORKSPACE_NOTIFICATION = @"AddWorkspaceNotification";
NSString * const LONG_PRESS_FILE_DL_NOTIFICATION = @"LongPressFileDlNotification";
NSString * const SIGNIN_SUCCESSFULL = @"SigninSuccessfull";
NSString * const ALL_ACTIVITY_NOTIFICATION = @"AllActivityNotification";
NSString * const ALL_COMMENT_NOTIFICATION = @"AllCommentNotification";
NSString * const AUTO_DEL_DAYS = @"AutoDelDays";
NSString * const AUTO_DEL_REM_DAYS = @"AutoDelRemDays";

NSString * const AESEncryptionKey = @"80000000000000000000000000000000";
int const AESEncryptionBlockSize = 10*1024*1024; // 1 MB

//Global retun codes for web services
int const RC_SUCCESS = 0;
int const RC_ERR_INSUFFICIENT_PRIVILEGE = -1;

//InitProperty
int const RC_ERR_INIT_PROPERTY_NOT_FOUND = -2;

//Add workspace comment
int const RC_ERR_REPLY_ALREADY_EXISTS = -2;
int const RC_ERR_FOLDER_NOT_FOUND = -3;
int const RC_ERR_SYSTEM_ERROR = -99;
int const RC_ERR_REPLY_NOT_RETRIEVED = -5;
int const RC_SESSION_TIME_OUT = -97;

NSString * const RC_ERR_SESSION_TIME_OUT = @"-97";

// Signin related error codes
int const RC_ERR_USERNAME = -1;
int const RC_ERR_PASSWORD = -2;
int const RC_ERR_ACCOUNT_NAME = -3;
int const RC_ERR_TOO_MANY_INVALID_ATTEMPTS = -4;
int const RC_ERR_SIGN_IN_LOCKED = -5;
int const RC_ERR_PASSWORD_EXPIRED = -6;
int const RC_ERR_PASSWORD_CHANGE_REQUIRED = -7;
int const RC_ERR_INVALID_AUTHENTICATION_METHOD = -8;
int const RC_ERR_NOT_EXTERNAL_USER = -9;
int const RC_ERR_EXTERNAL_AUTHENTICATION_SOURCE_CONFIGURATION = -10;
int const RC_ERR_EXTERNAL_USER_EMAIL_NOT_FOUND = -11;
int const RC_ERR_ACTIVE_DIRECTORY_SERVER_DOWN = -12;
int const RC_ERR_EXTERNAL_USER_INFO_NOT_FOUND = -13;
int const RC_ERR_ACCOUNT_NOT_ACTIVATED = -14; 
int const RC_ERR_CONNECTOR_COMMUNICATION = -15;
int const RC_ERR_ACCOUNT_DISABLED = -16;
int const RC_ERR_OUTLOOK_ADDIN_DISABLED= -17;
int const RC_ERR_OUTLOOK_NO_SENDER_ROLE = -18;
int const RC_ERR_OUTLOOK_SMTP_INPUT_NOT_ALLOWED = -19;
int const RC_ERR_ACCOUNT_EXPIRED = -20;
int const RC_ERR_MAXIMUM_SENDER_LIMIT_EXCEEDED = -21;
int const RC_ERR_INVALID_TOKEN = -22;
int const RC_ERR_TOKEN_AUTHENTICATION_NOT_ALLOWED_FOR_USER = -23;
int const RC_ERR_ACCOUNT_REGISTRATION_NOT_APPROVED = -24;
int const RC_ERR_ACCOUNT_REGISTRATION_DENIED = -25;
int const RC_ERR_AUTHENTICATION_RESTRICTED_FOR_IP_ADDRESS = -26;
int const RC_ERR_POSSIBLE_INTERNAL_USER = -29;
int const RC_ERR_AD_GLOBAL_CATALOG = -95;
int const RC_ERR_AD_AUTHENTICATION_FAILED= -96;
int const RC_ERR_UNKNOWN_CONNECTOR_ERROR = -97;
int const RC_ERR_INVALID_LICENSE = -98;

// Delivery return codes
int const RC_WARN_RECIPIENT_NOT_ACCEPTED  = 1;
int const RC_WARN_BLOCKED_DOCUMENT  = 2;
int const RC_ERR_DELIVERY_ALREADY_EXISTS = -2;
int const RC_ERR_PACKAGE_NOT_FOUND = -3;
int const RC_ERR_DELIVERY_NOT_RETRIEVED = -5;
int const RC_ERR_DATA_FILE_NOT_VALID = -6;
int const RC_ERR_INSUFFICIENT_QUOTA = -9;
int const RC_ERR_PACKAGE_CREATION = -10;

// Add Workspace related return codes
int const RC_WARN_AW_USER_NOT_ACCEPTED = 1;
int const RC_WARN_AW_SENDER_LICENSE_EXCEEDED = 2;
int const RC_WARN_AW_COLLABORATOR_LIMIT_EXCEEDED = 3;
int const RC_WARN_AW_COLLABORATOR_PER_USER_LIMIT_EXCEEDED = 4;
int const RC_WARN_AW_VIEWER_ASSIGNED_INSTEAD_COLLABORATOR = 5;
int const RC_ERR_AW_PACKAGE_ALREADY_EXISTS = -2;
int const RC_ERR_AW_FOLDER_NOT_FOUND = -3;
int const RC_ERR_AW_INSUFFICIENT_STORAGE = -4;
int const RC_ERR_AW_PACKAGE_NOT_RETRIEVED = -5;
int const RC_ERR_AW_INCUFFICIENT_QUOTA = -6;

// Edit workspace related return codes
int const RC_WARN_EW_USER_NOT_ACCEPTED = 1;
int const RC_WARN_EW_REQUESTER_NO_LONGER_OWNER = 2;
int const RC_WARN_EW_SENDER_LICENSE_EXCEEDED = 3;
int const RC_WARN_EW_COLLABORATOR_LIMIT_EXCEEDED = 4;
int const RC_WARN_EW_COLLABORATOR_PER_USER_LIMIT_EXCEEDED = 5;
int const RC_WARN_EW_VIEWER_ASSIGNED_INSTEAD_COLLABORATOR = 6;		
int const RC_ERR_EW_PACKAGE_NOT_FOUND = -2;
int const RC_ERR_EW_CANNOT_REMOVE_ALL_OWNERS = -3;

//Delivery view Cell cenfiguration parameters
float  DEFAULT_SECURE_MESSAGE_CELL_HEIGHT = 200.0; 
float  DEFAULT_NOTIFICATION_MESSAGE_CELL_HEIGHT = 200.0; 
float DEFAULT_MESSAGE_HEIGHT = 100.0;
float HEIGHT_FOR_CELL_PADDING = 50.0; 
float HEIGHT_FOR_MESSAGE_PADDING = 20.0; 

// Max file download size is 250 MB
long MAX_FILE_DOWNLOAD_SIZE = 262144000;
int const TYPE_DATE_FIELD_AUTO_DEL = 1;
int const TYPE_DATE_FIELD_AUTO_DEL_REM = 2;

//Document
int const DOCUMENT_TYPE_REPLY = 1;
int const DOCUMENT_TYPE_REGULAR = 2;

//Get data file chunk IS

/** Method return code: DataFile not found */
int const RC_ERR_DATA_FILE_NOT_FOUND = -2;
/** Method return code: Invalid chunk size */
int const RC_ERR_INVALID_CHUNK_SIZE = -3;
/** Method return code: Invalid offset */
int const RC_ERR_INVALID_OFFSET = -4;

// Default value: 60KB
int const DEFAULT_CHUNK_SIZE = 1024 * 60;

// BDS Release version number 4.2.1038
int const BDS_RELEASE_VERSION_MAJOR = 4;
int const BDS_RELEASE_VERSION_MINOR = 2;
int const BDS_BUILD_NUMBER = 1041;
int const BDS_BUILD_NUMBER_FOR_IPHONE = 1057;

// Version of the app
NSString * const APP_VERSION = @"Version: 5.1.0001.2000";

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
