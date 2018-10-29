//
//  ActivityVO.h
//  BDSiPadApp
//
//  Created by Lion User on 02/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityVO : NSObject {
    NSString *parsedEventDate;
    NSString *message;
}

- (void) setParsedEventDate: (NSString*) parsedEventDate;
- (NSString*) getParsedEventDate;

- (void) setMessage: (NSString*) message;
- (NSString*) getMessage;

@end
