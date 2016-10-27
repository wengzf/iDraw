//
//  Canvas.m
//  LOGO
//
//  Created by 翁志方 on 15/3/8.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "Canvas.h"


@interface Canvas()
{
}
@end


@implementation Canvas


+ (Canvas *) sharedInstance
{
    static Canvas *canvas = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        canvas = [[Canvas alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
        
        canvas.backgroundColor = [UIColor whiteColor];
    });
    return canvas;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void) drawPicture
{
    // 海龟初始化
    DRAWINVIEW(self);
    
    if ([_controlStr isEqualToString:@"莲花"]) {
        [self lotusFlower];
        
    }else if ([_controlStr isEqualToString:@"菊花"]){
        [self chrysanthemum];
        
    }else if ([_controlStr isEqualToString:@"大理花"]){
        [self flowerWithLeaf];
        
    }else if ([_controlStr isEqualToString:@"圆形正方形错觉"]){
        [self circleSquareCollimationError];
        
    }else if ([_controlStr isEqualToString:@"普通螺线"]){
        [self spirals];
        
    }else if ([_controlStr isEqualToString:@"多边形螺线"]){
        [self polygonSpiral];
        
    }else if ([_controlStr isEqualToString:@"黄金分割螺线"]){
        [self goldenSplitSpirals];
        
    }else if ([_controlStr isEqualToString:@"正多边形螺线"]){
        [self regularPolygonSpirals];
        
    }else if ([_controlStr isEqualToString:@"太阳"]){
        [self sun];
        
    }else if ([_controlStr isEqualToString:@"团锦"]){
        [self tuanJin];
        
    }else if ([_controlStr isEqualToString:@"支付宝完成动画"]){           // 分形部分
        [self finishPayAnimation];
        
    }else if ([_controlStr isEqualToString:@"路径"]){
//        [self windmill];
        [self pathAnimation];
        return;

    }else if ([_controlStr isEqualToString:@"线条二叉树"]){           // 分形部分
        [self binaryTree];
        
    }else if ([_controlStr isEqualToString:@"正方形二叉树"]){
        [self squareBinaryTree];
        
    }else if ([_controlStr isEqualToString:@"Sierpinski三角形"]){
        [self sierpinskiTriangle];
        
    }else if ([_controlStr isEqualToString:@"Sierpinski三角形曲线"]){
        [self sierpinskiTriangleCurve];
        
    }else if ([_controlStr isEqualToString:@"aboresent肺"]){
        [self aboresentLung];
        
    }else if ([_controlStr isEqualToString:@"peano曲线"]){
        [self peanoCurve];
        
    }else if ([_controlStr isEqualToString:@"Koch雪花"]){
        [self kochSnowflakes];
        
    }else if ([_controlStr isEqualToString:@"Mandelbrot集"]){
        //        [self ];
        
    }else if ([_controlStr isEqualToString:@"Julia集"]){
        [self juliaSet];
        
    }else if ([_controlStr isEqualToString:@"IFS拼贴树"]){
        [self ifsCollageTree];
    }else if ([_controlStr isEqualToString:@"IFS螺旋"]){
        [self ifsSpiral];
    }else if ([_controlStr isEqualToString:@"IFS羊齿叶"]){
        [self ifsCurlyLeaf];
    }else if ([_controlStr isEqualToString:@"IFS二叉树"]){
        [self ifsTreeBinary];
    }else if ([_controlStr isEqualToString:@"IFSSierpinski"]){
        [self ifsRightAngleSierpinskiTriangle];
    }
    
    // 添加动画
//    {
//        CGMutablePathRef path = CGPathCreateMutable();
//        CGPathAddArc(path, NULL, self.bounds.size.width/2, self.bounds.size.height/2, 100, 0, 6.28, 0);
//        
//        
//        DRAWINVIEW(self);
//
//        PU BK(60) LT(90)  FD(100) RT(90) PD
//        
//        for (int i=0; i<3; ++i) {
//            FD(200)
//            RT(120)
//        }
//
//        CGPathRef path1 = TURTLE.shapePath;
//        
//        DRAWINVIEW(self);
//        LT(90) PU  FD(30) RT(90) PD
//        for (int i=0; i<4; ++i) {
//            FD(60)
//            RT(90)
//        }
//        CGPathRef path2 = TURTLE.shapePath;
//        
//        
//    
//        
//        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] initWithLayer:self.layer];
//        
//        shapeLayer.path = path2;
//        shapeLayer.fillColor = [UIColor clearColor].CGColor;
//        
//        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
//        shapeLayer.lineWidth = 3;
//        
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
//        animation.duration = 3;
//        animation.fromValue = (__bridge id)(path1);
//        animation.toValue = (__bridge id)(path2);
//        [shapeLayer addAnimation:animation forKey:@"animation"];
//        
//        [self.layer addSublayer:shapeLayer];
//    }
    
    // 添加动画
    {
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] initWithLayer:self.layer];
        
        shapeLayer.path = TURTLE.shapePath;
        
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        shapeLayer.lineWidth = 3;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 3;
        animation.fromValue = @0;
        animation.toValue = @1;
        [shapeLayer addAnimation:animation forKey:@"animation"];
        
        [self.layer addSublayer:shapeLayer];
    }
}

