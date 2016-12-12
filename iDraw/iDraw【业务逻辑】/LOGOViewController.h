//
//  LOGOViewController.h
//  iDraw
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOGOViewController : UIViewController<UITableViewDataSource,
    UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UITableView *logoTableView;



@property (atomic, assign) NSInteger count;

@property (atomic, strong) NSMutableString *name;

//@property (nonatomic, assign) NSInteger count;


@end
