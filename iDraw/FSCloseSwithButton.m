//
//  FSCloseSwithButton.m
//  RRHua
//
//  Created by 翁志方 on 2016/11/3.
//  Copyright © 2016年 yangxiangwei. All rights reserved.
//

#import "FSCloseSwithButton.h"

CGFloat width = 54;
CGFloat height = 21;



@interface FSCloseSwithButton()
{
    int state;                  // 0=正常  1=再次点击清除
    
    CAShapeLayer *closeLayer;
    
    UILabel *qingLabel;
    UILabel *chuLabel;
    
    UIButton *screenBtn;
    UIButton *curBtn;
}


@end


@implementation FSCloseSwithButton


- (instancetype)init
{
    self = [super init];
 
    [self addTarget:self action:@selector(btnClked)];
    
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
    
    
    closeLayer.path = path;
    closeLayer.fillColor = [UIColor clearColor].CGColor;
    closeLayer.strokeColor = [UIColor blackColor].CGColor;
    
    [self.layer addSublayer:closeLayer];
    
    
    
    // 清除文字
    qingLabel = [UILabel new];
    qingLabel.text = @"清";
    qingLabel.font = [UIFont systemFontOfSize:16];
    qingLabel.textColor = [UIColor lightGrayColor];
    [qingLabel sizeToFit];
    qingLabel.hidden = YES;
    [self addSubview:qingLabel];
    
    chuLabel = [UILabel new];
    chuLabel.text = @"除";
    chuLabel.font = [UIFont systemFontOfSize:16];
    chuLabel.textColor = [UIColor lightGrayColor];
    [chuLabel sizeToFit];
    chuLabel.hidden = YES;
    [self addSubview:chuLabel];
    
    
    return self;
}

- (void)btnClked
{
    if (state == 0) {
        state = 1;
        
        // 滚动关闭按钮图层
        
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
