//
//  Canvas+Path.m
//  iDraw
//
//  Created by 翁志方 on 15/9/17.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

/*
 * 仿写的路径动画
 */


#define T(x) ((x)*unitWidth)
#define TX(x) ((x)*unitWidth + leftMargin)
#define TY(x) ((x)*unitWidth + topMargin)

#define M3 sqrt(3)


CGFloat leftMargin;
CGFloat topMargin;

CGFloat unitWidth;

CGFloat animationDuration;

CGFloat largeRadius;
CGFloat middleRadius;
CGFloat smallRadius;

CGFloat radiusOffset;


CAShapeLayer *shapeLayer1;
CAShapeLayer *shapeLayer2;
CAShapeLayer *shapeLayer3;
CAShapeLayer *shapeLayer4;

CAShapeLayer *shapeLayer5;
CAShapeLayer *shapeLayer6;


@implementation Canvas (Path)

// LOGO语言基本图形绘制

#pragma mark - 支付宝完成支付时动画

- (void) finishPayAnimation
{
    
}

#pragma mark - 科技感动画
- (void) pathAnimation
{
    // 根据屏幕大小进行适配
    leftMargin = ScreenWidth/24 * 2 + 30;
    topMargin = 200;
    
    unitWidth = ScreenWidth/24;
    
    
    // 首先绘制交叉网格点
    {
        for (int i=0; i<10; ++i) {
            // 横线
            MOVETO(CGPointMake(leftMargin-unitWidth, topMargin+unitWidth*i));
            LINETO(CGPointMake(leftMargin+unitWidth*18, topMargin+unitWidth*i));
            
            
            UILabel *label = [[UILabel alloc] init];
            label.text = [@(i) stringValue];
            label.font = [UIFont systemFontOfSize:9 weight:0.5];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            
            [label sizeToFit];
            
            
            label.center = CGPointMake(leftMargin-2.5*unitWidth, topMargin+unitWidth*i);
        }
        
        // 然后绘制竖线
        for (int i=0; i<18; ++i) {
            
            MOVETO(CGPointMake(leftMargin+unitWidth*i, topMargin-unitWidth));
            LINETO(CGPointMake(leftMargin+unitWidth*i, topMargin+unitWidth*10));
            
            UILabel *label = [[UILabel alloc] init];
            label.text = [@(i) stringValue];
            label.font = [UIFont systemFontOfSize:9 weight:0.5];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            
            [label sizeToFit];
            
            label.center = CGPointMake(leftMargin+unitWidth*i, topMargin-unitWidth*2.5);
        }
        
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] initWithLayer:self.layer];
        
        shapeLayer.path = TURTLE.shapePath;
        
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        shapeLayer.lineWidth = 1;
        
        [self.layer addSublayer:shapeLayer];
    }
    
    animationDuration = 4;
    
    largeRadius = unitWidth*2;
    middleRadius = unitWidth;
    smallRadius = unitWidth/2;
    
    radiusOffset = unitWidth/5.0;
    
    // 图层初始化
    {
        shapeLayer1 = [CAShapeLayer layer];
        shapeLayer2 = [CAShapeLayer layer];
        shapeLayer3 = [CAShapeLayer layer];
        shapeLayer4 = [CAShapeLayer layer];
        shapeLayer5 = [CAShapeLayer layer];
        shapeLayer6 = [CAShapeLayer layer];
    }
    
    // 绘制圆圈
    {
        // 绘制出所有的路径动画部分
        // 大圆半径  2*r
        // 小圆半径  r/2
        
        // 半圆
        // 每个圆的圆心和对应的角度
        
        DRAWINVIEW(self);
        // 1. (2.1, 0) 右
        // 7. (2.1, 17.5) 左
        // 8. (6.4, 17.5) 左
        MOVETOXY(TX(0), TY(2.1) - largeRadius);
        RT(90);
        ARC(largeRadius, 180);
        
        MOVETOXY(TX(17.5), TY(2.1) - largeRadius );
        TURNTO(180);
        LARC(largeRadius, 180);
        
        MOVETOXY(TX(17.5), TY(6.9) - largeRadius);
        TURNTO(180);
        LARC(largeRadius, 180);
        
        // 2，3，5，6，9，10 小
        // 2(0.6, 3)
        // 3(0.6, 6.5)
        // 5(0.6, 12)
        // 6(0.6, 15)
        // 9(8.4, 12.5)
        // 10(8.4, 15)
        MOVETOXY(TX(3), TY(0.6) - smallRadius );
        TURNTO(180);
        LARC(smallRadius, 360);
        
        MOVETOXY(TX(6.5), TY(0.6) - smallRadius);
        TURNTO(180);
        LARC(smallRadius, 360);
        
        MOVETOXY(TX(12), TY(0.6) - smallRadius );
        TURNTO(180);
        LARC(smallRadius, 360);
        
        MOVETOXY(TX(15), TY(0.6) - smallRadius);
        TURNTO(180);
        LARC(smallRadius, 360);
        
        MOVETOXY(TX(12.5), TY(8.4) - smallRadius );
        TURNTO(180);
        LARC(smallRadius, 360);
        
        MOVETOXY(TX(15), TY(8.4) - smallRadius);
        TURNTO(180);
        LARC(smallRadius, 360);
        
        // 12， 13中          middleRadius
        // 12（7.9 ,3）
        // 12（7.9 ,6）
        MOVETOXY(TX(3), TY(7.9) - middleRadius );
        TURNTO(180);
        LARC(middleRadius, 360);
        
        MOVETOXY(TX(6), TY(7.9) - middleRadius);
        TURNTO(180);
        LARC(middleRadius, 360);
        
        // 4, 11 大
        // 4 (9,2.1)
        // 11 (9, 6.9)
        MOVETOXY(TX(9), TY(2.1) - largeRadius );
        TURNTO(180);
        LARC(largeRadius, 360);
        
        MOVETOXY(TX(9), TY(6.9) - largeRadius);
        TURNTO(180);
        LARC(largeRadius, 360);
        
        // 图层
        CAShapeLayer *shapeLayer;
        
        shapeLayer = [self newShapeLayer];
        shapeLayer.path = TURTLE.shapePath;
        
        shapeLayer = [self newShapeLayer];
        shapeLayer.path = [self path1];
        
        shapeLayer = [self newShapeLayer];
        shapeLayer.path =  [self path2];
        
        shapeLayer = [self newShapeLayer];
        shapeLayer.path = [self path3];
        
        shapeLayer = [self newShapeLayer];
        shapeLayer.path = [self path4];
    }
    
    // 路径1
    {
        shapeLayer1.path = [self path1];
        [self addAnimationWithLayer:shapeLayer1];
    }
    
    // 路径2
    {
        shapeLayer2.path = [self path2];
        [self addAnimationWithLayer:shapeLayer2];
    }
    
    // 路径3
    {
        shapeLayer3.path = [self path3];
        [self addAnimationWithLayer:shapeLayer3];
    }
    
    // 路径4
    {
        shapeLayer4.path = [self path4];
        [self addAnimationWithLayer:shapeLayer4];
    }
    // 实现动画
}

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [shapeLayer1 removeFromSuperlayer];
    [shapeLayer2 removeFromSuperlayer];
    [shapeLayer3 removeFromSuperlayer];
    [shapeLayer4 removeFromSuperlayer];
    [shapeLayer5 removeFromSuperlayer];
    [shapeLayer6 removeFromSuperlayer];
}

