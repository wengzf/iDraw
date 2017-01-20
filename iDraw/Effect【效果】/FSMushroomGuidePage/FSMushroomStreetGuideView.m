//
//  FSMushroomStreetGuideView.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/23.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSMushroomStreetGuideView.h"
#import "UIView+XQ.h"

#import "ShadowView.h"

#import "FSEffectLabel.h"


@interface FSMushroomStreetGuideView()<UIScrollViewDelegate>
{
    // 中间的相框
    UIView *contentPictureView;
    
    // 第一页
    UIImageView *firstInfo;
    UIImageView *firstLabel;
    UIImageView *firstModel;
    UIImageView *firstTop;
    UIView *firstContentView;
    
    // 第二页
    UIImageView *secondAvatar;
    UIImageView *secondImage1;
    UIImageView *secondImage2;
    UIImageView *secondImage3;
    UIImageView *secondInfo;
    UIImageView *secondLabel;
    UIImageView *secondLeft;
    UIImageView *secondRight;
    UIView *secondContentView;
    
    // 第三页
    UIImageView *thirdCicle;
    UIImageView *thirdLabel;
    
    UIImageView *thirdModel1;
    UIImageView *thirdModel2;
    UIImageView *thirdModel3;
    UIImageView *thirdModel4;
    UIImageView *thirdModel5;
    UIImageView *thirdModel6;
    UIView *thirdContentView;
    
    // 第四页
    UIImageView *forthBtn;
    UIImageView *forthInfo;
    UIImageView *forthLabel;
    UIImageView *forthLeft;
    UIImageView *forthRight;
    UIImageView *forthTop;
    UIImageView *forthModel1;
    UIImageView *forthModel2;
    UIImageView *forthModel3;
    UIView *forthContentView;
    
    // 4个UI组
    NSMutableArray *groupArr1;
    NSMutableArray *groupArr2;
    NSMutableArray *groupArr3;
    NSMutableArray *groupArr4;
    NSArray *groupArr;
    
    
    CGFloat proportion;
    
    UIScrollView *contentScrollView;
    
    // pageControl
    UIPageControl *pageControl;
    
    // Layout
    CGFloat topMargin;
    CGFloat centerX;
    
}

@end


@implementation FSMushroomStreetGuideView

- (instancetype)init
{
    self = [super init];
    
    self.frame = ScreenBounds;

    self.backgroundColor = [UIColor whiteColor];
    
    [self initViews];
    
    return self;
}

#pragma -initViews
- (void)initViews
{
    proportion = ScreenWidth/375;
    
    topMargin = 32;
    centerX = ScreenWidth/2;
    
    // scrollView 初始化
    {
        contentScrollView = [[UIScrollView alloc] initWithFrame:ScreenBounds];
        contentScrollView.pagingEnabled = YES;
        contentScrollView.delegate = self;
        contentScrollView.showsHorizontalScrollIndicator = NO;
        contentScrollView.bounces = NO;
        [self addSubview:contentScrollView];
        
        CGRect frame = ScreenBounds;
        
        firstContentView = [[UIView alloc] initWithFrame:frame];
        [contentScrollView addSubview:firstContentView];
        
        frame.origin.x += ScreenWidth;
        secondContentView = [[UIView alloc] initWithFrame:frame];
        [contentScrollView addSubview:secondContentView];
        
        frame.origin.x += ScreenWidth;
        thirdContentView = [[UIView alloc] initWithFrame:frame];
        [contentScrollView addSubview:thirdContentView];
        
        frame.origin.x += ScreenWidth;
        forthContentView = [[UIView alloc] initWithFrame:frame];
        [contentScrollView addSubview:forthContentView];
        
        contentScrollView.contentSize =  CGSizeMake(ScreenWidth*4, ScreenHeight);
    }
    
    // 组初始化
    {
        groupArr1 = [NSMutableArray array];
        groupArr2 = [NSMutableArray array];
        groupArr3 = [NSMutableArray array];
        groupArr4 = [NSMutableArray array];
        groupArr = @[groupArr1, groupArr2, groupArr3, groupArr4];
    }
    
    // 相框初始化
    {
        contentPictureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 156)];
        contentPictureView.backgroundColor = [UIColor whiteColor];
        contentPictureView.top = 112;
        contentPictureView.centerX = centerX;
        contentPictureView.layer.cornerRadius = 6;