// 绘制从中心旋转的5个圆
- (void) drawFiveCircle
{
    for (int i=0; i<5; ++i) {
        [TURTLE circleRadius:80];
        [TURTLE rt:72];
    }
}

// 绘制一片叶子
- (void) leafe
{
    [TURTLE circleArcWithRadius:80 angle:70];
    [TURTLE rt:110];
    [TURTLE circleArcWithRadius:80 angle:70];
}

// 绘制3个正方形 正方形内带弧形
- (void) drawThreeSquare
{
    CGFloat len = 80;
    for (int i=0; i<3; ++i) {
        [TURTLE regularPolygon:len edgeNum:4];
        
        [TURTLE fd: len/2 ];
        
        [TURTLE circleArcWithRadius:len/2 angle:180];
    
        [TURTLE rt:90];
        [TURTLE leftCircleArcWithRadius:len/2 angle:90];
        
        [TURTLE rt:180];
        
        [TURTLE leftCircleArcWithRadius:len/2 angle:90];

        [TURTLE rt:90];
        
        [TURTLE bk:len/2];
        
        [TURTLE rt:120];
    }
}

// 画一个7个叶子的风车
- (void) windmill
{
    int num = 5;
    CGFloat len = 60;
    CGFloat len2 = 15;
    CGFloat len3 = 45;
    for (int i=0; i<num; ++i)
    {
        [TURTLE circleArcWithRadius:len angle:180];
        [TURTLE circleArcWithRadius:len2 angle:180];
        [TURTLE leftCircleArcWithRadius:len3 angle:180];
        [TURTLE rt:180];
        
        [TURTLE rt:360/num];
    }
}


// 画莲花
- (void) lotusFlower
{
    int n = 12;
    CGFloat radius = 50;
    CGFloat leafAngle = 80;
    
    LT(leafAngle/2+90);
    [TURTLE setCurWidth:3];
    for (int i=0; i<7; ++i) {
        // 画叶子
        for (int j=0; j<2; ++j) {
            [TURTLE circleArcWithRadius:radius angle:leafAngle];
            RT(180-leafAngle);
        }
        RT(360/n);
    }
    RT(90);
    [TURTLE circleArcWithRadius:100 angle:40];

}
// 画大理花
- (void) flowerWithLeaf
{
    PU; FD(80); PD;
    for (int i=0; i<12; ++i) {
        for (int j=0; j<12; ++j) {
            FD(10);
            RT(30);
        }
        RT(30);
    }
    PU; BK(37); PD;
    
    BK(100);
    FD(70);
    
    RT(45);
    CGFloat radius = 60;
    CGFloat leafAngle = 60;
    for (int j=0; j<2; ++j) {
        [TURTLE circleArcWithRadius:radius angle:leafAngle];
        RT(180-leafAngle);
    }
    LT(90+leafAngle);
    for (int j=0; j<2; ++j) {
        [TURTLE circleArcWithRadius:radius angle:leafAngle];
        RT(180-leafAngle);
    }
    
}


