//
//  LOGOViewController.m
//  iDraw
//
//  Created by 翁志方 on 15/4/2.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "LOGOViewController.h"
#import "Canvas.h"

#import "UberStartViewController.h"

#import "TableViewController.h"

#import "FSTestCloseSwitchView.h"
#import "FSTestCarouselView.h"
#import "FSScrollView.h"

@interface LOGOViewController ()
{
    NSArray *sectionNamesArr;
    
    NSArray *rowNameWithSectionArr;     // 二维
    
    //
    UIView *tmpView;
    Turtle *turtle;
    
}

@end

@implementation LOGOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableview 数据初始化
    {
        // 这个应该定义成全局的
        sectionNamesArr = @[@"花卉", @"错觉", @"螺线", @"IFS", @"路径",@"其它"];
        
        rowNameWithSectionArr = @[@[@"莲花", @"菊花", @"大理花"],
                                  @[@"圆形正方形错觉"],
                                  @[@"普通螺线", @"多边形螺线", @"黄金分割螺线", @"正多边形螺线"],
                                  @[@"IFSSierpinski", @"IFS拼贴树", @"IFS螺旋", @"IFS羊齿叶", @"IFS二叉树"],
                                  @[@"支付宝完成动画", @"路径",@"优步启动页"],
                                  @[@"太阳", @"团锦" ],
                                  ];
    }
    
//    tmpView = [[UIView alloc] initWithFrame:self.view.bounds];
//    tmpView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:tmpView];
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    
//    Canvas *canvas = [[Canvas alloc] initWithFrame:vc.view.bounds ];
//    
//    canvas.controlStr = @"优步启动页";
//    
//    [canvas drawPicture];
//    
//    [vc.view addSubview:canvas];
//    
//    [self.navigationController pushViewController:vc animated:NO];

    
    
//    TableViewController *vc = [TableViewController new];
//    [self presentViewController:vc animated:YES completion:NULL];
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidAppear:(BOOL)animated
{
//    [self testScrollView];
    [self testRecordPoint];
}

- (void)testRecordPoint
{
    // CBStoreHouse 描点
    [[FSNavigationRouter shareInstance] presentCurrentVC:self
                                                      to:@"RecordPointToolViewController"
                                              withParams:nil];
}
- (void)testUberStartViewController
{
    // 仿Uber开启启动页面
    UberStartViewController *vc = [UberStartViewController new];
    [self presentViewController:vc animated:NO completion:NULL];
}
- (void)testCloseSwitchView
{
    // 仿系统通知开关
    FSTestCloseSwitchView *closeSwitchView = [[FSTestCloseSwitchView alloc] init];
    [closeSwitchView configureView];
    [[UIApplication sharedApplication].keyWindow addSubview:closeSwitchView];
}
- (void)testCarouselView
{
    // 仿Safari
    FSTestCarouselView *view= [[FSTestCarouselView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}
- (void)testScrollView
{
    // 仿系统ScrollView
    FSScrollView *view= [[FSScrollView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}
- (void)testGradientView
{
    // 渐变view学习
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 120, 100)];
    view.backgroundColor = [UIColor redColor];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.colors = [NSArray arrayWithObjects:(id)[UIColor redColor].CGColor,
                             (id)[UIColor blueColor].CGColor, nil];
    gradientLayer1.locations = @[@0, @1];
    gradientLayer1.startPoint = CGPointMake(0, 0);
    gradientLayer1.endPoint = CGPointMake(1, 1);
    
    [view.layer addSublayer:gradientLayer1];
    
    [self.view addSubview:view];
}

- (void)testTianmaoAnimation
{
    // 仿天猫刷新动画
    
    // 绘制路径
    DRAWINVIEW(self.view);
    
    LT(90);
    PU; FD(47); PD; RT(90);
    
    FD(36);
    [turtle circleArcWithRadius:10 angle:90];
    RT(45);
    FD(38);
    LT(45);
    FD(20);
    LT(45);
    FD(38);
    RT(45);
    [turtle circleArcWithRadius:10 angle:90];
    
    FD(36);
    [turtle circleArcWithRadius:10 angle:90];
    FD(73.5);
    [turtle circleArcWithRadius:10 angle:90];
    
    // 添加动画图层
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = turtle.shapePath;
        
        //        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        
        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        shapeLayer.lineWidth = 3;
        [self.view.layer addSublayer:shapeLayer];
    }
    
    // 添加动画
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = turtle.shapePath;
        
        //        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.lineWidth = 4;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 3;
        animation.fromValue = @0.05;
        animation.toValue = @1;
        animation.repeatCount = 100;
        [shapeLayer addAnimation:animation forKey:nil];
        
        CABasicAnimation *animationStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        animationStart.duration = 3;
        animationStart.fromValue = @0;
        animationStart.toValue = @0.95;
        animationStart.repeatCount = 100;
        [shapeLayer addAnimation:animationStart forKey:nil];
        
        [self.view.layer addSublayer:shapeLayer];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionNamesArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rowNameWithSectionArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionNamesArr[section];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *title = [@"      " stringByAppendingString:rowNameWithSectionArr[indexPath.section][indexPath.row]];
    cell.textLabel.text = title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *vc = [[UIViewController alloc] init];

    vc.title = rowNameWithSectionArr[indexPath.section][indexPath.row];
    
    Canvas *canvas = [[Canvas alloc] initWithFrame:vc.view.bounds ];

    canvas.controlStr = rowNameWithSectionArr[indexPath.section][indexPath.row];
    
    [canvas drawPicture];
    
    [vc.view addSubview:canvas];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
