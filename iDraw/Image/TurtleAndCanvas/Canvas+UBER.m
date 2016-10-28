//
//  Canvas+UBER.m
//  iDraw
//
//  Created by 翁志方 on 2016/10/28.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "Canvas.h"

CGFloat radius = 15;
CGFloat diameter = 30;

@implementation Canvas (UBER)

- (void)uberAnimation
{
    // 背景绘制
    [self initCanvas];
    
    // 路径动画
    [self uberPathAnimation];
}

- (void)initCanvas
{
    // 绘制背景图片
    CGFloat proportion = ScreenWidth/320.0;
    radius *= proportion;
    diameter *= proportion;
    
    
    DRAWINVIEW(self)

    for (int k=<#from#>; k<<#to#>; ++k) {
        <#statements#>
    }
    
    
    MOVETOXY(ScreenWidth/2.0, ScreenHeight+10);
    
    for (int i=0; i<10; ++i) {
        // 开始绘制4个圆环
        PU FD(diameter)) PD
        for (int j=0; j<4; ++j) {
            ARC(radius, 360)
            RT90
        }
        PU FD(diameter) PD
        FD(length*2)
    }
    
    
    
    
}
- (void)uberPathAnimation
{
    
}


@end
