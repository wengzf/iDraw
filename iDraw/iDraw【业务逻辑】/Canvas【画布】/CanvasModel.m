//
//  CanvasModel.m
//  iDraw
//
//  Created by 翁志方 on 2016/10/28.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "CanvasModel.h"

@implementation CanvasModel

+ (CanvasModel *)shareInstance
{
    static CanvasModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        model = [[CanvasModel alloc] init];
    });
    return model;
}

- (instancetype)init
{
    self = [super init];
    
    _keyFunctionDic =
    @{
      @"莲花":
          @"lotusFlower",
      
      @"菊花":
          @"chrysanthemum",
      
      @"大理花":
          @"flowerWithLeaf",
      
      @"圆形正方形错觉":
          @"circleSquareCollimationError",
      
      @"普通螺线":
          @"spirals",
      
      @"多边形螺线":
          @"polygonSpiral",
      
      @"黄金分割螺线":
          @"goldenSplitSpirals",
      
      @"正多边形螺线":
          @"regularPolygonSpirals",
      
      @"太阳":
          @"sun",
      
      @"团锦":
          @"tuanJin",
      
      @"支付宝完成动画":
          @"finishPayAnimation",
      
      @"路径":
          @"pathAnimation",
      
      @"优步启动页":
          @"uberAnimation",
      
      @"线条二叉树":
          @"binaryTree",
      
      @"正方形二叉树":
          @"squareBinaryTree",
      
      @"Sierpinski三角形":
          @"sierpinskiTriangle",
      
      @"Sierpinski三角形曲线":
          @"sierpinskiTriangleCurve",
      
      @"aboresent肺":
          @"aboresentLung",
      
      @"peano曲线":
          @"peanoCurve",
      
      @"Koch雪花":
          @"kochSnowflakes",
      
      @"Mandelbrot集":
          @"",
      
      @"Julia集":
          @"juliaSet",
      
      @"IFS拼贴树":
          @"ifsCollageTree",
      
      @"IFS螺旋":
          @"ifsSpiral",
      
      @"IFS羊齿叶":
          @"ifsCurlyLeaf",
      
      @"IFS二叉树":
          @"ifsTreeBinary",
      
      @"IFSSierpinski":
          @"ifsRightAngleSierpinskiTriangle"};
    
    return self;
}

- (NSString *)selectorNameForKey:(NSString *)key
{
    NSString *str = _keyFunctionDic[key];
    return str;
}


@end
