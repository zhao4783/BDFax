//
//  ContactHelper.h
//  BDSiPadApp
//
//  Created by Nilavo Technologies Nilavo on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactInfo.h"
#import "Util.h"

#define CFAutorelease(obj) ({CFTypeRef _obj = (obj); (_obj == NULL) ? NULL : [(id)CFMakeCollectable(_obj) autorelease]; })

@interface ContactHelper : NSObject {
    NSMutableArray * _contacts;
}

-(void) reload;
-(NSArray*) search:(NSString*) str;
-(NSArray*) searchEmail:(NSString*) email;
@end
