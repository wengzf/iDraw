//
//  Canvas+PeanoCurve.m
//  LOGO
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (PeanoCurve)


// 皮亚诺曲线
// L → +RF-LFL-FR+
// R → −LF+RFR+FL−
- (void) drawPeanoCurve
{
    [self drawPeanoCurveL:6 level:2];
}
- (void) drawPeanoCurveL:(CGFloat) len level:(int) level
{
    if (level == 1) {
        RT(90);
        FD(len);
        LT(90);
        FD(len);
        LT(90);
        FD(len);
        RT(90);
        
        return;
    }
    
    RT(90);
    [self drawPeanoCurveR:len level:level-1 ];
    FD(len);
    LT(90);
    [self drawPeanoCurveL:len level:level-1];
    FD(len);
    [self drawPeanoCurveL:len level:level-1];
    LT(90);
    FD(len);
    [self drawPeanoCurveR:len level:level-1];
    RT(90);
    
}
- (void) drawPeanoCurveR:(CGFloat) len level:(int) level
{
    if (level == 1) {
        LT(90);
        FD(len);
        RT(90);
        FD(len);
        RT(90);
        FD(len);
        LT(90);
        
        return;
    }
    
    LT(90);
    [self drawPeanoCurveL:len level:level-1];
    FD(len);
    RT(90);
    [self drawPeanoCurveR:len level:level-1 ];
    FD(len);
    [self drawPeanoCurveR:len level:level-1];
    RT(90);
    FD(len);
    [self drawPeanoCurveL:len level:level-1];
    LT(90);
    
}


@end
