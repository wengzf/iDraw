//
//  UIView+XQ.m
//  BlueWhale
//
//  Created by Zhu Boxing on 14-9-28.
//  Copyright (c) 2014年 ZhuBoxing. All rights reserved.
//
#import "UIView+XQ.h"

@implementation UIView (XQ)



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCornerRadius:(CGFloat)cornerRadius;
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(CGFloat)inCenterX{
    return self.frame.size.width*0.5;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(CGFloat)inCenterY{
    return self.frame.size.height*0.5;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(CGPoint)inCenter{
    return CGPointMake(self.inCenterX, self.inCenterY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)b_width{
    return self.bounds.size.width;
}


- (CGFloat)b_height{
    return self.bounds.size.height;
}
- (CGFloat)b_x{
    return self.bounds.origin.x;
}
- (CGFloat)b_y{
    return self.bounds.origin.y;
}
- (void)setB_x:(CGFloat)b_x{
    self.bounds = CGRectMake(b_x, self.b_y, self.b_width, self.b_height);
}
- (void)setB_y:(CGFloat)b_y{
    self.bounds = CGRectMake(self.b_x, b_y, self.b_width, self.b_height);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if (view!=self && [view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
        if (![view isKindOfClass:[UIScrollView class]]) {
            x -= view.b_x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if (view!=self && [view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
        if (![view isKindOfClass:[UIScrollView class]]) {
            y -= view.b_y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.height : self.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.width : self.height;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)viewController {
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (void)addTargetForTouch:(id)target action:(SEL)action
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:target action:action];
    [self addGestureRecognizer:singleTap];
    
}

-(UIImage *)captureWithSelfContent:(BOOL)bWithSelf
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
    
    // Get the snapshot
    UIImage *snapshotImage = nil;
    
#ifdef __IPHONE_7_0
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    if ([systemVersion rangeOfString:@"7"].length > 0 && !bWithSelf) {
        // 系统版本号包含 7
        // There he is! The new API method
        [self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
        // Get the snapshot
        snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    }else{
#endif
        UIView *view = [[self.window subviews] objectAtIndex:0];
        self.hidden = !bWithSelf;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        //        CGContextTranslateCTM(context, 0, view.bounds.size.height);
        //        CGContextScaleCTM (context, 1, -1);
        CGContextClipToRect(context, [self convertRect:self.bounds toView:view]);
        [view.layer renderInContext:context];
        
        snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        self.hidden = NO;
#ifdef __IPHONE_7_0
    }
#endif
    
    // Be nice and clean your mess up
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

-(UIImage *)captureSelf
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
    
    // Get the snapshot
    UIImage *snapshotImage = nil;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //    CGContextScaleCTM (context, 1, -1);
    [self.layer renderInContext:context];
    
    snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Be nice and clean your mess up
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

- (NSArray *)descendantViews
{
    NSMutableArray *descendantArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        [descendantArray addObject:view];
        [descendantArray addObjectsFromArray:[view descendantViews]];
    }
    return [descendantArray copy];
}

- (UIView *)findViewThatIsFirstResponder
{
	if (self.isFirstResponder) {
		return self;
	}
    
	for (UIView *subView in self.subviews) {
		UIView *firstResponder = [subView findViewThatIsFirstResponder];
		if (firstResponder != nil) {
			return firstResponder;
		}
	}
	return nil;
}

@end
