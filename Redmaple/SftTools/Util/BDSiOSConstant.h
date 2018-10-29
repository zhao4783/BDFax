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

extern NSString * const USERNAME;
extern NSString * const SERVER;
extern NSString * const PASSWORD;
extern NSString * const DOMAIN_NAME;
extern NSString * const USER_ROLES;
extern NSString * const ROLES;
extern NSString * const USE_SSL;
extern NSString * const TOS_ACCEPTED;
extern NSString * const SESSION_ID;  
extern NSString * const SELECTED_FILES;
extern NSString * const FORCE_UPDATE;
extern NSString * const DOWNLOADED_FILES;
extern NSString * const USED_SPACE;
extern NSString * const NUM_DWN_FILES;
extern NSString * const NUM_PHOTOS;

extern NSString * const HTTP; 
extern NSString * const HTTPS; 
extern NSString * const BDS_REST_WEB_SERVICE; 
extern NSString * const SIGNIN_URL; 
extern NSString * const GET_DELIVERIES_URL;
extern NSString * const GET_DELIVERY_URL;
extern NSString * const DELETE_RECIPIENT_DELIVERY_URL;
extern NSString * const DELETE_RECIPIENT_DELIVERIES_URL;
extern NSString * const CREATE_DELIVERY_URL;
extern NSString * const CREATE_DELIVERY_WITH_DATA_FILES_URL;
extern NSString * const ADD_WORKSPACE_WITH_DATA_FILES_URL;
extern NSString * const FILE_URL;
extern NSString * const CHUNK_FILE_DL_URL;
extern NSString * const REGISTER_APP_URL;
extern NSString * const ACCEPT_TERMS_OF_SERVICE;

extern NSString * const GET_USER_WORKSPACES_URL;
extern NSString * const GET_WORKSPACE_URL;
extern NSString * const GET_WORKSPACE_COMMENTS_URL;
extern NSString * const GET_WORKSPACE_ACTIVITIES_URL;
extern NSString * const ADD_WORKSPACE_URL;
extern NSString * const DELETE_WORKSPACE_URL;
extern NSString * const LOCK_WORKSPACE_URL;
extern NSString * const ADD_FILES_IN_WORKSPACE_URL;
extern NSString * const ADD_FILES_IN_WORKSPACE_WITH_DATA_FILE_IDS_URL;
extern NSString * const ADD_WORKSPACE_COMMENT_URL;
extern NSString * const EDIT_WORKSPACE_URL;
extern NSString * const GET_WORKSPACE_USER_SETTINGS;
extern NSString * const SAVE_WORKSPACE_USER_SETTINGS;
extern NSString * const GET_INIT_PROPERTY;
extern NSString * const GET_ALLOWED_TO_OVERRIDE_AUTO_DELETE;

extern NSString * const INITIATE_DATA_FILE_UPLOAD;
extern NSString * const UPDATE_DATA_FILE_UPLOAD;
extern NSString * const COMPLETE_DATA_FILE_UPLOAD;

extern NSString * const GET_DIRECTORY_URL;
extern NSString * const RESET_PASSWORD_URL;
extern NSString * const ADD_FOLDER;

extern NSString * const DELIVERY_VOS; 
extern NSString * const CURRENT_DOCUMENT_ID;
extern NSString * const CURRENT_WORKSPACE_DOCUMENT_ID;
extern int const ITEM_PER_PAGE;
extern NSString * const FILE_NAME_POLICY_MARKER;

extern NSString * const WORKSPACE_VOS; 
extern NSString * const WORKSPACE_VO;

extern NSString * const WORKSPACE_COMMENTS;
extern NSString * const WORKSPACE_ACTIVITIES;

extern NSString * const TO;
extern NSString * const CC;
extern NSString * const BCC;
extern NSString * const SUBJECT;
extern NSString * const FILES;
extern NSString * const SECURE_MESSAGE;
extern NSString * const NOTIFICATION_MESSAGE;
extern NSString * const SELECT_FILE;

extern NSString * const ADDITIONAL_MANAGERS;
extern NSString * const COLLABORATORS;
extern NSString * const VIEWERS;
extern NSString * const WORKSPACE_NAME;
extern NSString * const TAGS;
extern NSString * const DESCRIPTION;
extern NSString * const AUTO_DEL_DATE; 
extern NSString * const AUTO_DEL_REM_DATE; 

