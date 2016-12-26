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
    morphingLabel.textColor = [UIColor darkGrayColor];
    morphingLabel.font = [UIFont systemFontOfSize:30];
    morphingLabel.frame = CGRectMake(100, 200, 214, 100);
    morphingLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:morphingLabel];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:ScreenBounds];
    
    [btn addTarget:self
            action:@selector(btnClked)
  forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)btnClked
{
    NSArray *arr = @[@"类与对象",@"OO 面向对象",@"设计模式",@"建筑设计",@"数据结构与算法"];
    morphingLabel.text = arr[arc4random()%5];
}




@end
