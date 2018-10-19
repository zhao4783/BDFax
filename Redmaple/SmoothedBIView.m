//
//  SmoothedBIView.m
//  MobileFax
//
//  Created by Zhao                                                     on 8/15/17.
//  Copyright © 2017 Zhao                                                    . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmoothedBIView.h"


////////////////////////////////////////
//
//

@implementation SmoothedBIView
{
    UIBezierPath *path;
    CGPoint pts[5]; // we now need to keep track of the four points of a Bezier segment and the first control point of the next segment
    uint ctr;
    int xMin, xMax, yMin, yMax;
}

@synthesize incrementalImage, signBox, color, nLineThickness;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setMultipleTouchEnabled:NO];
        path = [UIBezierPath bezierPath];
        [path setLineWidth:2.0];
        xMin = yMin = 1000;
        xMax = yMax = 0;
        signBox = [NSValue valueWithCGRect:CGRectZero];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [incrementalImage drawInRect:rect];
    [color setStroke];
    [path stroke];
}

- (void)setMinMax:(CGPoint)pt
{
    if( xMax < pt.x ) xMax = pt.x;
    if( xMin > pt.x ) xMin = pt.x;
    if( yMax < pt.y ) yMax = pt.y;
    if( yMin > pt.y ) yMin = pt.y;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ctr = 0;
    UITouch *touch = [touches anyObject];
    pts[0] = [touch locationInView:self];
    [path setLineWidth:nLineThickness*2];
    [self setMinMax:pts[0]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    ctr++;
    pts[ctr] = p;
    [self setMinMax:p];
    if (ctr == 4)
    {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
        
        [path moveToPoint:pts[0]];
        [path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]]; // add a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
        
        [self setNeedsDisplay];
        // replace points and get ready to handle the next segment
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( ctr < 4 )
    {
        UITouch *touch = [touches anyObject];
        CGPoint p = [touch locationInView:self];
        [self setMinMax:p];
        for(int i=ctr+1; i<4; i++)
        {
            pts[i] = p;
        }
        [path moveToPoint:pts[0]];
        [path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]];
        [self setNeedsDisplay];
    }
    [self drawBitmap];
    [self setNeedsDisplay];
    [path removeAllPoints];
    ctr = 0;
    
    CGRect rt = CGRectMake(xMin-5, yMin-5, xMax-xMin+10, yMax-yMin+10);
    signBox = [NSValue valueWithCGRect:rt];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)resetSign
{
    [self drawBitmap];
    [self setNeedsDisplay];
    CGRect rect = [signBox CGRectValue];
    xMin = rect.origin.x;
    yMin = rect.origin.y;
    xMax = xMin + rect.size.width;
    yMax = yMin + rect.size.height;
}

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    if (!incrementalImage) // first time; paint background white
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setFill];
        [rectpath fill];
    }
    [incrementalImage drawInRect:self.bounds];
    [color setStroke];
    [path stroke];
    incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end

