//
//  SignViewController.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/20/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmoothedBIView.h"

@interface SignViewController : UIViewController
{
    SmoothedBIView *signView;
    int nLineIndex;
    int nColorIndex;
    UISegmentedControl *colorSegments;
    UISegmentedControl *lineSegments;
    NSInteger nColors;
    NSNumber *mode;
}
@property (strong, nonatomic) NSNumber *mode;
@property (nonatomic) NSInteger imageWidth;

@end

