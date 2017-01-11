//
//  FSMushroomStreetGuideView.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/23.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSMushroomStreetGuideView.h"
#import "UIView+XQ.h"

@interface FSMushroomStreetGuideView()
{
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
    
    CGFloat proportion;
    
    UIScrollView *contentScrollView;
}

@end


@implementation FSMushroomStreetGuideView

- (instancetype)init
{
    self = [super init];
    
    self.frame = ScreenBounds;
    
    [self initViews];
    [self layoutViews];
    
    return self;
}

#pragma -initViews
- (void)initViews
{
    contentScrollView = [[UIScrollView alloc] initWithFrame:ScreenBounds];
    contentScrollView.pagingEnabled = YES;
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
    
    
    // 第一页
    firstInfo = [self imageViewWithName:@"1-info"];
    firstLabel = [self imageViewWithName:@"1-label"];
    firstModel = [self imageViewWithName:@"1-model"];
    firstTop = [self imageViewWithName:@"1-top"];
    
    [firstContentView addSubview:firstLabel];
    [firstContentView addSubview:firstModel];
    
    
    // 第二页
    secondAvatar = [self imageViewWithName:@"2-avatar"];
    secondImage1 = [self imageViewWithName:@"2-image1"];
    secondImage2 = [self imageViewWithName:@"2-image2"];
    secondImage3 = [self imageViewWithName:@"2-image3"];
    secondInfo = [self imageViewWithName:@"2-info"];
    secondLabel = [self imageViewWithName:@"2-label"];
    secondLeft = [self imageViewWithName:@"2-left"];
    secondRight = [self imageViewWithName:@"2-right"];
    
    [secondContentView addSubview:secondLabel];
    
    
    // 第三页
    thirdCicle = [self imageViewWithName:@"3-circle"];
    thirdLabel = [self imageViewWithName:@"3-label"];
    
    thirdModel1 = [self imageViewWithName:@"3-model1"];
    thirdModel2 = [self imageViewWithName:@"3-model2"];
    thirdModel3 = [self imageViewWithName:@"3-model3"];
    thirdModel4 = [self imageViewWithName:@"3-model4"];
    thirdModel5 = [self imageViewWithName:@"3-model5"];
    thirdModel6 = [self imageViewWithName:@"3-model6"];
    
    [thirdContentView addSubview:thirdLabel];
    
    
    // 第四页
    forthBtn = [self imageViewWithName:@"4-btn"];
    forthInfo = [self imageViewWithName:@"4-info"];
    forthLabel = [self imageViewWithName:@"4-label"];
    forthLeft = [self imageViewWithName:@"4-left"];
    
    forthModel1 = [self imageViewWithName:@"4-model1"];
    forthModel2 = [self imageViewWithName:@"4-model2"];
    forthModel3 = [self imageViewWithName:@"4-model3"];
    
    forthRight = [self imageViewWithName:@"4-right"];
    forthTop = [self imageViewWithName:@"4-top"];
    
    [forthContentView addSubview:forthLabel];
}
- (UIImageView *)imageViewWithName:(NSString *)name
{
    UIImage *img = [UIImage imageNamed:name];
    
    
    NSLog(@"image %@ not load!",name);
    
    if (img == nil) {
        NSLog(@"image %@ not load!",name);
    }
    UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
    CGRect frame = CGRectMake(0,
                              0,
                              img.size.width * proportion,
                              img.size.height * proportion);
    imgview.frame = frame;
    
    return imgview;
}

#pragma -layoutViews
- (void)layoutViews
{
    // 第一页
    firstInfo = [self imageViewWithName:@"1-info"];
    firstLabel = [self imageViewWithName:@"1-label"];
    firstModel = [self imageViewWithName:@"1-model"];
    firstTop = [self imageViewWithName:@"1-top"];
    
    [firstContentView addSubview:firstLabel];
    [firstContentView addSubview:firstModel];
    
    
    // 第二页
    secondAvatar = [self imageViewWithName:@"2-avatar"];
    secondImage1 = [self imageViewWithName:@"2-image1"];
    secondImage2 = [self imageViewWithName:@"2-image2"];
    secondImage3 = [self imageViewWithName:@"2-image3"];
    secondInfo = [self imageViewWithName:@"2-info"];
    secondLabel = [self imageViewWithName:@"2-label"];
    secondLeft = [self imageViewWithName:@"2-left"];
    secondRight = [self imageViewWithName:@"2-right"];
    
    [secondContentView addSubview:secondLabel];
    
    
    // 第三页
    thirdCicle = [self imageViewWithName:@"3-circle"];
    thirdLabel = [self imageViewWithName:@"3-label"];
    
    thirdModel1 = [self imageViewWithName:@"3-model1"];
    thirdModel2 = [self imageViewWithName:@"3-model2"];
    thirdModel3 = [self imageViewWithName:@"3-model3"];
    thirdModel4 = [self imageViewWithName:@"3-model4"];
    thirdModel5 = [self imageViewWithName:@"3-model5"];
    thirdModel6 = [self imageViewWithName:@"3-model6"];
    
    [thirdContentView addSubview:thirdLabel];
    
    
    // 第四页
    forthBtn = [self imageViewWithName:@"4-btn"];
    forthInfo = [self imageViewWithName:@"4-info"];
    forthLabel = [self imageViewWithName:@"4-label"];
    forthLeft = [self imageViewWithName:@"4-left"];
    
    forthModel1 = [self imageViewWithName:@"4-model1"];
    forthModel2 = [self imageViewWithName:@"4-model2"];
    forthModel3 = [self imageViewWithName:@"4-model3"];
    
    forthRight = [self imageViewWithName:@"4-right"];
    forthTop = [self imageViewWithName:@"4-top"];
    
    [forthContentView addSubview:forthLabel];
}
@end
