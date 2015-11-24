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
- (void) drawBinaryTree
{
    CGFloat len = 50;
    int level = 12;
    
    
    LT(90);
    FD(len/2);
    RT(90);
    
    [self binaryTreeWithLen:len level:level];
    
}
// 使用递归绘制
- (void) binaryTreeWithLen:(CGFloat) len level:(int) level
{
    [turtle beginPath];
    for (int i=0; i<4; ++i) {
        FD(len);
        RT(90);
    }
    [turtle endPath];
    
    --level;
    if (level>=1) {
        CGFloat nextLen = len/sqrt(2);
        
        FD(len);
        LT(45);
        [self binaryTreeWithLen:nextLen level:level];
        RT(90);
        FD(nextLen);
        [self binaryTreeWithLen:nextLen level:level];
        BK(nextLen);
        LT(45);
        BK(len);
    }
}


@end
