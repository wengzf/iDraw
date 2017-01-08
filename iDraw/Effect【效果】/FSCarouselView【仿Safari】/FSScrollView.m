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
#define DECELERATION_MULTIPLIER 20.0f


// bounce 动画参数

CGFloat bounceParameters[38] = {1.000000, 0.972881, 0.928814, 0.869492, 0.803390,
    0.732203, 0.661017, 0.594915, 0.528814, 0.464407,
    0.408475, 0.362712, 0.318644, 0.279661, 0.242373,
    0.211864, 0.184746, 0.161017, 0.140678, 0.122034,
    0.103390, 0.088136, 0.074576, 0.066102, 0.057627,
    0.050847, 0.044068, 0.037288, 0.032203, 0.027119,
    0.022034, 0.016949, 0.013559, 0.010169, 0.006780,
    0.003390, 0.001695, 0.000000};

CGFloat decelerateBounceParameters[6] = {1.000000,
    0.564644,
    0.287599,
    0.118734,
    0.023747,
    0.000000};


@interface FSScrollView()
{
    BOOL didDrag;
    
    BOOL dragging;
    BOOL scrolling;
    BOOL decelerating;
    
    BOOL deceleratingBounceFlag;            // 减速过程中碰到回弹
    
    
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
    int number = 100;
    contentHeight = number*90;
    
    // 添加容器视图
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, contentHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    panGesture.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self addGestureRecognizer:panGesture];
    
    // 添加20个页面
    for (int i=0; i<number; ++i) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i*90, 375, 74)];
        label.backgroundColor = [UIColor lightGrayColor];
        label.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        label.text = [NSString stringWithFormat:@"    %d",i];
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
        decelerating = NO;
        scrolling = NO;
        
        scrollOffset = offset;
        [self layoutToScrollOffset];
    }
}

- (CGFloat)easyInOut:(CGFloat)time
{
    // 关于（0.5，0.5）中心对称
    return (time<0.5)? 4*time*time*time : 1-4*(1-time)*(1-time)*(1-time);
}
- (CGFloat)calculateBounceParameter:(CGFloat)time
{
//    CGFloat decelerateBounceParameter[6];
    CGFloat res = 0;
    CGFloat delta = 1/37.0;
    int count = (int)(time / delta);
    
    if (count < 37) {
        // 线性插值
        res = bounceParameters[count] + (bounceParameters[count+1]-bounceParameters[count])*(time-count*delta)/delta;
    }else{
        res = bounceParameters[count];
    }
    if (res <0 || res>1) {
        NSLog(@"异常");
    }
    
    return res;
}
- (CGFloat)calculateDecelerateBounceParameter:(CGFloat)time
{
    CGFloat res = 0;
    CGFloat delta = 1/5.0;
    int count = (int)(time / delta);
    
    if (count < 5) {
        // 线性插值
        res = decelerateBounceParameters[count] + (decelerateBounceParameters[count+1]-decelerateBounceParameters[count])*(time-count)/delta;
    }else{
        res = bounceParameters[count];
    }
    
    return res;
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
        
        scrollOffset = startOffset + (endOffset - startOffset)*(1-[self calculateBounceParameter:time/scrollDuration]) ;
        
        if (time >= scrollDuration){
            scrolling = NO;
            
            [self layoutToScrollOffset];
            
            [self enableApp];
        }
        
    }else if (decelerating){
        // 开始减速
//        // 计算每一帧的scrollOffset
//        CGFloat time = fminf(scrollDuration, CACurrentMediaTime()-startTime);
//        CGFloat acceleration = -startVelocity * DECELERATION_MULTIPLIER * (1 - decelerationRate);
//        // 当前加速度
//        CGFloat offset = startVelocity*time + 0.5*acceleration*time*time;
//        
//        scrollOffset = startOffset - offset;

        
        NSTimeInterval curTime = CACurrentMediaTime();
        CGFloat time = fminf(scrollDuration, curTime-startTime);
 
        CGFloat proportion = (1-[self calculateBounceParameter:time/scrollDuration]);
        scrollOffset = startOffset + (endOffset - startOffset)*proportion;
        
        
        printf("%lf %lf    Duration:%lf   ScrollOffset: %lf    比例:%lf\n",startOffset,endOffset,time, scrollOffset,proportion);
        
        // 判断是否越界
        CGFloat upperBound = contentHeight - ScreenHeight;
        if (!deceleratingBounceFlag && (scrollOffset<0 || scrollOffset>upperBound) )
        {
            deceleratingBounceFlag = YES;
            
            NSLog(@"碰到边界");

            // 耗费时间计算
            CGFloat costTime = CACurrentMediaTime()-startTime;
            scrollDuration = costTime+(scrollDuration-costTime)*0.5;
            
            // 最终里程计算       控制到范围内部 ViewHeight
            if (endOffset<0) {
                
                if (-endOffset*0.1> ScreenHeight) {
                    endOffset = -ScreenHeight/2;
                }else{
                    endOffset = -endOffset*0.2;
                }
                
            }else if (endOffset>upperBound) {
                endOffset = upperBound + (endOffset-upperBound)*0.2;
            }
        }
        
        [self layoutToScrollOffset];
        
        // 判断当前时间是否已经结束
        if (time >= scrollDuration) {
            decelerating = NO;
            deceleratingBounceFlag = NO;
//
//            // bounce 回弹
//            if ((scrollOffset<0 || scrollOffset>upperBound)){
//                
//                [self scrollToOffset:[self clampOffset:scrollOffset]
//                            duration:SCROLL_DURATION];
//            }
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
            
            printf("ScrollOffset:%lf  StartVelocity:%lf\n",scrollOffset,startVelocity);
            
            [self layoutToScrollOffset];
        }
    }
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
    // 调整contentView的frame
    CGRect frame = contentView.frame;
    frame.origin.y = -scrollOffset;
    contentView.frame = frame;
}








@end
