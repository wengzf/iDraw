//
//  TestFSIndicatorViewController.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/15.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "TestFSIndicatorViewController.h"

#import "FSIndicator.h"

@interface TestFSIndicatorViewController ()

@end

@implementation TestFSIndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FSIndicator *indicator = [[FSIndicator alloc] init];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