- (void) addAnimationWithLayer:(CAShapeLayer *) shapeLayer
{
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 1.5;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.duration = animationDuration;
    animation1.fromValue = @0;
    animation1.toValue = @0.7;
    animation1.repeatCount = 100;
    [shapeLayer addAnimation:animation1 forKey:nil];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.duration = animationDuration;
    animation2.fromValue = @0.3;
    animation2.toValue = @1;
    animation2.delegate = self;
    animation2.repeatCount = 100;
    [shapeLayer addAnimation:animation2 forKey:nil];
    
    [self.layer addSublayer:shapeLayer];
}

- (CGPathRef) path1
{
    DRAWINVIEW(self)
    
    MOVETOXY(TX(0), TY(0))
    RT90
    FD(T(3))
    
    RT90
    FD(T(0.1))
    RT90
    LARC(smallRadius, 120);
    FD(T(sqrt(3)/2+3.5))
    LT(120)
    FD(T(sqrt(3)/2+3.5))
    LARC(smallRadius, 120);
    RT90
    FD(T(0.1))
    RT90
    
    FD(T(5.5))
    
    RT90
    FD(T(0.1))
    RT90
    LARC(smallRadius, 120);
    FD(T(sqrt(3)/2+3))
    LT(120)
    FD(T(sqrt(3)/2+3))
    LARC(smallRadius, 120);
    RT90
    FD(T(0.1))
    RT90
    
    FD(T(3))
    return TURTLE.shapePath;
}

