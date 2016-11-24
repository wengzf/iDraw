//
//  FSScrollView.m
//  iDraw
//
//  Created by 翁志方 on 2016/11/21.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSScrollView.h"


#define MIN_TOGGLE_DURATION 0.2
#define MAX_TOGGLE_DURATION 0.4

#define SCROLL_DURATION 0.4
#define INSERT_DURATION 0.4
#define DECELERATE_THRESHOLD 0.1f
#define SCROLL_SPEED_THRESHOLD 2.0f
#define SCROLL_DISTANCE_THRESHOLD 0.1f
#define DECELERATION_MULTIPLIER 30.0f



@interface FSScrollView()
{
    BOOL didDrag;
    
    BOOL dragging;
    BOOL scrolling;
    BOOL decelerating;
    
    UIView *contentView;
    
    CADisplayLink *displayLink;
    
    CGFloat previousTranslation;
    
    CGFloat startVelocity;
 
    CGFloat scrollDuration;
    
    CGFloat scrollOffset;
    
    CGFloat startOffset;
    CGFloat endOffset;
    
    NSTimeInterval startTime;
    NSTimeInterval endTime;
    NSTimeInterval lastTime;

    CGFloat bounceDistance;
    CGFloat contentHeight;
    
    CGFloat decelerationRate;
}


@end


@implementation FSScrollView

- (void)setUp
{
    decelerationRate = 0.95;
    bounceDistance = 300;
    contentHeight = 20*90;
    
    // 添加容器视图
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, contentHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    panGesture.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self addGestureRecognizer:panGesture];
    
    // 添加20个页面
    for (int i=0; i<20; ++i) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i*90, 375, 80)];
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor blackColor];
        label.text = [NSString stringWithFormat:@"%d",i];
        label.font = [UIFont systemFontOfSize:30];
        
        [contentView addSubview:label];
    }
    
    // self
    self.backgroundColor = [UIColor whiteColor];
    self.frame = ScreenBounds;
}
- (instancetype)init
{
    self = [super init];
    [self setUp];
    return self;
}
- (CGFloat)clampOffset:(CGFloat)offset
{
    return fminf(0, fmax(offset, contentHeight));
}

- (CGFloat)decelerationDistance
{
    CGFloat acceleration = -startVelocity * DECELERATION_MULTIPLIER * (1.0 - decelerationRate);
    return startVelocity*startVelocity / (2*acceleration);
}

- (BOOL)shouldDecelerate
{
    CGFloat decelerationDis = fabs([self decelerationDistance]);
    
    return (fabs(startVelocity) > SCROLL_SPEED_THRESHOLD) && (decelerationDis > DECELERATE_THRESHOLD);
}

- (void)disableApp
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}
- (void)enableApp
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}
- (void)scrollToOffset:(CGFloat)offset duration:(NSTimeInterval)duration
{
    if (duration > 0.0)
    {
        decelerating = NO;
        scrolling = YES;
        
        startTime = CACurrentMediaTime();
        scrollDuration = duration;

        startOffset = scrollOffset;
        endOffset = offset;
        
        [self disableApp];
        [self startAnimation];
    }
    else
    {
        scrollOffset = offset;
        [self layoutToScrollOffset];
    }
}

- (CGFloat)easyInOut:(CGFloat)time
{
    // 关于（0.5，0.5）中心对称
    return (time<0.5)? 4*time*time*time : 1-4*(1-time)*(1-time)*(1-time);
}

- (void)startAnimation
{
    if (!displayLink) {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}
- (void)step
{
    if (scrolling){
        CGFloat time = fminf(scrollDuration, CACurrentMediaTime()-startTime);
        
        CGFloat increment = [self easyInOut:time/scrollDuration];
        scrollOffset = startOffset + (endOffset - startOffset)*increment;
        
        if (time >= scrollDuration){
            scrolling = NO;
//            [self pushAnimationState:YES];
            
            [self layoutToScrollOffset];
            
            // 添加结束动画代理
            
            [self enableApp];
        }
        
    }else if (decelerating){
        // 开始减速
        // 计算每一帧的scrollOffset
        CGFloat time = fminf(scrollDuration, CACurrentMediaTime()-startTime);
        CGFloat acceleration = startVelocity * (1 - decelerationRate);
        // 当前加速度
        CGFloat offset = startVelocity*time + 0.5*acceleration*time*time;
        
        scrollOffset += offset;
        
        [self layoutToScrollOffset];
        
        // 判断当前时间是否已经结束
        if (time >= scrollDuration) {
            decelerating = NO;
            
            // bounce 回弹
            if (scrollOffset - [self clampOffset:scrollOffset] != 0){
                // 进入滑动状态
                [self scrollToOffset:[self clampOffset:scrollOffset]
                            duration:SCROLL_DURATION];
            }
        }
    }
}
- (void)didPan:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            
            dragging = YES;
            scrolling = NO;
            decelerating = NO;
            
            previousTranslation = [panGesture translationInView:contentView].y;
            
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            
            
            dragging = NO;
            didDrag = YES;
            if ([self shouldDecelerate]) {
                didDrag = NO;
                [self startDecelerating];
            }
            
            break;
        }
            
        default:{
            CGFloat translation = [panGesture translationInView:contentView].y - previousTranslation;
            previousTranslation = [panGesture translationInView:contentView].y;
            startVelocity = [panGesture velocityInView:contentView].y;
        
            scrollOffset -= translation;
            
            [self layoutToScrollOffset];
        }
    }
}

- (void)startDecelerating
{
    CGFloat distance = [self decelerationDistance];
    startOffset = scrollOffset;
    endOffset = startOffset+distance;
    
    startTime = CACurrentMediaTime();
    scrollDuration = fabs(distance) / fabs(0.5*startVelocity);
    
    if (distance != 0) {
        decelerating = YES;
        [self startAnimation];
    }
}

- (void)layoutToScrollOffset
{
    CGFloat min = -bounceDistance;
    CGFloat max = contentHeight + bounceDistance - ScreenHeight;
    if (scrollOffset < min)
    {
        scrollOffset = min;
        startVelocity = 0.0f;
    }
    else if (scrollOffset > max)
    {
        scrollOffset = max;
        startVelocity = 0.0f;
    }
    
    // 调整contentView的frame
    CGRect frame = contentView.frame;
    frame.origin.y = -scrollOffset;
    contentView.frame = frame;
}






@end
