//
//  FSCarouselView.m
//  iDraw
//
//  Created by 翁志方 on 2016/11/16.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSCarouselView.h"



#define MIN_TOGGLE_DURATION 0.2
#define MAX_TOGGLE_DURATION 0.4

#define SCROLL_DURATION 0.4
#define INSERT_DURATION 0.4
#define DECELERATE_THRESHOLD 0.1f
#define SCROLL_SPEED_THRESHOLD 2.0f
#define SCROLL_DISTANCE_THRESHOLD 0.1f
#define DECELERATION_MULTIPLIER 30.0f




@interface FSCarouselView()<UIGestureRecognizerDelegate>
{
    UIView *contentView;
    
    NSMutableArray *itemViewsArr;   // 所有显示的页面
    NSInteger numberOfItems;
    
    CADisplayLink *displayLink;
    
    NSInteger previousIndex;
    CGFloat previousTranslation;
    CGFloat scrollDuration;
    
    CGFloat startOffset;
    CGFloat endOffset;
    
    NSTimeInterval startTime;
    NSTimeInterval endTime;
    NSTimeInterval lastTime;
    
    CGFloat itemWidth;
    CGFloat scrollSpeed;
    CGFloat startVelocity;
    CGFloat decelerationRate;
    
    CGFloat perspective;                // 视距
    CGFloat bounceDistance;
    
    BOOL stopAtItemBoundary;
    BOOL scrollToItemBoundary;
    
}

@end


@implementation FSCarouselView

#pragma mark - Initialisation

- (void)setUp
{
    // 参数初始化
    itemWidth = 120;
    scrollSpeed = 1.0;
    perspective = -1/500.0;
    bounceDistance = 1.0;
    decelerationRate = 0.95;
    
    stopAtItemBoundary = YES;
    scrollToItemBoundary = YES;
    
    _bounces = YES;
    _scrollEnabled = YES;
    
    // 添加容器视图
    contentView = [[UIView alloc] initWithFrame:ScreenBounds];
    contentView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:contentView];
    
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    panGesture.delegate = (id<UIGestureRecognizerDelegate>)self;
    [contentView addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    tapGesture.delegate = (id<UIGestureRecognizerDelegate>)self;
    [contentView addGestureRecognizer:tapGesture];
    
    
    // 重新加载数据
    if (_dataSource){
        [self reloadData];
    }
}


- (void)setScrollOffset:(CGFloat)scrollOffset
{
    _scrolling = NO;
    _decelerating = NO;
    startOffset = scrollOffset;
    endOffset = scrollOffset;
    
    if (_scrollOffset != scrollOffset)
    {
        _scrollOffset = scrollOffset;
        [self depthSortViews];
        [self didScroll];
    }
}
- (void)setDataSource:(id<FSCarouselViewDatasource>)dataSource
{
    _dataSource = dataSource;
    if (_dataSource)
    {
        [self reloadData];
    }
}


- (instancetype)init
{
    self = [super init];
    self.frame =  [UIScreen mainScreen].bounds;

    [self setUp];
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    
    [self setUp];
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    contentView.frame = self.bounds;
//    [self layOutItemViews];
}


- (void)pushAnimationState:(BOOL)enabled
{
    [CATransaction begin];
    [CATransaction setDisableActions:!enabled];
}
- (void)popAnimationState
{
    [CATransaction commit];
}


- (void)reloadData
{
    // 数据加载
    itemViewsArr = [NSMutableArray array];
    if (_dataSource) {
        numberOfItems = [_dataSource numberOfItemsInCarouselView:self];
        
        for (int i=0; i<numberOfItems; ++i) {
            UIView *view = [_dataSource carouselView:self itemAtIndex:i];
            [itemViewsArr addObject:view];
        }
    }else{
        numberOfItems = 0;
    }
    
    // offset 移动到零位置
    [self scrollByOffset:0 duration:SCROLL_DURATION];
}

- (void)removeItemAtIndex:(NSInteger)index
{
    
}
- (void)insertItemView:(UIView *)view atIndex:(NSInteger)index
{
    
}

#pragma mark - ViewLayout

// 根据offset计算透明度
- (CGFloat)alphaForItemWithOffset:(CGFloat)offset
{
    CGFloat alpha = 1;
    
    return alpha;
}

