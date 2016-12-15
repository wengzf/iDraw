//
//  MovingArrow.m
//  ForceSource
//
//  Created by 翁志方 on 16/3/8.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import "MovingArrow.h"

@implementation MovingArrow


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self arrowInit];
    }
    return self;
}

- (void)arrowInit
{
    CGFloat wid = self.bounds.size.width/2;
    CGFloat height = 20;
    
    
    layer1 = [CAShapeLayer layer];
    layer1.fillColor = [UIColor colorWithRed:1.0 green:183/255.0 blue:50/255.0 alpha:1.0].CGColor;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil,    wid, height);
    CGPathAddLineToPoint(path, nil, wid-10, height+18);
    CGPathAddLineToPoint(path, nil, wid, height+14);
    CGPathAddLineToPoint(path, nil, wid+10, height+18);
    CGPathAddLineToPoint(path, nil, wid, height);
    layer1.path = path;
    layer1.zPosition = 2;
    [self.layer addSublayer:layer1];
    
    
    height += 6;
    layer2 = [CAShapeLayer layer];
    layer2.fillColor = [UIColor colorWithRed:1.0 green:146/255.0 blue:48/255.0 alpha:1.0].CGColor;
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, nil,    wid, height);
    CGPathAddLineToPoint(path2, nil, wid-10, height+18);
    CGPathAddLineToPoint(path2, nil, wid, height+14);
    CGPathAddLineToPoint(path2, nil, wid+10, height+18);
    CGPathAddLineToPoint(path2, nil, wid, height);
    layer2.path = path2;
    layer2.zPosition = 1;
    [self.layer addSublayer:layer2];
}
- (void)startAnimation
{
    {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                             [NSValue valueWithCGPoint:CGPointMake(0, -12)],
                             [NSValue valueWithCGPoint:CGPointMake(0, 0)]
                             ];
        animation.beginTime = CACurrentMediaTime();
        animation.duration = 1.3;
        //        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        animation.repeatCount = 1000;
        [layer1 addAnimation:animation forKey:nil];
    }
    {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                             [NSValue valueWithCGPoint:CGPointMake(0, -6)],
                             [NSValue valueWithCGPoint:CGPointMake(0, 0)]
                             ];
        animation.beginTime = CACurrentMediaTime() + 0.15;
        animation.duration = 1.3;
        //        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        animation.repeatCount = 1000;
        [layer2 addAnimation:animation forKey:nil];
    }
}
- (void)endAnimation
{
    [self.layer removeAllAnimations];
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeAllAnimations];
    }
}

- (void)pauseLayer:(CALayer *)layer
{
    CFTimeInterval curTime = CACurrentMediaTime();
    CFTimeInterval pauseTime = [layer convertTime:curTime
                                        fromLayer:nil];
    
    layer.timeOffset = pauseTime;
    layer.speed = 0;
}
- (void)resumeLayer:(CALayer *) layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    
    layer.beginTime = timeSincePause;
}
- (void)pauseAnimation
{
    [self pauseLayer:layer1];
    [self pauseLayer:layer2];
}
- (void)resumeAnimation;
{
    [self resumeLayer:layer1];
    [self resumeLayer:layer2];
}
@end
