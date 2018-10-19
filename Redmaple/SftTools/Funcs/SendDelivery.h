//
//  SendDelivery.h
//  MobileFax
//
//  Created by Zhao                                                     on 8/3/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#ifndef SendDelivery_h
#define SendDelivery_h
#import "ASIFormDataRequest.h"

@interface SendDelivery : NSObject
{
    NSDictionary *delvPackage;
    NSArray *recipientList;
    ASIFormDataRequest *request;
    int recipientIndex;
}
@property (retain, nonatomic) ASIFormDataRequest *request;

- (id)initWithPackage:(NSDictionary *)pack recipientList:(NSArray *)list index:(int)index;
- (void)sendDelivery;

@end

#endif /* SendDelivery_h */
