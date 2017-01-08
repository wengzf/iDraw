//
//  RecordPointToolViewController.m
//  iDraw
//
//  Created by 翁志方 on 2016/11/29.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "RecordPointToolViewController.h"

@interface RecordPointToolViewController ()
{
    NSMutableArray *layersArr;
    
    NSMutableArray *stPointsArr;
    NSMutableArray *edPointsArr;
    
    CGPoint stPos;
    CGPoint edPos;
    
    UIView *stPointView;        // 开始小红点
    
    BOOL flag;
    
    NSInteger fileNum;
}
@end

@implementation RecordPointToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    
    
    
    [self wordAnimation];
    return ;
    
    // 登录跟搜索文字
    {
        CGRect frame = ScreenBounds;
        frame.size.height = ScreenHeight*0.8;
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.numberOfLines = 0;
        label.text = @"登 录\n搜 索";
        label.text = @"木\n 火";
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:100];
        [self.view addSubview:label];
    }
    // 初始化
    {
        fileNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"fileNum"];
        
        [self initPath];
    }
    
    // 添加背景视图
    {
//        UIImageView *img = [[UIImageView alloc] initWithFrame:ScreenBounds];
//        img.image = [UIImage imageNamed:@"denglu"];
//        img.alpha = 0.5;
//        [self.view addSubview:img];
    }
    
    // 添加录制点手势
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClked:)];
        [self.view addGestureRecognizer:tap];
    }
    
    // 当前文件名
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 30, 100, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"当前文件名";
        label.textColor = [UIColor whiteColor];
        [self.view addSubview:label];
    }
    // 
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 100, 30, 70, 44)];
        [btn setTitle:@"新建路径" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(initPath) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        btn.layer.cornerRadius = 6;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        
        [self.view addSubview:btn];
    }
    
    // 取消按钮
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(30, ScreenHeight-74 - 74, ScreenWidth-60, 44)];
        [btn setTitle:@"取 消" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.cornerRadius = 6;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        
        [self.view addSubview:btn];
    }
    // 保存按钮
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(30, ScreenHeight-74, ScreenWidth-60, 44)];
        [btn setTitle:@"保 存" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.cornerRadius = 6;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        
        [self.view addSubview:btn];
    }
    
    // 开始小红点
    {
        stPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        stPointView.layer.cornerRadius = 2.5;
        stPointView.layer.masksToBounds = YES;
        stPointView.backgroundColor = [UIColor redColor];
        stPointView.hidden = YES;
        [self.view addSubview:stPointView];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
}


- (void)singleClked:(UITapGestureRecognizer *)gesture
{
    if (flag){
        edPos = [gesture locationInView:self.view];
        
        // 添加最后一条线段
        NSValue *stval = [NSValue valueWithCGPoint:stPos];
        [stPointsArr addObject:stval];
        
        NSValue *edval = [NSValue valueWithCGPoint:edPos];
        [edPointsArr addObject:edval];
        
        // 更新当前UI
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, stPos.x, stPos.y);
        CGPathAddLineToPoint(path, nil, edPos.x, edPos.y);
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path;
        layer.strokeColor = RGBA(255, 100, 100, 0.5).CGColor;
        layer.lineWidth = 2;
        [self.view.layer addSublayer:layer];
        
        [layersArr addObject:layer];
        
        // 清除 stPos,edPos
        stPointView.hidden = YES;
        stPos = CGPointZero;
        edPos = CGPointZero;
        
    }else{
        
        stPos = [gesture locationInView:self.view];
        
        // 移动小红点位置
        stPointView.hidden = NO;
        stPointView.center = stPos;

    }
    flag =!flag;
}
- (void)initPath
{
    for (CALayer *layer in layersArr) {
        [layer removeFromSuperlayer];
    }
    
    stPointView.hidden = YES;
    
    
    flag = NO;
    
    // 数组初始化
    layersArr = [NSMutableArray array];
    
    stPointsArr = [NSMutableArray array];
    edPointsArr = [NSMutableArray array];
    
    // 保存的文件名字加1
    ++fileNum;
    
}
- (void) cancel
{
    if (stPos.x == 0 && stPos.y == 0 ) {
        // 用户没有选择开始点
        if (stPointsArr.count > 0) {
            
            CALayer *layer = [layersArr lastObject];
            [layer removeFromSuperlayer];
            
            // 删除上一条路径
            [stPointsArr removeLastObject];
            [edPointsArr removeLastObject];
            
            [layersArr removeLastObject];
        }
    }
    // 清除 stPos,edPos
    stPointView.hidden = YES;
    stPos = CGPointZero;
    edPos = CGPointZero;
}
- (void)save
{
    NSString *path = [self filePathWithName:[NSString stringWithFormat:@"%ld",(long)fileNum]];
    
    NSLog(@"%@",path);
    // 创建文件
//    NSData *data = [NSData ];
//    [NSFileManager defaultManager] createFileAtPath:path contents:<#(nullable NSData *)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#>
//
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (NSValue *val in stPointsArr) {
        [arr1 addObject:NSStringFromCGPoint([val CGPointValue])];
    }
    
    NSMutableArray *arr2 = [NSMutableArray array];
    for (NSValue *val in edPointsArr) {
        [arr2 addObject:NSStringFromCGPoint([val CGPointValue])];
    }
    
    
    NSDictionary *dic = @{@"st":arr1,
                          @"ed":arr2
                          };
    BOOL tflag = [dic writeToFile:path atomically:YES];
    if (tflag){
        NSLog(@"写入成功");
    }else{
        NSLog(@"写入失败");
    }
}

#pragma mark - 文件操作
- (NSDictionary *)readDictionaryWithFileName:(NSString *)name
{
    NSString *path = [self filePathWithName:name];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    return dic;
}

- (NSString *)filePathWithName:(NSString *)name
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:name];
    return path;
}

- (CGMutablePathRef)readPathFromDic:(NSDictionary *)dic
{
    NSArray *arrSt = dic[@"st"];
    NSArray *arrEd = dic[@"ed"];
 
    CGMutablePathRef path = CGPathCreateMutable();
    
    FOR_I(arrSt.count){
        CGPoint pos;
        pos = CGPointFromString(arrSt[i]);
        CGPathMoveToPoint(path, nil, pos.x, pos.y);
        
        pos = CGPointFromString(arrEd[i]);
        CGPathAddLineToPoint(path, nil, pos.x, pos.y);
    }
    return path;
}


- (CGMutablePathRef)readPathWithName:(NSString *)name
{
    return [self readPathFromDic:[self readDictionaryWithFileName:name]];
}
- (void)wordAnimation
{
    // 获取文字路径
    CGMutablePathRef pathBegin = [self readPathWithName:@"3"];
    CGMutablePathRef pathEnd = [self readPathWithName:@"4"];
    
    // 路径到路径的动画
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 4;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 3;
    animation.fromValue = CFBridgingRelease(pathBegin);
    animation.toValue = CFBridgingRelease(pathEnd);
    animation.repeatCount = 100;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    [shapeLayer addAnimation:animation forKey:nil];
    
    [self.view.layer addSublayer:shapeLayer];
}


@end
