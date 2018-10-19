//
//  ContentViewController.h
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/9/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnotationView.h"
#import "MyScrollView.h"

@interface ContentViewController : UIViewController <UIScrollViewDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
    UILongPressGestureRecognizer *longPressRec;
    UIPinchGestureRecognizer *pinchRec;
    UIPanGestureRecognizer *panRec;
    AnnotationView *annotationView;
    CGFloat zoomRate;
    CGPoint origin;
    MyScrollView *scrollView;
    UIImageView *imageView;
    UIActivityIndicatorView *spinner;
}
@property (strong, nonatomic) MyScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property NSUInteger pageIndex;
@property NSString *pageTitle;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) AnnotationView *annotationView;
@property (strong, nonatomic) NSMutableArray *annotationList;

- (void)didChangeAnnotationType:(id)sender;
- (void)RedrawAnnotations;
- (CGFloat)getScaleRate;
- (CGPoint)getAbsolutePoint:(CGPoint)pt;
- (void)onSign;
- (void)onText;
- (void)onCrop:(BOOL)bEllipse;
- (UIImage *)flipImage:(UIImage *)image;
- (void)checkStates;
- (void)setImageViewFrame;

@end
