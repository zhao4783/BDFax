//
//  AnnotationView.h
//  IPFax
//
//  Created by Zhao                                                     on 11/21/12.
//
//

#import <UIKit/UIKit.h>

#define ANNOTATION_SIGN         0
#define ANNOTATION_HIGHLIGHT    1
#define ANNOTATION_TEXT         2
#define ANNOTATION_MOVE         3
#define ANNOTATION_SCALE        4
#define ANNOTATION_SETTINGS     5
#define ANNOTATION_IMAGE        6
#define ANNOTATION_ELLIPSE      7
#define ANNOTATION_TIME         8
#define ANNOTATION_CHECK1       9
#define ANNOTATION_CHECK2       10
#define ANNOTATION_LINEARROW    11
#define ANNOTATION_DATE         12
#define ANNOTATION_FREEHAND     13
#define ANNOTATION_LINE         14
#define ANNOTATION_RECT         15
#define ANNOTATION_SELECT       18

#define KEY_TYPE            @"Type"
#define KEY_LINETHICK       @"LineThick"
#define KEY_COLOR           @"Color"
#define KEY_MARKED          @"Marked"
#define KEY_DELETED         @"Deleted"
#define KEY_SELECTED        @"Selected"
#define KEY_POINT           @"Point"
#define KEY_SIZE            @"Size"
#define KEY_POINTARRAY      @"PointArray"
#define KEY_FONTSIZE        @"FontSize"
#define KEY_TEXT            @"Text"
#define KEY_TEXTROTATE      @"TextRotate"
#define KEY_TEXTPOINT2      @"TextPoint2"
#define KEY_TEXTMAXSIZE     @"TextMaxSize"
#define KEY_IMAGE           @"Image"
#define KEY_IMAGEFILENAME   @"ImageFileName"

#define M_DISPLAY       0
#define M_MERGE         1
#define M_DRWING        2
#define M_CROPING       3

@interface AnnotationView : UIView
{
    NSMutableArray *annotations;
    BOOL bImageView;
    BOOL bShow;
    BOOL bCropEllipse;
    BOOL bOnCrop;
    int cropIndex;
    CGRect cropRect;
}
@property (nonatomic, retain) NSMutableArray *annotations;
@property (nonatomic) BOOL bImageView;
@property (nonatomic) BOOL bShow;
@property (nonatomic) BOOL bOnCrop;
@property (nonatomic) BOOL bCropEllipse;
@property (nonatomic) CGRect cropRect;
@property (nonatomic) CGFloat zoomRate;
@property (nonatomic) CGPoint origin;

-(BOOL)selectAnnotationAtPoint:(CGPoint)point;
-(void)deselectAnnotationAtPoint:(CGPoint)point;
-(void)moveAnnotation:(NSMutableDictionary *)annotation offset:(CGPoint)off;
-(void)rotateAnnotations:(NSArray *)object size:(CGSize)size;
-(void)deselectAllAnnotations;
-(void)deselectSignature;
-(void)drawAnnotation:(NSMutableDictionary *)annotation atContext:(CGContextRef)ctx mode:(int)nMode;
-(bool)resizeImageFrame:(CGFloat)rate point1:(CGPoint)p1 point2:(CGPoint)p2;
-(void)doResizeAnnotationImage:(NSMutableDictionary *)anno;
-(void)resizeAnnotaionImages;
-(void)imageCropped:(CGPoint)pt;
-(void)deleteSelectedAnnotations;

@end
