//
//  Canvas.h
//  LOGO
//
//  Created by 翁志方 on 15/3/8.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Turtle.h"



#define SharedCanvas [Canvas sharedInstance]

@interface Canvas : UIView
{
}

+ (Canvas *) sharedInstance;

@property (nonatomic, copy) NSString *controlStr;

// 绘制图案
- (void) drawPicture;

- (void) lotusFlower;       // 画莲花

- (void) flowerWithLeaf;    // 画大理花

- (void) chrysanthemum;      // 菊花

- (void) circleSquareCollimationError;  // 圆方视觉误差图形

- (void) sun;           // 太阳

- (void) windmill;      // 风车


@end



// 通过分类来分散实现的代码

@interface Canvas(PeanoCurve)       // peano曲线
- (void) peanoCurve;
@end


@interface Canvas(AboresentLung)    // 分形肺
- (void) aboresentLung;
@end


@interface Canvas(BinaryTree)       // 二叉树
- (void) binaryTree;
- (void) squareBinaryTree;
@end

@interface Canvas(SierpinskiTriangle)
- (void) sierpinskiTriangle;       

- (void) sierpinskiTriangleCurve;

@end


@interface Canvas(Spirals)          // 螺线

- (void) spirals;            // 普通半圆形螺线

- (void) goldenSplitSpirals; // 黄金分割螺线

- (void) polygonSpiral;          // 多边形螺旋线

- (void) regularPolygonSpirals;  // 正多边形螺旋线，类似3D的效果

@end


@interface Canvas(KochSnow)

- (void) kochSnowflakes;     // koch曲线 雪花

@end


@interface Canvas(IFS)      // 通过IFS码生成

- (void) ifsTreeBinary;         // 二叉树

- (void) ifsCurlyLeaf;          // 卷曲的叶子

- (void) ifsRightAngleSierpinskiTriangle;

- (void) ifsTree2;

- (void) ifsSpiral;

- (void) ifsCollageTree;

@end

@interface Canvas(Mandelbrot)

- (void) juliaSet;     // Julia集


@end


@interface Canvas (Path)

- (void) finishPayAnimation;

- (void) pathAnimation;

@end


@interface Canvas (UBER)

- (void) uberAnimation;

@end


@interface Canvas (Geometry)

- (void)picture99;

@end























