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




//什么是适配器模式
//    国家电压频率不一致问题，使用电源适配器
//
//    类适配器
//
//    对象适配器
//
//
//
//数据直接适配带来的困境
//    直接赋值的弊端，耦合性太高
//    用对象赋值的灵活度问题， 对象的属性变化了
//
//
//
//如何使用适配器模式
//
//适配器模式的优缺点
//    降低视图层与数据层的耦合
//    类在不经过修改就可以适应新的情形
//
//saveText 设置，字典传过来的数据类型可能是nssnumber 或 nsstring
//
//
//
//
//
//策略模式
//    if  else 的困境
//
//
//
//
//
//交流电




