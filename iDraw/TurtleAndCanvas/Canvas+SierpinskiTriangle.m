//
//  Canvas+SierpinskiTriangle.m
//  LOGO
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (SierpinskiTriangle)


// 使用递归绘制三角形分型
- (void) drawTriangleFractal
{
    CGFloat len = 300;
    [turtle lt:90];
    [turtle fd:len/2];
    [turtle rt:120];
    
    [self drawTriangleFractal:len iterationTime:3];
}
- (void) drawTriangleFractal:(CGFloat) len iterationTime:(int) iterationNum
{
    if (iterationNum == 0) {
        
        // 绘制传统 sierpinski 三角形
        {
            len/=2;                 // 如果这个地方没有除2的话，嘿嘿
            [turtle regularPolygon:len edgeNum:3];
            [turtle fd:len];
            
            [turtle regularPolygon:len edgeNum:3];
            [turtle rt:120];
            [turtle fd:len];
            [turtle lt:120];
            [turtle regularPolygon:len edgeNum:3];
            [turtle lt:120];
            [turtle fd:len];
            [turtle rt:120];
        }
        // 绘制传统 sierpinski 三角形 变形
        {
            len/=2;                 // 如果这个地方没有除2的话，嘿嘿
            [turtle regularPolygon:len edgeNum:3];
            [turtle fd:len];
            
            [turtle regularPolygon:len edgeNum:3];
            [turtle rt:120];
            [turtle fd:len];
            [turtle lt:120];
            [turtle regularPolygon:len edgeNum:3];
            [turtle lt:120];
            [turtle fd:len];
            [turtle rt:120];
        }
        //        [NSThread sleepForTimeInterval:0.05];
        
        return;
    }
    
    CGFloat halfLen = len/2;
    
    [self drawTriangleFractal:halfLen iterationTime: iterationNum-1 ];
    [turtle fd:halfLen];
    
    [self drawTriangleFractal:halfLen iterationTime: iterationNum-1 ];
    [turtle rt:120];
    [turtle fd:halfLen];
    [turtle lt:120];
    [self drawTriangleFractal:halfLen iterationTime: iterationNum-1 ];
    [turtle lt:120];
    [turtle fd:halfLen];
    [turtle rt:120];
    
}

// 画sierpinski三角形
//  A = B - A - B     B = A + B + B
- (void) drawSierpinskiTriangleA:(CGFloat) len level:(int) level
{
    if (level == 1) {
        [turtle fd:len];
        [turtle lt:60];
        [turtle fd:len];
        [turtle lt:60];
        [turtle fd:len];
        
        return;
    }
    [self drawSierpinskiTriangleB:len level:level-1 ];
    [turtle lt:60];
    [self drawSierpinskiTriangleA:len level:level-1 ];
    [turtle lt:60];
    [self drawSierpinskiTriangleB:len level:level-1 ];
    
}
- (void) drawSierpinskiTriangleB:(CGFloat) len level:(int) level
{
    if (level == 1) {
        [turtle fd:len];
        [turtle rt:60];
        [turtle fd:len];
        [turtle rt:60];
        [turtle fd:len];
        
        return;
    }
    [self drawSierpinskiTriangleA:len level:level-1 ];
    [turtle rt:60];
    [self drawSierpinskiTriangleB:len level:level-1 ];
    [turtle rt:60];
    [self drawSierpinskiTriangleA:len level:level-1 ];
}



@end
