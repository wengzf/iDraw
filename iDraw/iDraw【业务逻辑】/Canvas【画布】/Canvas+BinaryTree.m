//
//  Canvas+BinaryTree.m
//  LOGO
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas (BinaryTree)


// 绘制正方形二叉树
- (void) binaryTree
{
    PU; BK(50); PD;
    
    [self binaryTreeWithLen:60 angle:35 level:9];
}
- (void) binaryTreeWithLen:(CGFloat) len angle:(CGFloat) angle level:(int) level
{
    if (level == 0) {
        return;
    }
    FD(len);
    LT(angle);
    [self binaryTreeWithLen:len*0.75 angle:angle*0.9 level:level-1];
    RT(angle*2);
    [self binaryTreeWithLen:len*0.75 angle:angle*0.9 level:level-1];
    LT(angle);
    PU;
    BK(len);
    PD;
}



- (void) squareBinaryTree
{
    CGFloat len = 50;
    int level = 11;
    
    PU; BK(50); LT(90); FD(len/2); RT(90); PD;
    
    [self squareBinaryTreeWithLen:len level:level];
}
// 使用递归绘制
- (void) squareBinaryTreeWithLen:(CGFloat) len level:(int) level
{
    for (int i=0; i<4; ++i) {
        FD(len);
        RT(90);
    }

    
    --level;
    if (level>=1) {
        CGFloat nextLen = len/sqrt(2);
        
        FD(len);
        LT(45);
        [self squareBinaryTreeWithLen:nextLen level:level];
        RT(90);
        FD(nextLen);
        [self squareBinaryTreeWithLen:nextLen level:level];
        BK(nextLen);
        LT(45);
        BK(len);
    }
}


@end
