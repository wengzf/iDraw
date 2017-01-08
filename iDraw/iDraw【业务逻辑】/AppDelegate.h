//
//  AppDelegate.h
//  iDraw
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "LOGOViewController.h"
#import "FractalViewController.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) LOGOViewController *logoVC;
@property (strong, nonatomic) FractalViewController *fractalVC;


@property (strong, nonatomic) UIWindow *window;


@end

