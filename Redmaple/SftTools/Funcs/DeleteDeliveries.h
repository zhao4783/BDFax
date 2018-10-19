//
//  DeleteRecipientDeliveries.h
//  BDSiPadApp
//
//  Created by Lion User on 13/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeleteDeliveries : NSObject  {
    NSURLConnection *conn;
    NSMutableData *webData;
    int dlvId;
    NSString *src;
}
@property (strong, nonatomic) NSString *src;

- (void)deleteDelivery:(int) deliveryId;

@end
