//
//  ContentViewController.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/9/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "PageViewController.h"
#import "ContentViewController.h"
#import "SignViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize pageIndex, image, pageTitle, annotationView, annotationList, scrollView, imageView, spinner;

extern NSInteger nAnnotationType;
extern NSInteger nAnnoLineIndex;
extern NSInteger nAnnoColorIndex;
extern NSInteger nAnnoFontSizeIndex;
extern UISegmentedControl *colorAnnoSegments;
extern UIColor *backgroundColor;

ContentViewController *contentVC = nil;
BOOL bKeepDrawing = YES;
BOOL bKeepScaling = YES;
BOOL bKeepWating = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = backgroundColor;
    scrollView = [[MyScrollView alloc] init];
    scrollView.minimumZoomScale=1.0; //The minimum zoom scale
    scrollView.maximumZoomScale=4.0; //Maximum zoom (currently 4x image size)
    scrollView.delegate=self;
    scrollView.clipsToBounds = YES;
    scrollView.bTransparent = NO;
    scrollView.frame = savedScrollViewFrame;
    
    imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizesSubviews = NO;
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
    [self setImageViewFrame];

    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    int center = savedScrollViewFrame.size.width / 2;
    spinner.frame = CGRectMake(center-20, 50, 40, 40);
    spinner.hidden = YES;
    [scrollView addSubview:spinner];

    CGRect rt = [imageView bounds];
    annotationView = [[AnnotationView alloc] initWithFrame:rt];
    annotationView.opaque = NO;
    annotationView.backgroundColor = [UIColor clearColor];
    [imageView addSubview:annotationView];
    
    longPressRec = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressRec.cancelsTouchesInView = NO;
    longPressRec.numberOfTouchesRequired = 1;
    longPressRec.minimumPressDuration = 0.0;
    longPressRec.delegate = self;
    pinchRec = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchRec.cancelsTouchesInView = NO;
    pinchRec.delegate = self;
    panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panRec.cancelsTouchesInView = NO;
    panRec.delegate = self;

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:doubleTap];
    
    zoomRate = [self getScaleRate];
    origin = [self getOrigin];
}

- (void)viewWillAppear:(BOOL)animated
{
    contentVC = self;
    scrollView.frame = savedScrollViewFrame;
    annotationView.annotations = annotationList;
    [self RedrawAnnotations];
 }

- (void)setImageViewFrame
{
    CGSize size = scrollView.frame.size;
    NSInteger gap = nDeviceType == DEVICE_IPHONE ? 2 : 5;
    CGRect rt = CGRectMake(gap, gap, size.width-2*gap, size.height-2*gap);
    scrollView.zoomScale = 1.0;
    imageView.frame = rt;
    imageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView; //Needs to be the same as the outlet you created in the .h file
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if( UIInterfaceOrientationIsPortrait(fromInterfaceOrientation) )
    {
        if( landscapeFrame.size.width == 0 )
        {
            landscapeFrame = [viewerPage getScrollViewFrame];
            savedScrollViewFrame = landscapeFrame;
            scrollView.frame = savedScrollViewFrame;
            [self setImageViewFrame];
        }
    }
    else
    {
        if( portraitFrame.size.width == 0 )
        {
            portraitFrame = [viewerPage getScrollViewFrame];
            savedScrollViewFrame = portraitFrame;
            scrollView.frame = savedScrollViewFrame;
            [self setImageViewFrame];
        }
    }
    int center = savedScrollViewFrame.size.width / 2;
    spinner.frame = CGRectMake(center-20, 50, 40, 40);

    CGSize size = self.navigationController.toolbar.frame.size;
    int y = size.height > 40 ? 5 : 2;
    typeSegments.frame = CGRectMake(10, y, size.width-20, size.height-2*y);
    
    if( annotationView.bOnCrop )
    {
        double x = imageView.image.size.width > 300 ? 100 : imageView.image.size.width/3.0;
        double y = imageView.image.size.height > 300 ? 100 : imageView.image.size.height/3.0;
        annotationView.cropRect = CGRectMake(x, y, imageView.image.size.width-2*x, imageView.image.size.height-2*y);
    }
    zoomRate = [self getScaleRate];
    origin = [self getOrigin];
    [self RedrawAnnotations];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if( UIInterfaceOrientationIsPortrait(toInterfaceOrientation) )
    {
        if( portraitFrame.size.width > 0 )
        {
            savedScrollViewFrame = portraitFrame;
            scrollView.frame = savedScrollViewFrame;
            [self setImageViewFrame];
        }
    }
    else
    {
        if( landscapeFrame.size.width > 0 )
        {
            savedScrollViewFrame = landscapeFrame;
            scrollView.frame = savedScrollViewFrame;
            [self setImageViewFrame];
        }
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    if( recognizer.state == UIGestureRecognizerStateEnded )
    {
        [annotationView deselectAllAnnotations];
        CGPoint pt = [recognizer locationInView:imageView];
        if( [annotationView selectAnnotationAtPoint:pt] )
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete"
                                                                           message:@"Do you want to delete the selected annotation?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [annotationView deleteSelectedAnnotations];
                                                                      [self RedrawAnnotations];
                                                                  }];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * action) {
                                                                     [annotationView deselectAllAnnotations];
                                                                     [self RedrawAnnotations];
                                                                 }];
            [alert addAction:ok];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

