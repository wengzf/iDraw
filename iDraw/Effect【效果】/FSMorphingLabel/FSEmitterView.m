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
                 paticleName:(NSString *)particleName
                    duration:(float)duration
{
    if (self = [super init]) {
        
        self.cell.name = name;
        self.cell.contents = [UIImage imageNamed:particleName];
        
        self.duration = duration;
    }
    return self;
}
- (CAEmitterLayer *)layer
{
    if (_layer == nil){
        _layer = [CAEmitterLayer new];
        _layer.emitterPosition = CGPointMake(10, 10);
        _layer.emitterSize = CGSizeMake(10, 1);
        _layer.renderMode = kCAEmitterLayerAdditive;
        _layer.emitterShape = kCAEmitterLayerLine;
    }
    return _layer;
}
- (CAEmitterCell *)cell
{
    if (_cell == nil){
        _cell = [CAEmitterCell new];
        _cell.name = @"sparkle";
        _cell.birthRate = 150;
        _cell.velocity = 50.0;
        _cell.velocityRange = 80;
        _cell.lifetime = 0.16;
        _cell.lifetimeRange = 0.1;
        
        _cell.emissionLongitude = M_PI;
        _cell.emissionRange = M_PI;
        _cell.scale = 0.1;
        
        _cell.yAcceleration = 100;
        _cell.scaleSpeed = -0.006;
        _cell.scaleRange = 0.1;
    }
    return _cell;
}

- (void)play
{
    if (self.layer.emitterCells.count > 0) {
        return ;
    }
    self.layer.emitterCells = @[self.cell];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.layer.birthRate = 0;
    });
}

- (void)stop
{
    if (self.layer.superlayer) {
        [self.layer removeFromSuperlayer];
    }
}

- (FSEmitter *)update:(FSEmitterConfigureClosure) closure
{
    closure(self.layer, self.cell);
    return self;
}

@end


@implementation FSEmitterView

- (NSMutableDictionary *)emitters
{
    if (_emitters == nil) {
        _emitters = [NSMutableDictionary dictionary];
    }
    return _emitters;
}


- (FSEmitter *)createEmitter:(NSString *)name
                particleName:(NSString *)particleName
                    duration:(float)duration
            configureClosure:(FSEmitterConfigureClosure) closure
{
    FSEmitter *emitter = [self emitterByName:name];
    if (emitter == nil) {
        emitter = [[FSEmitter alloc] initWithName:name
                                      paticleName:particleName
                                         duration:duration];
        
        closure(emitter.layer, emitter.cell);
        [self.layer addSublayer:emitter.layer];
        [self.emitters setObject:emitter forKey:name];
    }
    return emitter;
}


- (FSEmitter *)emitterByName:(NSString *)name
{
    return self.emitters[name];
}

- (void)removeAllEmitters
{
    for (FSEmitter *emitter in self.emitters.allValues) {
        [emitter.layer removeFromSuperlayer];
    }
    
}


@end









