//
//  NZProgressBarView.m
//  FireShadow
//
//  Created by 翁志方 on 15/8/5.
//  Copyright (c) 2015年 Yonglibao. All rights reserved.
//

#import "NZProgressBarView.h"

@implementation NZProgressBarView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        progressBarWidth = frame.size.width;
        
        progressBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        progressBar.backgroundColor = UIColorWithHex(0x25b6ee);
        
        [self addSubview:progressBar];
    }
    return self;
}

- (void)startAnimation
{
    curProgressBarWidth = 0;
    
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
- (void)endAnimation
{
    if (animationTimer) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
    [UIView animateWithDuration:0.618 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        progressBar.frame = self.bounds;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)removeAnimation
{
    if (animationTimer) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
    [self removeFromSuperview];
}

- (void)timerAction
{
    CGFloat proportion = curProgressBarWidth / self.frame.size.width;
    // 进度控制
    if (proportion >= 0.9) {
        if (animationTimer) {
            [animationTimer invalidate];
            animationTimer = nil;
        }
    }else if (proportion > 0.6){
        speed = 1.6;
    }else if (proportion > 0.3){
        speed = 2;
    }else{
        speed = 2.5;
    }
    
    curProgressBarWidth += speed;
    
    CGRect frame = progressBar.frame;
    frame.size.width = curProgressBarWidth;
    progressBar.frame = frame;

}


@end
