//
//  AddContact.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 10/16/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@class ASIFormDataRequest;

@interface AddContact : NSObject {
    ASIFormDataRequest *request;
}
@property (retain, nonatomic) ASIFormDataRequest *request;

- (void)addContactWithName:(NSString *)name address:(NSString *)address company:(NSString *)company;
- (void)addContactFailed:(ASIHTTPRequest *)theRequest;
- (void)addContactFinished:(ASIHTTPRequest *)theRequest;

@end