CGPoint startPoint;
- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            startPoint = [recognizer locationInView:imageView];
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
            break;
        default:
            break;
    }
}

- (void)finishDrawing
{
    if( !bKeepDrawing )
    {
        [scrollView removeGestureRecognizer:panRec];
        [scrollView removeGestureRecognizer:longPressRec];
        nAnnotationType = -1;
        typeSegments.selectedSegmentIndex = -1;
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    static CGPoint originalPoint;
    CGPoint pt = [recognizer locationInView:imageView];
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if( bKeepWating )
            {
                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                bKeepWating = NO;
            }
            if( !bKeepDrawing )
            {
                [NSObject cancelPreviousPerformRequestsWithTarget:self];
            }
            
            bKeepDrawing = YES;
            if( nAnnotationType == ANNOTATION_MOVE )
            {
                [annotationView deselectAllAnnotations];
                [annotationView selectAnnotationAtPoint:startPoint];
                originalPoint = startPoint;
            }
            else
            {
                pt = [self getAbsolutePoint:startPoint];
                NSMutableDictionary *ann = [self makeAnnotationAtPoint:pt];
                [annotationView.annotations addObject:ann];
                annotationView.bShow = true;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if( annotationView.bOnCrop )
            {
                CGFloat dx = pt.x - originalPoint.x;
                CGFloat dy = pt.y - originalPoint.y;
                CGPoint off = CGPointMake(dx, dy);
                [annotationView moveAnnotation:nil offset:off];
                [annotationView setNeedsDisplay];
                originalPoint = pt;
            }
            else
            if( nAnnotationType == ANNOTATION_MOVE )
            {
                for(NSInteger i=0; i<[annotationView.annotations count]; i++)
                {
                    NSMutableDictionary *anno = [annotationView.annotations objectAtIndex:i];
                    NSNumber *states = (NSNumber *)[anno valueForKey:KEY_SELECTED];
                    if( [states boolValue] == YES )
                    {
                        CGFloat dx = pt.x - originalPoint.x;
                        CGFloat dy = pt.y - originalPoint.y;
                        CGPoint off = CGPointMake(dx, dy);
                        [annotationView moveAnnotation:anno offset:off];
                        [annotationView setNeedsDisplay];
                        originalPoint = pt;
                        break;
                    }
                }
            }
            else
            {
                CGSize sz = imageView.image.size;
                pt = [self getAbsolutePoint:pt];
                if( pt.x > sz.width ) pt.x = sz.width;
                if( pt.y > sz.height ) pt.y = sz.height;
                if( pt.x < 0 ) pt.x = 0;
                if( pt.y < 0 ) pt.y = 0;
                NSMutableDictionary *ann = [annotationView.annotations lastObject];
                if( nAnnotationType == ANNOTATION_FREEHAND || nAnnotationType == ANNOTATION_SIGN )
                {
                    NSMutableArray *arr = [ann valueForKey:KEY_POINTARRAY];
                    [arr addObject:[NSValue valueWithCGPoint:pt]];
                }
                else
                {
                    NSValue *value = [ann valueForKey:KEY_POINT];
                    CGPoint p = [value CGPointValue];
                    CGSize size = CGSizeMake(pt.x - p.x, pt.y - p.y);
                    [ann setObject:[NSValue valueWithCGSize:size] forKey:KEY_SIZE];
                }
                [self RedrawAnnotations];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSMutableDictionary *ann = [annotationView.annotations lastObject];
            if( nAnnotationType == ANNOTATION_SIGN || nAnnotationType == ANNOTATION_FREEHAND )
            {
                NSArray *points = [ann valueForKey:KEY_POINTARRAY];
                if( [points count] == 1 )
                {
                    [annotationView.annotations removeLastObject];
                }
            }
            if( nAnnotationType == ANNOTATION_LINE || nAnnotationType == ANNOTATION_RECT ||
               nAnnotationType == ANNOTATION_LINEARROW || nAnnotationType == ANNOTATION_ELLIPSE )
            {
                CGSize psize = [[ann valueForKey:KEY_SIZE] CGSizeValue];
                if( fabs(psize.width) < 3.0 && fabs(psize.height) < 3.0 )
                {
                    [annotationView.annotations removeLastObject];
                }
            }
            [annotationView deselectAllAnnotations];
            [self RedrawAnnotations];
            if( !annotationView.bOnCrop )
            {
                bKeepDrawing = NO;
                [self performSelector:@selector(finishDrawing) withObject:nil afterDelay:1.2];
            }
            if( nAnnotationType == ANNOTATION_SCALE )
            {
                bKeepScaling = NO;
                [self performSelector:@selector(finishScaling) withObject:nil afterDelay:1.5];
            }
        }
            break;
        default:
            break;
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    static NSMutableDictionary *annSelected;
    static CGPoint annPoint;
    static CGSize annSize;
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if( bKeepWating )
            {
                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                bKeepWating = NO;
            }
            if( !bKeepScaling )
            {
                [NSObject cancelPreviousPerformRequestsWithTarget:self];
            }
            bKeepScaling = YES;
            CGPoint pt1 = [recognizer locationOfTouch:0 inView:imageView];
            CGPoint pt2 = [recognizer locationOfTouch:1 inView:imageView];
            CGPoint p = CGPointMake((pt1.x + pt2.x)/2.0, (pt1.y + pt2.y)/2.0);
            CGPoint pt = [self getAbsolutePoint:p];
            annSelected = nil;
            for(NSInteger i=0; i<[annotationView.annotations count]; i++)
            {
                NSMutableDictionary *anno = [annotationView.annotations objectAtIndex:i];
                CGPoint pp = [[anno valueForKey:KEY_POINT] CGPointValue];
                CGSize size = [[anno valueForKey:KEY_SIZE] CGSizeValue];
                CGRect rc = CGRectMake(pp.x, pp.y, size.width, size.height);
                if( CGRectContainsPoint(rc, pt) )
                {
                    annSelected = anno;
                    annPoint = CGPointMake(pp.x + size.width/2.0, pp.y + size.height/2.0);
                    annSize = size;
                    [annSelected setObject:[NSNumber numberWithBool:YES] forKey:KEY_SELECTED];
                    [self RedrawAnnotations];
                    break;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if( annSelected )
            {
                CGSize sz = CGSizeMake(annSize.width * recognizer.scale, annSize.height * recognizer.scale);
                CGPoint pt = CGPointMake(annPoint.x - sz.width/2.0, annPoint.y - sz.height/2.0);
                [annSelected setObject:[NSValue valueWithCGSize:sz] forKey:KEY_SIZE];
                [annSelected setObject:[NSValue valueWithCGPoint:pt] forKey:KEY_POINT];
                [self RedrawAnnotations];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if( annSelected )
            {
                [annSelected setObject:[NSNumber numberWithBool:NO] forKey:KEY_SELECTED];
                [self RedrawAnnotations];
            }
            bKeepScaling = NO;
            [self performSelector:@selector(finishScaling) withObject:nil afterDelay:1.5];
        }
            break;
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}

- (void)finishScaling
{
    if( !bKeepScaling )
    {
        [scrollView removeGestureRecognizer:pinchRec];
        for( UIGestureRecognizer *recognizer in [scrollView gestureRecognizers] )
        {
            if( [recognizer isKindOfClass:[UIPinchGestureRecognizer class]] )
                [recognizer setEnabled:YES];
        }
        for (UIScrollView *view in viewerPage.view.subviews)
        {
            if ([view isKindOfClass:[UIScrollView class]])
            {
                view.scrollEnabled = YES;
            }
        }
        nAnnotationType = -1;
        typeSegments.selectedSegmentIndex = -1;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if( (gestureRecognizer == panRec && otherGestureRecognizer == longPressRec) ||
        (gestureRecognizer == pinchRec && otherGestureRecognizer == panRec) )
        return YES;
    else
        return NO;
}

- (void)didChangeAnnotationType:(id)sender
{
    if( sender )
    {
        [annotationView deselectAllAnnotations];
    }
    [self RedrawAnnotations];
    
    if( nAnnotationType == ANNOTATION_SCALE )
    {
        for( UIGestureRecognizer *recognizer in [scrollView gestureRecognizers] )
        {
            if( [recognizer isKindOfClass:[UIPinchGestureRecognizer class]] && recognizer != pinchRec )
                [recognizer setEnabled:NO];
        }
        [scrollView addGestureRecognizer:pinchRec];
        
        for (UIScrollView *view in viewerPage.view.subviews)
        {
            if ([view isKindOfClass:[UIScrollView class]])
            {
                view.scrollEnabled = NO;
            }
        }
    }
    else
    {
        [scrollView addGestureRecognizer:panRec];
        [scrollView addGestureRecognizer:longPressRec];
    }
    
    if( sender )
    {
        bKeepWating = YES;
        [self performSelector:@selector(procFunc) withObject:nil afterDelay:2.0];
    }
}

- (void)checkStates
{
    if( bKeepWating && nAnnotationType >= 0 )
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self procFunc];
    }
}

- (void)procFunc
{
    if( nAnnotationType == ANNOTATION_SCALE )
    {
        [scrollView removeGestureRecognizer:pinchRec];
        for( UIGestureRecognizer *recognizer in [scrollView gestureRecognizers] )
        {
            if( [recognizer isKindOfClass:[UIPinchGestureRecognizer class]] && recognizer != pinchRec )
                [recognizer setEnabled:YES];
        }
        
        for (UIScrollView *view in viewerPage.view.subviews)
        {
            if ([view isKindOfClass:[UIScrollView class]])
            {
                view.scrollEnabled = YES;
            }
        }
    }
    else
    {
        [scrollView removeGestureRecognizer:panRec];
        [scrollView removeGestureRecognizer:longPressRec];
    }
    nAnnotationType = -1;
    typeSegments.selectedSegmentIndex = -1;
    bKeepWating = NO;
}

- (CGFloat)getScaleRate
{
    CGRect rt = imageView.frame;
    CGSize sz = imageView.image.size;
    CGFloat r = rt.size.height / sz.height;
    if( sz.width * r > rt.size.width )
    {
        r = rt.size.width / sz.width;
    }
    return r;
}

- (CGPoint)getAbsolutePoint:(CGPoint)pt
{
    pt.x -= origin.x;
    pt.y -= origin.y;
    pt.x /= zoomRate;
    pt.y /= zoomRate;
    return pt;
}

- (CGPoint)getOrigin
{
    CGRect rt = imageView.frame;
    CGSize sz = imageView.image.size;
    CGFloat r = rt.size.height / sz.height;
    if( sz.width * r > rt.size.width )
    {
        r = rt.size.width / sz.width;
    }
    CGFloat x = (rt.size.width - sz.width*r) / 2.0;
    CGFloat y = (rt.size.height - sz.height*r) / 2.0;
    return CGPointMake(x, y);
}

- (NSMutableDictionary *)makeAnnotationAtPoint:(CGPoint)pt
{
    int color = (int)(nAnnotationType == ANNOTATION_SIGN ? 4 : colorAnnoSegments.selectedSegmentIndex);
    float width = nAnnotationType == ANNOTATION_SIGN ? 2.3 : [viewerPage getLineWidthWithIndex:nAnnoLineIndex];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:(int)nAnnotationType], KEY_TYPE,
                                [NSNumber numberWithFloat:width], KEY_LINETHICK,
                                [viewerPage getColorWithIndex:color], KEY_COLOR,
                                [NSNumber numberWithBool:NO], KEY_MARKED,
                                [NSNumber numberWithBool:NO], KEY_DELETED,
                                [NSNumber numberWithBool:NO], KEY_SELECTED,
                                [NSValue valueWithCGPoint:pt], KEY_POINT,
                                [NSValue valueWithCGSize:CGSizeZero], KEY_SIZE,
                                nil];
    
    if( nAnnotationType == ANNOTATION_SIGN )
    {
        NSValue *value = [NSValue valueWithCGPoint:pt];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:value, nil];
        [dic setObject:arr forKey:KEY_POINTARRAY];
    }
    if( nAnnotationType == ANNOTATION_TEXT )
    {
        CGFloat r = zoomRate;
        [dic setObject:[NSNumber numberWithInteger:[viewerPage getFontSizeWithIndex:nAnnoFontSizeIndex]/r] forKey:KEY_FONTSIZE];
        [dic setObject:@"" forKey:KEY_TEXT];
        [dic setObject:[NSNumber numberWithInt:0] forKey:KEY_TEXTROTATE];
        [dic setObject:[NSValue valueWithCGPoint:CGPointZero] forKey:KEY_TEXTPOINT2];
        CGSize size = CGSizeMake(imageView.image.size.width-pt.x, imageView.image.size.height-pt.y);
        [dic setObject:[NSValue valueWithCGSize:size] forKey:KEY_TEXTMAXSIZE];
    }
    
    return dic;
}

