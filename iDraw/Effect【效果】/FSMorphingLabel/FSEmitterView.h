//
//  FSEmitterView.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/30.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSEmitter : NSObject

@property (nonatomic, strong) CAEmitterLayer *layer;

@property (nonatomic, strong) CAEmitterCell *cell;

@property (nonatomic, assign) float duration;


- (instancetype)initWithName:(NSString *)name
                 paticleName:(NSString *)paticleName
                    duration:(float)duration;



@end


@interface FSEmitterView : UIView


@end
