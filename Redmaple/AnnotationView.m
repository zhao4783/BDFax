//
//  AnnotationView.m
//  MGSplitView
//
//  Created by Zhao on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageViewController.h"
#import "AnnotationView.h"


@implementation AnnotationView
@synthesize annotations, bImageView, bShow, cropRect, bOnCrop, bCropEllipse, zoomRate, origin;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        bShow = YES;
        bImageView = YES;
        annotations = [[NSMutableArray alloc] init];
        bOnCrop = NO;
        bCropEllipse = NO;
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// Annotation data structure ///////////////////////////////////////////
//
// 0.   UIColor   color;
// 1.   float     line width;
// 2.   NSInteger       type;
// 3.   NSInteger       states;     0x00000001 = selected,  0x00000010 = merged
// 4.   CGPoint   pt1;
// .....
// n+3. CGPoint   ptn;
//
////////////////////////////////////////////////////////////////////////

-(void)drawAnnotation:(NSMutableDictionary *)ann atContext:(CGContextRef)ctx mode:(int)nMode
{
    UIImageView *imgView = (UIImageView *)self.superview;
    CGRect rt = imgView.frame;

    CGFloat r;
    if( nMode == M_MERGE )
    {
        r = 1.0;
    }
    else
    {
        r = zoomRate;
    }

    NSNumber *states = (NSNumber *)[ann valueForKey:KEY_DELETED];
    if( [states boolValue] == YES )
        return;
    
    UIColor *color = (UIColor *)[ann valueForKey:KEY_COLOR];
    [color set];
    NSNumber *thick = (NSNumber *)[ann valueForKey:KEY_LINETHICK];
    CGContextSetLineWidth(ctx, [thick floatValue] * r);
    CGContextSetLineDash(ctx, 0, nil, 0);
    NSNumber *type = (NSNumber *)[ann valueForKey:KEY_TYPE];
    NSInteger nType = [type intValue];
    
    CGSize psize = [[ann valueForKey:KEY_SIZE] CGSizeValue];
    CGPoint pt1, pt2;
    pt1 = [self convertPoint:[ann valueForKey:KEY_POINT] AtZoomRate:r];
    pt2.x = pt1.x + psize.width * r;
    pt2.y = pt1.y + psize.height * r;

    if( nType == ANNOTATION_TEXT || nType == ANNOTATION_DATE || nType == ANNOTATION_TIME )
    {
        NSString *text = (NSString *)[ann valueForKey:KEY_TEXT];
        CGFloat fsize = [[ann valueForKey:KEY_FONTSIZE] floatValue];
        CGFloat scale = bImageView ? imgView.image.scale : 1.0;
        UIFont *font = [UIFont systemFontOfSize:fsize*scale*r];
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(rt.size.width-pt1.x-20, rt.size.height-pt1.y-20) lineBreakMode:NSLineBreakByWordWrapping];
        pt2 = CGPointMake(pt1.x + size.width, pt1.y + size.height);
        CGSize sz = [[ann valueForKey:KEY_TEXTMAXSIZE] CGSizeValue];
        CGRect rect = CGRectMake(pt1.x, pt1.y, sz.width*r, sz.height*r);
        NSNumber *nm = (NSNumber *)[ann valueForKey:KEY_TEXTROTATE];
        NSInteger nRotates = [nm intValue];
        if( nRotates == 0 )
        {
            [text drawInRect:rect withFont:font];
        }
        else
        {
            CGFloat angle = nRotates * M_PI / -2.0;
            CGContextSaveGState(ctx);
            CGContextTranslateCTM(ctx, pt1.x, pt1.y);
            CGAffineTransform textTransform = CGAffineTransformMakeRotation(angle);
            CGContextConcatCTM(ctx, textTransform);
            CGContextTranslateCTM(ctx, -pt1.x, -pt1.y);
            [text drawInRect:rect withFont:font];
            CGContextRestoreGState(ctx);
            if( nRotates == 1 )
            {
                pt2.x = pt1.x + size.height;
                pt2.y = pt1.y - size.width;
            }
            if( nRotates == 2 )
            {
                pt2.x = pt1.x - size.width;
                pt2.y = pt1.y - size.height;
            }
            if( nRotates == 3 )
            {
                pt2.x = pt1.x - size.height;
                pt2.y = pt1.y + size.width;
            }
        }
        [ann setObject:[NSValue valueWithCGPoint:pt2] forKey:KEY_TEXTPOINT2];
    }
    else
    {
        CGContextBeginPath(ctx);
        if( nType == ANNOTATION_CHECK1 )
        {
            float w = [[ann valueForKey:KEY_FONTSIZE] floatValue] * r;
            float h = w * 1.9;
            CGContextMoveToPoint(ctx, pt1.x-w/1.6, pt1.y);
            CGContextAddLineToPoint(ctx, pt1.x, pt1.y+w);
            CGContextAddLineToPoint(ctx, pt1.x+h/1.5, pt1.y+w-h);
            pt1.x -= w;
            pt1.y -= h;
            pt2.x = pt1.x + 2*w;
            pt2.y = pt1.y + 2*h;
        }
        else
        if( nType == ANNOTATION_CHECK2 )
        {
            float h = [[ann valueForKey:KEY_FONTSIZE] floatValue] * r;
            float w = h * 0.8;
            CGContextMoveToPoint(ctx, pt1.x-w, pt1.y-h);
            CGContextAddLineToPoint(ctx, pt1.x+w, pt1.y+h);
            CGContextStrokePath(ctx);
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, pt1.x-w, pt1.y+h);
            CGContextAddLineToPoint(ctx, pt1.x+w, pt1.y-h);
            pt1.x -= w;
            pt1.y -= h;
            pt2.x = pt1.x + 2*w;
            pt2.y = pt1.y + 2*h;
        }
        else
        if( nType == ANNOTATION_IMAGE )
        {
            UIImage *image = [ann valueForKey:KEY_IMAGE];
            CGRect rect = CGRectMake(pt1.x, pt1.y, pt2.x-pt1.x, pt2.y-pt1.y);
            CGContextDrawImage(ctx, rect, image.CGImage);
        }
        else
        if( nType == ANNOTATION_FREEHAND || nType == ANNOTATION_SIGN )
        {
            // This is an improved Bezier curve. It transits 3rd point to the midle between 2nd and 4th point.
            NSArray *points = [ann valueForKey:KEY_POINTARRAY];
            int num = (int)[points count];
            if( num < 4 )
            {
                CGContextMoveToPoint(ctx, pt1.x, pt1.y);
                for(int n = 1; n < num; n++)
                {
                    NSValue *value = [points objectAtIndex:n];
                    CGPoint pt = [self convertPoint:value AtZoomRate:r];
                    CGContextAddLineToPoint(ctx, pt.x, pt.y);
                }
            }
            else
            {
                CGPoint *pt = (CGPoint *)malloc(num*sizeof(CGPoint));
                for(int n = 0; n < num; n++)
                {
                    NSValue *value = [points objectAtIndex:n];
                    pt[n] = [self convertPoint:value AtZoomRate:r];
                }
                
                UIBezierPath *path = [UIBezierPath bezierPath];
                CGContextSetAllowsAntialiasing(ctx, YES);
                
                CGPoint cpt[5];
                cpt[0] = pt[0];
                cpt[1] = pt[1];
                [path moveToPoint:cpt[0]];
                for(int i = 2; i < num; i += 3)
                {
                    cpt[2] = pt[i];
                    if( i+2 == num )
                    {
                        cpt[3] = pt[num-1];
                        [path addCurveToPoint:cpt[3] controlPoint1:cpt[1] controlPoint2:cpt[2]];
                        CGContextAddPath(ctx, path.CGPath);
                        break;
                    }
                    else
                    {
                        cpt[4] = pt[i+2];
                        cpt[3] = CGPointMake((cpt[2].x + cpt[4].x)/2.0, (cpt[2].y + cpt[4].y)/2.0);
                        [path addCurveToPoint:cpt[3] controlPoint1:cpt[1] controlPoint2:cpt[2]];
                        CGContextAddPath(ctx, path.CGPath);
                        cpt[1] = cpt[4];
                        if( i+3 == num )
                        {
                            CGContextAddLineToPoint(ctx, pt[num-1].x, pt[num-1].y);
                            break;
                        }
                        if( i+4 == num )
                        {
                            cpt[3] = pt[num-1];
                            [path addCurveToPoint:cpt[3] controlPoint1:cpt[1] controlPoint2:cpt[1]];
                            CGContextAddPath(ctx, path.CGPath);
                            break;
                        }
                    }
                }
                free(pt);
            }
        }
        else
        {
            if( nType == ANNOTATION_LINE || nType == ANNOTATION_LINEARROW )
            {
                CGContextMoveToPoint(ctx, pt1.x, pt1.y);
                CGContextAddLineToPoint(ctx, pt2.x, pt2.y);
                
                if( nType == ANNOTATION_LINEARROW )
                {
                    double len = 26 * r * (0.85 + 0.075 * [thick floatValue]);
                    if( len < 3.0 ) len = 3.0;
                    double d = sqrt((pt2.x-pt1.x)*(pt2.x-pt1.x) + (pt2.y-pt1.y)*(pt2.y-pt1.y));
                    if( d > 1.0 )
                    {
                        double dx = (pt1.x-pt2.x) / d;
                        double dy = (pt1.y-pt2.y) / d;
                        double cos = cosh(35*3.1415926/180.0);
                        double sin = sinh(35*3.1415926/180.0);
                        CGPoint pp1, pp2;
                        pp1.x = pt2.x + (dx*cos - dy*sin) * len;
                        pp1.y = pt2.y + (dx*sin + dy*cos) * len;
                        pp2.x = pt2.x + (dx*cos + dy*sin) * len;
                        pp2.y = pt2.y + (dy*cos - dx*sin) * len;
                        CGContextMoveToPoint(ctx, pp1.x, pp1.y);
                        CGContextAddLineToPoint(ctx, pt2.x, pt2.y);
                        CGContextAddLineToPoint(ctx, pp2.x, pp2.y);
                    }
                }
            }
            else
            {
                CGRect rt = CGRectMake(pt1.x, pt1.y, (pt2.x-pt1.x), (pt2.y-pt1.y));
                if( nType == ANNOTATION_RECT )
                {
                    CGContextAddRect(ctx, rt);
                }
                if( nType == ANNOTATION_ELLIPSE )
                {
                    CGContextAddEllipseInRect(ctx, rt);
                }
                if( nType == ANNOTATION_HIGHLIGHT )
                {
                    UIColor *color = (UIColor *)[ann valueForKey:KEY_COLOR];
                    CGFloat red, green, blue, alpha;
                    if( color == [UIColor grayColor] )
                    {
                        red = green = blue = 0.5;
                        alpha = 1.0;
                    }
                    if( color == [UIColor blackColor] )
                    {
                        red = green = blue = 0.0;
                        alpha = 1.0;
                    }
                    [color getRed:&red green:&green blue:&blue alpha:&alpha];
                    CGContextSetRGBFillColor(ctx, red, green, blue, 0.45);
                    CGContextFillRect(ctx, rt);
                }
            }
        }
        CGContextStrokePath(ctx);
    }
    
    NSNumber *bsel = (NSNumber *)[ann valueForKey:KEY_SELECTED];
    if( nMode != M_MERGE && [bsel boolValue] )
    {
        NSInteger xMax = -10000;
        NSInteger yMax = -10000;
        NSInteger xMin = 10000;
        NSInteger yMin = 10000;
        if( nType == ANNOTATION_FREEHAND || nType == ANNOTATION_SIGN )
        {
            NSArray *points = [ann valueForKey:KEY_POINTARRAY];
            int num = (int)[points count];
            for(NSInteger n = 0; n < num; n++)
            {
                CGPoint pt = [self convertPoint:[points objectAtIndex:n] AtZoomRate:r];
                if( pt.x > xMax ) xMax = pt.x;
                if( pt.y > yMax ) yMax = pt.y;
                if( pt.x < xMin ) xMin = pt.x;
                if( pt.y < yMin ) yMin = pt.y;
            }
        }
        else
        {
            if( pt1.x > xMax ) xMax = pt1.x;
            if( pt1.y > yMax ) yMax = pt1.y;
            if( pt1.x < xMin ) xMin = pt1.x;
            if( pt1.y < yMin ) yMin = pt1.y;
            if( pt2.x > xMax ) xMax = pt2.x;
            if( pt2.y > yMax ) yMax = pt2.y;
            if( pt2.x < xMin ) xMin = pt2.x;
            if( pt2.y < yMin ) yMin = pt2.y;
        }
        CGRect rect = CGRectMake(xMin, yMin, xMax-xMin, yMax-yMin);

        UIColor *color = [UIColor colorWithRed:0.6 green:0.7 blue:0.99 alpha:1.0];
        [color set];
        CGContextSetLineWidth(ctx, 1.0);
        CGFloat ph[2] = {15, 3};
        CGContextSetLineDash(ctx, 0, ph, 2);
        CGContextBeginPath(ctx);
        NSInteger m = 8;
        rect.origin.x -= m;
        rect.origin.y -= m;
        rect.size.width += 2*m;
        rect.size.height += 2*m;
        CGContextAddRect(ctx, rect);
        CGContextStrokePath(ctx);
    }

    if( bOnCrop )
    {
        CGFloat redt = bCropEllipse ? 0.4 : 1.0;
        [[UIColor colorWithRed:redt green:0.0 blue:0.0 alpha:1.0] set];
        CGContextSetLineWidth(ctx, 1.0);
        CGFloat ph[2] = {8, 1};
        CGContextSetLineDash(ctx, 0, ph, 2);
        CGContextBeginPath(ctx);
        CGSize psize = cropRect.size;
        CGPoint pt1 = cropRect.origin;
        pt1.x = pt1.x *r;
        pt1.y = pt1.y *r;
        pt1.x += origin.x;
        pt1.y += origin.y;
        CGPoint pt2 = pt1;
        pt2.x += psize.width * r;
        pt2.y += psize.height * r;
        CGRect rt = CGRectMake(pt1.x, pt1.y, psize.width * r, psize.height * r);
        CGContextAddRect(ctx, rt);
        CGContextStrokePath(ctx);
        if( bCropEllipse )
        {
            [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] set];
            CGContextBeginPath(ctx);
            CGContextAddEllipseInRect(ctx, rt);
            CGContextStrokePath(ctx);
        }
        
        CGPoint pt;
        pt.x = (pt1.x + pt2.x)/2.0;
        pt.y = pt1.y;
        [self setResizeMark:pt context:ctx];
        pt.y = pt2.y;
        [self setResizeMark:pt context:ctx];
        pt.x = pt1.x;
        pt.y = (pt1.y + pt2.y)/2.0;
        [self setResizeMark:pt context:ctx];
        pt.x = pt2.x;
        [self setResizeMark:pt context:ctx];
        pt = pt1;
        [self setResizeMark:pt context:ctx];
        pt.x = pt2.x;
        [self setResizeMark:pt context:ctx];
        pt = pt2;
        [self setResizeMark:pt context:ctx];
        pt.x = pt1.x;
        [self setResizeMark:pt context:ctx];
    }
}