extern NSString * const AUTO_DEL_DATE; 
extern NSString * const AUTO_DEL_REM_DATE; 

extern NSString * const COMMENT; 
extern NSString * const NEW_FILE;
extern NSString * const FILE_UPDATED;
extern NSString * const NEW_COMMENT;
extern NSString * const WRK_DEL;
extern NSString * const FL_DWN;
extern NSString * const FL_DEL;
extern NSString * const OTH_CHNG;
extern NSString * const USR_ADD;
extern NSString * const USR_DEL;
extern NSString * const SLF_REM;

extern NSString * const TXT_CLR;
extern NSString * const TXT_BGD_CLR;
extern NSString * const TITLE_COLOR;
extern NSString * const TITLE_BACKGD_COLOR;

extern NSString * const BDS_FILES;
extern NSString * const BDS_TEMP_FILES;
extern NSString * const SIGNIN_NOTIFICATION;
extern NSString * const ADD_WORKSPACE_NOTIFICATION;
extern NSString * const LONG_PRESS_FILE_DL_NOTIFICATION;
extern NSString * const ALL_ACTIVITY_NOTIFICATION;
extern NSString * const ALL_COMMENT_NOTIFICATION;
extern NSString * const SIGNIN_SUCCESSFULL;
extern NSString * const AUTO_DEL_DAYS;
extern NSString * const AUTO_DEL_REM_DAYS;

extern NSString * const AESEncryptionKey;
extern int const AESEncryptionBlockSize;

extern int const RC_SUCCESS;
extern int const RC_SESSION_TIME_OUT;
extern int const RC_ERR_INSUFFICIENT_PRIVILEGE;
extern NSString * const RC_ERR_SESSION_TIME_OUT;

extern NSString * const DISPLAY_NAME_EMAIL_SEPARATION_STRING;

extern int const RC_ERR_REPLY_ALREADY_EXISTS;
extern int const RC_ERR_FOLDER_NOT_FOUND;
extern int const RC_ERR_SYSTEM_ERROR;
extern int const RC_ERR_REPLY_NOT_RETRIEVED;

extern int const RC_ERR_INIT_PROPERTY_NOT_FOUND;

// Signin related error codes
extern int const RC_ERR_USERNAME;
extern int const RC_ERR_PASSWORD;
extern int const RC_ERR_ACCOUNT_NAME;
extern int const RC_ERR_TOO_MANY_INVALID_ATTEMPTS;
extern int const RC_ERR_SIGN_IN_LOCKED;
extern int const RC_ERR_PASSWORD_EXPIRED;
extern int const RC_ERR_PASSWORD_CHANGE_REQUIRED;
extern int const RC_ERR_INVALID_AUTHENTICATION_METHOD;
extern int const RC_ERR_NOT_EXTERNAL_USER;
extern int const RC_ERR_EXTERNAL_AUTHENTICATION_SOURCE_CONFIGURATION;
extern int const RC_ERR_EXTERNAL_USER_EMAIL_NOT_FOUND;
extern int const RC_ERR_ACTIVE_DIRECTORY_SERVER_DOWN;
extern int const RC_ERR_EXTERNAL_USER_INFO_NOT_FOUND;
extern int const RC_ERR_ACCOUNT_NOT_ACTIVATED; 
extern int const RC_ERR_CONNECTOR_COMMUNICATION;
extern int const RC_ERR_ACCOUNT_DISABLED;
extern int const RC_ERR_OUTLOOK_ADDIN_DISABLED;
extern int const RC_ERR_OUTLOOK_NO_SENDER_ROLE;
extern int const RC_ERR_OUTLOOK_SMTP_INPUT_NOT_ALLOWED;
extern int const RC_ERR_ACCOUNT_EXPIRED;
extern int const RC_ERR_MAXIMUM_SENDER_LIMIT_EXCEEDED;
extern int const RC_ERR_INVALID_TOKEN;
extern int const RC_ERR_TOKEN_AUTHENTICATION_NOT_ALLOWED_FOR_USER;
extern int const RC_ERR_ACCOUNT_REGISTRATION_NOT_APPROVED;
extern int const RC_ERR_ACCOUNT_REGISTRATION_DENIED;
extern int const RC_ERR_AUTHENTICATION_RESTRICTED_FOR_IP_ADDRESS;
extern int const RC_ERR_AD_GLOBAL_CATALOG;
extern int const RC_ERR_AD_AUTHENTICATION_FAILED;
extern int const RC_ERR_UNKNOWN_CONNECTOR_ERROR;
extern int const RC_ERR_INVALID_LICENSE;

