//
//  MyScrollView.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/23/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView
@synthesize bTransparent;

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return bTransparent;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