// 圆方视觉误差图形
- (void) circleSquareCollimationError
{
    CGFloat radius = 30;
    CGFloat delta = 10;
    
    PU;
    LT(90);
    FD(radius);
    RT(90);
    PD;
    
    for (int i=0; i<10; ++i) {
        [TURTLE circleRadius:radius];
        radius+=delta;
        
        PU;
        LT(90);
        FD(delta);
        RT(90);
        PD;
    }
    
    PU;
    RT(90);
    FD(delta*2);
    LT(90 - 45);
    PD;
    
    CGFloat squareLen = (radius-delta*2)*sqrt(2);
    for (int i=0; i<4; ++i) {
        FD(squareLen);
        RT(90);
    }
}
// 平行线错觉  等待实现直接使用位置进行直线绘制函数的实现
- (void) parrelCollimationError
{
    
}


// 多角形绘制
// 角度的乘数k 必须和边数是互质的。
- (void) ninePolygon
{
    [TURTLE polygon:60 edgeNum:9 angle:3*40];
}

// 风轮
- (void) windCircle
{
    int num = 20;
    for (int i=0; i<num; ++i) {
        [TURTLE circleArcWithRadius:60 angle:120];
        PU;
        RT(180);
        [TURTLE leftCircleArcWithRadius:60 angle:120];
        LT(180-360/num);
        PD;
    }
}

// 菊花
- (void) chrysanthemum
{
    int num = 20;
    CGFloat radius = 50;
    [TURTLE setCurWidth:2];
    for (int i=0; i<num; ++i) {
        [TURTLE circleArcWithRadius:radius angle:120];
        
        LT(90);
        [TURTLE circleRadius:4];
        RT(90);
        
        PU;
        RT(180);
        [TURTLE leftCircleArcWithRadius:radius angle:120];
        LT(180-360/num);
        PD;
    }
}


// 波浪线
- (void) tildeWithRadius:(CGFloat) radius angle:(CGFloat) angle
{
    for (int i=0; i<2; ++i) {
        [TURTLE circleArcWithRadius:radius angle:angle];
        [TURTLE leftCircleArcWithRadius:radius angle:angle];
    }
}
// 太阳
- (void) sun
{
    PU; FD(170); PD;
    [self sunWithTildeNum:20 ];
    
    PU; RT(90); BK(70); LT(90); BK(190); PD;
    [self sunWithNum:11 angleNum:3];
    
    PU; RT(90); FD(40); LT(90); BK(190); PD;
    [self sunWithNum:11 angleNum:5];
}
- (void) sunWithTildeNum:(int) num
{
    for (int i=0; i<num; ++i) {
        SAVE;
        [self tildeWithRadius:30 angle:30 ];
        RESTORE;
        RT(360/num);
    }
}
- (void) sunWithNum:(int) num angleNum:(int) angleNum
{
    FOR_I(num){
        [self tildeWithRadius:30 angle:60];
        RT(360.0*angleNum/num);
    }
}

// 团锦
- (void) tuanJin
{
    [self tuanJinWithRadius:140 num:15];
}
- (void) tuanJinWithRadius:(CGFloat) radius num:(int) num
{
    CGPoint *points;
    
    points = malloc(sizeof(CGPoint) * num);
    
    CGFloat angle = 0;
    CGFloat midx = self.bounds.size.width/2;
    CGFloat midy = self.bounds.size.height/2;
    
    for (int i=0; i<num; ++i) {
        points[i].x = midx + radius*cos(angle);
        points[i].y = midy + radius*sin(angle);
        
        angle += M_PI*2/num;
    }
    
    for (int i=0; i<num; ++i)
    {
        for (int j=i+1; j<num; ++j) {
            MOVETO(points[i]);
            LINETO(points[j]);
        }
    }
    
    free(points);
}






@end
