//
//  ContactHelper.m
//  BDSiPadApp
//
//  Created by Nilavo Technologies Nilavo on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContactHelper.h"

@implementation ContactHelper 

-(id)init
{
    self = [super init];
    if (self) {
        _contacts = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)reload 
{
    ABAddressBookRef addressBook = CFAutorelease(ABAddressBookCreate());
    NSArray *thePeople = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    [_contacts removeAllObjects];
    for (id person in thePeople) {
        CFTypeRef theProperty = ABRecordCopyValue(person, kABPersonEmailProperty);
        NSArray *emails = (NSArray *)ABMultiValueCopyArrayOfAllValues(theProperty);
        
        int i = 0;
        for (NSString *email in emails) {
            ContactInfo *c = [[ContactInfo alloc] init];
            c.firstName = [((NSString *) ABRecordCopyValue(person, kABPersonFirstNameProperty)) autorelease];
            c.lastName = [((NSString *) ABRecordCopyValue(person, kABPersonLastNameProperty)) autorelease];
            c.compositeName = [((NSString *) ABRecordCopyCompositeName(person)) autorelease];
            if (!c.compositeName) {
                c.compositeName = @"";
            }
            CFStringRef label = ABMultiValueCopyLabelAtIndex(theProperty, i);
            if (label != nil) {
                c.emailLabel = [((NSString *) ABAddressBookCopyLocalizedLabel(label)) autorelease];
                CFRelease(label);
            } else {
                c.emailLabel = @"";
            }
            c.email = [NSString stringWithString:email];
            c.record = person;
            c.emailIndex = i;
            [_contacts addObject:c];
            [c release];
            i ++;
        }
        [emails release];
        CFRelease(theProperty);
    }
    [thePeople release];
}

-(NSArray *)search:(NSString *)str
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"firstName contains[cd] %@ OR lastName contains[cd] %@ OR email contains[cd] %@", str, str, str];
    return [_contacts filteredArrayUsingPredicate:pred];
}

-(NSArray *)searchEmail:(NSString *)email
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"email contains %@", email];
    return [_contacts filteredArrayUsingPredicate:pred];
}

@end
