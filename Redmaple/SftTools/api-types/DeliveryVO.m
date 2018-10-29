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

#import "DeliveryVO.h"

@implementation DeliveryVO

// Constants

/** Default delivery id */
int const DEFAULT_DELIVERY_ID = 0;
/** Default tracking number */
NSString * const DEFAULT_TRACKING_NUMBER = @"";
/** Default unread reply count */
int const DEFAULT_UNREAD_REPLY_COUNT = -1;

/** Status: Valid */
NSString * const STATUS_VALID = @"V";
/** Status: Deleted */
NSString * const STATUS_DELETED = @"D";

/** Event for access reminder: Delivery access reminder for sender */
NSString * const DELIVERY_ACCESS_REMINDER = @"DLV_REMINDER";

/** Notification on event setting: Do not notify */
NSString * const DO_NOT_NOTIFY = @"NO";
/** Notification on event setting: Notify on first access (per user) */
NSString * const NOTIFY_FIRST_TIME = @"FT";
/** Notification on event setting: Notify every time */
NSString * const NOTIFY_EVERY_TIME = @"ET";

/** Delivery access reminder: After sending delivery */
NSString * const REMIND_AFTER_SENDING_DELIVERY = @"ASD";
/** Delivery access reminder: Before delivery expires */
NSString * const REMIND_BEFORE_DELIVERY_EXPIRES = @"BDE";

/** Maximum length for delivery name */
int const MAX_LEN_DELIVERY_NAME = 2000;
/** Maximum length for description */
int const MAX_LEN_DESCRIPTION = 2000;

/** Virus scan status of an express delivery */
NSString * const VIRUS_SCAN_STATUS_COMPLETED = @"completed";
/** Virus scan status of an express delivery */
NSString * const VIRUS_SCAN_STATUS_NOT_COMPLETED = @"not-completed";


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (int) getDeliveryId {
    return deliveryId;
}

- (void) setDeliveryId : (int) dlvId {
    deliveryId = dlvId;
}

- (NSString *) getStatus {
    return status;
}

- (void) setStatus : (NSString *) sts {
    status = sts;
}

- (NSString *) getTrackingNumber {
    return trackingNumber;
}

- (void) setTrackingNumber : (NSString *) trackNumber {
    trackingNumber = trackNumber;
}

- (int) getPackageId {
    return packageId;
}

- (void) setPackageId : (int) packId {
    packageId = packId;
}

- (int) getSenderId {
    return senderId;
}

- (void) setSenderId : (int) sndrId {
    senderId = sndrId;
}

- (NSString *) getReplyToAddress {
    return replyToAddress;
}

- (void) setReplyToAddress : (NSString *) replyTo {
    replyToAddress = replyTo;
}

- (NSString *) getName {
    return name;
}

- (void) setName : (NSString *) dlvName {
    name = dlvName;
}

- (NSString *) getDescription {
    return description;
}
                            
- (void) setDescription : (NSString *) dsc {
    description = dsc;
}

- (NSString *) getMessage {
    return message;
}

- (void) setMessage : (NSString *) msg {
    message = msg;
}

- (NSString*) getSecureMessage {
    return secureMessage;
}

- (void) setSecureMessage : (NSString *) secureMsg {
    secureMessage = secureMsg;
}

- (NSString *) getDateAvailable {
    return dateAvailable;
}

- (void) setDateAvailable : (NSString *) availableDate {
    dateAvailable = availableDate;
}

- (NSString *) getDateExpires {
    return dateExpires;
}

- (void) setDateExpires : (NSString *) expireDate {
    dateExpires = expireDate;
}

- (BOOL) getRequireSignIn {
    return requireSignIn;
}

- (void) setRequireSignIn : (BOOL) signInRequire {
    requireSignIn = signInRequire;
}

- (NSString *) getEncodedPassword {
    return encodedPassword;
}

- (void) setEncodedPassword : (NSString *) encodedPasswd {
    encodedPassword = encodedPasswd;
}

- (NSString *) getNotificationEmails {
    return notificationEmails;
}

- (void) setNotificationEmails : (NSString *) notifictnEmails {
    notificationEmails = notifictnEmails;
}

- (int) getCreatedBy {
    return createdBy;
}

- (void) setCreatedBy : (int) createBy {
    createdBy = createBy;
}

- (NSString *) getDateCreated {
    return dateCreated;
}

- (void) setDateCreated : (NSString *) dateCreate {
    dateCreated = dateCreate;
}

- (int) getLastUpdatedBy {
    return lastUpdatedBy;
}

- (void) setLastUpdatedBy : (int) lastUpdateBy {
    lastUpdatedBy = lastUpdateBy;
}

- (NSString *) getDateLastUpdated {
    return dateLastUpdated;
}

- (void) setDateLastUpdated : (NSString *) dateLastUpdate {
    dateLastUpdated = dateLastUpdate;
}

- (NSString *) getLastActivityDate {
    return lastActivityDate;
}

- (void) setLastActivityDate : (NSString *) lastDatedActivity {
    lastActivityDate = lastDatedActivity;
}

- (BOOL) getReadStatus {
    return readStatus;
}

- (void) setReadStatus : (BOOL) readSts {
    readStatus = readSts;
}

/**
 * @return the notifyOnDeliveryViewSetting
 */
