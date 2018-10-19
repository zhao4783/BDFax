//
//  SmoothedBIView.h
//  MobileFax
//
//  Created by Zhao                                                     on 8/15/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef SmoothedBIView_h
#define SmoothedBIView_h


////////////////////
@interface SmoothedBIView : UIView
{
    UIImage *incrementalImage;
    NSValue *signBox;
    UIColor *color;
    NSInteger nLineThickness;
}
@property (strong, nonatomic) UIImage *incrementalImage;
@property (strong, nonatomic) NSValue *signBox;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) NSInteger nLineThickness;

- (void)resetSign;

@end


#endif /* SmoothedBIView_h */