- (void)RedrawAnnotations
{
    annotationView.bShow = true;
    annotationView.zoomRate = zoomRate;
    annotationView.origin = origin;
    CGRect rt = imageView.frame;
    annotationView.frame = CGRectMake(0, 0, rt.size.width, rt.size.height);
    [annotationView setNeedsDisplay];
}

- (void)onSign
{
    SignViewController *signVC = [[SignViewController alloc] init];
    signVC.mode = [NSNumber numberWithInt:1];
    signVC.imageWidth = image.size.width;
    signVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:signVC animated:YES completion:nil];
}

- (void)onText
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Input text"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self enterText:alert.textFields[0].text];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             typeSegments.selectedSegmentIndex = -1;
                                                             nAnnotationType = -1;
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter text:";
        textField.font = [UIFont systemFontOfSize:18];
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)enterText:(NSString *)text
{
    if( ![text isEqualToString:@""] )
    {
        CGFloat r = [self getScaleRate];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentLeft;
        CGFloat fs = [viewerPage getFontSizeWithIndex:nAnnoFontSizeIndex]/r;
        NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:fs],
                                      NSForegroundColorAttributeName: [viewerPage getColorWithIndex:nAnnoColorIndex],
                                      NSParagraphStyleAttributeName: style
                                      };
        CGRect rect = [text boundingRectWithSize:imageView.image.size
                                         options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                      attributes:attributes
                                         context:nil];
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 0);
        CGContextFillRect(ctx, rect);
        [text drawInRect:rect withAttributes:attributes];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        image = [self flipImage:image];
        
        CGPoint pt = CGPointMake(40/r, 40/r);
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:ANNOTATION_IMAGE], KEY_TYPE,
                                    [NSNumber numberWithBool:NO], KEY_MARKED,
                                    [NSNumber numberWithBool:NO], KEY_DELETED,
                                    [NSNumber numberWithBool:YES], KEY_SELECTED,
                                    image, KEY_IMAGE,
                                    [NSValue valueWithCGPoint:pt], KEY_POINT,
                                    [NSValue valueWithCGSize:rect.size], KEY_SIZE,
                                    nil];
        
        [annotationView.annotations addObject:dic];
        [scrollView setZoomScale:1.0];
        typeSegments.selectedSegmentIndex = ANNOTATION_MOVE;
        nAnnotationType = ANNOTATION_MOVE;
        [self performSelector:@selector(didChangeAnnotationType:) withObject:nil afterDelay:0.2];
    }
}