-(void)drawRect:(CGRect)rect
{
    if( !bShow )
    {
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for(NSInteger i = 0; i < [annotations count]; i++)
    {
        NSMutableDictionary *ann = [annotations objectAtIndex:i];
        @try
        {
            [self drawAnnotation:ann atContext:ctx mode:M_DISPLAY];
        }
        @catch (NSException *ex)
        {
            [annotations removeObject:ann];
            break;
        }
    }

    if( bOnCrop)
    {
        [self drawAnnotation:nil atContext:ctx mode:M_CROPING];
    }
}

-(void)imageCropped:(CGPoint)pt
{
    for(NSInteger i = 0; i < [annotations count]; i++)
    {
        NSMutableDictionary *ann = [annotations objectAtIndex:i];
        CGPoint op = [[ann valueForKey:KEY_POINT] CGPointValue];
        op.x -= pt.x;
        op.y -= pt.y;
        [ann setObject:[NSValue valueWithCGPoint:op] forKey:KEY_POINT];
    }
}

-(void)setResizeMark:(CGPoint)pt context:(CGContextRef)ctx
{
    CGContextBeginPath(ctx);
    [[UIColor grayColor] set];
    CGContextSetLineDash(ctx, 0, nil, 0);
    CGFloat m = 6;
    CGRect rect;
    rect.size.width = 2*m;
    rect.size.height = 2*m;
    rect.origin.x = pt.x - m;
    rect.origin.y = pt.y - m;
    CGContextSetRGBFillColor(ctx, 0.85, 0.85, 0.85, 1);
    CGContextFillRect(ctx, rect);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (UIImage *)doResizeImage:(UIImage *)image imageSize:(CGSize)size
{
    float rx = size.width / image.size.width;
    float ry = size.height / image.size.height;
    float r = rx < ry ? rx : ry;
    CGSize newSize = CGSizeMake(image.size.width * r, image.size.height * r);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect: CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)doResizeAnnotationImage:(NSMutableDictionary *)anno
{
    UIImageView *imgView = (UIImageView *)self.superview;
    CGSize sz = imgView.image.size;
    CGFloat r = zoomRate;
    NSString *fname = [anno valueForKey:KEY_IMAGEFILENAME];
    NSData *data = [[NSData alloc] initWithContentsOfFile:fname];
    UIImage *image = [UIImage imageWithData:data];
    CGSize psize = [[anno valueForKey:KEY_SIZE] CGSizeValue];
    sz = CGSizeMake(psize.width * r, psize.height * r);
    image = [self doResizeImage:image imageSize:sz];
    [anno setObject:image forKey:KEY_IMAGE];
}

- (void)resizeAnnotaionImages
{
    for(NSInteger i = [annotations count]-1; i >= 0; i--)
    {
        NSMutableDictionary *anno = [annotations objectAtIndex:i];
        NSNumber *states = (NSNumber *)[anno valueForKey:KEY_DELETED];
        if( [states boolValue] == YES )
            continue;
        NSNumber *type = (NSNumber *)[anno valueForKey:KEY_TYPE];
        if( [type intValue] == ANNOTATION_IMAGE )
        {
            [self doResizeAnnotationImage:anno];
        }
    }
}

-(bool)resizeImageFrame:(CGFloat)rate point1:(CGPoint)p1 point2:(CGPoint)p2
{
    UIImageView *imgView = (UIImageView *)self.superview;
    CGSize sz = imgView.image.size;
    CGFloat r = zoomRate;
    for(NSInteger i = [annotations count]-1; i >= 0; i--)
    {
        NSMutableDictionary *anno = [annotations objectAtIndex:i];
        NSNumber *states = (NSNumber *)[anno valueForKey:KEY_DELETED];
        if( [states boolValue] == YES )
            continue;
        NSNumber *type = (NSNumber *)[anno valueForKey:KEY_TYPE];
        if( [type intValue] == ANNOTATION_IMAGE || [type intValue] == ANNOTATION_RECT ||
            [type intValue] == ANNOTATION_ELLIPSE || [type intValue] == ANNOTATION_HIGHLIGHT )
        {
            CGSize psize = [[anno valueForKey:KEY_SIZE] CGSizeValue];
            CGPoint pt1, pt2;
            pt1 = [self convertPoint:[anno valueForKey:KEY_POINT] AtZoomRate:r];
            pt2.x = pt1.x + psize.width * r;
            pt2.y = pt1.y + psize.height * r;
            CGRect rect = CGRectMake(pt1.x, pt1.y, (pt2.x-pt1.x), (pt2.y-pt1.y));
            rect = CGRectStandardize(rect);
            if( CGRectContainsPoint(rect, p1) || CGRectContainsPoint(rect, p2) )
            {
                CGPoint ct, w, u;
                ct.x = rect.origin.x + rect.size.width/2.0;
                ct.y = rect.origin.y + rect.size.height/2.0;
                float dx = rect.size.width * rate;
                float dy = rect.size.height * rate;
                pt1.x = ct.x - dx/2.0;
                pt1.y = ct.y - dy/2.0;
                pt2.x = pt1.x + dx;
                pt2.y = pt1.y + dy;
                w.x = pt1.x / r;
                w.y = pt1.y / r;
                u.x = pt2.x / r;
                u.y = pt2.y / r;
                if( w.x < 0 || w.y < 0 || u.x > sz.width || u.y > sz.height )
                {
                    if( rate > 1.0 )
                        return true;
                }
                [anno setObject:[NSValue valueWithCGPoint:w] forKey:KEY_POINT];
                CGSize size = CGSizeMake(rect.size.width * rate, rect.size.height * rate);
                psize = CGSizeMake(size.width / r, size.height / r);
                [anno setObject:[NSValue valueWithCGSize:psize] forKey:KEY_SIZE];
 
                return true;
            }
        }
    }
    return false;
}

-(void)deleteSelectedAnnotations
{
    NSInteger num = [annotations count];
    for(NSInteger i = num-1; i >= 0; i--)
    {
        NSMutableDictionary *ann = [annotations objectAtIndex:i];
        NSNumber *bsel = (NSNumber *)[ann valueForKey:KEY_SELECTED];
        if( [bsel boolValue] )
        {
            [annotations removeObject:ann];
        }
    }
}

-(void)deselectAllAnnotations
{
    for(NSInteger i = 0; i < [annotations count]; i++)
    {
        NSMutableDictionary *anno = [annotations objectAtIndex:i];
        [anno setObject:[NSNumber numberWithBool:NO] forKey:KEY_SELECTED];
    }
}

-(void)deselectSignature
{
    for(NSInteger i = 0; i < [annotations count]; i++)
    {
        NSMutableDictionary *anno = [annotations objectAtIndex:i];
        NSNumber *type = (NSNumber *)[anno valueForKey:KEY_TYPE];
        if( [type intValue] == ANNOTATION_SIGN )
        {
            [anno setObject:[NSNumber numberWithBool:NO] forKey:KEY_SELECTED];
        }
    }
}

-(BOOL)selectAnnotationAtPoint:(CGPoint)point
{
    cropIndex = 0;

    if( bOnCrop )
    {
        CGFloat r = zoomRate;
        CGFloat dt = 20.0 / r;
        CGPoint pt;
        pt.x = (point.x - origin.x) / r;
        pt.y = (point.y - origin.y) / r;
        CGSize size = cropRect.size;
        CGPoint p1 = cropRect.origin;
        CGPoint p2 = CGPointMake(p1.x + size.width, p1.y + size.height);
        CGFloat mx = p1.x + size.width/2.0;
        CGFloat my = p1.y + size.height/2.0;
        if( fabs(pt.x - mx) < dt && fabs(pt.y - p1.y) < dt )
            cropIndex = 1;
        if( fabs(pt.x - p1.x) < dt && fabs(pt.y - my) < dt )
            cropIndex = 2;
        if( fabs(pt.x - mx) < dt && fabs(pt.y - p2.y) < dt )
            cropIndex = 3;
        if( fabs(pt.x - p2.x) < dt && fabs(pt.y - my) < dt )
            cropIndex = 4;
        if( fabs(pt.x - p1.x) < dt && fabs(pt.y - p1.y) < dt )
            cropIndex = 5;
        if( fabs(pt.x - p2.x) < dt && fabs(pt.y - p1.y) < dt )
            cropIndex = 6;
        if( fabs(pt.x - p2.x) < dt && fabs(pt.y - p2.y) < dt )
            cropIndex = 7;
        if( fabs(pt.x - p1.x) < dt && fabs(pt.y - p2.y) < dt )
            cropIndex = 8;
        
        if( cropIndex == 0 )
        {
            if( CGRectContainsPoint(cropRect, pt) )
                cropIndex = 99;
        }
        
        return cropIndex > 0;
    }

    CGFloat minDist = 10000.0;
    NSInteger selectedObj = 0;
    for(NSInteger i = [annotations count]-1; i >= 0; i--)
    {
        NSMutableDictionary *anno = [annotations objectAtIndex:i];
        NSNumber *states = (NSNumber *)[anno valueForKey:KEY_DELETED];
        if( [states boolValue] == YES )
            continue;
        
        CGFloat dist = [self getDistanceToAnnotation:anno atPoint:point];
        if( dist < minDist )
        {
            minDist = dist;
            selectedObj = i;
        }
    }
    
    BOOL ret = YES;
    if( minDist > 10 ) //If nothing is selected, deselect all annotations.
    {
        [self deselectAllAnnotations];
        ret = NO;
    }
    else 
    {
        NSMutableDictionary *anno = [annotations objectAtIndex:selectedObj];
        [anno setObject:[NSNumber numberWithBool:YES] forKey:KEY_SELECTED];
    }
    [self setNeedsDisplay];
    
    return ret;
}

-(void)deselectAnnotationAtPoint:(CGPoint)point
{
    CGFloat minDist = 10000.0;
    NSInteger selectedObj = 0;
    for(NSInteger i = 0; i < [annotations count]; i++)
    {
        NSMutableDictionary *anno = [annotations objectAtIndex:i];
        CGFloat dist = [self getDistanceToAnnotation:anno atPoint:point];
        if( dist < minDist )
        {
            minDist = dist;
            selectedObj = i;
        }
    }
    
    if( minDist < 10 )
    {
        NSMutableDictionary *anno = [annotations objectAtIndex:selectedObj];
        [anno setObject:[NSNumber numberWithBool:NO] forKey:KEY_SELECTED];
        [self setNeedsDisplay];
    }
}

-(CGPoint)convertPoint:(NSValue *)point AtZoomRate:(CGFloat)r
{
    CGPoint pt = [point CGPointValue];
    pt.x *= r;
    pt.y *= r;
    pt.x += origin.x;
    pt.y += origin.y;
    
    return pt;
}

-(CGFloat)getDistanceToAnnotation:(NSMutableDictionary *)annotation atPoint:(CGPoint)point
{
    static CGFloat fMax = 10000.0;
    static CGFloat fMin = 0.0;
    
    CGFloat r = zoomRate;
    CGSize psize = [[annotation valueForKey:KEY_SIZE] CGSizeValue];
    CGPoint pt1, pt2;
    pt1 = [self convertPoint:[annotation valueForKey:KEY_POINT] AtZoomRate:r];
    pt2.x = pt1.x + psize.width * r;
    pt2.y = pt1.y + psize.height * r;

    NSNumber *type = (NSNumber *)[annotation valueForKey:KEY_TYPE];
    if( [type intValue] == ANNOTATION_TEXT || [type intValue] == ANNOTATION_DATE || [type intValue] == ANNOTATION_TIME )
    {
        CGPoint pt = [[annotation valueForKey:KEY_TEXTPOINT2] CGPointValue];
        CGRect rect = CGRectMake(pt1.x, pt1.y, (pt.x-pt1.x), (pt.y-pt1.y));
        if( CGRectGetMinX(rect) < point.x && CGRectGetMaxX(rect) > point.x &&
            CGRectGetMinY(rect) < point.y && CGRectGetMaxY(rect) > point.y )
        {
            return fMin;
        }
        else
        {
            return fMax;
        }
    }

    if( [type intValue] == ANNOTATION_CHECK1 || [type intValue] == ANNOTATION_CHECK2 )
    {
        float w = [[annotation valueForKey:KEY_FONTSIZE] floatValue] * r/2.0 + 10;
        float h = w * ([type intValue] == ANNOTATION_CHECK1 ? 1.5 : 1.3);
        CGRect rect = CGRectMake(pt1.x-w, pt1.y-h, 2*w, 2*h);
        if( CGRectGetMinX(rect) < point.x && CGRectGetMaxX(rect) > point.x &&
            CGRectGetMinY(rect) < point.y && CGRectGetMaxY(rect) > point.y )
        {
            return fMin;
        }
        else
        {
            return fMax;
        }
    }
    
    CGFloat dist = 0.0;
    if( [type intValue] == ANNOTATION_LINE || [type intValue] == ANNOTATION_LINEARROW )
    {
        dist = [self getDistanceFrom:point to:pt1 and:pt2];
    }
    else
    if( [type intValue] == ANNOTATION_FREEHAND || [type intValue] == ANNOTATION_SIGN )
    {
        CGFloat minDt = fMax;
        NSArray *points = [annotation valueForKey:KEY_POINTARRAY];
        int num = (int)[points count];
        for(NSInteger i = 1; i < num; i++)
        {
            CGPoint pt2 = [self convertPoint:[points objectAtIndex:i] AtZoomRate:r];
            CGFloat dd = [self getDistanceFrom:point to:pt1 and:pt2];
            if( dd < minDt )
            {
                minDt = dd;
            }
            pt1 = pt2;
        }
        dist = minDt;
    }
    else
    {
        CGRect rect = CGRectMake(pt1.x, pt1.y, (pt2.x-pt1.x), (pt2.y-pt1.y));
        rect = CGRectStandardize(rect);
        if( CGRectContainsPoint(rect, point) )
        {
            dist = fMin;
        }
        else
        {
            dist = fMax;
        }
    }
    
    return dist;
}

-(double)getDistanceFrom:(CGPoint)pt to:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat dx = p2.x - p1.x;
    CGFloat dy = p2.y - p1.y;
    CGFloat length = sqrtf(dx*dx + dy*dy);
    if( length == 0.0 )
    {
        CGFloat dx = pt.x - p1.x;
        CGFloat dy = pt.y - p1.y;
        return sqrtf(dx*dx + dy*dy);
    }
    
    dx /= length;
    dy /= length;
    CGFloat sx = (pt.x-p1.x) / length;
    CGFloat sy = (pt.y-p1.y) / length;
    CGFloat rr = dx*sx + dy*sy;
    if( rr > 1.0 )
    {
        CGFloat dx = pt.x - p2.x;
        CGFloat dy = pt.y - p2.y;
        return sqrtf(dx*dx + dy*dy);
    }
    if( rr < 0.0 )
    {
        CGFloat dx = pt.x - p1.x;
        CGFloat dy = pt.y - p1.y;
        return sqrtf(dx*dx + dy*dy);
    }
    
    return fabs(dy*(pt.x-p1.x) - dx*(pt.y-p1.y));
}

-(void)moveAnnotation:(NSMutableDictionary *)annotation offset:(CGPoint)off
{
    UIImageView *imgView = (UIImageView *)self.superview;
    CGSize sz = imgView.image.size;
    CGFloat r = zoomRate;

    if( bOnCrop )
    {
        CGPoint p1 = cropRect.origin;
        CGPoint p2 = p1;
        p2.x += cropRect.size.width;
        p2.y += cropRect.size.height;
        CGFloat fx = off.x / r;
        CGFloat fy = off.y / r;
        
        if( cropIndex == 99 )
        {
            if( p1.x + fx < 0 ) fx = -p1.x;
            if( p1.y + fy < 0 ) fy = -p1.y;
            if( p2.x + fx > sz.width ) fx = sz.width - p2.x;
            if( p2.y + fy > sz.height ) fy = sz.height - p2.y;
            cropRect = CGRectOffset(cropRect, fx, fy);
            return;
        }

        if( cropIndex < 5 )
        {
            if( cropIndex == 1 )
            {
                p1.y += fy;
            }
            if( cropIndex == 2 )
            {
                p1.x += fx;
            }
            if( cropIndex == 3 )
            {
                p2.y += fy;
            }
            if( cropIndex == 4 )
            {
                p2.x += fx;
            }
            if( p1.x < 0 ) p1.x = 0;
            if( p1.y < 0 ) p1.y = 0;
            if( p2.x > sz.width ) p2.x = sz.width;
            if( p2.y > sz.height ) p2.y = sz.height;
            if( p1.x > p2.x-10 ) p1.x = p2.x-10;
            if( p2.x < p1.x+10 ) p2.x = p1.x+10;
            if( p1.y > p2.y-10 ) p1.y = p2.y-10;
            if( p2.y < p1.y+10 ) p2.y = p1.y+10;
        }
        else
        {
            if( fabs(fx) > fabs(fy) )
            {
                fy = fx * cropRect.size.height / cropRect.size.width;
            }
            else
            {
                fx = fy * cropRect.size.width / cropRect.size.height;
            }
            if( cropIndex == 5 )
            {
                if( p1.x+fx >= 0 && p1.y+fy >= 0 )
                {
                    p1.x += fx;
                    p1.y += fy;
                }
            }
            if( cropIndex == 6 )
            {
                if( p2.x+fx <= sz.width && p1.y-fy >= 0 )
                {
                    p2.x += fx;
                    p1.y -= fy;
                }
            }
            if( cropIndex == 7 )
            {
                if( p2.x+fx <= sz.width && p2.y+fy <= sz.height )
                {
                    p2.x += fx;
                    p2.y += fy;
                }
            }
            if( cropIndex == 8 )
            {
                if( p1.x+fx >= 0 && p2.y-fy <= sz.height )
                {
                    p1.x += fx;
                    p2.y -= fy;
                }
            }
        }
        cropRect.origin = p1;
        cropRect.size.width = p2.x - p1.x;
        cropRect.size.height = p2.y - p1.y;
        return;
    }

    NSInteger type = [(NSNumber *)[annotation valueForKey:KEY_TYPE] intValue];
    CGPoint pt1, pt2;
    NSValue *value = [annotation valueForKey:KEY_POINT];
    pt1 = [value CGPointValue];
    if( type == ANNOTATION_TEXT || type == ANNOTATION_DATE || type == ANNOTATION_TIME )
    {
        NSString *text = (NSString *)[annotation valueForKey:KEY_TEXT];
        UIFont *font = [UIFont systemFontOfSize:[[annotation valueForKey:KEY_FONTSIZE] floatValue]];
        CGSize size = [text sizeWithFont:font constrainedToSize:sz lineBreakMode:NSLineBreakByWordWrapping];
        pt2 = CGPointMake(pt1.x + size.width, pt1.y + size.height);
    }
    else
    if( type == ANNOTATION_CHECK1 || type == ANNOTATION_CHECK2 )
    {
        float w = [[annotation valueForKey:KEY_FONTSIZE] floatValue] / 3.0;
        float h = w * 1.5;
        pt1.x -= w;
        pt1.y -= h;
        pt2.x = pt1.x + 2*w;
        pt2.y = pt1.y + 2*h;        
    }
    else
    if( type == ANNOTATION_SIGN || type == ANNOTATION_FREEHAND )
    {
        pt2 = pt1;
        NSMutableArray *points = [annotation valueForKey:KEY_POINTARRAY];
        for(NSInteger i=0; i<[points count]; i++)
        {
            NSValue * value = [points objectAtIndex:i];
            CGPoint t = [value CGPointValue];
            if( t.x < pt1.x ) pt1.x = t.x;
            if( t.y < pt1.y ) pt1.y = t.y;
            if( t.x > pt2.x ) pt2.x = t.x;
            if( t.y > pt2.y ) pt2.y = t.y;
        }
    }
    else
    {
        NSValue *value = [annotation valueForKey:KEY_SIZE];
        CGSize t = [value CGSizeValue];
        CGRect rt = CGRectMake(pt1.x, pt1.y, t.width, t.height);
        rt = CGRectStandardize(rt);
        pt1 = rt.origin;
        pt2.x = pt1.x + rt.size.width;
        pt2.y = pt1.y + rt.size.height;
    }
    
    CGFloat fx = off.x / r;
    CGFloat fy = off.y / r;
    if( type == ANNOTATION_TEXT || type == ANNOTATION_DATE || type == ANNOTATION_TIME )
    {
        pt1.x += fx;
        pt1.y += fy;
        if( pt1.x < 0 ) pt1.x = 0;
        if( pt1.y < 0 ) pt1.y = 0;
        NSInteger min = 100;
        if( pt1.x > sz.width - min ) pt1.x = sz.width - min;
        if( pt1.y > sz.height - min ) pt1.y = sz.height - min;
        CGSize size = CGSizeMake(sz.width-pt1.x, sz.height-pt1.y);
        [annotation setObject:[NSValue valueWithCGSize:size] forKey:KEY_TEXTMAXSIZE];
        [annotation setObject:[NSValue valueWithCGPoint:pt1] forKey:KEY_POINT];
    }
    else
    {
        if( pt1.x + fx < 0 ) fx = -pt1.x;
        if( pt1.y + fy < 0 ) fy = -pt1.y;
        if( pt2.x + fx > sz.width ) fx = sz.width - pt2.x;
        if( pt2.y + fy > sz.height ) fy = sz.height - pt2.y;
        
        if( type == ANNOTATION_SIGN || type == ANNOTATION_FREEHAND )
        {
            NSMutableArray *points = [annotation valueForKey:KEY_POINTARRAY];
            for(NSInteger i=0; i<[points count]; i++)
            {
                NSValue *value = [points objectAtIndex:i];
                CGPoint p = [value CGPointValue];
                p.x += fx;
                p.y += fy;
                [points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:p]];
            }
        }
        else
        {
            NSValue *value = [annotation valueForKeyPath:KEY_POINT];
            CGPoint pt = [value CGPointValue];
            pt.x += fx;
            pt.y += fy;
            [annotation setObject:[NSValue valueWithCGPoint:pt] forKey:KEY_POINT];
        }
    }
}

