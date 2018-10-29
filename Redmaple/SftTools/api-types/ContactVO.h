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

@interface ContactVO : NSObject {
    /** The id of the contact */
    int contactId;
    /** The id of the user that the contact entry belongs to */
    int contactOwnerId;
    /** The status of the contact */
    NSString* status;
    /** The user who created the record. */
    int createdBy;
    /** The date when the record was created. */
    NSString* dateCreated;
    /** The user who last updated the record. */
    int lastUpdatedBy;
    /** The date when the record was last updated. */
    NSString* dateLastUpdated;
    /** The contact's first name. */
    NSString* firstName;
    /** The contact's middle name. */
    NSString* middleName;
    /** The contact's last name. */
    NSString* lastName;
    /** The contact's nickname. */
    NSString* nickname;
    /** The contact's combined name (combination of last name, first name, nickname and email address). */
    NSString* combinedName;
    /** The contact's email address. */
    NSString* emailAddress;
    /** The contact's alternate(1) email address. */
    NSString* emailAddressAlt1;
    /** The contact's alternate(2) email address. */
    NSString* emailAddressAlt2;
    /** The category for the contact. */
    NSString* category;
    /** The contact's home address (first line). */
    NSString* homeAddressLine1;
    /** The contact's home address (second line). */
    NSString* homeAddressLine2;
    /** The contact's home city. */
    NSString* homeCity;
    /** The contact's home state. */
    NSString* homeState;
    /** The contact's home zip code. */
    NSString* homeZipCode;
    /** The contact's home country. */
    NSString* homeCountry;
    /** The contact's job title. */
    NSString* jobTitle;
    /** The contact's company. */
    NSString* company;
    /** The contact's work website. */
    NSString* workWebsite;
    /** The contact's work address (first line). */
    NSString* workAddressLine1;
    /** The contact's work address (second line). */
    NSString* workAddressLine2;
    /** The contact's work city. */
    NSString* workCity;
    /** The contact's work state. */
    NSString* workState;
    /** The contact's work zip code. */
    NSString* workZipCode;
    /** The contact's work country. */
    NSString* workCountry;
    /** The contact's work phone number. */
    NSString* workPhoneNumber;
    /** The contact's home phone number. */
    NSString* homePhoneNumber;
    /** The contact's mobile phone number. */
    NSString* mobilePhoneNumber;
    /** The contact's other phone number. */
    NSString* otherPhoneNumber;
    /** The contact's fax number. */
    NSString* faxNumber;
    /** The contact's pager number. */
    NSString* pagerNumber;
    /** The contact's personal website. */
    NSString* personalWebsite;
    /** The contact's birthday. */
    NSString* birthday;
    /** The notes about the contact. */
    NSString* notes;
    /** Is the contact external. */
    Boolean externalContact;
    /** The id of external contact source. */
    int externalContactSourceId;
}

@end
