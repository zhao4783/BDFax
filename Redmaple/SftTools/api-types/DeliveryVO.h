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

extern int const DEFAULT_DELIVERY_ID;
extern NSString * const DEFAULT_TRACKING_NUMBER;
extern int const DEFAULT_UNREAD_REPLY_COUNT;
extern NSString * const STATUS_VALID;
extern NSString * const STATUS_DELETED;
extern NSString * const DELIVERY_ACCESS_REMINDER;
extern NSString * const DO_NOT_NOTIFY;
extern NSString * const NOTIFY_FIRST_TIME;
extern NSString * const NOTIFY_EVERY_TIME;
extern NSString * const REMIND_AFTER_SENDING_DELIVERY ;
extern NSString * const REMIND_BEFORE_DELIVERY_EXPIRES;
extern int const MAX_LEN_DELIVERY_NAME;
extern int const MAX_LEN_DESCRIPTION;
extern NSString * const VIRUS_SCAN_STATUS_COMPLETED;
extern NSString * const VIRUS_SCAN_STATUS_NOT_COMPLETED;

/**
 This class is the value object of Dlivery.
 @author Mahfuzul Amin
 */
@interface DeliveryVO : NSObject {
    /** The id of the delivery */
    int deliveryId;
    /** The status of the delivery */
    NSString * status;
    /** The tracking number of the delivery */
    NSString * trackingNumber;
    /** The id of the package the delivery is for */
    int packageId;
    /** The id of the delivery sender */
    int senderId;
    /** The reply to address to use */
    NSString * replyToAddress;
    /** The delivery's name. */
    NSString * name;
    /** The delivery's description. */
    NSString * description;
    /** The message for the delivery. */
    NSString * message;
    /** The secure message for the delivery. */
    NSString * secureMessage;
    /** The date when the delivery is available. */
    NSString * dateAvailable;
    /** The date when the delivery expires. */
    NSString * dateExpires;
    /** Flag to indicate if sign in is required for viewing the delivery. */
    BOOL requireSignIn;
    /** The encoded password for the delivery. */
    NSString * encodedPassword;
    /** The list of emails to send the notification on access message to. */
    NSString * notificationEmails;
    /** The user who created the record. */
    int createdBy;
    /** The date when the record was created. */
    NSString * dateCreated;
    /** The user who last updated the record. */
    int lastUpdatedBy;
    /** The date when the record was last updated. */
    NSString * dateLastUpdated;
    /** The date of the last activity. */
    NSString * lastActivityDate;
    /** Flag to indicate if the delivery has been read. */
    BOOL readStatus;
    /** The unread reply count. */
    int unreadReplyCount;
    /** Flag to indicate if notification on deletion is turned on / off */
    BOOL notifyWhenRecipientDeletes;
    /** Flag to indicate if it is a limited delivery */
    BOOL isLimited;
    /** Flag to indicate if the delivery contains only safe html */
    BOOL safeHtml;
    /** Days to remind after sending delivery. */
    int remindDaysAfterSendingDelivery;
    /** Days to remind before delivery expires. */
    int remindDaysBeforeDeliveryExpires;
    /** Requires payment or not */
    BOOL requiresPayment;
    /** Payment amount */
    double amount;
    /** Is express delivery */
    BOOL isExpress;
    /** Virus scan status */
    NSString * scanStatus;
    /** Notify on file download setting (first access, every access, etc.). */
    NSString * notifyOnFileDownloadSetting;
    /** Notify on delivery view setting (first access, every access, etc.). */
    NSString * notifyOnDeliveryViewSetting;
    NSString* senderEmailAddress;
    NSString *parsedDateCreated;
    NSString *parsedDateAvailable;
    NSString *parsedDateExpires;
    NSString *parsedDateLastUpdated;
    NSString *parsedLastActivityDate;
    NSString *receivedAs;
    NSString *sentToGroupName;   
    NSMutableArray *documentVOs;
    NSString *toAddressList;
    NSString *ccAddressList;
    NSString *bccAddressList; 
    BOOL selectionStatus;
 }


- (int) getDeliveryId;
- (void) setDeliveryId : (int) dlvId;

- (NSString *) getStatus;
- (void) setStatus : (NSString *) sts;

- (NSString *) getTrackingNumber;
- (void) setTrackingNumber : (NSString *) trackNumber;

