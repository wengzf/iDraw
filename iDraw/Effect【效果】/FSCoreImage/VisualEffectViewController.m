//
//  VisualEffectViewController.m
//  iDraw
//
//  Created by 翁志方 on 2017/1/12.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import "VisualEffectViewController.h"

@interface VisualEffectViewController ()

@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation VisualEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentScrollView = [[UIScrollView alloc] initWithFrame:ScreenBounds];
    self.contentScrollView.bounces = NO;
    [self.view addSubview:self.contentScrollView];
    
    UIImage *img = [UIImage imageNamed:@"5.jpg"];
    UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
    imgview.frame = CGRectMake(0, 0, 540, 960);
    [self.contentScrollView addSubview:imgview];
    
    self.contentScrollView.contentSize = CGSizeMake(540, 960);
    
    // 添加模糊效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = CGRectMake(0, 0, 414, 100);
    [self.view addSubview:effectView];
    
    // 添加标题
    UILabel *label = [[UILabel alloc] initWithFrame:effectView.bounds];
    label.text = @"FSSource";
    label.font = [UIFont systemFontOfSize:60 weight:1.5];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 创建子效果
    UIVibrancyEffect *subEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *subVisualView = [[UIVisualEffectView alloc] initWithEffect:subEffect];
    subVisualView.frame = effectView.bounds;
    [subVisualView.contentView addSubview:label];
    [effectView.contentView addSubview:subVisualView];
 

}

@end
