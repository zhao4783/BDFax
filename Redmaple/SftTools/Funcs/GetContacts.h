//
//  GetContacts.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 10/16/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@class ASIFormDataRequest;

@interface GetContacts : NSObject {
}
@property (retain, nonatomic) ASIFormDataRequest *request;
@property (retain, nonatomic) NSArray *returnList;;

- (void)getContacts;

@end