//        contentPictureView.layer.masksToBounds = YES;
        [self addSubview:contentPictureView];
        
        // 阴影设置
        contentPictureView.layer.shadowOffset = CGSizeMake(0, 0);
        contentPictureView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        contentPictureView.layer.shadowRadius = 15;
        contentPictureView.layer.shadowOpacity = 0.6;
    }
    
    // 第一页
    {
        firstLabel = [self imageViewWithName:@"1-label"];   // first
        firstTop   = [self imageViewWithName:@"1-top"];         // contentPicture
        firstInfo  = [self imageViewWithName:@"1-info"];        // contentPicture
        firstModel = [self imageViewWithName:@"1-model"];   // first
        
        // 组
        [groupArr1 addObject:firstTop];
        [groupArr1 addObject:firstInfo];
        
        // 标题
        firstLabel.top = topMargin;                 // 235*108
        firstLabel.centerX = centerX;
        [firstContentView addSubview:firstLabel];
    
        // 相框   220, 156
        firstTop.frame = CGRectMake(4, 4, contentPictureView.width-8, 100);     // 菇凉
        [contentPictureView addSubview:firstTop];
        
        firstInfo.frame = CGRectMake(3, 108, contentPictureView.width-8, 40);   // 文字信息
        [contentPictureView addSubview:firstInfo];
        
        
        // 相框底下模特
        firstModel.top = 274;
        firstModel.centerX = centerX;
        [firstContentView addSubview:firstModel];
    }
    
    // 第二页
    {
        secondAvatar = [self imageViewWithName:@"2-avatar"];    // contentPicture
        secondImage1 = [self imageViewWithName:@"2-image1"];    // contentPicture
        secondImage2 = [self imageViewWithName:@"2-image2"];    // contentPicture
        secondImage3 = [self imageViewWithName:@"2-image3"];    // contentPicture
        secondInfo   = [self imageViewWithName:@"2-info"];      // contentPicture
        secondLabel  = [self imageViewWithName:@"2-label"]; // second
        secondLeft   = [self imageViewWithName:@"2-left"];              // self
        secondRight  = [self imageViewWithName:@"2-right"];             // self
        
        
        // 组
        [groupArr2 addObject:secondAvatar];
        [groupArr2 addObject:secondImage1];
        [groupArr2 addObject:secondImage2];
        [groupArr2 addObject:secondImage3];
        [groupArr2 addObject:secondInfo];
        [groupArr2 addObject:secondLeft];
        [groupArr2 addObject:secondRight];
        
        // 标题
        secondLabel.top = topMargin;
        secondLabel.centerX = centerX;
        [secondContentView addSubview:secondLabel];
        
        // 临时比例计算
        CGFloat tmp;
        
        // 相框   220, 276   top=138
        CGFloat top = 138;
        tmp = 34/80.0;
        secondAvatar.frame = CGRectMake(4, 4, 183*tmp, 80*tmp);     //      183*80
        secondAvatar.contentMode = UIViewContentModeLeft;
        [contentPictureView addSubview:secondAvatar];
        
        secondImage1.frame = CGRectMake(4, 54, 140, 140);     // 330*330
        [contentPictureView addSubview:secondImage1];
        
        secondImage2.frame = CGRectMake(148, 54, 68, 68);     // 160*160
        [contentPictureView addSubview:secondImage2];
        
        secondImage3.frame = CGRectMake(148, 126, 68, 68);     // 160*160
        [contentPictureView addSubview:secondImage3];
        
        secondInfo.frame = CGRectMake(8, 194, 204, 149*204/473.0);     // 473*149
        [contentPictureView addSubview:secondInfo];
        
        // 左右两张图片
        CGSize size = CGSizeMake(520*260/650.0, 260);
        secondLeft.frame = CGRectMake(0, 0, size.width, size.height);     // 520*650
        secondLeft.top = top-4;
        secondLeft.right = 20;
        [self addSubview:secondLeft];
        
        secondRight.frame = CGRectMake(0, 0, size.width, size.height);     // 520*650
        secondRight.top = top-4;
        secondRight.left = ScreenWidth - 20;
        [self addSubview:secondRight];
    }
    
    // 第三页
    {
        thirdCicle = [self imageViewWithName:@"3-circle"];
        thirdLabel = [self imageViewWithName:@"3-label"];   // thirdContentView
        
        thirdModel1 = [self imageViewWithName:@"3-model1"];    // contentPicture
        thirdModel2 = [self imageViewWithName:@"3-model2"];    // contentPicture
        thirdModel3 = [self imageViewWithName:@"3-model3"];    // contentPicture
        thirdModel4 = [self imageViewWithName:@"3-model4"];    // contentPicture
        thirdModel5 = [self imageViewWithName:@"3-model5"];    // contentPicture
        thirdModel6 = [self imageViewWithName:@"3-model6"];    // contentPicture
        
        // 组
        [groupArr3 addObject:thirdModel1];
        [groupArr3 addObject:thirdModel2];
        [groupArr3 addObject:thirdModel3];
        [groupArr3 addObject:thirdModel4];
        [groupArr3 addObject:thirdModel5];
        [groupArr3 addObject:thirdModel6];
        
        // 标题
        thirdLabel.top = topMargin;
        thirdLabel.centerX = centerX;
        [thirdContentView addSubview:thirdLabel];
        
        
        // 相框   196*282             (196 - 16) / 3 = 60    (280-12)/2=136
        thirdModel1.frame = CGRectMake(4, 4, 60, 136);     // 140*315
        [contentPictureView addSubview:thirdModel1];
        
        thirdModel2.frame = CGRectMake(68, 4, 60, 136);     // 140*315
        [contentPictureView addSubview:thirdModel2];
        
        thirdModel3.frame = CGRectMake(132, 4, 60, 136);     // 140*315
        [contentPictureView addSubview:thirdModel3];
        
        thirdModel4.frame = CGRectMake(4, 144, 60, 136);     // 140*315
        [contentPictureView addSubview:thirdModel4];
        
        thirdModel5.frame = CGRectMake(68, 144, 60, 136);     // 140*315
        [contentPictureView addSubview:thirdModel5];
        
        thirdModel6.frame = CGRectMake(132, 144, 60, 136);     // 140*315
        [contentPictureView addSubview:thirdModel6];
    }
    
    // 第四页
    {
        forthBtn   = [self imageViewWithName:@"4-btn"];
        forthLabel = [self imageViewWithName:@"4-label"];
        forthLeft  = [self imageViewWithName:@"4-left"];
        
        forthModel1 = [self imageViewWithName:@"4-model1"];     // contentPicture
        forthModel2 = [self imageViewWithName:@"4-model2"];     // contentPicture
        forthModel3 = [self imageViewWithName:@"4-model3"];     // contentPicture
        
        forthRight = [self imageViewWithName:@"4-right"];
        forthTop   = [self imageViewWithName:@"4-top"];         // contentPicture
        forthInfo  = [self imageViewWithName:@"4-info"];        // contentPicture
        
        // 组
        [groupArr4 addObject:forthModel1];
        [groupArr4 addObject:forthModel2];
        [groupArr4 addObject:forthModel3];
        [groupArr4 addObject:forthTop];
        [groupArr4 addObject:forthInfo];
        [groupArr4 addObject:forthLeft];
        [groupArr4 addObject:forthRight];
        
        // 标题
        forthLabel.top = topMargin;                     // 235*108
        forthLabel.centerX = centerX;
        [forthContentView addSubview:forthLabel];
        
        
        // 相框   145, 228
        forthTop.frame = CGRectMake(4, 4, 137, 74);     // 328*176
        [contentPictureView addSubview:forthTop];
        
        forthInfo.frame = CGRectMake(4, 84, 137, 62);     // 312*141
        [contentPictureView addSubview:forthInfo];
        
        // (145-16)/3 = 43   66
        forthModel1.frame = CGRectMake(4, 154, 43, 66);     // 104*160
        [contentPictureView addSubview:forthModel1];
        
        forthModel2.frame = CGRectMake(51, 154, 43, 66);     // 104*160
        [contentPictureView addSubview:forthModel2];
        
        forthModel3.frame = CGRectMake(98, 154, 43, 66);     // 104*160
        [contentPictureView addSubview:forthModel3];
        
        // 左右两张图片
        CGSize size = CGSizeMake(520*260/650.0, 260);
        forthLeft.frame = CGRectMake(0, 0, size.width, size.height);     // 561*697
        forthLeft.top = contentPictureView.top-4;
        forthLeft.right = 50;
        [self addSubview:forthLeft];
        
        forthRight.frame = CGRectMake(0, 0, size.width, size.height);     // 561*697
        forthRight.top = contentPictureView.top-4;
        forthRight.left = ScreenWidth - 50;
        [self addSubview:forthRight];
    }
    
    // pageControl
    {
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        pageControl.numberOfPages = 4;
        pageControl.pageIndicatorTintColor = [UIColor blackColor];
        pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        
        pageControl.bottom = ScreenHeight - 30;
        pageControl.centerX = centerX;
        
        [self addSubview:pageControl];
    }
    
    // 移动相框到最顶层
    [self bringSubviewToFront:contentPictureView];
    
    [self justShowIndex:0];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
