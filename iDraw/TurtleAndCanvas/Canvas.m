//
//  Canvas.m
//  LOGO
//
//  Created by 翁志方 on 15/3/8.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"


@implementation Canvas


- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}



- (void) drawRect:(CGRect)rect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
        // 在这里使用海龟绘图 画一个正方形
        turtle = [[Turtle alloc] initWithView:self contextRef:contextRef];
    });
    
//    [self leafe];
    
    [self drawThreeSquare];
    
//    [self drawWindmill];
    
//    [self drawKochSnowflakes];                    // koch雪花
    
//    [self drawTriangleFractal];                   // 三角形分形
    
//    [self drawSierpinskiTriangleB:5 level:5];     // 信儿病死鸡 三角形
    
//    [self drawSpirals];               // 螺线
    
//    [self drawGoldenSplitSpirals];    // 黄金分割螺线
    
//    [self regularPolygonSpirals];       // 3d 正多边形螺线
    
//    [self drawPeanoCurve];    // peano曲线
    
//    [self drawBinaryTree];    // 二叉树 实心正方形
    
//    [self lotusFlower];     // 莲花

//    [self flowerWithLeaf];    // 带叶子的花朵
    
//    [self circleSquareCollimationError];   // 圆形正方形错觉
    
//    [self ninePolygon];                   // 九角星
    
//    [self windCircle];              // 风轮
    
//    [self chrysanthemum];       // 菊花
    
//    [self polygonSpiral];         // 多边形螺线
    
//    [self sunWithTildeNum:30];       // 太阳
    
//    [self aboresentLung];
}

// 绘制从中心旋转的5个圆
- (void) drawFiveCircle
{
    for (int i=0; i<5; ++i) {
        [turtle circleRadius:80];
        [turtle rt:72];
    }
}

// 绘制一片叶子
- (void) leafe
{
    [turtle circleArcWithRadius:80 angle:70];
    [turtle rt:110];
    [turtle circleArcWithRadius:80 angle:70];
}

// 绘制3个正方形 正方形内带弧形
- (void) drawThreeSquare
{
    CGFloat len = 80;
    for (int i=0; i<3; ++i) {
        [turtle regularPolygon:len edgeNum:4];
        
        [turtle fd: len/2 ];
        
        [turtle circleArcWithRadius:len/2 angle:180];
    
        [turtle rt:90];
        [turtle leftCircleArcWithRadius:len/2 angle:90];
        
        [turtle rt:180];
        
        [turtle leftCircleArcWithRadius:len/2 angle:90];

        [turtle rt:90];
        
        [turtle bk:len/2];
        
        [turtle rt:120];
    }
}

// 画一个7个叶子的风车
- (void) drawWindmill
{
    CGFloat len = 60;
    CGFloat len2 = 15;
    CGFloat len3 = 45;
    for (int i=0; i<7; ++i)
    {
        [turtle circleArcWithRadius:len angle:180];
        [turtle circleArcWithRadius:len2 angle:180];
        [turtle leftCircleArcWithRadius:len3 angle:180];
        [turtle rt:180];
        
        
        [turtle rt:360/7];
    }
}


// LOGO语言基本图形绘制


// 画莲花
- (void) lotusFlower
{
    int n = 9;
    CGFloat radius = 60;
    CGFloat leafAngle = 80;
    for (int i=0; i<n; ++i) {
        // 画叶子
        for (int j=0; j<2; ++j) {
            [turtle circleArcWithRadius:radius angle:leafAngle];
            RT(180-leafAngle);
        }
        
        RT(369/n);
    }
}
// 画大理花
- (void) flowerWithLeaf
{
    for (int i=0; i<12; ++i) {
        for (int j=0; j<12; ++j) {
            FD(10);
            RT(30);
        }
        RT(30);
    }
    [turtle penup];
    BK(37);
    [turtle pendown];
    
    BK(100);
    FD(70);
    
    RT(45);
    CGFloat radius = 60;
    CGFloat leafAngle = 60;
    for (int j=0; j<2; ++j) {
        [turtle circleArcWithRadius:radius angle:leafAngle];
        RT(180-leafAngle);
    }
    LT(90+leafAngle);
    for (int j=0; j<2; ++j) {
        [turtle circleArcWithRadius:radius angle:leafAngle];
        RT(180-leafAngle);
    }
    
}


// 圆方视觉误差图形
- (void) circleSquareCollimationError
{
    CGFloat radius = 30;
    CGFloat delta = 10;
    
    PU;
    LT(90);
    FD(radius);
    RT(90);
    PD;
    
    for (int i=0; i<10; ++i) {
        [turtle circleRadius:radius];
        radius+=delta;
        
        PU;
        LT(90);
        FD(delta);
        RT(90);
        PD;
    }
    
    PU;
    RT(90);
    FD(delta*2);
    LT(90 - 45);
    PD;
    
    CGFloat squareLen = (radius-delta*2)*sqrt(2);
    for (int i=0; i<4; ++i) {
        FD(squareLen);
        RT(90);
    }
}
// 平行线错觉  等待实现直接使用位置进行直线绘制函数的实现
- (void) parrelCollimationError
{
    
}



// 多角形绘制
// 角度的乘数k 必须和边数是互质的。
- (void) ninePolygon
{
    [turtle polygon:60 edgeNum:9 angle:3*40];
}

// 风轮
- (void) windCircle
{
    int num = 20;
    for (int i=0; i<num; ++i) {
        [turtle circleArcWithRadius:60 angle:120];
        PU;
        RT(180);
        [turtle leftCircleArcWithRadius:60 angle:120];
        LT(180-360/num);
        PD;
    }
}

// 菊花
- (void) chrysanthemum
{
    int num = 20;
    CGFloat radius = 50;
    [turtle setCurWidth:2];
    for (int i=0; i<num; ++i) {
        [turtle circleArcWithRadius:radius angle:120];
        
        LT(90);
        [turtle circleRadius:4];
        RT(90);
        
        PU;
        RT(180);
        [turtle leftCircleArcWithRadius:radius angle:120];
        LT(180-360/num);
        PD;
    }
}

// 太阳

// 波浪线
- (void) tildeWithRadius:(CGFloat) radius angle:(CGFloat) angle
{
    for (int i=0; i<2; ++i) {
        [turtle circleArcWithRadius:radius angle:angle];
        [turtle leftCircleArcWithRadius:radius angle:angle];
    }
}

- (void) sunWithTildeNum:(int) num
{
    for (int i=0; i<num; ++i) {
        SAVE;
        [self tildeWithRadius:60 angle:30];
        RESTORE;
        RT(360/num);
    }

    
}






@end