- (CGPathRef) path2
{
    DRAWINVIEW(self)
    
    MOVETOXY(TX(17), TY(0))
    RT90
    FD(T(0.5))
    
    RT90
    FD(T(0.1))
    RT90
    LARC(largeRadius, 60)
    FD(T( 3.4/cos(RADIAN(30)) ) )
    LT(60)
    FD(T( 3.4/cos(RADIAN(30)) ) )
    LARC(largeRadius, 60);
    RT90
    FD(T(0.1))
    RT90
    
    FD(T(2.5))
    
    RT90
    FD(T(0.1))
    RT90
    LARC(smallRadius, 120);
    FD(T(sqrt(3)/2+2.5))
    LT(120)
    FD(T(sqrt(3)/2+2.5))
    LARC(smallRadius, 120);
    RT90
    FD(T(0.1))
    RT90
    
    FD(T(3.5))
    
    RT90
    FD(T(0.1))
    LT90
    ARC(largeRadius, 180);
    LT90
    FD(T(0.8))
    LT90
    ARC(largeRadius, 181);
    LT90
    FD(T(1.2))
    
    return TURTLE.shapePath;
}
- (CGPathRef) path3
{
    DRAWINVIEW(self)
    
    MOVETOXY(TX(9), TY(10))
    FD(T(1.1))
    
    RT90
    LARC(largeRadius, 60)
    FD(T( 3.4/cos(RADIAN(30)) ) )
    LT(60)
    FD(T( 3.4/cos(RADIAN(30)) ) )
    LARC(largeRadius, 120);
    
    FD(T(2*( 2+ 2-sqrt(3)) ))
    
    LT(30)
    FD(T(2.85))
    
    
    LARC(middleRadius, 90);
    RT90
    FD(T(0.1))
    
    RT90
    FD(T(7))
    
    return TURTLE.shapePath;
}
- (CGPathRef) path4
{
    DRAWINVIEW(self)
    
    MOVETOXY(TX(-1), TY(9))
    RT90
    FD(T(4))
    
    LT90
    FD(T(0.1))
    RT90
    LARC(middleRadius, 90)
    FD(T( 6.8 - M3*(4-M3)) )
    LT(30)
    FD(T( 2*(4-M3)) )
    LARC(largeRadius, 60);
    
    RT90
    FD(T(0.1))
    
    
    LT90
    FD(T(1))
    
    return TURTLE.shapePath;
}

- (CAShapeLayer *) newShapeLayer
{
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] initWithLayer:self.layer];
    
    shapeLayer.path = TURTLE.shapePath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.lineWidth = 1;
    
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}


@end
