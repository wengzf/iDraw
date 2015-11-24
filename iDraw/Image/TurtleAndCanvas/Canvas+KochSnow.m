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
- (void) kochSnowflakes
{
    int len = 200;
    
    PU; BK(len/5); LT(90); FD(len/2); RT(120); PD;
    
    FOR_I(3){
        [self drawKochCurve:len];
        [TURTLE rt:120];
    }
}
- (void) drawKochCurve:(CGFloat) len
{
    if (len<2) {
        [TURTLE fd:len];
        return ;
    }
    
    double fractal = 4.0;
    double len1 = (len - len/fractal) / 2.0;
    double len2 = len/fractal;
    
    
    [self drawKochCurve:len1];
    [TURTLE lt:60];
    [self drawKochCurve:len2];
    [TURTLE rt:120];
    [self drawKochCurve:len2];
    [TURTLE lt:60];
    [self drawKochCurve:len1];
    
}



@end
