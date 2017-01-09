//
//  TestMorphingLabelViewController.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/26.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "TestMorphingLabelViewController.h"
#import "FSMorphingLabel.h"


@interface TestMorphingLabelViewController ()
{
    FSMorphingLabel *morphingLabel;
}
@end

@implementation TestMorphingLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    morphingLabel = [[FSMorphingLabel alloc] init];
    morphingLabel.textColor = [UIColor whiteColor];
    morphingLabel.font = [UIFont systemFontOfSize:30];
    morphingLabel.frame = CGRectMake(0, 200, ScreenWidth, 100);
    morphingLabel.textAlignment = NSTextAlignmentCenter;
    
    morphingLabel.morphingEffect = kMorphingEffectBurn;
    
    [self.view addSubview:morphingLabel];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:ScreenBounds];
    
    [btn addTarget:self
            action:@selector(btnClked)
  forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:btn belowSubview:self.scaleBtn];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)btnClked
{
    static NSInteger count = 0;
    
    //    NSArray *arr = @[@"类与对象",@"OO 面向对象",@"设计模式",@"建筑设计",@"数据结构与算法"];
    
    NSArray *arr = @[
                     @"What is design?",
                     @"Design",
                     @"Design is not just",
                     @"what it looks like",
                     @"and feels like.",
                     @"Design",
                     @"is how it works.",
                     @"- Steve Jobs",
                     @"Older people", @"sit down and ask,", @"'What is it?'",
                     @"but the boy asks,", @"'What can I do with it?'.", @"- Steve Jobs",
                     @"", @"Swift", @"Objective-C", @"iPhone", @"iPad", @"Mac Mini",
                     @"MacBook Pro🔥", @"Mac Pro⚡️",
                     //     @"爱老婆",
                     //     @"老婆和儿子"
                     ];
    morphingLabel.text = arr[count % arr.count];
    
    ++count;
}



- (IBAction)scaleBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectScale;
    [self btnClked];
}
- (IBAction)evaporateBtnBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectEvaporate;
    [self btnClked];
}
- (IBAction)fallBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectFall;
    [self btnClked];
}
- (IBAction)pixelateBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectPixelate;
    [self btnClked];
}
- (IBAction)anvilBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectAnvil;
    [self btnClked];
}
- (IBAction)burnBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectBurn;
    [self btnClked];
}
- (IBAction)sparkleBtnClked:(UIButton *)sender
{
    morphingLabel.morphingEffect = kMorphingEffectSparkle;
    [self btnClked];
}


@end
