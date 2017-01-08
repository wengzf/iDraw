//
//  LoadingCheckView.m
//  ForceSource
//
//  Created by 翁志方 on 2016/12/15.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "LoadingCheckView.h"

@implementation LoadingCheckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    // 支付宝对勾动画
    {
        NSMutableArray *stArr;
        NSMutableArray *edArr;
        
        stArr = [NSMutableArray arrayWithArray:@[@(0), @(0), @(0), @(0),
                                                 @(1.358364), @(2.757775), @(3.646883), @(4.317598),
                                                 @(5.149016), @(5.513171), @(5.706810), @(5.926966),
                                                 @(6.156213), @(6.220766), @(6.25), @(6.26)//,@(M_PI*2)
                                                 ]];
        
        edArr = [NSMutableArray arrayWithArray:@[@(0), @(0.908067), @(2.631104), @(3.663027),
                                                 @(4.937666), @(5.396684), @(5.689436), @(5.921982),
                                                 @(6.220766), @(6.26), @(M_PI*2), @(M_PI*2),
                                                 @(M_PI*2), @(M_PI*2), @(M_PI*2), @(M_PI*2)//,@(M_PI*2)
                                                 ]];
        
        NSMutableArray *timeArr = [NSMutableArray array];
        for (int i=0; i<stArr.count; ++i) {
            NSNumber *num = [NSNumber numberWithFloat:i/(double)(stArr.count-1)];
            [timeArr addObject:num];
            
            NSNumber *st = stArr[i];
            st = @([st doubleValue]/ M_PI/2.0);
            [stArr replaceObjectAtIndex:i withObject:st];
            
            NSNumber *ed = edArr[i];
            ed = @([ed doubleValue]/ M_PI/2.0);
            [edArr replaceObjectAtIndex:i withObject:ed];
        }
        
        checkView = [[UIView alloc] initWithFrame:CGRectMake(150, 230, 59, 59)];
        
        CGMutablePathRef pathCircle = CGPathCreateMutable();
        CGPathAddArc(pathCircle, nil, 30, 30, 30, -M_PI_2, M_PI_2+M_PI, NO);
        
        
        circleLayer = [CAShapeLayer layer];
        circleLayer.path = pathCircle;
        circleLayer.lineWidth = 4;
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = [UIColor colorWithRed:0 green:168/255.0 blue:232/255.0 alpha:1].CGColor;
        circleLayer.lineCap = kCALineCapRound;
        circleLayer.shadowColor = [UIColor lightGrayColor].CGColor;
        circleLayer.shadowRadius = 1;
        circleLayer.shadowOffset = CGSizeMake(-0.5, -0.5);
        circleLayer.shadowOpacity = 0.5;
        [checkView.layer addSublayer:circleLayer];
        
        // 添加动画
        CGFloat duration = 0;
        duration = 1.8;
        //        duration = 10;
        
        // 头部动画参数
        CAKeyframeAnimation *animationStart = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
        animationStart.duration = duration;
        animationStart.values = stArr;
        animationStart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animationStart.keyTimes = timeArr;
        animationStart.removedOnCompletion = NO;
        animationStart.fillMode = kCAFillModeBoth;
        animationStart.repeatCount = 2;
        
        [circleLayer addAnimation:animationStart forKey:nil];
        

        // 尾部动画参数
        CAKeyframeAnimation *animationEnd = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        animationEnd.duration = duration;
        animationEnd.values = edArr;
        animationEnd.keyTimes = timeArr;
        animationEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        animationEnd.repeatCount = 2;
        animationEnd.delegate = self;
        animationEnd.removedOnCompletion = NO;
        animationEnd.fillMode = kCAFillModeBoth;
        [circleLayer addAnimation:animationEnd forKey:nil];
        
        [self addSubview:checkView];
    }

    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 对勾动画
    {
        [circleLayer removeFromSuperlayer];
        
        CGFloat checkDuration = 0.5;
        // 结束绘制圆环
        {
            CGMutablePathRef finishCircle = CGPathCreateMutable();
            CGPathAddArc(finishCircle, nil, 30, 30, 30, -M_PI_2, M_PI_2+M_PI, NO);
            
            CAShapeLayer *checkCircleLayer = [CAShapeLayer layer];
            checkCircleLayer.path = finishCircle;
            checkCircleLayer.lineWidth = 4;
            checkCircleLayer.fillColor = [UIColor clearColor].CGColor;
            checkCircleLayer.strokeColor = [UIColor colorWithRed:0 green:168/255.0 blue:232/255.0 alpha:1].CGColor;
            checkCircleLayer.lineCap = kCALineCapRound;
            checkCircleLayer.shadowColor = [UIColor lightGrayColor].CGColor;
            checkCircleLayer.shadowRadius = 1;
            checkCircleLayer.shadowOffset = CGSizeMake(-0.5, -0.5);
            checkCircleLayer.shadowOpacity = 0.5;
            [checkView.layer addSublayer:checkCircleLayer];
            
            CAKeyframeAnimation *animationEnd = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
            animationEnd.duration = checkDuration;
            animationEnd.values = @[@(0),@(1)];
            //            animationEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            [checkCircleLayer addAnimation:animationEnd forKey:nil];
        }
        
        // 绘制对勾
        {
            // 对勾
            CGMutablePathRef checkPath = CGPathCreateMutable();
            CGPathMoveToPoint(checkPath, nil, 14, 30);
            CGPathAddLineToPoint(checkPath, nil, 28, 42);
            CGPathAddLineToPoint(checkPath, nil, 50, 17);
            
            CAShapeLayer *checkLayer = [CAShapeLayer layer];
            checkLayer.path = checkPath;
            checkLayer.lineWidth = 4;
            checkLayer.fillColor = [UIColor clearColor].CGColor;
            checkLayer.strokeColor = [UIColor colorWithRed:0 green:168/255.0 blue:232/255.0 alpha:1].CGColor;
            checkLayer.lineCap = kCALineCapRound;
            checkLayer.lineJoin = kCALineJoinRound;
            checkLayer.shadowColor = [UIColor lightGrayColor].CGColor;
            checkLayer.shadowRadius = 1;
            checkLayer.shadowOffset = CGSizeMake(-0.5, -0.5);
            checkLayer.shadowOpacity = 0.5;
            [checkView.layer addSublayer:checkLayer];
            
            CAKeyframeAnimation *checkAnimation= [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
            checkAnimation.beginTime = 0.35 + CACurrentMediaTime();
            checkAnimation.duration = checkDuration;
            checkAnimation.values = @[@(0), @(1), @(0.9)];
            checkAnimation.removedOnCompletion = NO;
            checkAnimation.fillMode = kCAFillModeBoth;
            checkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            [checkLayer addAnimation:checkAnimation forKey:nil];
        }
    }
}



@end
