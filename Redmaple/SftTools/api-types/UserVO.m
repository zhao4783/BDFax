//
//  UserVO.m
//  BDSiPadApp
//
//  Created by Lion User on 12/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserVO.h"

@implementation UserVO


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (NSString *) getDisplayName {
    return displayName;
}

- (void) setDisplayName : (NSString *) displyName {
    displayName = displyName;
}


- (NSString *) getEmailAddress {
    return emailAddress;
}

- (void) setEmailAddress : (NSString *) emailAdrs {
    emailAddress = emailAdrs;
}

/*
- (NSString *) getUsername {
    return username;
}

- (void) setUsername : (NSString *) usrname {
    username = usrname;
}

- (NSString *) getAuthenticationMethod {
    return authenticationMethod;
}

- (void) setAuthenticationMethod : (NSString *) authenticationMthd {
    authenticationMethod = authenticationMthd;
}

- (int) getUserId {
    return userId;
}

- (void) setUserId : (int) usrId {
    userId = usrId;
}

- (NSString *) getEmailAddress {
    return emailAddress;
}

- (void) setEmailAddress : (NSString *) emailAdrs {
    emailAddress = emailAdrs;
}

- (NSString *) getFirstName {
    return firstName;
}

- (void) setFirstName : (NSString *) frstName {
    firstName = frstName;
}

- (NSString *) getMiddleName {
    return middleName;
}

- (void) setMiddleName : (NSString *) mddleName {
    middleName = mddleName;
}

- (NSString *) getLastName {
    return lastName;
}

- (void) setLastName : (NSString *) lstName {
    lastName = lstName;
}

- (int) getCreatedBy {
    return createdBy;
}

- (void) setCreatedBy : (int) creatdBy {
    createdBy = creatdBy;
}

- (NSString *) getDateCreated {
    return dateCreated;
}

- (void) setDateCreated : (NSString *) dateCrted {
    dateCreated = dateCrted;
}

- (int) getLastUpdatedBy {
    return lastUpdatedBy;
}

- (void) setLastUpdatedBy : (int) lstUpdatedBy {
    lastUpdatedBy = lstUpdatedBy;
}

- (NSString *) getDateLastUpdated {
    return dateLastUpdated;
}

- (void) setDateLastUpdated : (NSString *) dateLstUpdated {
    dateLastUpdated = dateLstUpdated;
}

- (NSString *) getSignupCompletedDate {
    return signupCompletedDate;
}

- (void) setSignupCompletedDate : (NSString *) signupCmpletedDate {
    signupCompletedDate = signupCmpletedDate;
}

- (NSString *) getLastSignInDate {
    return lastSignInDate;
}

- (void) setLastSignInDate : (NSString *) lstSignInDate {
    lastSignInDate = lstSignInDate;
}

- (NSString *) getCompany {
    return company;
}

- (void) setCompany : (NSString *) compny {
    company = compny;
}

- (NSString *) getAddressLine1 {
    return addressLine1;
}

- (void) setAddressLine1 : (NSString *) addressLne1 {
    addressLine1 = addressLne1;
}

- (NSString *) getAddressLine2 {
    return addressLine2;
}

- (void) setAddressLine2 : (NSString *) addressLne2 {
    addressLine2 = addressLne2;
}

- (NSString *) getCity {
    return city;
}

- (void) setCity : (NSString *) cty {
    city = cty;
}

- (NSString *) getZipCode {
    return zipCode;
}

- (void) setZipCode : (NSString *) zipCde {
    zipCode = zipCde;
}

- (NSString *) getWorkPhoneNumber {
    return workPhoneNumber;
}

- (void) setWorkPhoneNumber : (NSString *) wrkPhoneNumber {
    workPhoneNumber = wrkPhoneNumber;
}

- (NSString *) getHomePhoneNumber {
    return homePhoneNumber;
}

- (void) setHomePhoneNumber : (NSString *) hmePhoneNumber {
    homePhoneNumber = hmePhoneNumber;
}

- (NSString *) getMobilePhoneNumber {
    return mobilePhoneNumber;
}
- (void) setMobilePhoneNumber : (NSString *) mobilePhneNumber {
    mobilePhoneNumber = mobilePhneNumber;
}

- (NSString *) getOtherPhoneNumber {
    return otherPhoneNumber;
}

- (void) setOtherPhoneNumber : (NSString *) otherPhneNumber {
    otherPhoneNumber = otherPhneNumber;
}

- (NSString *) getFaxNumber {
    return faxNumber;
}

- (void) setFaxNumber : (NSString *) faxNumbr {
    faxNumber = faxNumbr;
}

- (NSString *) getSecretQuestions {
    return secretQuestions;
}

- (void) setSecretQuestions : (NSString *) secrtQuestions {
    secretQuestions = secrtQuestions;
}

- (BOOL) getSignInLocked {
    return signInLocked;
}

- (void) setSignInLocked : (BOOL) signInLockd {
    signInLocked = signInLockd;
}

- (int) getSignInFailureCount {
    return signInFailureCount;
}

- (void) setSignInFailureCount : (int) signInFailureCnt {
    signInFailureCount = signInFailureCnt;
}

- (int) getSignInTotalFailureCount {
    return signInTotalFailureCount;
}

- (void) setSignInTotalFailureCount : (int) signInTotalFailureCnt {
    signInTotalFailureCount = signInTotalFailureCnt;
}

- (NSString *) getSignInLastFailureDate {
    return signInLastFailureDate;
}

- (void) setSignInLastFailureDate : (NSString *) signInLstFailureDate {
    signInLastFailureDate = signInLstFailureDate;
}

- (int) getResetPasswordFailureCount {
    return resetPasswordFailureCount;
}

- (void) setResetPasswordFailureCount : (int) resetPasswordFailureCnt {
    resetPasswordFailureCount = resetPasswordFailureCnt;
}

- (int) getResetPasswordTotalFailureCount {
    return resetPasswordTotalFailureCount;
}

- (void) setResetPasswordTotalFailureCount : (int) resetPasswordTotalFailureCnt {
    resetPasswordTotalFailureCount = resetPasswordTotalFailureCnt;
}

- (NSString *) getResetPasswordLastFailureDate {
    return resetPasswordLastFailureDate;
}

- (void) setResetPasswordLastFailureDate : (NSString *) resetPasswordLstFailureDate {
    resetPasswordLastFailureDate = resetPasswordLstFailureDate;
}

- (NSString *) getRecipientInclusionList {
    return recipientInclusionList;
}

- (void) setRecipientInclusionList : (NSString *) recipientInclusionLst {
    recipientInclusionList = recipientInclusionLst;
}

- (NSString *) getRecipientExclusionList {
    return recipientExclusionList;
}

- (void) setRecipientExclusionList : (NSString *) recipientExclusionLst {
    recipientExclusionList = recipientExclusionLst;
}

- (BOOL) getAllowSMTPInput {
    return allowSMTPInput;
}

- (void) setAllowSMTPInput : (BOOL) allwSMTPInput {
    allowSMTPInput = allwSMTPInput;
}

- (BOOL) getInactive {
    return inactive;
}

- (void) setInactive : (BOOL) inactve {
    inactive = inactve;
}

- (NSString *) getLastPasswordResetDate {
    return lastPasswordResetDate;
}

- (void) setLastPasswordResetDate : (NSString *) lstPasswordResetDate {
    lastPasswordResetDate = lstPasswordResetDate;
}

- (BOOL) getPasswordExpires {
    return passwordExpires;
}

- (void) setPasswordExpires : (BOOL) passwrdExpires {
    passwordExpires = passwrdExpires;
}

- (BOOL) getForcePasswordReset {
    return forcePasswordReset;
}

- (void) setForcePasswordReset : (BOOL) forcePasswrdReset {
    forcePasswordReset = forcePasswrdReset;
}

- (NSString *) getState {
    return state;
}

- (void) setState : (NSString *) stat {
    state = stat;
}

- (NSString *) getCountry {
    return country;
}

- (void) setCountry : (NSString *) cntry {
    country = cntry;
}


- (BOOL) getActive {
    return active;
}

- (void) setActive : (BOOL) actve {
    active = actve;
}

- (NSString *) getTitle {
    return title;
}

- (void) setTitle : (NSString *) titl {
    title = titl;
}

- (NSString *) getStatus {
    return status;
}

- (void) setStatus : (NSString *) stats {
    status = stats;
}
*/

@end
