//
//  DeleteContacts.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 10/16/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@class ASIFormDataRequest;

@interface DeleteContact : NSObject {
    ASIFormDataRequest *request;
    BOOL bEnd;
}
@property (retain, nonatomic) ASIFormDataRequest *request;

- (void)deleteContact:(NSString *)contactId;

@end
