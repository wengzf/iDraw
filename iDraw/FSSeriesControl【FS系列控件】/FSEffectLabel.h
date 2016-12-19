//
//  FSEffectLabel.h
//  SystemNavigation
//
//  Created by 翁志方 on 16/6/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSEffectLabel : UILabel
{
    CGColorSpaceRef colorSpaceRef;
    CGColorRef glowColorRef;
}

// 光晕设置
@property (nonatomic, assign) CGSize glowOffset;
@property (nonatomic, assign) CGFloat glowAmount;
@property (nonatomic, retain) UIColor *glowColor;

@end
