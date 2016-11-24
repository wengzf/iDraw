//
//  FSTestCarouselView.m
//  iDraw
//
//  Created by 翁志方 on 2016/11/17.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSTestCarouselView.h"
#import "FSScrollView.h"

@implementation FSTestCarouselView

- (instancetype)init
{
    self = [super init];
    
    self.frame = ScreenBounds;
    self.backgroundColor = [UIColor lightGrayColor];
    
    
    FSScrollView *view = [[FSScrollView alloc] init];
    [self addSubview:view];
    
//    [self  configureView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)];
//    [self addGestureRecognizer:tap];
//    
    return self;
}

- (void)test
{
    CGFloat curtime = CACurrentMediaTime();
    NSLog(@"%f",curtime);
}
- (void)configureView
{
    // 添加closeView
    FSCarouselView *view = [[FSCarouselView alloc] init];
    view.frame = ScreenBounds;
    view.dataSource = self;
//    view.delegate = self;
    [self addSubview:view];
    
    [view reloadData];
}


// item数量
- (NSInteger)numberOfItemsInCarouselView:(FSCarouselView *)carouselView
{
    return 12;
}

// item视图
- (UIView *)carouselView:(FSCarouselView *)carouselView itemAtIndex:(NSInteger) index
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:ScreenBounds];
    
    
    view.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)index%8]];
    
    return view;
}




@end
