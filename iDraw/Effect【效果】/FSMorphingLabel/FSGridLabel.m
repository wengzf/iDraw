//
//  FSGridLabel.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/21.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSGridLabel.h"
#import <CoreText/CoreText.h>


@interface FSGridLabel()
{
    CGRect characterFrames[100];
    
    CTFramesetterRef framesetter;
    
    CTFrameRef ctFrame;
    
    CGRect frameRect;
    
    NSInteger lineCount;
    
    CGPoint *lineOrigins;
    CGRect *lineFrames;
}

@end

@implementation FSGridLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = RGBA(100, 0, 0, 0.5);
    [self recalculate];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self renderInContext:context contextSize:CGSizeMake(0, 0)];
}

-(void)recalculate{
    
    // get characters from NSString
    
    NSUInteger len = [self.text length];
    UniChar *characters = (UniChar *)malloc(sizeof(UniChar)*len);
    CFStringGetCharacters((__bridge CFStringRef)self.text, CFRangeMake(0, [self.text length]), characters);
    
    // allocate glyphs and bounding box arrays for holding the result
    // assuming that each character is only one glyph, which is wrong
    CGGlyph *glyphs = (CGGlyph *)malloc(sizeof(CGGlyph)*len);
    
    CTFontRef font = CTFontCreateWithName((CFStringRef)[self.font fontName], 30, &CGAffineTransformIdentity);
    CTFontGetGlyphsForCharacters(font, characters, glyphs, len);
    
    // get bounding boxes for glyphs
    CTFontGetBoundingRectsForGlyphs(font, kCTFontDefaultOrientation, glyphs, characterFrames, len);
    free(characters);
    free(glyphs);
    
    // Measure how mush specec will be needed for this attributed string
    // So we can find minimun frame needed
    CFRange fitRange;
    
    
    CGSize s = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, len), NULL, CGSizeMake(self.frame.size.width, MAXFLOAT), &fitRange);
    
    frameRect = CGRectMake(0, 0, s.width, s.height);
    CGPathRef framePath = CGPathCreateWithRect(frameRect, NULL);
    ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, len), framePath, NULL);
    CGPathRelease(framePath);
    
    
    // Get the lines in our frame
    NSArray *lines = (NSArray*)CTFrameGetLines(ctFrame);
    lineCount = [lines count];
    
    // Allocate memory to hold line frames information:
    if (lineOrigins != NULL)free(lineOrigins);
    lineOrigins= malloc(sizeof(CGPoint) * lineCount);
    
    if (lineFrames != NULL)free(lineFrames);
    lineFrames = malloc(sizeof(CGRect) * lineCount);
    
    // Get the origin point of each of the lines
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    // Solution borrowew from (but simplified):
    // https://github.com/twitter/twui/blob/master/lib/Support/CoreText%2BAdditions.m
    
    
    // Loop throught the lines
    for(CFIndex i = 0; i < lineCount; ++i) {
        
        CTLineRef line = (__bridge CTLineRef)[lines objectAtIndex:i];
        
        CFRange lineRange = CTLineGetStringRange(line);
        CFIndex lineStartIndex = lineRange.location;
        CFIndex lineEndIndex = lineStartIndex + lineRange.length;
        
        CGPoint lineOrigin = lineOrigins[i];
        CGFloat ascent, descent, leading;
        CGFloat lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        
        // If we have more than 1 line, we want to find the real height of the line by measuring the distance between the current line and previous line. If it's only 1 line, then we'll guess the line's height.
        BOOL useRealHeight = i < lineCount - 1;
        CGFloat neighborLineY = i > 0 ? lineOrigins[i - 1].y : (lineCount - 1 > i ? lineOrigins[i + 1].y : 0.0f);
        CGFloat lineHeight = ceil(useRealHeight ? abs(neighborLineY - lineOrigin.y) : ascent + descent + leading);
        
        lineFrames[i].origin = lineOrigin;
        lineFrames[i].size = CGSizeMake(lineWidth, lineHeight);
        
        for (int ic = lineStartIndex; ic < lineEndIndex; ic++) {
            
            CGFloat startOffset = CTLineGetOffsetForStringIndex(line, ic, NULL);
            characterFrames[ic].origin = CGPointMake(startOffset, lineOrigin.y);
        }
    }
}


#pragma mark - Rendering Text:

-(void)renderInContext:(CGContextRef)context contextSize:(CGSize)size{
    
    CGContextSaveGState(context);
    
    
    // Draw Core Text attributes string:
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, CGRectGetHeight(frameRect));
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // ctframeref
    CTFrameDraw(ctFrame, context);
    
    // Draw line and letter frames:
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextBeginPath(context);
    CGContextAddRects(context, lineFrames, lineCount);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5].CGColor);
    CGContextBeginPath(context);
    CGContextAddRects(context, characterFrames, self.text.length);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
}


@end
