//
//  CommentVO.h
//  BDSiPadApp
//
//  Created by Lion User on 01/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentVO : NSObject {    
    NSString *createdBy;
    NSString *parsedDateCreated;
    NSString *replyMessage;
}

- (void) setCreatedBy: (NSString*) createdBy;
- (NSString*) getCreatedBy;

- (void) setParsedDateCreated: (NSString*) parsedDateCreated;
- (NSString*) getParsedDateCreated;

- (void) setReplyMessage: (NSString*) replyMessage;
- (NSString*) getReplyMessage;

@end
