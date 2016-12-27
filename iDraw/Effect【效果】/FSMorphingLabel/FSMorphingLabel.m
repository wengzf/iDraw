//
//  FSMorphingLabel.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSMorphingLabel.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>


//@interface FSMorphingLabel()
//{
//}
//
//@end


@implementation FSMorphingLabel

- (void)configureInit
{
    presentingInIB = YES;
}

- (void)setText:(NSString *)text
{
    previousText = self.text?:@"";
    super.text = text?:@"";
    
    diffResults = [FSCharacterDiffResult compareString:previousText withRightString:text];
    
    morphingProgress = 0;
    currentFrame = 0;
    totalFrame = 0;
    
    [self setNeedsLayout];
    
    if (![previousText isEqualToString:text]){
        if (displayLink){
            displayLink.paused = false;
        }else{
            displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayFrameTick)];
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)setNeedsLayout
{
    if (previousRects) free(previousRects);
    previousRects = [self rectsOfEachCharacter:previousText withFont:self.font];
    
    if (newRects) free(newRects);
    newRects = [self rectsOfEachCharacter:self.text withFont:self.font];
}

- (void)displayFrameTick
{
    static NSInteger count = 0;
    NSLog(@"%ld",(long)count++);
    
    if (displayLink.duration>0 && totalFrame==0) {
        float frameRate = displayLink.duration / displayLink.frameInterval;
        totalFrame = ceil(morphingDuration / frameRate);
        float totalDelay = self.text.length * morphingCharacterDelay;
        totalDelayFrame = ceil(totalDelay / frameRate);
    }
    
    currentFrame += 1;
    if (![previousText isEqualToString:self.text] && currentFrame<totalFrame+totalDelayFrame+5) {
        morphingProgress += 1.0 / totalFrame;
        
        //        if () {
        //
        //        }
        [self setNeedsDisplay];
    }else{
        // 结束
        displayLink.paused = YES;
    }
}
- (CGRect *)rectsOfEachCharacter:(NSString *)string withFont:(UIFont *)font
{
    float leftOffset = 0;
    
    charHeight = [@"Leg" sizeWithAttributes:@{NSFontAttributeName:font}].height;
    
    float topOffset = (self.bounds.size.height - charHeight)/2.0;
    
    NSRange range;
    range.length = 1;
    CGRect *charRects = malloc(sizeof(CGRect)*string.length);
    for (int i=0; i<string.length; ++i) {
        range.location = i;
        NSString *str = [string substringWithRange:range];
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:font}];
        charRects[i] = CGRectMake(leftOffset, topOffset, size.width, size.height);
        
        leftOffset += size.width;
    }
    
    totalWidth = leftOffset;
    
    float stringLeftOffset = 0;
    if (self.textAlignment == NSTextAlignmentCenter) {
        stringLeftOffset = (self.bounds.size.width - totalWidth)/2.0;
    }else if (self.textAlignment == NSTextAlignmentRight) {
        stringLeftOffset = (self.bounds.size.width - totalWidth);
    }
    
    CGRect *offsetedCharRects = malloc(sizeof(CGRect)*string.length);
    for (int i=0; i<string.length; ++i) {
        
        CGRect *p = offsetedCharRects+i;
        *p = charRects[i];
        p->size.width += stringLeftOffset;
    }
    
    free(charRects);
    
    return offsetedCharRects;
}
- (FSCharacterLimbo *)limboOfOriginalCharacter:(unichar) ch
                                         index:(NSInteger) index
                                       process:(float) progress
{
    CGRect currentRect = previousRects[index];
    float oriX = currentRect.origin.x;
    float newX = currentRect.origin.x;
    
    FSCharacterDiffResult *diffResult = diffResults[index];
    float currentFontSize = self.font.pointSize;
    float currentAlpha = 1.0;
    
    switch (diffResult.diffType) {
        case kCharacterDiffTypeSame:
            newX = newRects[index].origin.x;
            currentRect.origin.x = easeOutQuint(progress, oriX, newX - oriX, 1);
            break;
            
        case kCharacterDiffTypeMove:
            newX = newRects[index+diffResult.moveOffset].origin.x;
            currentRect.origin.x = easeOutQuint(progress, oriX, newX - oriX, 1);
            break;
            
        case kCharacterDiffTypeMoveAndAdd:
            newX = newRects[index+diffResult.moveOffset].origin.x;
            currentRect.origin.x = easeOutQuint(progress, oriX, newX - oriX, 1);
            break;
            
        default:{
            
            float fontEase = easeOutQuint(progress, 0, self.font.pointSize, 1);
            currentFontSize = MAX(0.0001, self.font.pointSize-fontEase);
            
            currentAlpha = 1.0-progress;
            CGRect rect = previousRects[index];
            rect.origin.y += self.font.pointSize - currentFontSize;
            currentRect = rect;
        }
            break;
    }
    
    FSCharacterLimbo *limbo = [FSCharacterLimbo new];
    limbo.ch = ch;
    limbo.rect = currentRect;
    limbo.alpha = currentAlpha;
    limbo.size = currentFontSize;
    limbo.drawingProgress = 0;
    
    return limbo;
}
- (FSCharacterLimbo *)limboOfNewCharacter:(unichar) ch
                                    index:(NSInteger) index
                                  process:(float) progress
{
    CGRect currentRect = newRects[index];
    
    float currentFontSize = easeOutQuint(progress, 0, self.font.pointSize, 1);;
    float currentAlpha = 1.0;
    
    if (NO) {
        // 如果实现了效果计算
        
    }else{
        currentFontSize = MAX(0.0001, self.font.pointSize-currentFontSize);
        
        currentAlpha = 1.0-progress;
        CGRect rect = previousRects[index];
        rect.origin.y += self.font.pointSize - currentFontSize;
        currentRect = rect;
    }
    
    FSCharacterLimbo *limbo = [FSCharacterLimbo new];;
    limbo.ch = ch;
    limbo.rect = currentRect;
    limbo.alpha = morphingProgress;
    limbo.size = currentFontSize;
    limbo.drawingProgress = 0;
    
    return limbo;
}
- (NSArray<FSCharacterLimbo *> *)limboOfCharacter
{
    // original characters
    NSMutableArray *limboArr = [NSMutableArray array];
    for (int i=0; i<previousText.length; ++i) {
        unichar ch = [previousText characterAtIndex:i];
        
        float progress = 0;
        
        if (NO) {
            // progressClosures
        }else{
            progress = MIN(1.0, MAX(0, morphingProgress+morphingCharacterDelay*i));
        }
        FSCharacterLimbo *limbo = [self limboOfOriginalCharacter:ch index:i process:progress];
        [limboArr addObject:limbo];
    }
    
    
    // new characters
    for (int i=0; i<self.text.length; ++i) {
        if (i>=diffResults.count) {
            break;
        }
        unichar ch = [self.text characterAtIndex:i];
        
        float progress = 0;
        
        if (NO) {
            // progressClosures
        }else{
            progress = MIN(1.0, MAX(0, morphingProgress - morphingCharacterDelay*i));
        }
        
        // 不绘制已经存在的字符
        if (NO){
            //            continue;
        }
        FSCharacterDiffResult *diffResult = diffResults[i];
        switch (diffResult.diffType) {
            case kCharacterDiffTypeMove:
            case kCharacterDiffTypeReplace:
            case kCharacterDiffTypeAdd:
            case kCharacterDiffTypeDelete:
            {
                FSCharacterLimbo *limbo = [self limboOfNewCharacter:ch index:i process:progress];
                [limboArr addObject:limbo];
            }
            default:
                break;
        }
    }
    return limboArr;
}

- (void)drawTextInRect:(CGRect)rect
{
    for (FSCharacterLimbo *limbo in [self limboOfCharacter]) {
        CGRect rect = limbo.rect;
        
        // 绘制效果
        const unichar ch = limbo.ch;
        NSString *str = [NSString stringWithCharacters:&ch length:1];
        
        [str drawInRect:rect
         withAttributes:@{NSFontAttributeName:
                              [UIFont fontWithName:self.font.fontName size:limbo.size],
                          NSForegroundColorAttributeName:
                              [self.textColor colorWithAlphaComponent:limbo.alpha]}];
    }
    
}








@end

