//
//  ActivityVO.m
//  BDSiPadApp
//
//  Created by Lion User on 02/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityVO.h"

@implementation ActivityVO

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) setParsedEventDate: (NSString*) parsedEvntDate {
    parsedEventDate = parsedEvntDate;
}

- (NSString*) getParsedEventDate {
    return parsedEventDate;
}

- (void) setMessage: (NSString*) messge {
    message = messge;
}

- (NSString*) getMessage {
    return message;
}

@end
