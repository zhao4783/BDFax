//
//  ContactInfo.h
//  BDSiPadApp
//
//  Created by Nilavo Technologies Nilavo on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ContactInfo : NSObject
@property (nonatomic, retain) NSString * emailLabel;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * compositeName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, readwrite) ABRecordRef record;
@property (nonatomic, readwrite) int emailIndex;
@end
