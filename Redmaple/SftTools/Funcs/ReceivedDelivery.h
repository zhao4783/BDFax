/*
 * Copyright (c) 2012 Biscom, Inc.
 * Chelmsford, MA, 01824 U.S.A.
 * All rights reserved.
 *
 * This source code is considered Confidential Information and
 * property of Biscom, Inc. This source code may not be copied,
 * shared, distributed, or used in any other software application
 * or derivative work without the express written permission
 * from Biscom, Inc.
 * This header must be included in all source code that contains
 * any or all of the code or documentation included in this file.
 * You agree not to remove this proprietary rights legend from
 * this or any derivative source code file. Any derivative source
 * code file that contains any or all of the source code contained
 * in this file, whether or not this legend appears in such
 * derivative source code file, shall remain the exclusive property
 * of Biscom, Inc. and shall be treated as Confidential Information.
 */

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "GetDelivery.h"

/**
 This class implements the getDeliveries web service.
 @author Mahfuzul Amin
 */
@interface ReceivedDelivery : NSObject<GetDeliveryDelegate> {
    NSURLConnection *conn;
    NSMutableData *webData;
    int deliveryIndex;
    NSString *src;
}
@property (strong, nonatomic) NSString *src;

- (id)initWithDeliveryIndex :(int) index;
- (void)getDeliveries;

@end
