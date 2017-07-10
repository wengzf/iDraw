//
//  Canvas+Mandelbrot.m
//  iDraw
//
//  Created by 翁志方 on 15/4/3.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (Mandelbrot)


- (void) juliaSet
{
    printf("%lf %lf %lf %lf",atan(1), atan(0.5), atan(-1), atan(-.05));
    
    [self juliaSetWithX:0 Y:0 CX:-0.77 CY:0.08 level:15];
    
}

- (void) juliaSetWithX:(double) x Y:(double) y CX:(double) cx CY:(double) cy level:(int) level
{
    if (level == 0){
        return ;
    }
    
    double m,n;
    double wx,wy;
    double theta =0, r;

    m = (x*12 + 120);
    n = (y*12 + 300);
    
    MOVETO(CGPointMake(m, n));
    LINETO(CGPointMake(m+1, n));
    
    wx = x - cx;
    wy = y - cy;
    
    if (wx>0) {
        theta = atan(wy/wx);
    }
    if (wx<0) {
        theta = M_PI + atan(wy/wx);
    }
    if (wx == 0) {
        theta = M_PI/2.0;
    }

    theta /= 2.0;
    
    r = sqrt(wx*wx + wy*wy);
    
//    if ((arc4random()&1) == 0) {
//        r = -r;
//    }
    x = r*cos(theta);
    y = r*sin(theta);
    
    [self juliaSetWithX:x  Y:y  CX:cx CY:cy level:level-1];
    [self juliaSetWithX:-x Y:-y CX:cx CY:cy level:level-1];
}

// 使用逃逸算法绘制分形
//- (void)






@end
