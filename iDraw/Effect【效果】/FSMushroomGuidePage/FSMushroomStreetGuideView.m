//
//  FSMushroomStreetGuideView.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/23.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSMushroomStreetGuideView.h"
#import "UIView+XQ.h"

@interface FSMushroomStreetGuideView()
{
    CGFloat proportion;
    
    UIScrollView *contentScrollView;
}

@end


@implementation FSMushroomStreetGuideView

- (instancetype)init
{
    self = [super init];
    
    self.frame = ScreenBounds;
    
    contentScrollView = [[UIScrollView alloc] initWithFrame:ScreenBounds];
    contentScrollView.pagingEnabled = YES;
    [self addSubview:contentScrollView];
    
    CGRect frame = ScreenBounds;
    // 添加4个页面
    {
        for (int i=0; i<4; ++i) {
            UIView *view = [[UIView alloc] initWithFrame:frame];
            [contentScrollView addSubview:view];
            
            UIImageView *imgview = [UIImageView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
            [view addSubview:imgview];
        }
        
        [];
    }
    
    // 添加对应视图
    {
        
    }
    
    
    
    return self;
}


@end
