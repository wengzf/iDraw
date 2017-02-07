//
//  FSCarrotGuideView.m
//  iCarrot
//
//  Created by 翁志方 on 2017/2/7.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import "FSCarrotGuideView.h"
#import "UIView+XQ.h"

#define ScreenBounds [UIScreen mainScreen].bounds               //屏幕尺寸
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

#define ScreenCenter CGPointMake(ScreenWidth/2.0, ScreenHeight/2)

@interface FSCarrotGuideView()<UIScrollViewDelegate>
{
    UIScrollView *contentScrollView;
    UIScrollView *gestureScrollView;
    
    // pageControl
    UIView *pageControlView;
    NSMutableArray *pageIndicatorArr;
    UIColor *pageColor;
    
    // Layout
    CGFloat topMargin;
    CGFloat centerX;
    
    UILabel *label1;
    UILabel *label2;
    NSString *str1;
    NSString *str2;
    
    UIImageView *arrowImage;
}
@end

@implementation FSCarrotGuideView
- (instancetype)init
{
    self = [super init];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self initViews];
    
    return self;
}

- (void)viewDidLoad
{
}

- (void)viewDidAppear:(BOOL)animated
{
}

#pragma -initViews
- (void)initViews
{
    str1 = @"看一本新书";
    str2 = @"平板电脑";
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 60, 20)];
    label1.text = str1;
    label1.textColor = [UIColor orangeColor];
    label1.font = [UIFont boldSystemFontOfSize:20];
    [label1 sizeToFit];
    [self.view addSubview:label1];
    
    arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3_thread_arrow"]];
    [self.view addSubview:arrowImage];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 60, 20)];
    label2.text = str2;
    label2.textColor = [UIColor greenColor];
    label2.font = [UIFont boldSystemFontOfSize:20];
    [label2 sizeToFit];
    [self.view addSubview:label2];
    
    arrowImage.centerY = label1.centerY;
    label2.centerY = label1.centerY;
    
    arrowImage.left = label1.right+4;
    label2.left = arrowImage.right+4;
    
    // content
    contentScrollView = [[UIScrollView alloc] initWithFrame:ScreenBounds];
    contentScrollView.pagingEnabled = YES;
//    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.bounces = NO;
    contentScrollView.delegate = self;
    [self.view addSubview:contentScrollView];
   
    contentScrollView.backgroundColor = [UIColor clearColor];
    contentScrollView.contentSize =  CGSizeMake(ScreenWidth*2, ScreenHeight);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    
    NSLog(@"%lf",offset);
    // 按照滑动25 少一个文字计算frame
    CGFloat stOffset = 0;
    
    NSInteger cnt = (offset-stOffset) / 25;
    
    NSString *cstr1;
    NSString *cstr2;
    
//    str1 = @"看一本新书";
//    str2 = @"平板电脑";
    
    cnt = cnt>9 ? 9 : cnt;
    if (cnt >= 4) {
        cnt = 9-cnt;
        cstr1 = [str1 substringToIndex:cnt];
        cstr2 = @"";
        
        label1.text = cstr1;
        label2.text = cstr2;
        
        [label1 sizeToFit];
        [label2 sizeToFit];
        
        arrowImage.left = label1.right+4;
        label2.left = arrowImage.right+4;
    }else{
        cnt = 4-cnt;
        cstr1 = str1;
        cstr2 = [str2 substringToIndex:cnt];
        
        label1.text = cstr1;
        label2.text = cstr2;
        
        [label1 sizeToFit];
        [label2 sizeToFit];
        
        arrowImage.left = label1.right+4;
        label2.left = arrowImage.right+4;
    }
    
    
}

@end
