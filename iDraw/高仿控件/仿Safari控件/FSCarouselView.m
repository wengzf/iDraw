//
//  FSCarouselView.m
//  iDraw
//
//  Created by 翁志方 on 2016/11/16.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSCarouselView.h"


@interface FSCarouselView()
{
    UIView *containerView;
}



@end


@implementation FSCarouselView

- (instancetype)init
{
    self = [super init];
    self.frame =  [UIScreen mainScreen].bounds;
    
    // 添加容器视图
    containerView = [[UIView alloc] initWithFrame:self.bounds];
    
    // 添加手势
    
    
    
    
    // 重新加载数据
    [self reloadData];

    return self;
}




- (void)reloadData
{
    
}


@end
