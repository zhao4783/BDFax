//
//  WebserviceSft.h
//  MobileFax
//
//  Created by Zhao                                                     on 7/27/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#ifndef WebserviceSft_h
#define WebserviceSft_h

#import "DeliveryVO.h"

@class ASIFormDataRequest;

@interface WebServicesSft : NSObject
{
    ASIFormDataRequest *request;
    bool bAccessing;
    DeliveryVO *delV;
}
@property (retain, nonatomic) ASIFormDataRequest *request;
@property (retain, nonatomic) DeliveryVO *deliveryVO;
@property bool bAccessing;

- (BOOL)login:(BOOL)inSilent;
- (void)terminateSession;
- (BOOL)setStatusLogs;
- (BOOL)removeStatusMessage:(UITableView *)aTableView forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)getReceivedIPFaxes:(BOOL)silent;
- (void)updateReceivedIPFaxes;
- (NSString *)receiveIPFaxByFaxID;
- (void)removeFaxWithIndex:(NSIndexPath *)indexPath;
- (bool)sendFax:(NSArray *)recipientSet pack:(NSDictionary *)pack index:(int)index;
- (BOOL)canAccess;
- (NSArray *)getContacts:(BOOL)silent;
- (void)addContact:(NSDictionary *)contact;
- (void)deleteContacts:(NSArray *)contacts;

@end

#endif /* WebserviceSft_h */
