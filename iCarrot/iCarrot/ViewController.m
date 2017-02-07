//
//  ViewController.m
//  iCarrot
//
//  Created by 翁志方 on 2017/1/22.
//  Copyright © 2017年 wzf. All rights reserved.
//

#import "ViewController.h"


#import "FSCarrotGuideView.h"

@interface ViewController ()
{
    FSCarrotGuideView *vc;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    vc = [[FSCarrotGuideView alloc] init];
    [self.view addSubview:vc.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