-(void)rotateAnnotations:(NSArray *)objects size:(CGSize)size
{
    if( [objects count] == 0 )
        return;
    
    for(NSInteger i = 0; i < [objects count]; i++)
    {
        NSMutableDictionary *anno = [objects objectAtIndex:i];
        NSNumber *type = (NSNumber *)[anno valueForKey:KEY_TYPE];
        
        CGPoint p1 = [[anno valueForKey:KEY_POINT] CGPointValue];
        CGSize sz = [[anno valueForKey:KEY_SIZE] CGSizeValue];
        CGPoint p, w;
        p.y = p1.x;
        p.x = size.height - p1.y;
        [anno setObject:[NSValue valueWithCGPoint:p] forKey:KEY_POINT];
        
        if( [type intValue] == ANNOTATION_SIGN || [type intValue] == ANNOTATION_FREEHAND )
        {
            NSMutableArray *points = [anno valueForKey:KEY_POINTARRAY];
            for(int i=0; i<[points count]; i++)
            {
                CGPoint p2 = [[points objectAtIndex:i] CGPointValue];
                w.y = p2.x;
                w.x = size.height - p2.y;
                [points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:w]];
            }
        }
        else
        if( [type intValue] == ANNOTATION_TEXT || [type intValue] == ANNOTATION_DATE || [type intValue] == ANNOTATION_TIME )
        {
            NSNumber *nm = (NSNumber *)[anno valueForKey:KEY_TEXTROTATE];
            int nRotate = [nm intValue] - 1;
            if( nRotate < 0 ) nRotate = 3;
            [anno setObject:[NSNumber numberWithInt:nRotate] forKey:KEY_TEXTROTATE];
        }
        else
        {
            if( [type intValue] == ANNOTATION_IMAGE )
            {
                UIImage *img = (UIImage *)[anno valueForKey:KEY_IMAGE];
                CGSize size = CGSizeMake(img.size.height, img.size.width);
                UIGraphicsBeginImageContext(size);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGContextTranslateCTM(ctx, 0, size.height);
                CGContextRotateCTM(ctx,  -M_PI / 2.0);
                [img drawAtPoint:CGPointMake(0, 0)];
                UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [anno setObject:newimage forKey:KEY_IMAGE];
            }
            CGPoint p2 = CGPointMake(p1.x + sz.width, p1.y + sz.height);
            w.y = p2.x;
            w.x = size.height - p2.y;
            CGSize sz = CGSizeMake(w.x - p.x, w.y - p.y);
            [anno setObject:[NSValue valueWithCGSize:sz] forKey:KEY_SIZE];
        }
    }
}

@end
