//
//  Canvas+AboresentLung.m
//  LOGO
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (AboresentLung)


- (void) aboresentLung
{
    CGFloat angle = 10;
    CGFloat len = 150;
    int level = 6;
    
    CGFloat proportion = sin(RADIAN(45-angle/2)) / sin(RADIAN(90+angle));
    
    PU; RT(90); BK(len/proportion/2); LT(angle); PD;
    [self aboresentLungLen:len level:level angle:angle proportion:proportion];
    
    PU; RT(angle); FD(len/proportion); LT(180-angle); PD;
    [self aboresentLungLen:len level:level angle:angle proportion:proportion ];
}
- (void) aboresentLungLen:(CGFloat) len level:(int) level angle:(CGFloat) angle proportion:(CGFloat) proportion
{
    if (level == 1) {
        CGFloat len1 = len*proportion;
        
        RT(angle);
        FD(len1);
        RT(90-angle);
        FD(len1);
        RT(135+angle/2);
        FD(len);
        
        RT(90-angle);
        FD(len);
        RT(135+angle/2);
        FD(len1);
        RT(90-angle);
        FD(len1);
        LT(180-angle);
        
        return ;
    }
    
    CGFloat len1 = len*proportion;
    LT(angle);
    PU; FD(len1); LT(135-angle/2); PD;
    [self aboresentLungLen:len1 level:level-1 angle:angle proportion:proportion];
    
    PU; RT(135-angle/2); BK(len1); RT(angle*2);
    FD(len1); RT(135-angle/2); PD;
    [self aboresentLungLen:len1 level:level-1 angle:angle proportion:proportion];
    
    PU; LT(135-angle/2); BK(len1); LT(angle); PD;
}

@end