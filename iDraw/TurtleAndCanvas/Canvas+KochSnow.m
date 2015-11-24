//
//  Canvas+KochSnow.m
//  LOGO
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (KochSnow)

// 绘制分形koch曲线 雪花
- (void) drawKochSnowflakes
{
    for (int i=0; i<3; ++i) {
        [self drawKochCurve:200];
        [turtle rt:120];
    }
}
- (void) drawKochCurve:(CGFloat) len
{
    if (len<2) {
        [turtle fd:len];
        return ;
    }
    
    double fractal = 4.0;
    double len1 = (len - len/fractal) / 2.0;
    double len2 = len/fractal;
    
    
    [self drawKochCurve:len1];
    [turtle lt:60];
    [self drawKochCurve:len2];
    [turtle rt:120];
    [self drawKochCurve:len2];
    [turtle lt:60];
    [self drawKochCurve:len1];
    
}



@end
