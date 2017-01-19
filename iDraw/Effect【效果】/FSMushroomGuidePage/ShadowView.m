//
//  ShadowView.m
//  iDraw
//
//  Created by 翁志方 on 2017/1/19.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView

- (void)drawRect:(CGRect)rect {
    // 光晕绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetShadow(context, CGSizeZero, 10);
    CGContextSetShadowWithColor(context,  CGSizeZero, 10, [UIColor lightGrayColor].CGColor);
    
    [[UIColor blueColor] setFill];
    CGContextAddRect(context, self.bounds);
    CGContextStrokePath(context);
    CGContextFillPath(context);
    [super drawRect:rect];
    
    CGContextRestoreGState(context);}

@end
