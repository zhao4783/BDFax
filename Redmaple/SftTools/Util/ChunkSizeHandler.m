//
//  ChunkSizeHandler.m
//  BDSiPadApp
//
//  Created by Lion User on 10/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChunkSizeHandler.h"

@implementation ChunkSizeHandler

static int DEFAULT_CHUNK_SIZE = 60 * 1024; // 60KB 
//private static final int MAX_CHUNK_SIZE = 10 * 1024 * 1024; // 10MB
static int MAX_CHUNK_SIZE = 4 * 1024 * 1024; // 4MB

long targetInterval = 5 * 1000; // 5 seconds 
int paddingValueForIncrease = 1024 * 10; // 10KB 
int paddingValueForDecrease = 1024 * 10; // 10KB 
int minChunkSize = 1024 * 50; // Default value: 50KB 
int lastComputedChunkSize = 1024 * 50; // Default value: 50KB 

/** 
 * Constructor. 
 */ 
-(void) ChunkSizeHandler :(int) chunkSize { 
    int initialChunkSize = [self getValidatedChunkSize:chunkSize]; 
    
    lastComputedChunkSize = initialChunkSize;
    
    // Set the minimum chunk size to 80% of the initial chunk size 
    minChunkSize = (int) (initialChunkSize * 0.8); 
//    NSLong(@"minChunkSize: %d", minChunkSize); 
    
    // Set the padding sizes 
    [self setPaddingSizes:initialChunkSize];
} 


-(int) getValidatedChunkSize :(int) chunkSize { 
    // Ensure that the chunk size is positive and does not exceed the maximum size 
    int size = (chunkSize > 0) ? chunkSize : DEFAULT_CHUNK_SIZE; 
    if (size > MAX_CHUNK_SIZE) { 
        size = MAX_CHUNK_SIZE; 
    } 
    
    // In case encryption is enabled for storing files, ensure that chunk size is a multiple of 60 KB. 
    // Get the current multiplier and increase it by 1 to determine the size to be used. 
    int unit = 60 * 1024; // 60 KB 
    int multiplier = size / unit; 
    size = (multiplier + 1) * unit; 
    
    return size; 
} 


-(void) setPaddingSizes :(int) chunkSize { 
    // Set the padding size for increasing to 25% of the chunk size 
    paddingValueForIncrease = (int) (chunkSize * 0.25); 
    //	 AppletLogger.debug("paddingValueForIncrease: " + this.paddingValueForIncrease); 
    
    // Set the padding size for decreasing to 10% of the chunk size 
    paddingValueForDecrease = (int) (chunkSize * 0.10); 
    //	 AppletLogger.debug("paddingValueForDecrease: " + this.paddingValueForDecrease); 
} 


/* 
 * Compute the chunk size based on whether we got done earlier or later 
 * than expected. Increase the chunk size if we got done earlier and decrease it 
 * if we got done later. 
 * @param interval The time taken to transfer a chunk 
 */ 
-(int) computeChunkSize :(long) interval { 
    
    //AppletLogger.debug("interval: " + interval); 
    //AppletLogger.debug("targetInterval: " + this.targetInterval); 
    
    int chunkSize = lastComputedChunkSize; 
    
    if (interval < targetInterval) { 
        // Increase the default chunk size if we got done early 
        chunkSize = chunkSize + paddingValueForIncrease; 
        //AppletLogger.debug(cn + ": Try to increase chunk size to: " + chunkSize); 
        
    } else if (interval > targetInterval) { 
        // Decrease the default chunk size if we got done late, but don't go lower than the minimum 
        if ((chunkSize - paddingValueForDecrease) >= minChunkSize) { 
            chunkSize = chunkSize - paddingValueForDecrease; 
            //AppletLogger.debug(cn + ": Try to decrease chunk size to: " + chunkSize); 
        } 
    } 
    
    // Ensure that the chunk size satisfies various requirements. 
    // For example, is positive, does not exceed the maximum size, etc. 
    chunkSize =  [self getValidatedChunkSize:chunkSize];   
    
    // Set the padding sizes 
    [self setPaddingSizes:chunkSize];
    
    lastComputedChunkSize = chunkSize; 
    
    return chunkSize; 
}


@end
