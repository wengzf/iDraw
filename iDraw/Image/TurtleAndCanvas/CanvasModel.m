//
//  CanvasModel.m
//  iDraw
//
//  Created by 翁志方 on 2016/10/28.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "CanvasModel.h"

@implementation CanvasModel

- (CanvasModel *)shareInstance
{
    static CanvasModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[CanvasModel alloc] init];
    });
    return model;
}

- (instancetype)init
{
    self = [super init];
    
    _keyFunctionDic = @{};
    
    
    
//    sectionNamesArr = @[@"花卉", @"错觉", @"螺线", @"IFS", @"路径",@"其它"];
//    
//    rowNameWithSectionArr = @[@[@"莲花", @"菊花", @"大理花"],
//                              @[@"圆形正方形错觉"],
//                              @[@"普通螺线", @"多边形螺线", @"黄金分割螺线", @"正多边形螺线"],
//                              @[@"IFSSierpinski", @"IFS拼贴树", @"IFS螺旋", @"IFS羊齿叶", @"IFS二叉树"],
//                              @[@"支付宝完成动画", @"路径",@"优步启动页动画"],
//                              @[@"太阳", @"团锦" ],
//                              ];
//    
//    // 对应的函数名称
//    
//    
//    sectionNamesArr = @[@"树", @"三角形", @"曲线", @"Mandelbrot集"];
//    
//    rowNameWithSectionArr = @[@[@"线条二叉树", @"正方形二叉树"],
//                              @[@"Sierpinski三角形", @"Sierpinski三角形曲线", @"aboresent肺"],
//                              @[@"peano曲线", @"Koch雪花"],
//                              @[@"Mandelbrot集", @"Julia集" ]
//                              ];
//}


    return self;
}


@end