// 根据offset计算transform
- (CATransform3D)transformForItemViewWithOffset:(CGFloat)offset
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;

    CGFloat width = 140;
    CGFloat offsety = width * offset - width;
    CGFloat angle = -M_PI/8;
    
    NSLog(@"%f",offsety);
    
    transform = CATransform3DTranslate(transform, 0, offsety, -160);
    transform = CATransform3DRotate(transform, angle, 1, 0, 0);
    
    return transform;
}

// 计算index项的offset
- (CGFloat)offsetForItemAtIndex:(NSInteger)index
{
    CGFloat offset = index - _scrollOffset;

    return offset;
}

// 更新当前显示的项数
- (void)updateNumberOfVisibleItems
{
    
}

// 更新itemViews的布局
- (void)layoutItemsViews
{
    
}


- (void)loadUnloadViews
{
    // 更新当前显示的页面数量
    
    // 计算出当前显示哪些页面
    
    // 移除现在不显示的页面
    
    // 添加当前显示页面
    
    
    // 显示所有页面
    BOOL flag = NO;
    for (int i=0; i<numberOfItems; ++i) {
        UIView *view = itemViewsArr[numberOfItems - 1 - i];
        if (!view.superview){
            view.frame = ScreenBounds;
            [contentView addSubview:view];
            flag = YES;
        }
    }
    if (flag) {
        [self depthSortViews];
        
        [self transformItemViews];
    }
}


- (void)depthSortViews
{
    for (int i=0; i<numberOfItems; ++i) {
        UIView *view = itemViewsArr[i];
        [contentView bringSubviewToFront:view];
    }
}

#pragma mark - Scrolling

