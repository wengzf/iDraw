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
- (void) sierpinskiTriangle
{
    CGFloat len = 300;
    
    PU; BK(len/4); LT(90); FD(len/2); RT(120); PD;
    
    
    [self drawTriangleFractal:len iterationTime:4];
}
- (void) drawTriangleFractal:(CGFloat) len iterationTime:(int) iterationNum
{
    if (iterationNum == 0) {
        
        // 绘制传统 sierpinski 三角形
        {
            len/=2;
            [TURTLE solidPolygon:len edgeNum:3 angle:360/3];
            [TURTLE fd:len];
            
            [TURTLE solidPolygon:len edgeNum:3 angle:360/3];
            [TURTLE rt:120];
            [TURTLE fd:len];
            [TURTLE lt:120];
            [TURTLE solidPolygon:len edgeNum:3 angle:360/3];
            [TURTLE lt:120];
            [TURTLE fd:len];
            [TURTLE rt:120];
        }
        // 绘制传统 sierpinski 三角形 变形
        {
            len/=2;              
            [TURTLE solidPolygon:len edgeNum:3 angle:360/3];
            [TURTLE fd:len];
            
            [TURTLE solidPolygon:len edgeNum:3 angle:360/3];
            [TURTLE rt:120];
            [TURTLE fd:len];
            [TURTLE lt:120];
            [TURTLE solidPolygon:len edgeNum:3 angle:360/3];
            [TURTLE lt:120];
            [TURTLE fd:len];
            [TURTLE rt:120];
        }
        //        [NSThread sleepForTimeInterval:0.05];
        
        return;
    }
    
    CGFloat halfLen = len/2;
    
    [self drawTriangleFractal:halfLen iterationTime: iterationNum-1 ];
    [TURTLE fd:halfLen];
    
    [self drawTriangleFractal:halfLen iterationTime: iterationNum-1 ];
    [TURTLE rt:120];
    [TURTLE fd:halfLen];
    [TURTLE lt:120];
    [self drawTriangleFractal:halfLen iterationTime: iterationNum-1 ];
    [TURTLE lt:120];
    [TURTLE fd:halfLen];
    [TURTLE rt:120];
    
}

// 画sierpinski三角形
//  A = B - A - B     B = A + B + B


- (void) sierpinskiTriangleCurve
{
    int num = 6;
    int len = 3;
    int length = len;
    
    FOR_I(num){
        length = length*2;
    }
    
    PU; BK(length/4); LT(90); BK(length/2); PD;
    
    [self drawSierpinskiTriangleA:len level:num];
}
- (void) drawSierpinskiTriangleA:(CGFloat) len level:(int) level
{
    if (level == 1) {
        [TURTLE fd:len];
        [TURTLE lt:60];
        [TURTLE fd:len];
        [TURTLE lt:60];
        [TURTLE fd:len];
        
        return;
    }
    [self drawSierpinskiTriangleB:len level:level-1 ];
    [TURTLE lt:60];
    [self drawSierpinskiTriangleA:len level:level-1 ];
    [TURTLE lt:60];
    [self drawSierpinskiTriangleB:len level:level-1 ];
    
}
- (void) drawSierpinskiTriangleB:(CGFloat) len level:(int) level
{
    if (level == 1) {
        [TURTLE fd:len];
        [TURTLE rt:60];
        [TURTLE fd:len];
        [TURTLE rt:60];
        [TURTLE fd:len];
        
        return;
    }
    [self drawSierpinskiTriangleA:len level:level-1 ];
    [TURTLE rt:60];
    [self drawSierpinskiTriangleB:len level:level-1 ];
    [TURTLE rt:60];
    [self drawSierpinskiTriangleA:len level:level-1 ];
}



@end