//    label.font = [UIFont systemFontOfSize:40 weight:1.4];
//    label.text = @"相框";
//    label.textColor = [UIColor blackColor];
//    [contentPictureView addSubview:label];
    
}
- (UIImageView *)imageViewWithName:(NSString *)name
{
    UIImage *img = [UIImage imageNamed:name];
    
    if (img == nil) {
        NSLog(@"image %@ not load!",name);
    }
    UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
    imgview.contentMode = UIViewContentModeScaleAspectFit;
    CGRect frame = CGRectMake(0,
                              0,
                              img.size.width,
                              img.size.height);
    imgview.frame = frame;
    
    return imgview;
}


#pragma mark - ScrollView 代理

// 线性计算
float calculate(float begin, float end, float lowerBound, float upperBound, float curVal)
{
    float res;
    
    if (curVal<lowerBound) {
        curVal = lowerBound;
    }
    if (curVal>upperBound) {
        curVal = upperBound;
    }
    float t = (curVal-lowerBound) / (upperBound-lowerBound);
    
    res = begin + (end-begin)*t;
    
    return res;
}
float calculateBoundDelta(float begin, float end, float lowerBound, float delta, float curVal)
{
    return calculate(begin, end, lowerBound, lowerBound+delta, curVal);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    int curIndex = offset / ScreenWidth;
    if (curIndex != pageControl.currentPage) {
        pageControl.currentPage = curIndex;
//        [self justShowIndex:curIndex];
    }
    // 动画
    // 第一页跟第二页之间
    
    // top 消失，接下来info消失
    // 相框部分开始慢慢往上方变大
    
    // 相框
    {
        // 相框originY
        if (offset < 160) {
            
            contentPictureView.top    = calculate(112, 80, 0, 160, offset);
        }else if (offset < 320) {
            
            contentPictureView.top    = calculate(80, 138, 160, 320, offset);
        }else if (offset < 200) {
            
            contentPictureView.top    = calculate(112, 80, 0, 200, offset);
        }else if (offset < 200) {
            
            contentPictureView.top    = calculate(112, 80, 0, 200, offset);
        }else if (offset < 200) {
            
            contentPictureView.top    = calculate(112, 80, 0, 200, offset);
        }
        
        // 相框高度
        if (offset <= 230) {
            
            contentPictureView.height = calculate(156, 276, 0, 230, offset);
        }
    }
    
    // 第一页
    {
        firstTop.alpha = calculate(1, 0, 0, 120, offset);
        firstInfo.alpha = calculate(1, 0, 30, 160, offset);
    }
    
    // 第二页
    {
        secondAvatar.alpha = calculate(0, 1, 260, 320, offset);
        secondInfo.alpha = calculate(0, 1,  260, 320, offset);
        
        float tmp;
        
        tmp = calculate(0, 140, 160, 200, offset);
        secondImage1.width = tmp;
        secondImage1.height = tmp;
        secondImage1.alpha = calculate(0, 1, 160, 200, offset);;
        
        tmp = calculate(0, 68, 190, 230, offset);
        secondImage2.width = tmp;
        secondImage2.height = tmp;
        secondImage2.alpha = calculate(0, 1, 190, 230, offset);
        
        tmp = calculate(0, 68, 220, 260, offset);
        secondImage3.width = tmp;
        secondImage3.height = tmp;
        secondImage3.alpha = calculate(0, 1, 220, 260, offset);
        
        // 中间两页从中间移动往两边, 第三个model出来的时候
        if (offset<320) {
            secondLeft.alpha = calculate(0, 1, 220, 230, offset);
            secondRight.alpha = calculate(0, 1, 220, 230, offset);
            
            secondLeft.centerX = calculate(centerX, 0-30, 230, 270, offset);
            secondRight.centerX = calculate(centerX, ScreenWidth+30, 230, 270, offset);
        }else{
            // 隐藏
            secondLeft.alpha = calculate(0, 1, ScreenWidth, ScreenWidth, offset);
            secondRight.alpha = calculate(0, 1, ScreenWidth, 230, offset);
            
            secondLeft.centerX = calculate(centerX, 0-30, ScreenWidth, 270, offset);
            secondRight.centerX = calculate(ScreenWidth+30, centerX, ScreenWidth, 270, offset);
        }
    }
    
    // 第三页
    {
//        thirdCicle = [self imageViewWithName:@"3-circle"];
//        thirdLabel = [self imageViewWithName:@"3-label"];   // thirdContentView
//        
//        thirdModel1 = [self imageViewWithName:@"3-model1"];    // contentPicture
//        thirdModel2 = [self imageViewWithName:@"3-model2"];    // contentPicture
//        thirdModel3 = [self imageViewWithName:@"3-model3"];    // contentPicture
//        thirdModel4 = [self imageViewWithName:@"3-model4"];    // contentPicture
//        thirdModel5 = [self imageViewWithName:@"3-model5"];    // contentPicture
//        thirdModel6 = [self imageViewWithName:@"3-model6"];    // contentPicture
        
        
//        320 640
        if (offset < 640) {
            CGFloat st = ScreenWidth * 1.2;
            CGFloat dis = ScreenWidth * 0.5;
            CGFloat delta = ScreenWidth * 0.05;
            
            thirdModel1.alpha = calculate(0, 1, st, st+dis, offset);
            
            st+=delta;
            thirdModel2.alpha = calculate(0, 1, st, st+dis, offset);
            
            st+=delta;
            thirdModel3.alpha = calculate(0, 1, st, st+dis, offset);
            
            st+=delta;
            thirdModel4.alpha = calculate(0, 1, st, st+dis, offset);
            
            st+=delta;
            thirdModel5.alpha = calculate(0, 1, st, st+dis, offset);
            
            st+=delta;
            thirdModel6.alpha = calculate(0, 1, st, st+dis, offset);
        }else{
            CGFloat st = ScreenWidth * 2.2;
            CGFloat dis = ScreenWidth * 0.5;
            CGFloat delta = ScreenWidth * 0.05;
            
            // 相框旋转
            CGFloat angle = calculate(0, M_PI_4, st, st+dis, offset);
            CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
            contentPictureView.transform = transform;
            
            // 模特消失
            
            st+=delta;
            thirdModel3.alpha = calculate(1, 0, st, st+dis, offset);
            thirdModel4.alpha = calculate(1, 0, st, st+dis, offset);
            
            st+=delta;
            thirdModel2.alpha = calculate(1, 0, st, st+dis, offset);
            thirdModel5.alpha = calculate(1, 0, st, st+dis, offset);
            
            st+=delta;
            thirdModel1.alpha = calculate(1, 0, st, st+dis, offset);
            thirdModel6.alpha = calculate(1, 0, st, st+dis, offset);
        }
    }
    
    // 第四页
    {
        // 相框动画，旋转缩小
        
        
        // 相框内部内容
        
        CGFloat st = ScreenWidth * 3.2;
        CGFloat dis1 = ScreenWidth * 0.1;
        CGFloat dis2 = ScreenWidth * 0.5;
        CGFloat delta = ScreenWidth * 0.05;
        
        forthTop.alpha = calculate(0, 1, st, st+dis1, offset);
        
        st+=delta;
        forthInfo.alpha = calculate(0, 1, st, st+dis1, offset);
        
        st+=delta;
        forthModel1.alpha = calculate(0, 1, st, st+dis2, offset);
        
        st+=delta;
        forthModel2.alpha = calculate(0, 1, st, st+dis2, offset);
        
        st+=delta;
        forthModel3.alpha = calculate(0, 1, st, st+dis2, offset);
        
        
        // 左右两张图片
        
        
//        forthBtn;
//         *forthInfo;
//         *forthLabel;
//         *forthLeft;
//         *forthRight;
//         *forthTop;
        
        
        //
    }
}


- (void)justShowIndex:(NSInteger)index
{
    FOR_I(4){
        if (i == index) {
            [self showGroup:groupArr[i]];
        }else{
            [self hideGroup:groupArr[i]];
        }
    }
}

- (void)showGroup:(NSArray *)arr
{
    for (UIView *view in arr) {
        view.alpha = 1;
    }
}
- (void)hideGroup:(NSArray *)arr
{
    for (UIView *view in arr) {
        view.alpha = 0;
    }
}

// 给view添加阴影
- (void)addShadowToView:(UIView *)view
{
    
}

@end
