//
//  ContactInfo.m
//  BDSiPadApp
//
//  Created by Nilavo Technologies Nilavo on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContactInfo.h"

@implementation ContactInfo
@synthesize emailLabel, email, firstName, lastName, compositeName, emailIndex;
@synthesize record = _record;

-(void)dealloc {
    [emailLabel release];
    [email release];
    [firstName release];    
    [lastName release];
    [compositeName release];
    if (_record) CFRelease(_record);
    [super dealloc];
}

-(void)setRecord:(ABRecordRef)record
{
    _record = CFRetain(record);
}

@end
