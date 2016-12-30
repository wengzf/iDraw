//
//  FSEmitterView.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/30.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSEmitterView.h"

@implementation FSEmitter

- (instancetype)initWithName:(NSString *)name
                 paticleName:(NSString *)paticleName
                    duration:(float)duration
{
    if (self = [super init]) {
        [self configure];
        
        
        
    }
    return self;
}

- (void)configure
{
    CAEmitterLayer *layer = [CAEmitterLayer new];
    layer.emitterPosition = CGPointMake(10, 10);
    layer.emitterSize = CGSizeMake(10, 1);
    layer.renderMode = kCAEmitterLayerOutline;
    layer.emitterShape = kCAEmitterLayerLine;
    self.layer = layer;
    
    CAEmitterCell *cell = [CAEmitterCell new];
    cell.name = @"sparkle";
    cell.birthRate = 150;
    cell.velocity = 50.0;
    cell.velocityRange = 80;
    cell.lifetime = 0.16;
    cell.lifetimeRange = 0.1;
    
    cell.emissionLongitude = M_PI;
    cell.emissionRange = M_PI;
    cell.scale = 0.1;
    
    cell.yAcceleration = 100;
    cell.scaleSpeed = -0.006
    
    self.cell = cell;
}


@end



@implementation FSEmitterView

@end