- (CGFloat)easyInOut:(CGFloat)time
{
    // 关于（0.5，0.5）中心对称
    return (time<0.5)? 4*time*time*time : 1-4*(1-time)*(1-time)*(1-time);
}
- (void)disableApp
{
//    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}
- (void)enableApp
{
//    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void)scrollByOffset:(CGFloat)offset duration:(NSTimeInterval)duration
{
    if (duration > 0.0) {
        _decelerating = NO;
        _scrolling = YES;
        
        startTime = CACurrentMediaTime();
        startOffset = _scrollOffset;
        scrollDuration = duration;
        endOffset = startOffset + offset;
        
        // 调用开始动画代理
//      [self.delegate willStartAnimation];
        
        [self disableApp];
        
        [self startAnimation];
    }else{
        self.scrollOffset += offset;
    }
}
- (void)startAnimation
{
    if (!displayLink) {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}
- (void)stopAnimation
{
    if (displayLink) {
        [displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        displayLink = nil;
    }
}
- (CGFloat)decelerationDistance
{
    CGFloat acceleration = -startVelocity * DECELERATION_MULTIPLIER * (1.0 - decelerationRate);
    return startVelocity*startVelocity / (2*acceleration);
}
- (void)startDecelerating
{
    CGFloat distance = [self decelerationDistance];
    startOffset = _scrollOffset;
    endOffset = startOffset+distance;
    
    startTime = CACurrentMediaTime();
    scrollDuration = fabs(distance) / fabs(0.5*startVelocity);
    
    if (distance != 0) {
        _decelerating = YES;
        [self startAnimation];
    }
}
- (void)step
{
    [self pushAnimationState:NO];
    
    NSTimeInterval currentTime = CACurrentMediaTime();
    lastTime = currentTime;

    NSTimeInterval time = fminf(scrollDuration, currentTime-startTime);
    if (_scrolling) {
        CGFloat increment = [self easyInOut:time/scrollDuration];
        _scrollOffset = startOffset + (endOffset - startOffset)*increment;
        
        if (time >= scrollDuration){
            _scrolling = NO;
            [self pushAnimationState:YES];
    
            [self didScroll];
            
            // 添加结束动画代理
            
            [self enableApp];
            [self popAnimationState];
        }
    }else if (_decelerating){
        CGFloat acceleration = -startVelocity/scrollDuration;
        CGFloat distance = startVelocity*time+0.5*acceleration*time*time;
        _scrollOffset = startOffset + distance;
        
        [self didScroll];
        
        if (time >= scrollDuration) {
            _decelerating = NO;
            
            [self pushAnimationState:YES];
            // 添加结束减速代理
            [self popAnimationState];
            
        }
        
    }
}
- (void)didScroll
{
    CGFloat min = -bounceDistance;
    CGFloat max = fmaxf(numberOfItems - 1, 0.0f) + bounceDistance;
    if (_scrollOffset < min)
    {
        _scrollOffset = min;
        startVelocity = 0.0f;
    }
    else if (_scrollOffset > max)
    {
        _scrollOffset = max;
        startVelocity = 0.0f;
    }
    
    
    NSInteger currentIndex = roundf(_scrollOffset);
    NSInteger difference = currentIndex - previousIndex;
    if (difference) {
        [self startAnimation];
    }
    
    // 加载未加载的item到contentView
    [self loadUnloadViews];
    
    // 根据offset计算transform
    [self transformItemViews];
    
//    previousIndex = currentIndex;
}

- (void)transformItemViews
{
    for (int i=0; i<numberOfItems; ++i) {
        UIView *view = itemViewsArr[i];
        
        [self transformItemView:view atIndex:i];
    }
}
- (void)transformItemView:(UIView *)view atIndex:(NSInteger)index
{
    //calculate offset
    CGFloat offset = [self offsetForItemAtIndex:index];
    
    view.alpha = [self alphaForItemWithOffset:offset];
    view.layer.transform = [self transformForItemViewWithOffset:offset];
    
}


#pragma mark - View Management
- (NSInteger)indexOfItemView:(UIView *)view
{
    return [itemViewsArr indexOfObject:view];
}
- (UIView *)itemViewAtPoint:(CGPoint) point
{
    for (NSInteger i=numberOfItems-1; i>0; --i) {
        UIView *view = itemViewsArr[i];
        if ([view.layer hitTest:point]) {
            return view;
        }
    }
    return nil;
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (_scrollEnabled) {
        _dragging = NO;
        _scrolling = NO;
        _decelerating = NO;
    }
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        // handle tap
        
    }else if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        if (!_scrollEnabled) {
            return NO;
        }
    }
    
    return YES;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gesture
{
    if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]){
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gesture;
        CGPoint translation = [panGesture translationInView:self];
        return fabs(translation.x) <= fabs(translation.y);
    }
    
    return YES;
}
- (void)didTap:(UIGestureRecognizer *)gesture
{
    UIView *view = [self itemViewAtPoint:[gesture locationInView:contentView]];
    NSInteger index = [self indexOfItemView:view];
    if (index != NSNotFound) {
        if (index != _currentItemIndex) {
            // 调用是否 shouldSelect代理
            
            [self scrollToItemAtIndex:index animated:YES];
            
            // 调用didSelect代理
        }
    }
}
- (void)didPan:(UIPanGestureRecognizer *)panGesture
{
    if (_scrollEnabled){
        switch (panGesture.state) {
            case UIGestureRecognizerStateBegan:{
                
                _dragging = YES;
                _scrolling = NO;
                _decelerating = NO;
                
                previousTranslation = [panGesture translationInView:contentView].y;
                
                // 调用代理 willBeginDragging
                
                break;
            }
                
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled:{
                _dragging = NO;
                _didDrag = YES;
                if ([self shouldDecelerate]) {
                    _didDrag = NO;
                    [self startDecelerating];
                }
                
                // 调用代理 didenddragging willDecelerate
                
                if (!_decelerating) {
                    
                }
                
                break;
            }
                
            default:{
                CGFloat translation = [panGesture translationInView:contentView].y - previousTranslation;
                CGFloat factor = 1.0;
                if (_bounces) {
                    factor = 1.0 - fminf(fabs(_scrollOffset - [self clampedOffset:_scrollOffset]), bounceDistance)/bounceDistance;
                }
                previousTranslation = [panGesture translationInView:contentView].y;
                startVelocity = [panGesture velocityInView:contentView].y * factor * scrollSpeed / itemWidth;
                
                _scrollOffset -= translation * factor / itemWidth;
                
                
                [self didScroll];
            }
        }
    }
}

- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated
{
    
}

- (CGFloat)clampedOffset:(CGFloat) offset
{
    return fminf(fmaxf(0, offset),
                 fmaxf(0, numberOfItems-1));
}

- (BOOL)shouldDecelerate
{
    return (fabs(startVelocity) > SCROLL_SPEED_THRESHOLD) && (fabs([self decelerationDistance]) > DECELERATE_THRESHOLD);
}
- (BOOL)shouldScroll
{
    return (fabs(startVelocity) > SCROLL_SPEED_THRESHOLD) &&
           (fabs(_scrollOffset - self.currentItemIndex) > SCROLL_DISTANCE_THRESHOLD);
}

@end












