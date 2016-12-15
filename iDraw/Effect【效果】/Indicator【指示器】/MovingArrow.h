//
//  MovingArrow.h
//  ForceSource
//
//  Created by 翁志方 on 16/3/8.
//  Copyright © 2016年 wzf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovingArrow : UIView
{
    CAShapeLayer *layer1;
    CAShapeLayer *layer2;
}

- (void)startAnimation;
- (void)endAnimation;

- (void)pauseAnimation;
- (void)resumeAnimation;


@end
