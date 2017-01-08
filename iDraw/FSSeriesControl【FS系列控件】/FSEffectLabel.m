//
//  FSEffectLabel.m
//  SystemNavigation
//
//  Created by 翁志方 on 16/6/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSEffectLabel.h"

@implementation FSEffectLabel

- (void)setGlowColor:(UIColor *)newGlowColor
{
    CGColorRelease(glowColorRef);
    _glowColor = newGlowColor;
    glowColorRef = CGColorCreate(colorSpaceRef, CGColorGetComponents(_glowColor.CGColor));
}
- (void)setGlowAmount:(CGFloat)glowAmount
{
    _glowAmount = glowAmount;
    [self setNeedsDisplay];
}

- (void)initialize {
    colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    self.glowOffset = CGSizeMake(0.0, 0.0);
    self.glowAmount = 0.0;
    self.glowColor = [UIColor clearColor];
}

- (void)awakeFromNib {
    [self initialize];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self initialize];
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    // 光晕绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetShadow(context, self.glowOffset, self.glowAmount);
    CGContextSetShadowWithColor(context, self.glowOffset, self.glowAmount, glowColorRef);
    
    [super drawTextInRect:rect];
    
    CGContextRestoreGState(context);
}

- (void)dealloc {
    CGColorRelease(glowColorRef);
    CGColorSpaceRelease(colorSpaceRef);
}


@end
