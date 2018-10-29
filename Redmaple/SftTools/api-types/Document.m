//
//  Document.m
//  BDSiPadApp
//
//  Created by Nilavo Technologies on 3/6/13.
//
//

#import "Document.h"

@implementation Document
// This returns the name of the Entity it extends (basically the name of the superclass)
+(NSString *)entityName {
    return @"DocumentEntity";
}

// This returns the name of your xcdatamodeld model, without the extension
+(NSString *)modelName {
    return @"BDSiPadApp";
}


@end