- (UIImage *)flipImage:(UIImage *)image
{
    static UIImage *flipImg = nil;
    CGSize size = image.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, size.height);
    CGContextScaleCTM(c, 1, -1);
    [image drawAtPoint:CGPointMake(0, 0)];
    flipImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return flipImg;
}

- (void)onCrop:(BOOL)bEllipse
{
    for(int i=0; i<6; i++)
    {
        [typeSegments setEnabled:i==4 forSegmentAtIndex:i];
    }
    typeSegments.selectedSegmentIndex = 4;
    nAnnotationType = ANNOTATION_MOVE;
    [self didChangeAnnotationType:nil];
    annotationView.bOnCrop = YES;
    annotationView.bCropEllipse = bEllipse;
    [annotationList removeAllObjects];
    double x = imageView.image.size.width > 300 ? 100 : imageView.image.size.width/3.0;
    double y = imageView.image.size.height > 300 ? 100 : imageView.image.size.height/3.0;
    CGRect rt = CGRectMake(x, y, imageView.image.size.width-2*x, imageView.image.size.height-2*y);
    rt.size.height = rt.size.width * imageView.image.size.height / imageView.image.size.width;
    annotationView.cropRect = rt;
    
    savedLeftButton = viewerPage.navigationItem.leftBarButtonItem;
    savedRightButton = viewerPage.navigationItem.rightBarButtonItem;
    savedTitle = viewerPage.navigationItem.title;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    viewerPage.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCropCancel)];
    viewerPage.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStylePlain target:self action:@selector(onCropOk)];
    viewerPage.navigationItem.title = @"Cropping";
    [self RedrawAnnotations];
    [UIView commitAnimations];
}