- (NSString*) getNotifyOnDeliveryViewSetting {
    return notifyOnDeliveryViewSetting;
}


/**
 * @param notifyOnDeliveryViewSetting the notifyOnDeliveryViewSetting to set
 */
- (void) setNotifyOnDeliveryViewSetting : (NSString*) notifyOnDlvViewSetting {
    notifyOnDeliveryViewSetting = notifyOnDlvViewSetting;
}


/**
 * @return the notifyOnFileDownloadSetting
 */
- (NSString*) getNotifyOnFileDownloadSetting {
    return notifyOnFileDownloadSetting;
}


/**
 * @param notifyOnFileDownloadSetting the notifyOnFileDownloadSetting to set
 */
- (void) setNotifyOnFileDownloadSetting : (NSString*) notifyOnFileDLSetting {
    notifyOnFileDownloadSetting = notifyOnFileDLSetting;
}
    
	/**
	 * @return the isLimited
	 */
	- (BOOL) isLimited {
		return isLimited;
	}
    
    
	/**
	 * @param isLimited the isLimited to set
	 */
    - (void) setLimited : (BOOL) limited {
		isLimited = limited;
	}
    
    
	/**
	 * @return the safeHtml
	 */
	- (BOOL) isSafeHtml {
		return safeHtml;
	}
    
    
	/**
	 * @param safeHtml the safeHtml to set
	 */
    - (void) setSafeHtml : (BOOL) html {
		safeHtml = html;
	}
    
    
	/**
	 * @return the amount
	 */
	- (double) getAmount {
		return amount;
	}
    
    
	/**
	 * @param amount the amount to set
	 */
    - (void) setAmount : (double) amnt {
		amount = amnt;
	}
    
    
	/**
	 * @return the requiresPayment
	 */
	- (BOOL) isRequiresPayment {
		return requiresPayment;
	}
    
    
	/**
	 * @param requiresPayment the requiresPayment to set
	 */
    - (void) setRequiresPayment : (BOOL) requirePayment {
		requiresPayment = requirePayment;
	}
    
    
	/**
	 * @return the isExpress
	 */
	- (BOOL) isExpress {
		return isExpress;
	}
    
    
	/**
	 * @param isExpress the isExpress to set
	 */
    - (void) setIsExpress : (BOOL) express {
		isExpress = express;
	}
    
    
	/**
	 * @return the scanStatus
	 */
	- (NSString*) getScanStatus {
		return scanStatus;
	}
    
    
	/**
	 * @param scanStatus the scanStatus to set
	 */
    - (void) setScanStatus : (NSString*) scnStatus {
		scanStatus = scnStatus;
	}
    

- (void) setSenderEmailAddress : (NSString*) senderEmail {
    senderEmailAddress = senderEmail; 
}

- (NSString*) getSenderEmailAddress {
    return senderEmailAddress;
}

- (NSString*) getNotificationMessage {
    return message;
}

- (NSString*) getDeliveryName {
    return name;
}

- (void) setParsedDateCreated : (NSString*) parsedCreatedDate {
    parsedDateCreated = parsedCreatedDate;
}

- (NSString*) getParsedDateCreated {
    return parsedDateCreated;
}

- (void) setParsedDateAvailable : (NSString*) parsedAvailableDate {
    parsedDateAvailable = parsedAvailableDate;
}

- (NSString*) getParsedDateAvailable {
    return parsedDateAvailable;
}

- (void) setParsedDateExpires : (NSString*) parsedExpireDate {
    parsedDateExpires = parsedExpireDate;
}

- (NSString*) getParsedDateExpires {
    return parsedDateExpires;
}

- (void) setParsedDateLastUpdated : (NSString*) parsedLastUpdatedDate {
    parsedDateLastUpdated = parsedLastUpdatedDate;
}

- (NSString*) getParsedDateLastUpdated {
    return parsedDateLastUpdated;
}

- (void) setParsedLastActivityDate : (NSString*) parsedActivityDateLast {
    parsedLastActivityDate = parsedActivityDateLast;
}

- (NSString*) getParsedLastActivityDate {
    return parsedLastActivityDate;
}

- (void) setReceivedAs : (NSString*) rcvdAs {
    receivedAs = rcvdAs;
}

- (NSString*) getReceivedAs {
    return receivedAs;
}

- (void) setSentToGroupName : (NSString*) sentToGroup {
    sentToGroupName = sentToGroup;
}

- (NSString*) getSentToGroupName {
    return sentToGroupName;
}

- (void) setDocumentVOs : (NSMutableArray*) docuVOs {
    documentVOs = docuVOs;
}

- (NSMutableArray*) getDocumentVOs {
    return documentVOs;
}

- (void) setToAddressList : (NSString*) toList {
    toAddressList = toList;
}

- (NSString*) getToAddressList {
    return toAddressList;
}

- (void) setCcAddressList : (NSString*) ccList {
    ccAddressList = ccList;
}

- (NSString*) getCCAddressList {
    return ccAddressList;
}

- (void) setBccAddressList : (NSString*) bccList {
    bccAddressList = bccList;
}

- (NSString*) getBccAddressList {
    return bccAddressList;
}


- (BOOL) getSelectionStatus {
    return selectionStatus;
}

- (void) setSelectionStatus : (BOOL) selSts {
    selectionStatus = selSts;
}

@end
