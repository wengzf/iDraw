//
//  Canvas+IFS.m
//  iDraw
//
//  Created by 翁志方 on 15/4/4.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (IFS)

double (*m)[7];
int n;
int iterationTime = 25000;
bool flagReverse = YES;
double scalex, adjustx;
double scaley, adjusty;

- (void) ifsIteration
{
    double a,b,c,d,e,f;
    double r;
    double *p;
    double x,y;
    double newx, newy;
    double posx, posy;
    
    a = b = c = d = e = f = 0;
    x = y = 0;
    
//    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    DRAWINVIEW(self);
    
    [[UIColor blackColor] set];
    for (int i=0; i<iterationTime; ++i) {
        
        r = rand() / (double)RAND_MAX;
        for (int j=0; j<n; ++j) {
            p = m[j];
            if (r<=m[j][6]) {
                a = p[0];
                b = p[1];
                c = p[2];
                d = p[3];
                e = p[4];
                f = p[5];
                
                break;
            }
            r -= m[j][6];
        }
        
        newx = a*x + b*y + e;
        newy = c*x + d*y + f;
        
        x = newx;
        y = newy;
        
        posx = x*scalex + adjustx;
        posy = y*scaley + adjusty;
        if (flagReverse) {
            posy = 500 - posy;
        }
        
//        CGContextMoveToPoint(ref, posx, posy);
//        CGContextAddLineToPoint(ref, posx+0.5, posy);
        MOVETO(CGPointMake(posx, posy));
        LINETO(CGPointMake(posx+0.5, posy));
        
//        printf("%d %d\n",posx, posy);
    }
    
//    CGContextStrokePath(ref);
}


- (void) ifsRightAngleSierpinskiTriangle
{
    double paramArr[3][7] = {{0.5, 0, 0, 0.5, 0,   0, 0.333},
                             {0.5, 0, 0, 0.5, 1.5, 0, 0.333},
                             {0.5, 0, 0, 0.5, 0, 1.5, 0.333},};
    
    m = paramArr;
    n = 3;
    scalex = 100;   adjustx = 100;
    scaley = 100;   adjusty = 100;
    
    [self ifsIteration];
}
- (void) ifsTreeBinary
{
    double paramArr[4][7] = {{0.01,  0,    0,   0.45,  0,  0,   0.05},
                             {-0.01, 0,    0,   -0.45, 0,  0.4, 0.15},
                             {0.42, -0.42, 0.42, 0.42, 0,  0.4, 0.4},
                             {0.42, 0.42, -0.42, 0.42, 0,  0.4, 0.4}};
    
    m = paramArr;
    n = 4;
    
    scalex = 200;   adjustx = 185;
    scaley = 200;   adjusty = 100;
    iterationTime = 15000;
    flagReverse = YES;
    
    [self ifsIteration];
}
- (void) ifsTree2
{
    
}

- (void) ifsSpiral          // 螺旋花纹
{
    double paramArr[3][7] = {{0.787879, -0.424242, 0.242424, 0.859848, 1.758647, 1.408065, 0.9},
                             {-0.121212, 0.257576, 0.05303,  0.05303, -6.721654, 1.377236, 0.05},
                             {0.181818, -0.136364, 0.090909, 0.181818, 6.086107, 1.568035, 0.05}};
    
    m = paramArr;
    n = 3;
    scalex = 18;   adjustx = 180;
    scaley = 18;   adjusty = 200;
    iterationTime = 21000;
    
    [self ifsIteration];
}


- (void) ifsCurlyLeaf
{
    double paramArr[4][7] = {{ 0,      0,     0,    0.25,  0,    -0.04, 0.02 },
                             { 0.92,   0.05, -0.05, 0.93, -0.002, 0.5,  0.84 },
                             { 0.035, -0.2,   0.16, 0.04, -0.09,  0.02, 0.07 },
                             { -0.04,  0.2,   0.16, 0.04,  0.083, 0.12, 0.07 } };
    
    m = paramArr;
    n = 4;
    scalex = 30;   adjustx = 180;
    scaley = 30;   adjusty = 100;
    iterationTime = 31000;
    
    [self ifsIteration];
    
}

- (void) ifsCollageTree     // 很仿真
{
    double paramArr[4][7] = {{ -0.04,   0,    -0.19, -0.47, -0.12, 0.3,  0.25 },
                             { 0.65,    0,     0,     0.56,  0.06, 1.56, 0.25 },
                             { 0.41,    0.46, -0.39,  0.61,  0.46, 0.4,  0.25 },
                             { 0.52,   -0.35,  0.25,  0.74, -0.48, 0.38, 0.25 }
    };
    
    m = paramArr;
    n = 4;
    scalex = 35;   adjustx = 180;
    scaley = 35;   adjusty = 150;
    iterationTime = 31000;
    
    [self ifsIteration];
}

/*
double paramArr[3][7] = {{ 0,   0, 0, 0., 0, -0.4, 0. },
    { 0., 0., 0., 0., 0., 0., 0. },
    { 0., 0., 0., 0., 0., 0., 0. },
    { 0., 0., 0., 0., 0., 0., 0. } };

*/

@end




















