//
//  NZProgressBarView.h
//  FireShadow
//
//  Created by 翁志方 on 15/8/5.
//  Copyright (c) 2015年 Yonglibao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZProgressBarView : UIView
{
    UIView *progressBar;
    
    CGFloat curProgressBarWidth;
    CGFloat progressBarWidth;
    
    CGFloat speed;
    NSTimer *animationTimer;
}


- (void)startAnimation;
- (void)endAnimation;
- (void)removeAnimation;


@end
