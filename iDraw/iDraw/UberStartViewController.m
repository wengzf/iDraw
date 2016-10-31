//
//  UberStartViewController.m
//  iDraw
//
//  Created by 翁志方 on 2016/10/31.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "UberStartViewController.h"

CGFloat radius = 15;
CGFloat diameter = 30;

UIColor *wideColor;
UIColor *thinColor;

const CGFloat wideWidth = 1.75;
const CGFloat thinWidth = 0.75;


@interface UberStartViewController ()
{
    NSTimer *generateTimer;             // 定时器，每秒定时生成随机路径
}
@end

@implementation UberStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 颜色初始化
    wideColor = [UIColor colorWithRed:157/255.0 green:20/255.0 blue:20/255.0 alpha:1];
    thinColor = [UIColor colorWithRed:150/255.0 green:16/255.0 blue:16/255.0 alpha:1];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    // 背景绘制
    [self initCanvas];
    
    // 路径动画
    [self uberPathAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCanvas
{
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:136.0/255 green:0 blue:0 alpha:1.0];
    
    // 绘制背景图片
    CGFloat proportion = ScreenWidth/320.0;
    radius *= proportion;
    diameter *= proportion;
    
    // 水平边界 offset = radius/3;
    // 竖直边界 offset = radius/2;
    // 一个基本单位 radius*3
    
    CGFloat sx = -radius/3 + diameter;
    CGFloat sy = -radius/2;
    
    // 偶数位线
    for (int k=0; k<4; ++k) {
        
        // 绘制粗线
        DRAW
        MOVETOXY(sx, sy);
        RT(180)
        for (int j=0; j<8; ++j) {
            FD(diameter)
            LT90
            ARC(radius, 180)
            
            SAVE
            RT90
            ARC(radius, 180)
            RESTORE
            
            LT90
            ARC(radius, 180)
            RESTORE
            
            LARC(radius, 180)
            RT90
        }
        CAShapeLayer *wideLayer = [[CAShapeLayer alloc] initWithLayer:self.view.layer];
        wideLayer.strokeColor =  wideColor.CGColor;
        wideLayer.lineWidth = wideWidth;
        wideLayer.fillColor = [UIColor clearColor].CGColor;
        wideLayer.path = TURTLE.shapePath;
        [self.view.layer addSublayer:wideLayer];
        
        // 绘制细线
        DRAW
        MOVETOXY(sx, sy);
        RT(180)
        for (int j=0; j<8; ++j) {
            PU FD(radius) RT90  FD(radius)  PD
            BK(diameter)
            PU FD(radius) LT90  FD(radius) PD
            RT90
            LARC(radius, 180)
            
            SAVE
            LT90
            LARC(radius, 180)
            RESTORE
            
            RT90
            LARC(radius, 180)
            RT90
            FD(diameter)
            RESTORE
            
            ARC(radius, 180)
            LT90
        }
        
        CAShapeLayer *thinLayer = [CAShapeLayer layer];
        thinLayer.strokeColor =  thinColor.CGColor;
        thinLayer.lineWidth = thinWidth;
        thinLayer.fillColor = [UIColor clearColor].CGColor;
        thinLayer.path = TURTLE.shapePath;
        [self.view.layer addSublayer:thinLayer];
        
        sx += diameter*3;
    }
    
    
    // 奇数位
    sx = -radius/3 - radius;
    sy = -radius/2 - 3*radius;
    
    for (int k=0; k<5; ++k) {
        
        // 绘制细线
        DRAW
        MOVETOXY(sx, sy);
        RT(180)
        for (int j=0; j<8; ++j) {
            PU FD(radius) RT90  FD(radius)  PD
            BK(diameter)
            PU FD(radius) LT90  FD(radius) PD
            
            LT90
            ARC(radius, 180)
            
            SAVE
            RT90
            ARC(radius, 180)
            RESTORE
            
            LT90
            ARC(radius, 180)
            RESTORE
            
            LARC(radius, 180)
            RT90
        }
        CAShapeLayer *thinLayer = [CAShapeLayer layer];
        thinLayer.strokeColor =  thinColor.CGColor;
        thinLayer.lineWidth = thinWidth;
        thinLayer.fillColor = [UIColor clearColor].CGColor;
        thinLayer.path = TURTLE.shapePath;
        [self.view.layer addSublayer:thinLayer];
        
        // 绘制粗线
        DRAW
        MOVETOXY(sx, sy);
        RT(180)
        for (int j=0; j<8; ++j) {
            
            FD(diameter)
            RT90
            LARC(radius, 180)
            
            SAVE
            LT90
            LARC(radius, 180)
            RESTORE
            
            RT90
            LARC(radius, 180)
            RT90
            FD(diameter)
            RESTORE
            
            ARC(radius, 180)
            LT90
        }
        CAShapeLayer *wideLayer = [[CAShapeLayer alloc] initWithLayer:self.view.layer];
        wideLayer.strokeColor =  wideColor.CGColor;
        wideLayer.lineWidth = wideWidth;
        wideLayer.fillColor = [UIColor clearColor].CGColor;
        wideLayer.path = TURTLE.shapePath;
        [self.view.layer addSublayer:wideLayer];
        
        sx += diameter*3;
    }
    
    
}
- (void)uberPathAnimation
{
    // 首个2~4秒， 后面都是在 0~3秒内随机生成
    
    
    generateTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:<#(BOOL)#> block:<#^(NSTimer * _Nonnull timer)block#>];
    
    
    //        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //        animation.duration = 10;
    //        animation.fromValue = @0;
    //        animation.toValue = @1;
    //        [wideLayer addAnimation:animation forKey:nil];
    
    
    //
    //        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //        animation1.duration = 10;
    //        animation1.fromValue = @0;
    //        animation1.toValue = @1;
    //        animation1.beginTime = CACurrentMediaTime()+10;
    //        [thinLayer addAnimation:animation1 forKey:nil];
}

@end
