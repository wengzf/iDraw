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
    morphingLabel.frame = CGRectMake(50, 200, 314, 100);
    morphingLabel.center = self.view.center;
    morphingLabel.textAlignment = NSTextAlignmentCenter;
    
    morphingLabel.morphingEffect = kMorphingEffectBurn;
    
    [self.view addSubview:morphingLabel];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:ScreenBounds];
    
    [btn addTarget:self
            action:@selector(btnClked)
  forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
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




@end
