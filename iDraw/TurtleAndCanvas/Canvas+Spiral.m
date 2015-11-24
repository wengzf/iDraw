//
//  Canvas+Spiral.m
//  LOGO
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (Spiral)




// 螺线
// 普通半圆形螺线
- (void) drawSpirals
{
    CGFloat delta = 5;
    CGFloat radius = 3;
    for (int i=0; i<20; ++i) {
        [turtle leftCircleArcWithRadius:radius angle:180];
        radius += delta;
    }
}
// 黄金分割螺线
- (void) drawGoldenSplitSpirals
{
    CGFloat goldenNum = 1.618;
    CGFloat len = 5;
    
    for (int i=0; i<8; ++i) {
        [turtle circleArcWithRadius:len angle:90];
        len *= goldenNum;
    }
}
// 多边形螺旋线
// 维持edgeNum的一半时候再进行半径增加可以保持螺线间的间距时一样的，同半圆一个道理
- (void) polygonSpiral
{
    int num = 28;
    int radius = 1;
    int edgeNum = 8;
    int delta = 2;
    for (int i=0; i<num; ++i) {
        for (int j=0; j<edgeNum-4; ++j) {
            FD(radius);
            RT(360/edgeNum);
        }
        radius+=delta;
    }
}

- (void) paperTuan
{
    int num = 28;
    int radius = 3;
    int edgeNum = 11;
    int delta = 3;
    for (int i=0; i<num; ++i) {
        for (int j=0; j<edgeNum-4; ++j) {
            FD(radius);
            RT(360/edgeNum);
        }
        radius+=delta;
    }
}

// 正多边形螺旋线，可以绘制出类似3D的效果
// 15 edgeNum=9  alpha=4 ， 戒指
//
- (void) regularPolygonSpirals
{
    int num = 20;
    int edgeNum = 6;
    int edgeLen = 120;
    
    CGFloat angle = 360.0/edgeNum;
    CGFloat alpha = 50;             //  需要保证 alpha < 360/edgeNum
    CGFloat theta = 180.0 - angle;
    
    CGFloat alphaRadian = alpha * M_PI / 180.0;
    CGFloat thetaRadian = theta * M_PI / 180.0;
    
    PU; LT(90); BK(edgeLen/2); PD;
    
    CGFloat x = sin(alphaRadian);
    CGFloat y = sin(alphaRadian + thetaRadian);
    CGFloat proportion1 = sin(thetaRadian) / (x + y);
    CGFloat proportion2 = x / (x+y);
    
    
    for (int i=0; i<num; ++i) {
        for (int j=0; j<edgeNum; ++j) {
            FD(edgeLen);
            RT(angle);
        }
        PU;
        FD(edgeLen * proportion2 );
        RT(alpha);
        PD;
        edgeLen *= proportion1;
        
    }
}

@end
