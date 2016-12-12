//
//  FSTestCloseSwitchView.m
//  iDraw
//
//  Created by 翁志方 on 2016/11/11.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "FSTestCloseSwitchView.h"
#import "FSCloseSwithView.h"

@implementation FSTestCloseSwitchView

- (instancetype)init
{
    self = [super init];
    
    self.frame = ScreenBounds;
    
    
    
    return self;
}

- (void)configureView
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"closeSwitchBackground"]];
    imgView.frame = ScreenBounds;
    imgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:imgView];
    
    // 添加closeView
    FSCloseSwithView *closeView = [[FSCloseSwithView alloc] init];
    CGRect frame = closeView.bounds;
    frame.origin = CGPointMake(250, 296);
    closeView.frame = frame;
    [self addSubview:closeView];
    
}
@end
