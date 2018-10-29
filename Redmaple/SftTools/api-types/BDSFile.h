//
//  BDSFile.h
//  BDSiPadApp
//
//  Created by Lion User on 18/07/2013.
//
//

#import <Foundation/Foundation.h>

@interface BDSFile : NSObject {
    
}

@property (nonatomic) int bdsFileId;
@property (nonatomic) int datafileId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic) long size;
@property (nonatomic) BOOL isDirectory;
@property (nonatomic) int parentDirectoryId;
@property (nonatomic) int rootDirectoryId;
@property (nonatomic, retain) NSString *dateCreated;
@property (nonatomic, retain) NSMutableArray *children;

@property (nonatomic, retain) BDSFile *parent;

@end
