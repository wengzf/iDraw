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
#import "FSMorphingEffectPhase.h"
#import "FSEmitterView.h"



typedef void (^FSMorphingStartClosure)(void);

typedef FSCharacterLimbo * (^FSMorphingEffectClosure)(unichar ch, NSInteger index, float progress);

typedef BOOL (^FSMorphingDrawingClosure)(FSCharacterLimbo *limbo);

typedef float (^FSMorphingManipulateProgressClosure)(NSInteger index,float progress, BOOL isNewChar);

typedef int (^FSMorphingSkipFramesClosure)(void);



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
    float morphingProgress;
    float morphingDuration;
    float morphingCharacterDelay;
  
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
    
    CADisplayLink *displayLink;
}
@property (nonatomic, assign) BOOL morphingDisable;

@property (nonatomic, assign) FSMorphingEffect morphingEffect;            // 默认scale

@property (nonatomic, strong) NSMutableDictionary *effectDictionary;

@property (nonatomic, strong) FSEmitterView *emitterView;


@property (nonatomic, weak) id<FSMorphingLabelDelegate> delegate;



@end