extern int const RC_WARN_RECIPIENT_NOT_ACCEPTED;
extern int const RC_WARN_BLOCKED_DOCUMENT;
extern int const RC_ERR_DELIVERY_ALREADY_EXISTS;
extern int const RC_ERR_PACKAGE_NOT_FOUND;
extern int const RC_ERR_DELIVERY_NOT_RETRIEVED;
extern int const RC_ERR_DATA_FILE_NOT_VALID;
extern int const RC_ERR_INSUFFICIENT_QUOTA;
extern int const RC_ERR_PACKAGE_CREATION;

// Add Workspace related return codes
extern int const RC_WARN_AW_USER_NOT_ACCEPTED;
extern int const RC_WARN_AW_SENDER_LICENSE_EXCEEDED;
extern int const RC_WARN_AW_COLLABORATOR_LIMIT_EXCEEDED;
extern int const RC_WARN_AW_COLLABORATOR_PER_USER_LIMIT_EXCEEDED;
extern int const RC_WARN_AW_VIEWER_ASSIGNED_INSTEAD_COLLABORATOR;

extern int const RC_ERR_AW_PACKAGE_ALREADY_EXISTS;
extern int const RC_ERR_AW_FOLDER_NOT_FOUND;
extern int const RC_ERR_AW_INSUFFICIENT_STORAGE;
extern int const RC_ERR_AW_PACKAGE_NOT_RETRIEVED;
extern int const RC_ERR_AW_INCUFFICIENT_QUOTA;

// Edit workspace related codes
extern int const RC_WARN_EW_USER_NOT_ACCEPTED;
extern int const RC_WARN_EW_REQUESTER_NO_LONGER_OWNER;
extern int const RC_WARN_EW_SENDER_LICENSE_EXCEEDED;
extern int const RC_WARN_EW_COLLABORATOR_LIMIT_EXCEEDED;
extern int const RC_WARN_EW_COLLABORATOR_PER_USER_LIMIT_EXCEEDED;
extern int const RC_WARN_EW_VIEWER_ASSIGNED_INSTEAD_COLLABORATOR;		
extern int const RC_ERR_EW_PACKAGE_NOT_FOUND;
extern int const RC_ERR_EW_CANNOT_REMOVE_ALL_OWNERS;

extern float  DEFAULT_SECURE_MESSAGE_CELL_HEIGHT; 
extern float  DEFAULT_NOTIFICATION_MESSAGE_CELL_HEIGHT; 
extern float DEFAULT_MESSAGE_HEIGHT;
extern float HEIGHT_FOR_CELL_PADDING; 
extern float HEIGHT_FOR_MESSAGE_PADDING; 
extern long MAX_FILE_DOWNLOAD_SIZE;

extern int const DOCUMENT_TYPE_REPLY;
extern int const DOCUMENT_TYPE_REGULAR;

extern int const DEFAULT_CHUNK_SIZE;

extern int const TYPE_DATE_FIELD_AUTO_DEL;
extern int const TYPE_DATE_FIELD_AUTO_DEL_REM;

extern int const RC_SUCCESS;
extern int const RC_ERR_INSUFFICIENT_PRIVILEGE;
extern int const RC_ERR_DATA_FILE_NOT_FOUND;
extern int const RC_ERR_INVALID_CHUNK_SIZE;
extern int const RC_ERR_INVALID_OFFSET;
extern int const RC_ERR_SYSTEM_ERROR;

extern int const BDS_RELEASE_VERSION_MAJOR;
extern int const BDS_RELEASE_VERSION_MINOR;
extern int const BDS_BUILD_NUMBER;
extern int const BDS_BUILD_NUMBER_FOR_IPHONE;


/**
 This class contains all the constants of the app.
 @author Mahfuzul Amin
 */
@interface BDSiOSConstant : NSObject


@end
