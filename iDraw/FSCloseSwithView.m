//
//  FSCloseSwithView.m
//  RRHua
//
//  Created by 翁志方 on 2016/11/3.
//  Copyright © 2016年 yangxiangwei. All rights reserved.
//

#import "FSCloseSwithView.h"

CGFloat width = 54;
CGFloat height = 21;
CGFloat margin = 8;

@interface FSCloseSwithView()
{
    int state;                  // 0=正常  1=再次点击清除
    
    CAShapeLayer *closeLayer;
    
    UILabel *qingLabel;
    UILabel *chuLabel;
    
    UIButton *screenBtn;
    UIButton *curBtn;
    
    UIButton *button;
}
@end


@implementation FSCloseSwithView


- (instancetype)init
{
    self = [super init];
    
    // 自身layout设置
    self.bounds = CGRectMake(0, 0, width, height);
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = height/2.0;
    
    // 关闭X初始化
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddLineToPoint(path, nil, 10, 10);
    
    CGPathMoveToPoint(path, nil, 10, 0);
    CGPathAddLineToPoint(path, nil, 0, 10);
    
    closeLayer.frame = CGRectMake(width-height, 0, height, height);
    closeLayer.path = path;
    closeLayer.fillColor = [UIColor clearColor].CGColor;
    closeLayer.strokeColor = [UIColor blackColor].CGColor;
    
    [self.layer addSublayer:closeLayer];
    
    // 清除文字
    qingLabel = [UILabel new];
    qingLabel.text = @"清";
    qingLabel.textAlignment = NSTextAlignmentCenter;
    qingLabel.font = [UIFont systemFontOfSize:16];
    qingLabel.textColor = [UIColor lightGrayColor];
    [qingLabel sizeToFit];
    qingLabel.hidden = YES;
    qingLabel.center = CGPointMake(width/2.0-margin, height/2);
    [self addSubview:qingLabel];
    
    chuLabel = [UILabel new];
    chuLabel.text = @"除";
    chuLabel.textAlignment = NSTextAlignmentCenter;
    chuLabel.font = [UIFont systemFontOfSize:16];
    chuLabel.textColor = [UIColor lightGrayColor];
    [chuLabel sizeToFit];
    chuLabel.hidden = YES;
    qingLabel.center = CGPointMake(width/2 + width/4.0-margin/2.0, height/2);
    [self addSubview:chuLabel];
    
    
    // 关闭按钮
    button = [[UIButton alloc] initWithFrame:CGRectMake(width-height, 0, height, height)];
    [button addTarget:self action:@selector(btnClked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return self;
}

- (void)btnClked
{
    if (state == 0) {
        state = 1;
        
        // 滚动关闭按钮图层
        
        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
        animation1.duration = 0.15;
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
        
        
        
        // 自身向左伸长
        CGRect frame = self.frame;
        frame.origin.x -= width-height;
        frame.size.width = width;
        self.bounds = frame;
        
        // 依次弹出清除文字
        [self addMaskButton];
    }else{
        
        // 执行
        self.closeBlock();
        
        // 清除自身
        
    }
}

- (void)cacel
{
    state = 0;
    
    // 清除文字消失
    
    
    // 自身向右变短
    self.bounds = CGRectMake(0, 0, 54, 21);
    
    // 关闭X滚动出现
    
    
}

- (void)addMaskButton
{
    // 添加全屏取消手势
    screenBtn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [screenBtn addTarget:self action:@selector(cancel)];
    [[UIApplication sharedApplication].keyWindow addSubview:screenBtn];
    
    // 覆盖当前按钮
    curBtn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [screenBtn addTarget:self action:@selector(btnClked)];
    [[UIApplication sharedApplication].keyWindow addSubview:screenBtn];
}

- (void)removeMaskButton
{
    [screenBtn removeFromSuperview];
    [curBtn removeFromSuperview];
    
    screenBtn = nil;
    curBtn = nil;
}





@end





