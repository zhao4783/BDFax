//
//  SignViewController.m
//  Redmaple
//
//  Created by Xiuwei Zhao on 4/20/18.
//  Copyright © 2018 Xiuwei Zhao. All rights reserved.
//

#import "PageViewController.h"
#import "SignViewController.h"

@interface SignViewController ()

@end

@implementation SignViewController
@synthesize mode, imageWidth;

extern NSInteger nAnnotationType;

NSString *signatureFilePath = @"";
UIColor *signColor[5];

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    signatureFilePath = [documentsDirectory stringByAppendingPathComponent:@"Signature.dat"];

    signColor[0] = [UIColor redColor];
    signColor[1] = [UIColor greenColor];
    signColor[2] = [UIColor blueColor];
    signColor[3] = [UIColor yellowColor];
    signColor[4] = [UIColor blackColor];
    CGSize sz = [[UIScreen mainScreen] bounds].size;
    int width = sz.width > sz.height ? sz.width : sz.height;
    int height = sz.width > sz.height ? sz.height : sz.width;
    if( [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone )
    {
        width = sz.width;
        height = sz.height;
    }
    
    int len = width - 20;
    if( len > 740 ) len = 740;
    int hgt = 300;
    int x = (width - len) / 2;
    int y = (height - hgt) / 2;
    signView = [[SmoothedBIView alloc] initWithFrame:CGRectMake(x, y, len, hgt)];
    signView.backgroundColor = [UIColor whiteColor];
    signView.layer.cornerRadius = 10;
    signView.layer.masksToBounds = YES;
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, len, 40)];
    UINavigationItem *tmpItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:tmpItem animated:NO];
    navBar.topItem.title = @"Signature";
    UIBarButtonItem *lb = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onSignCancel)];
    UIBarButtonItem *rb = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOK)];
    navBar.topItem.rightBarButtonItem = rb;
    navBar.topItem.leftBarButtonItem = lb;
    [signView addSubview:navBar];
    
    UIView *dumy = [[UIView alloc] initWithFrame:CGRectMake(0, 230, len, hgt-230)];
    dumy.backgroundColor = [UIColor whiteColor];
    [signView addSubview:dumy];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, len-40, 2)];
    lab.backgroundColor = [UIColor grayColor];
    [signView addSubview:lab];
    
    nColors = width > 500 ? 5 : 3;
    colorSegments = [[UISegmentedControl alloc] initWithFrame:CGRectMake(len-20-nColors*40, 250, nColors*40, 30)];
    for(NSInteger i=0; i<nColors; i++)
    {
        int wd = 25;
        int ht = 20;
        UIGraphicsBeginImageContext(CGSizeMake(wd, ht));
        CGFloat r, g, b, a;
        NSInteger index = nColors == 5 ? i : i*2;
        [signColor[index] getRed:&r green:&g blue:&b alpha:&a];
        CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), r, g, b, 1);
        CGContextFillEllipseInRect(UIGraphicsGetCurrentContext(), CGRectMake (0, 0, wd, ht));
        UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
        UIImage* goodImg = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [colorSegments insertSegmentWithImage:goodImg atIndex:i animated:NO];
        UIGraphicsEndImageContext();
    }
    nColorIndex = 4;
    colorSegments.selectedSegmentIndex = nColors - 1;
    [colorSegments addTarget:self action:@selector(onColorChanged) forControlEvents:UIControlEventValueChanged];
    [signView addSubview:colorSegments];
    
    lineSegments = [[UISegmentedControl alloc] initWithFrame:CGRectMake(20, 250, 120, 30)];
    for(NSInteger i=0; i<3; i++)
    {
        int wd = 25;
        int ht = 20;
        UIGraphicsBeginImageContext(CGSizeMake(wd, ht));
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextBeginPath(ctx);
        [[UIColor blackColor] set];
        CGContextSetLineWidth(ctx, (i+1)*2);
        CGContextMoveToPoint(ctx, 2, ht-2);
        CGContextAddLineToPoint(ctx, wd-2, 2);
        CGContextStrokePath(ctx);
        UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
        UIImage* goodImg = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [lineSegments insertSegmentWithImage:goodImg atIndex:i animated:NO];
        UIGraphicsEndImageContext();
    }
    nLineIndex = 1;
    lineSegments.selectedSegmentIndex = nLineIndex;
    [lineSegments addTarget:self action:@selector(onLineChanged) forControlEvents:UIControlEventValueChanged];
    [signView addSubview:lineSegments];
    
    for(int i=0; i<2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(165+i*50, 250, 40, 30);
        [[btn layer] setBorderWidth:1.0f];
        [[btn layer] setBorderColor:[UIColor blackColor].CGColor];
        [[btn layer] setCornerRadius:4.0];
        [[btn layer] setMasksToBounds:YES];
        NSString *tt = i == 0 ? @"X" : @"M";
        [btn setTitle:tt forState:UIControlStateNormal];
        UIColor *cc = i == 0 ? [UIColor redColor] : [UIColor blackColor];
        [btn setTitleColor:cc forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        SEL ss = i == 0 ? @selector(xTapped) : @selector(mTapped);
        [btn addTarget:self action:ss forControlEvents:UIControlEventTouchUpInside];
        [signView addSubview:btn];
    }
    signView.color = signColor[nColorIndex];
    signView.nLineThickness = nLineIndex + 1;
    [self.view addSubview:signView];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
    if( [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone )
    {
        mask = UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait ;
    }
    else
    {
        if( [mode intValue] == 1 )
            mask = UIInterfaceOrientationMaskLandscapeLeft;
        if( [mode intValue] == 2 )
            mask = UIInterfaceOrientationMaskPortrait;
    }
    
    return mask;
}

- (BOOL)shouldAutorotate
{
    return [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onColorChanged
{
    nColorIndex = (int)colorSegments.selectedSegmentIndex;
    if( nColors == 3 )
    {
        nColorIndex *= 2;
    }
    signView.color = signColor[nColorIndex];
}

- (void)onLineChanged
{
    nLineIndex = (int)lineSegments.selectedSegmentIndex;
    signView.nLineThickness = nLineIndex + 1;
}

- (void)xTapped
{
    signView.incrementalImage = nil;
    [signView setNeedsDisplay];
}

- (void)mTapped
{
    NSDictionary* properties = [NSDictionary dictionaryWithContentsOfFile:signatureFilePath];
    signView.incrementalImage = [UIImage imageWithData: [properties objectForKey:@"ImageData"]];
    NSString *str = [properties objectForKey:@"Bounds"];
    NSArray *arr = [str componentsSeparatedByString:@","];
    CGRect cropRect = CGRectZero;
    if( [arr count] == 4 )
    {
        cropRect.origin.x = [[arr objectAtIndex:0] intValue];
        cropRect.origin.y = [[arr objectAtIndex:1] intValue];
        cropRect.size.width = [[arr objectAtIndex:2] intValue];
        cropRect.size.height = [[arr objectAtIndex:3] intValue];
    }
    signView.signBox = [NSValue valueWithCGRect:cropRect];
    [signView resetSign];
}

- (void)onSignOK
{
    CGRect cropRect = [signView.signBox CGRectValue];
    if( cropRect.size.width == 0 && cropRect.size.height == 0 )
    {
        [self onSignCancel];
        return;
    }
    
    NSData *data = UIImagePNGRepresentation(signView.incrementalImage);
    NSString *strBounds = [NSString stringWithFormat:@"%d,%d,%d,%d",
                           (int)cropRect.origin.x,
                           (int)cropRect.origin.y,
                           (int)cropRect.size.width,
                           (int)cropRect.size.height];
    NSDictionary* properties = [NSDictionary dictionaryWithObjectsAndKeys:
                                data,               @"ImageData",
                                strBounds,          @"Bounds",
                                nil];
    [properties writeToFile:signatureFilePath atomically:NO];
    
    CGFloat y1 = cropRect.origin.y;
    CGFloat y2 = y1 + cropRect.size.height;
    if( y1 < 40 )
        y1 = cropRect.origin.y = 40;
    if( y2 > 230 )
        y2 = 230;
    cropRect.size.height = y2 - y1;
    float sc = [UIScreen mainScreen].scale;
    cropRect.origin.x *= sc;
    cropRect.origin.y *= sc;
    cropRect.size.width *= sc;
    cropRect.size.height *= sc;
    
    UIImage *img = [self imageWithView:signView];
    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], cropRect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    image = [contentVC flipImage:image];
    UIImage *inputImage = [UIImage imageWithData:UIImageJPEGRepresentation(image, 1.0)];
    
    if (CGColorSpaceGetModel(CGImageGetColorSpace(inputImage.CGImage)) == kCGColorSpaceModelRGB)
    {
        // Make the background transparent.
        const CGFloat colorMasking[6] = {120.0, 255.0, 120.0, 255.0, 120.0, 255.0};
        CGImageRef imageRefa = CGImageCreateWithMaskingColors(inputImage.CGImage, colorMasking);
        if( imageRefa != NULL )
        {
            image = [UIImage imageWithCGImage: imageRefa];
            CGImageRelease(imageRefa);
            
            UIGraphicsBeginImageContextWithOptions(image.size, NO, 1.0);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    
    CGSize size;
    size.width = imageWidth * 0.45;
    size.height = size.width * cropRect.size.height / cropRect.size.width;
    CGFloat r = [contentVC getScaleRate];
    CGPoint pt = CGPointMake(40/r, 40/r);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:ANNOTATION_IMAGE], KEY_TYPE,
                                [NSNumber numberWithBool:NO], KEY_MARKED,
                                [NSNumber numberWithBool:NO], KEY_DELETED,
                                [NSNumber numberWithBool:YES], KEY_SELECTED,
                                image, KEY_IMAGE,
                                [NSValue valueWithCGPoint:pt], KEY_POINT,
                                [NSValue valueWithCGSize:size], KEY_SIZE,
                                nil];
    [contentVC.annotationView.annotations addObject:dic];
    [contentVC.scrollView setZoomScale:1.0];
    typeSegments.selectedSegmentIndex = ANNOTATION_MOVE;
    nAnnotationType = ANNOTATION_MOVE;
    [contentVC performSelector:@selector(didChangeAnnotationType:) withObject:nil afterDelay:0.1];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onSignCancel
{
    [viewerPage cleanTypeSelection];
    [self dismissViewControllerAnimated:YES completion:nil];
    [contentVC performSelector:@selector(RedrawAnnotations) withObject:nil afterDelay:0.0];
}

- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
