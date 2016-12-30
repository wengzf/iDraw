//
//  FSMorphingEffectPhase.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/29.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#ifndef FSMorphingEffectPhase_h
#define FSMorphingEffectPhase_h

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



NSArray  *allKeysForEffect();

NSString *keyForEffect(FSMorphingEffect effect);

NSString *keyForPhase(FSMorphingPhases phase);

NSString *keyForEffectPhase(FSMorphingEffect effect, FSMorphingPhases phase);


#endif /* FSMorphingEffectPhase_h */
