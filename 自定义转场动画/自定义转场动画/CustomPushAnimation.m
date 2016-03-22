//
//  CustomPushAnimation.m
//  自定义转场动画
//
//  Created by 翁志方 on 16/3/22.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "CustomPushAnimation.h"

@implementation CustomPushAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    [[transitionContext containerView] insertSubview:toVC.view aboveSubview:fromVC.view];
    
    // 自定义动画
    toVC.view.transform = CGAffineTransformMakeTranslation(320, 568);
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                              fromVC.view.transform = CGAffineTransformMakeTranslation(-320, -568);
                              toVC.view.transform = CGAffineTransformIdentity;
                           } completion:^(BOOL finished) {
//                               fromVC.view.transform = CGAffineTransformIdentity;
                               [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                          }];
}

@end
