//
//  CommentVO.m
//  BDSiPadApp
//
//  Created by Lion User on 01/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CommentVO.h"

@implementation CommentVO

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) setCreatedBy: (NSString*) creatdBy {
    createdBy = creatdBy;
}

- (NSString*) getCreatedBy {
    return createdBy;
}

- (void) setParsedDateCreated: (NSString*) parsedDateCreatd {
    parsedDateCreated = parsedDateCreatd;
}

- (NSString*) getParsedDateCreated {
    return parsedDateCreated;
}

- (void) setReplyMessage: (NSString*) replyMessge {
    replyMessage = replyMessge;
}

- (NSString*) getReplyMessage {
    return replyMessage;
}

@end
