//
//  FSCloseSwithView.m
//  RRHua
//
//  Created by 翁志方 on 2016/11/3.
//  Copyright © 2016年 yangxiangwei. All rights reserved.
//

#import "FSCloseSwithView.h"



@interface FSCloseSwithView()<CAAnimationDelegate>
{
    int state;                  // 0=正常  1=再次点击清除
    
    CGFloat width;
    CGFloat height;
    CGFloat margin;
    
    CGFloat stickWith;
    
    CGFloat animationDuration;
    
    UIColor *backgroundColor;
    
    
    CAShapeLayer *closeLayer;
    UIView *closeView;
    
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
    
    // 全局参数配置
    width = 54;
    height = 21;
    margin = 8;
    
    stickWith = 10;
    
    animationDuration =1;
    
    backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    
    // 自身layout设置
    self.bounds = CGRectMake(0, 0, width, height);
    
    self.backgroundColor = [UIColor clearColor];
    
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = height/2.0;
    
    // 关闭X初始化
    CGFloat st = (height-stickWith)/2.0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, st, st);
    CGPathAddLineToPoint(path, nil, st+stickWith, st+stickWith);
    
    CGPathMoveToPoint(path, nil, st+stickWith, st);
    CGPathAddLineToPoint(path, nil, st, st+stickWith);
    
    
    closeLayer = [CAShapeLayer layer];
    closeLayer.frame = CGRectMake(0, 0, height, height);
    closeLayer.path = path;
    closeLayer.fillColor = [UIColor clearColor].CGColor;
    closeLayer.strokeColor = [UIColor blackColor].CGColor;
    
    
    closeView = [[UIView alloc] initWithFrame:CGRectMake(width-height, 0, height, height)];
    
    [closeView.layer addSublayer:closeLayer];
    [self addSubview:closeView];
    
    // 清除文字
    qingLabel = [UILabel new];
    qingLabel.text = @"清";
    qingLabel.textAlignment = NSTextAlignmentCenter;
    qingLabel.font = [UIFont systemFontOfSize:14];
    qingLabel.textColor = [UIColor blackColor];
    [qingLabel sizeToFit];
    qingLabel.alpha = 0;
    qingLabel.center = CGPointMake(width/2.0-margin, height/2);
    [self addSubview:qingLabel];
    
    chuLabel = [UILabel new];
    chuLabel.text = @"除";
    chuLabel.textAlignment = NSTextAlignmentCenter;
    chuLabel.font = [UIFont systemFontOfSize:14];
    chuLabel.textColor = [UIColor blackColor];
    [chuLabel sizeToFit];
    chuLabel.alpha = 0;
    chuLabel.center = CGPointMake(width/2 + width/4.0-margin/2.0, height/2);
    [self addSubview:chuLabel];
    
    
    // 关闭按钮
    button = [[UIButton alloc] initWithFrame:CGRectMake(width-height, 0, height, height)];
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = height/2.0;
    button.backgroundColor = backgroundColor;
    
    [button addTarget:self action:@selector(btnClked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return self;
}

- (void)btnClked
{
    CGPoint posEd = CGPointMake(width/2, height/2);
    
    if (state == 0) {
        state = 1;
        
        // 滚动关闭按钮图层
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            closeView.layer.position = posEd;
            closeView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        } completion:^(BOOL finished) {
            
        }];
        [UIView animateWithDuration:animationDuration/2 delay:animationDuration/2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            closeView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
        }];
        
        // 自身向左伸长
        [UIView animateWithDuration:animationDuration*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            button.frame = self.bounds;
        } completion:^(BOOL finished) {
            
        }];
        
        // 依次弹出清除文字
        qingLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
        chuLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        [UIView animateWithDuration:animationDuration*0.4 delay:animationDuration*0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            chuLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:animationDuration*0.4 delay:animationDuration*0.85 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            qingLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
        
        
        [UIView animateWithDuration:animationDuration delay:animationDuration*0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            chuLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
        [UIView animateWithDuration:animationDuration delay:animationDuration*0.85 options:UIViewAnimationOptionCurveEaseIn animations:^{
            qingLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
        
        
        // 添加点击全屏按钮退出
        [self addMaskButton];
    }else{
        
        // 执行
//        self.closeBlock();
        
        // 清除自身
 作用： 看清楚东西
        营造气氛，
        暖冷
        空间感
        

        
        
        
    }
}

- (void)cacel
{
    state = 0;
    
    CGPoint posSt = CGPointMake(width-height/2, height/2);
    
    // 滚动关闭按钮图层
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        closeView.layer.position = posSt;
        closeView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:animationDuration/2 delay:animationDuration/2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        closeView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
    }];
    
    // 自身向左伸长
    [UIView animateWithDuration:animationDuration*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button.frame = CGRectMake(width-height, 0, height, height);
    } completion:^(BOOL finished) {
        
    }];
    
    // 依次弹出清除文字
    qingLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
    chuLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [UIView animateWithDuration:animationDuration*0.4 delay:animationDuration*0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        chuLabel.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:animationDuration*0.4 delay:animationDuration*0.85 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        qingLabel.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    
    [UIView animateWithDuration:animationDuration delay:animationDuration*0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
        chuLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:animationDuration delay:animationDuration*0.85 options:UIViewAnimationOptionCurveEaseIn animations:^{
        qingLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    
    // 清除mask按钮
    [self removeMaskButton];
}

- (void)addMaskButton
{
    // 添加全屏取消手势
    screenBtn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [screenBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:screenBtn];
    
    // 覆盖当前按钮
    CGRect frame = [button convertRect:button.bounds toView:[UIApplication sharedApplication].keyWindow];
    curBtn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [curBtn addTarget:self action:@selector(btnClked) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:curBtn];
}

- (void)removeMaskButton
{
    [screenBtn removeFromSuperview];
    [curBtn removeFromSuperview];
    
    screenBtn = nil;
    curBtn = nil;
}

#pragma mark - AnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}





@end





