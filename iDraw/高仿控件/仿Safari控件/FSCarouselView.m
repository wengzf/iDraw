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




@interface FSCarouselView()
{
    UIView *contentView;
    
    
    NSMutableArray *itemViewsArr;   // 所有显示的页面
    NSInteger itemCount;
    
    
    CADisplayLink *displayTimer;
    
    CGFloat scrollDuration;
    
    CGFloat startOffset;
    CGFloat endOffset;
    
    NSTimeInterval startTime;
    NSTimeInterval endTime;
    
    CGFloat startVelocity;
    CGFloat decelerationRate;
    
    CGFloat perspective;                // 视距
    
    BOOL decelerating;
    BOOL scrolling;
    BOOL bounces;
}

@end


@implementation FSCarouselView

#pragma mark - Initialisation

- (void)setUp
{
    // 参数初始化
    decelerationRate = 0.95;
    perspective = 1/500.0;
    
    bounces = YES;
    
    itemViewsArr = [NSMutableArray array];
    
    
    // 添加容器视图
    contentView = [[UIView alloc] initWithFrame:self.bounds];
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


- (void)pushAnimationState:(BOOL)enabled
{
    [CATransaction begin];
    [CATransaction setDisableActions:!enabled];
}

- (void)reloadData
{
    // 数据加载
    itemViewsArr = [NSMutableArray array];
    if (_dataSource) {
        itemCount = [_dataSource numberOfItemsInCarouselView:self];
        
        for (int i=0; i<itemCount; ++i) {
            UIView *view = [_dataSource carouselView:self itemAtIndex:i];
            [itemViewsArr addObject:view];
        }
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
    CGFloat alpha = 0;
    
    return alpha;
}

// 根据offset计算transform
- (CATransform3D)transformForItemViewWithOffset:(CGFloat)offset
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    
    return transform;
}

// 计算index项的offset
- (CGFloat)offsetForItemAtIndex:(NSInteger)index
{
    CGFloat offset = 0;
    
    
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


#pragma mark - Scrolling
- (void)disableApp
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}
- (void)enableApp
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void)scrollByOffset:(CGFloat)offset duration:(NSTimeInterval)duration
{
    if (duration > 0.0) {
        decelerating = NO;
        scrolling = YES;
        
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
    if (!displayTimer) {
        displayTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    }
}
- (void)stopAnimation
{
    if (displayTimer) {
        displayTimer conformsToProtocol:<#(Protocol *)#>
    }
}
- (void)step
{
    
}



#pragma mark - UIGestureRecognizerDelegate
- (void)didPan:(UIGestureRecognizer *)gesture
{
    
}
- (void)didTap:(UIGestureRecognizer *)gesture
{
    
}



@end