- (int) getPackageId;
- (void) setPackageId : (int) packId;

- (int) getSenderId;
- (void) setSenderId : (int) sndrId;

- (NSString *) getReplyToAddress;
- (void) setReplyToAddress : (NSString *) replyTo;

- (NSString *) getName;
- (void) setName : (NSString *) dlvName;

- (NSString *) getDescription;
- (void) setDescription : (NSString *) dsc;

- (NSString *) getMessage;
- (void) setMessage : (NSString *) msg;

- (NSString *) getSecureMessage;
- (void) setSecureMessage : (NSString *) secureMsg;

- (NSString *) getDateAvailable;
- (void) setDateAvailable : (NSString *) availableDate;

- (NSString *) getDateExpires;
- (void) setDateExpires : (NSString *) expireDate;

- (BOOL) getRequireSignIn;
- (void) setRequireSignIn : (BOOL) signInRequire;

- (NSString *) getEncodedPassword;
- (void) setEncodedPassword : (NSString *) encodedPasswd;

- (NSString *) getNotificationEmails;
- (void) setNotificationEmails : (NSString *) notifictnEmails;

- (int) getCreatedBy;
- (void) setCreatedBy : (int) createBy;

- (NSString *) getDateCreated;
- (void) setDateCreated : (NSString *) dateCreate;

- (int) getLastUpdatedBy;
- (void) setLastUpdatedBy : (int) lastUpdateBy;

- (NSString *) getDateLastUpdated;
- (void) setDateLastUpdated : (NSString *) dateLastUpdate;

- (NSString *) getLastActivityDate;
- (void) setLastActivityDate : (NSString *) lastDatedActivity;

- (BOOL) getReadStatus;
- (void) setReadStatus : (BOOL) readSts;

- (NSString *) getNotifyOnDeliveryViewSetting;
- (void) setNotifyOnDeliveryViewSetting: (NSString *) notifyOnDlvViewSetting;

- (NSString *) getNotifyOnFileDownloadSetting;
- (void) setNotifyOnFileDownloadSetting : (NSString *) notifyOnFileDLSetting;

- (BOOL) isLimited;
- (void) setLimited : (BOOL) limited;

- (BOOL) isSafeHtml;
- (void) setSafeHtml : (BOOL) html;

- (double) getAmount;
- (void) setAmount : (double) amnt;

- (BOOL) isRequiresPayment;
- (void) setRequiresPayment : (BOOL) requirePayment;

- (BOOL) isExpress;
- (void) setIsExpress : (BOOL) express;

- (NSString*) getScanStatus;
- (void) setScanStatus : (NSString*) scnStatus;

- (void) setSenderEmailAddress : (NSString*) senderEmail;
- (NSString*) getSenderEmailAddress;

- (NSString*) getDateLastUpdated;
- (NSString*) getDeliveryName;
- (NSString*) getSecureMessage;
- (NSString*) getNotificationMessage;

- (void) setParsedDateCreated : (NSString*) parsedCreatedDate;
- (NSString*) getParsedDateCreated;

- (void) setParsedDateAvailable : (NSString*) parsedAvailableDate;
- (NSString*) getParsedDateAvailable;

- (void) setParsedDateExpires : (NSString*) parsedExpireDate;
- (NSString*) getParsedDateExpires;

- (void) setParsedDateLastUpdated : (NSString*) parsedLastUpdatedDate;
- (NSString*) getParsedDateLastUpdated;

- (void) setParsedLastActivityDate : (NSString*) parsedActivityDateLast;
- (NSString*) getParsedLastActivityDate;

- (void) setReceivedAs : (NSString*) rcvdAs;
- (NSString*) getReceivedAs;

- (void) setSentToGroupName : (NSString*) sentToGroup;
- (NSString*) getSentToGroupName;

- (void) setDocumentVOs : (NSMutableArray*) docuVOs;
- (NSMutableArray*) getDocumentVOs;

- (void) setToAddressList : (NSString*) toList;
- (NSString*) getToAddressList;

- (void) setCcAddressList : (NSString*) ccList;
- (NSString*) getCCAddressList;

- (void) setBccAddressList : (NSString*) bccList;
- (NSString*) getBccAddressList;

- (BOOL) getSelectionStatus;
- (void) setSelectionStatus : (BOOL) selSts;

@end
