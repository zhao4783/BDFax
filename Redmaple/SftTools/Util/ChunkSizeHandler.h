//
//  ChunkSizeHandler.h
//  BDSiPadApp
//
//  Created by Lion User on 10/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChunkSizeHandler : NSObject

extern long targetInterval; // 5 seconds 
extern int paddingValueForIncrease; // 10KB 
extern int paddingValueForDecrease; // 10KB 
extern int minChunkSize; // Default value: 50KB 
extern int lastComputedChunkSize; // Default value: 50KB 

-(void) ChunkSizeHandler :(int) chunkSize;
-(int) getValidatedChunkSize :(int) chunkSize;
-(void) setPaddingSizes :(int) chunkSize;
-(int) computeChunkSize :(long) interval;

@end
