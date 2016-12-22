//
//  FSMorphingLabel.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/20.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSEasing.h"
#import "FSCharacterDiffResult.h"
#import "FSCharacterLimbo.h"

// 动画效果
typedef NS_ENUM(NSInteger, FSMorphingEffect){
    kMorphingEffectScale = 0,
    kMorphingEffectEvaporate,
    kMorphingEffectFall,
    kMorphingEffectPixelate,
    kMorphingEffectSparkle,
    kMorphingEffectBurn,
    kMorphingEffectAnvil
    
};

// 动画状态枚举
typedef NS_ENUM(NSInteger, FSMorphingPhases){
    kMorphingPhasesStart,
    kMorphingPhasesAppear,
    kMorphingPhasesDisappear,
    kMorphingPhasesDraw,
    kMorphingPhasesProgress,
    kMorphingPhasesSkipFrames,
};

// 代理
@class FSMorphingLabel;
@protocol FSMorphingLabelDelegate<NSObject>

@optional
- (void)morphingDidStart:(FSMorphingLabel *)label;
- (void)morphingDidComplete:(FSMorphingLabel *)label;
- (void)morphingDidOnProgress:(FSMorphingLabel *)label;

@end



@interface FSMorphingLabel : UILabel
{
    FSMorphingEffect morphingEffect;            // 默认scale

    float morphingProgress;
    float morphingDuration;
    float morphingCharacterDelay;
    BOOL morphingEnabled;
    
    NSString *previousText;
    NSArray *diffResults;           // 变化数组
    
    int currentFrame;
    int totalFrame;
    int totalDelayFrame;
    
    float totalWidth;
    CGRect *previousRects;
    CGRect *newRects;
    
    float charHeight;
    int skipFramesCount;

    BOOL presentingInIB;
    
    
    CADisplayLink *displayLink;
}

@property (nonatomic, assign) float morphingProgress;
@property (nonatomic, assign) float morphingDuration;
@property (nonatomic, assign) float morphingCharacterDelay;
@property (nonatomic, assign) BOOL morphingEnabled;


@property (nonatomic, weak) id<FSMorphingLabelDelegate> delegate;



@end
