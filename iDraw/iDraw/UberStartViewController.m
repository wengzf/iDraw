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
    
    CGFloat animationDuration;
}
@end

@implementation UberStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 颜色初始化
    wideColor = [UIColor colorWithRed:157/255.0 green:20/255.0 blue:20/255.0 alpha:1];
    thinColor = [UIColor colorWithRed:150/255.0 green:16/255.0 blue:16/255.0 alpha:1];
    
    animationDuration = 60;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    // 背景绘制
    [self initCanvas];
    
    // 路径动画
    [self uberPathAnimation];
    
    [self generateUberPath];
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
    
    
//    generateTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 repeats:<#(BOOL)#> block:<#^(NSTimer * _Nonnull timer)block#>];
    
    
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
- (void)generateUberPath
{
    // 0xFFFF
    
    // 0xFFFF
    // 使用8进制表示法表示4个象限的12种路线走法
    
    
    NSArray *arr1 = @[@"010001000100", @"000000000000", @"001000010011",
                      @"000000000000", @"000010011001", @"000000000000" ];
    
    NSArray *arr2 = @[@"100100100100", @"001000100010", @"000000000000",
                      @"011011011011", @"000000000000", @"100010001000" ];
    
    NSArray *arr3 = @[@"000100010001", @"000000000000", @"011001000010",
                      @"000000000000", @"010011001000", @"000000000000" ];
    
    NSArray *arr4 = @[@"000000000000", @"000010011001", @"000000000000",
                      @"010001000100", @"000000000000", @"001000010011" ];
    
    NSArray *arr5 = @[@"011011011011", @"000000000000", @"100010001000",
                      @"100100100100", @"001000100010", @"000000000000" ];
    
    NSArray *arr6 = @[@"000000000000", @"010011001000", @"000000000000",
                      @"000100010001", @"000000000000", @"011001000010" ];
    
    NSArray *arr = @[arr1, arr2, arr3, arr4, arr5, arr6];
    
    // 每种走法之后对应的角度
    int inAngleArr[] = {0, 0, 90,         90, 90, 180,
                          180, 180, 270,    270, 270, 0};
    
    int outAngleArr[] = {  0,  90,  0,     90, 180,  90,
                           180, 270, 180,   270,   0, 270};
    
    
    
    CGFloat sx = -radius/3 - radius + 3*diameter + 3*diameter;
    CGFloat sy = -radius/2 - 3*radius + 6*diameter + 3*diameter;
    
    int curx = 0;
    int cury = 0;
    
    int preAngle = -1;
    
    // 给出任意一点，根据当前所在位置进行选择
    // 考虑当前角度，只需要保证不从老的角度进来就好
    DRAW
    MOVETOXY(sx, sy)
    for (int i=0; i<80; ++i) {
        NSString *str = arr[curx][cury];
        
        int cnt = 0;
        int chooseIndexs[8];
        for (int j=0; j<str.length; ++j) {
            unichar ch = [str characterAtIndex:j];
            if (ch == '1') {
                int inAngle = inAngleArr[j];
                
                if (preAngle==-1) {
                    chooseIndexs[cnt++] = j;
                }else{
                    int angleDis = abs(inAngle-preAngle);
                    if (angleDis>180) {
                        angleDis = 360-angleDis;
                    }
                    if (angleDis <= 135) {
                        chooseIndexs[cnt++] = j;
                    }
                }
            }
        }
        
        // 在几个选择中挑选出一个角度出来
        if (cnt!=0) {
            int idx = chooseIndexs[arc4random()%cnt];
            
            TURNTO(inAngleArr[idx])
        
            preAngle = outAngleArr[idx];
            
            // 移动路径，移动当前位置
            if (idx == 0  || idx == 3  || idx == 6  || idx == 9 ) {
                FD(radius)
            }else if (idx == 1  || idx == 4  || idx == 7  || idx == 10 ) {
                LARC(radius, 90)
            }else if (idx == 2  || idx == 5  || idx == 8  || idx == 11 ) {
                ARC(radius, 90)
            }
            
            if (idx == 0) {
                ++cury;
            }else if (idx == 1) {
                --curx; ++cury;
            }else if (idx == 2) {
                --curx; ++cury;
                
            }else if (idx == 3) {
                --curx;
            }else if (idx == 4) {
                --curx; --cury;
            }else if (idx == 5) {
                --curx; --cury;
                
            }else if (idx == 6) {
                --cury;
            }else if (idx == 7) {
                ++curx; --cury;
            }else if (idx == 8) {
                ++curx; --cury;
                
            }else if (idx == 9) {
                ++curx;
            }else if (idx == 10) {
                ++curx; ++cury;
            }else if (idx == 11) {
                ++curx; ++cury;
            }
            curx = (curx+6)%6;
            cury = (cury+6)%6;
        }
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = TURTLE.shapePath;
    
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 1.5;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.duration = animationDuration;
    animation1.fromValue = @0;
    animation1.toValue = @0.95;
    animation1.repeatCount = 100;
    [shapeLayer addAnimation:animation1 forKey:nil];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.duration = animationDuration;
    animation2.fromValue = @0.05;
    animation2.toValue = @1;
    animation2.delegate = self;
    animation2.repeatCount = 100;
    [shapeLayer addAnimation:animation2 forKey:nil];
    
    [self.view.layer addSublayer:shapeLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    
    
    []
    
    // 变速
    
    // 先慢后快   先粗后细   先深后淡
    
    
}

@end
