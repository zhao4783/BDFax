//
//  DocumentEntity.h
//  BDSiPadApp
//
//  Created by Nilavo Technologies on 3/6/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RHManagedObject.h"

@interface DocumentEntity : RHManagedObject

@property (nonatomic, retain) NSString * docId;
@property (nonatomic, retain) NSString * docName;
@property (nonatomic, retain) NSNumber * actualSize;
@property (nonatomic, retain) NSNumber * downloadedSize;
@property (nonatomic, retain) NSNumber * sizeOnDisk;

@end
