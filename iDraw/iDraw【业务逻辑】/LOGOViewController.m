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
#import "UIImageView+FSWebCache.h"

#import "TestMorphingLabelViewController.h"
#import "TestCoreImageViewController.h"


#import "VisualEffectViewController.h"

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
    // Do any additional setup after loading the view from its nib.
    
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
}


- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidAppear:(BOOL)animated
{
    [self testPictures];
}

- (void)testPictures
{
    // 海龟初始化
    DRAWINVIEW([Canvas sharedInstance]);
    
    [[Canvas sharedInstance] picture72];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] initWithLayer:[Canvas sharedInstance].layer];
    
    shapeLayer.path = TURTLE.shapePath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.strokeColor = [UIColor darkGrayColor].CGColor;
    
    shapeLayer.lineWidth = 3;

    
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowRadius = 10;
    shapeLayer.shadowColor = [UIColor darkGrayColor].CGColor;
    
    [[Canvas sharedInstance].layer addSublayer:shapeLayer];
    
    [[UIApplication sharedApplication].keyWindow addSubview:[Canvas sharedInstance]];
}

// 毛玻璃效果
- (void)testVisualEffectViewController
{
    VisualEffectViewController *vc = [VisualEffectViewController new];
    [self presentViewController:vc animated:YES completion:NULL];
}
// 滤镜使用
- (void)testCoreImage
{
    TestCoreImageViewController *vc = [TestCoreImageViewController new];
    [self presentViewController:vc animated:YES completion:NULL];
}

// morphing Label 测试
- (void)testMorphingLabel
{
    TestMorphingLabelViewController *vc = [TestMorphingLabelViewController new];
    [self presentViewController:vc animated:YES completion:NULL];
}

// FSIndicator
- (void)testFSIndicator
{
    
}

// ImageAnalysisViewController
- (void)testImageAnalysisViewController
{
    // 
}

// Moving Arrow
- (void)testMovingArrow
{
    
}



// 仿Uber开启启动页面
- (void)testUberStartViewController
{
    UberStartViewController *vc = [UberStartViewController new];
    [self presentViewController:vc animated:NO completion:NULL];
}

// 仿系统通知开关
- (void)testCloseSwitchView
{
    FSTestCloseSwitchView *closeSwitchView = [[FSTestCloseSwitchView alloc] init];
    [closeSwitchView configureView];
    [[UIApplication sharedApplication].keyWindow addSubview:closeSwitchView];
}

// 仿Safari
- (void)testCarouselView
{
    FSTestCarouselView *view= [[FSTestCarouselView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

// 仿系统ScrollView
- (void)testScrollView
{
    FSScrollView *view= [[FSScrollView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

// 渐变view学习
- (void)testGradientView
{
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

// 仿天猫刷新动画
- (void)testTianmaoAnimation
{
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
