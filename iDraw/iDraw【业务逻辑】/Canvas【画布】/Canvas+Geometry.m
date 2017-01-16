//
//  Canvas+Geometry.m
//  iDraw
//
//  Created by 翁志方 on 2017/1/16.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (Geometry)


- (void)picture99
{
    CGFloat len = 150;
    int count = 9;
    CGFloat unitLen = len/count;
    
    // 从左下角开始绘制
    // base
    RT(30)
    BEGINPATH
    for (int i=0; i<2; ++i) {
        FD(len)
        RT(120)
    }
    ENDPATH
    PU RT(180) FD(len) PD
    
    // 绘制台阶
    for (int i=0; i<3; ++i) {
        PU BK(unitLen) LT(120) PD
        FD(unitLen)
        LT(60)
        FD(unitLen*(7-i*2) )
        
        PU BK(unitLen) RT(120) PD
        FD(unitLen)
        RT(60)
        FD(unitLen*(6-i*2) )
    }
    
    // 顶部三角
    PU BK(unitLen) LT(120) PD
    FD(unitLen)
    LT(60)
    SAVE
    FD(unitLen)
    RESTORE
    RT(120)
    FD(unitLen)
}

- (void)picture72
{
    CGFloat len = 100;
    int count = 6;
    CGFloat unitLen = len/count;
    
    // 从底部开始绘制
    LT(45)
    BEGINPATH
    for (int i=0; i<4; ++i) {
        FD(len)
        RT(90)
    }
    
    UFD(unitLen)
    RT90 FD(unitLen) LT90
    FD(unitLen*5)
    
    UBK(len)
    RT90 UFD(unitLen)
    LT90
    FD(unitLen*5)
    RT90 FD(unitLen*4)
    
    RT90 UFD(unitLen)
    RT90 FD(unitLen*3)
    LT90 FD(unitLen*2)
    LT90 FD(unitLen*3)
    
    LT90 UFD(unitLen)
    LT90 FD(unitLen*2)
    
    UBK(unitLen*2)
    LT90 UFD(unitLen*2)
    RT90 FD(unitLen*3)
    LT90 FD(unitLen)
}

@end
