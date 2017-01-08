//
//  FSIndicator.h
//  ForceSource
//
//  Created by 翁志方 on 16/3/1.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FSIndicator : UIView
{

}

@property (nonatomic, assign) NSInteger numberOfPages;          // default is 0
@property (nonatomic, assign) NSInteger currentPage;



// 配置
@property (nonatomic, assign) CGFloat smallBubbleSize;          // 小球尺寸
@property (nonatomic, assign) CGFloat mainBubbleSize;           // 大球尺寸
@property (nonatomic, assign) CGFloat margin;                   // 间距
@property (nonatomic, assign) CGFloat bubbleXOffsetSpace;       // 小球间距
@property (nonatomic, assign) CGFloat bubbleYOffsetSpace;       // 纵向间距
@property (nonatomic, assign) CGFloat animationDuration;        // 动画时长
@property (nonatomic, assign) CGFloat smallBubbleMoveRadius;    // 小球运动半径

@property (nonatomic, strong) UIColor *backgroundColor;     // 横条背景颜色
@property (nonatomic, strong) UIColor *smallBubbleColor;    // 小球颜色
@property (nonatomic, strong) UIColor *bigBubbleColor;      // 大球颜色


@end
