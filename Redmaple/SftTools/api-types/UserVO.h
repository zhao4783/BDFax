//
//  UserVO.h
//  BDSiPadApp
//
//  Created by Lion User on 12/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserVO : NSObject {

    NSString *displayName;
    NSString *emailAddress;

    /*
    NSString *username;
    NSString *authenticationMethod;
    int userId;
    NSString *emailAddress;
    NSString *firstName;
    NSString *middleName;
    NSString *lastName;
    int createdBy;
    NSString *dateCreated;
    int lastUpdatedBy;
    NSString *dateLastUpdated;    
    NSString *signupCompletedDate;
    NSString *lastSignInDate;
    NSString *company;
    NSString *addressLine1;
    NSString *addressLine2;
    NSString *city;
    NSString *zipCode;
    NSString *workPhoneNumber;
    NSString *homePhoneNumber;
    NSString *mobilePhoneNumber;
    NSString *otherPhoneNumber;
    NSString *faxNumber;
    NSString *secretQuestions;
    BOOL signInLocked;
    int signInFailureCount;
    int signInTotalFailureCount;
    NSString *signInLastFailureDate;
    int resetPasswordFailureCount;
    int resetPasswordTotalFailureCount;
    NSString *resetPasswordLastFailureDate;
    NSString *recipientInclusionList;
    NSString *recipientExclusionList;
    BOOL allowSMTPInput;
    BOOL inactive;
    NSString *lastPasswordResetDate;
    BOOL passwordExpires;
    BOOL forcePasswordReset;
    NSString *state;
    NSString *country;
    BOOL active;
    NSString *title;
    NSString *status;
     */
}

- (NSString *) getDisplayName;
- (void) setDisplayName : (NSString *) displayName;

- (NSString *) getEmailAddress;
- (void) setEmailAddress : (NSString *) emailAddress;

/*
- (NSString *) getUsername;
- (void) setUsername : (NSString *) username;

- (NSString *) getAuthenticationMethod;
- (void) setAuthenticationMethod : (NSString *) authenticationMethod;

- (int) getUserId;
- (void) setUserId : (int) userId;

- (NSString *) getEmailAddress;
- (void) setEmailAddress : (NSString *) emailAddress;

- (NSString *) getFirstName;
- (void) setFirstName : (NSString *) firstName;

- (NSString *) getMiddleName;
- (void) setMiddleName : (NSString *) middleName;

- (NSString *) getLastName;
- (void) setLastName : (NSString *) lastName;

- (int) getCreatedBy;
- (void) setCreatedBy : (int) createdBy;

- (NSString *) getDateCreated;
- (void) setDateCreated : (NSString *) dateCreated;

- (int) getLastUpdatedBy;
- (void) setLastUpdatedBy : (int) lastUpdatedBy;

- (NSString *) getDateLastUpdated;
- (void) setDateLastUpdated : (NSString *) dateLastUpdated;

- (NSString *) getSignupCompletedDate;
- (void) setSignupCompletedDate : (NSString *) signupCompletedDate;

- (NSString *) getLastSignInDate;
- (void) setLastSignInDate : (NSString *) lastSignInDate;

- (NSString *) getCompany;
- (void) setCompany : (NSString *) company;

- (NSString *) getAddressLine1;
- (void) setAddressLine1 : (NSString *) addressLine1;

- (NSString *) getAddressLine2;
- (void) setAddressLine2 : (NSString *) addressLine2;

- (NSString *) getCity;
- (void) setCity : (NSString *) city;

- (NSString *) getZipCode;
- (void) setZipCode : (NSString *) zipCode;

- (NSString *) getWorkPhoneNumber;
- (void) setWorkPhoneNumber : (NSString *) workPhoneNumber;

- (NSString *) getHomePhoneNumber;
- (void) setHomePhoneNumber : (NSString *) homePhoneNumber;

- (NSString *) getMobilePhoneNumber;
- (void) setMobilePhoneNumber : (NSString *) mobilePhoneNumber;

- (NSString *) getOtherPhoneNumber;
- (void) setOtherPhoneNumber : (NSString *) otherPhoneNumber;

- (NSString *) getFaxNumber;
- (void) setFaxNumber : (NSString *) faxNumber;

- (NSString *) getSecretQuestions;
- (void) setSecretQuestions : (NSString *) secretQuestions;

- (BOOL) getSignInLocked;
- (void) setSignInLocked : (BOOL) signInLocked;

- (int) getSignInFailureCount;
- (void) setSignInFailureCount : (int) signInFailureCount;

- (int) getSignInTotalFailureCount;
- (void) setSignInTotalFailureCount : (int) signInTotalFailureCount;

- (NSString *) getSignInLastFailureDate;
- (void) setSignInLastFailureDate : (NSString *) signInLastFailureDate;

- (int) getResetPasswordFailureCount;
- (void) setResetPasswordFailureCount : (int) resetPasswordFailureCount;

- (int) getResetPasswordTotalFailureCount;
- (void) setResetPasswordTotalFailureCount : (int) resetPasswordTotalFailureCount;

- (NSString *) getResetPasswordLastFailureDate;
- (void) setResetPasswordLastFailureDate : (NSString *) resetPasswordLastFailureDate;

- (NSString *) getRecipientInclusionList;
- (void) setRecipientInclusionList : (NSString *) recipientInclusionList;

- (NSString *) getRecipientExclusionList;
- (void) setRecipientExclusionList : (NSString *) recipientExclusionList;

- (BOOL) getAllowSMTPInput;
- (void) setAllowSMTPInput : (BOOL) allowSMTPInput;

- (BOOL) getInactive;
- (void) setInactive : (BOOL) inactive;

- (NSString *) getLastPasswordResetDate;
- (void) setLastPasswordResetDate : (NSString *) lastPasswordResetDate;

- (BOOL) getPasswordExpires;
- (void) setPasswordExpires : (BOOL) passwordExpires;

- (BOOL) getForcePasswordReset;
- (void) setForcePasswordReset : (BOOL) forcePasswordReset;

- (NSString *) getState;
- (void) setState : (NSString *) state;

- (NSString *) getCountry;
- (void) setCountry : (NSString *) country;

- (BOOL) getActive;
- (void) setActive : (BOOL) active;

- (NSString *) getTitle;
- (void) setTitle : (NSString *) title;

- (NSString *) getStatus;
- (void) setStatus : (NSString *) status;
*/

@end
