//
//  Canvas.h
//  LOGO
//
//  Created by 翁志方 on 15/3/8.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Turtle.h"



#define RADIAN(x) ((x)*M_PI/180.0)

#define FD(len) [turtle fd:len]
#define BK(len) [turtle bk:len]

#define RT(angle) [turtle rt:angle]
#define LT(angle) [turtle lt:angle]

#define PU [turtle penup]
#define PD [turtle pendown]

#define SAVE [turtle savePosState]
#define RESTORE [turtle restorePosState]


@interface Canvas : UIView
{
    Turtle *turtle;
}

@end



// 通过分类来分散实现的代码

@interface Canvas(PeanoCurve)       // peano曲线
- (void) drawPeanoCurve;
@end


@interface Canvas(AboresentLung)    // 分形肺
- (void) aboresentLung;
@end


@interface Canvas(BinaryTree)       // 二叉树
- (void) drawBinaryTree;
@end



@interface Canvas(Spirals)          // 螺线

- (void) drawSpirals;            // 普通半圆形螺线

- (void) drawGoldenSplitSpirals; // 黄金分割螺线

- (void) polygonSpiral;          // 多边形螺旋线

- (void) regularPolygonSpirals;  // 正多边形螺旋线，类似3D的效果

@end


@interface Canvas(KochSnow)

- (void) drawKochSnowflakes;     // koch曲线 雪花

@end