-(void)onCropCancel
{
    for(int i=0; i<6; i++)
    {
        [typeSegments setEnabled:YES forSegmentAtIndex:i];
    }
    typeSegments.selectedSegmentIndex = -1;
    nAnnotationType = -1;
    annotationView.bOnCrop = NO;
    bKeepDrawing = NO;
    [self finishDrawing];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    viewerPage.navigationItem.leftBarButtonItem = savedLeftButton;
    viewerPage.navigationItem.rightBarButtonItem = savedRightButton;
    viewerPage.navigationItem.title = savedTitle;
    [self RedrawAnnotations];
    [UIView commitAnimations];
}

-(void)onCropOk
{
    NSString *fname = [[viewerPage.pageList objectAtIndex:pageIndex] valueForKey:PAGE_IMAGEFILE];
    UIImage *img = [UIImage imageWithContentsOfFile:fname];
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], annotationView.cropRect);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    if( annotationView.bCropEllipse )
    {
        CGSize size = annotationView.cropRect.size;
        CGRect ct = CGRectMake(0, 0, size.width, size.height);
        image = [self circularCropImage:newImage frame:ct];
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:fname atomically:YES];
    }
    else
    {
        [UIImageJPEGRepresentation(newImage, 1.0) writeToFile:fname atomically:YES];
        image = [UIImage imageWithContentsOfFile:fname];
    }
    imageView.image = image;
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self performSelector:@selector(onCropCancel) withObject:nil afterDelay:0.1];
}

-(UIImage*)circularCropImage:(UIImage*)image frame:(CGRect)frame
{
    //Create the bitmap graphics context
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat ac = 1.0;
    CGContextSetRGBFillColor(context, ac, ac, ac, 1.0);
    CGContextFillRect(context, frame);
    
    CGContextAddEllipseInRect(context, frame);
    CGContextClosePath (context);
    CGContextClip (context);
    
    // Draw the IMAGE
    [image drawInRect:frame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
