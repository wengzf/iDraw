//
//  FSPhotosView.m
//  DEyes
//
//  Created by 翁志方 on 14-10-24.
//
//

#import "FSPhotosView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Category.h"
@interface FSPhotosView (){
    CGRect imageScreenRect;
    
    CGFloat scrollViewBoundWidth;
}
@end

@implementation FSPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)configureWithImgArr:(NSArray *) aImageArr curIndex:(NSInteger) aCurindex frameArr:(NSArray*) aFrameArr chooseArr:(BOOL *) aChooseArr completion:(void (^)())block
{
    self.userInteractionEnabled = NO;
    
    imageScreenRect = CGRectMake(0, 60, ScreenWidth, ScreenHeight-110);
    
    // 判断时图片还是url
    if ([aImageArr[0] isKindOfClass:[NSString class]]) {
        isImage = NO;
    }else{
        isImage = YES;
    }
    
    imgArr = aImageArr;
    curIdx = aCurindex;
    frameArr = aFrameArr;
    chooseArr = aChooseArr;
    completionBlock = block;
    
    // 初始位置
    NSValue *val = frameArr[curIdx];
    CGRect originalFrame = [val CGRectValue];

    self.backgroundColor = [UIColor clearColor];
    bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    
    // 先播放一个从stFrame 开始的动画
    self.tmpImgView = [[UIImageView alloc] initWithFrame:originalFrame];
    self.tmpImgView.contentMode = UIViewContentModeScaleAspectFit;

    self.tmpImgView.clipsToBounds = YES;
    if (isImage) {
        self.tmpImgView.image = [imgArr objectAtIndex:curIdx];
    }else{
        [self.tmpImgView sd_setImageWithURL:imgArr[curIdx] placeholderImage:nil];
    }

    [self addSubview:self.tmpImgView];
    

    [self startAninamtion];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapExitPhotosView)];
    [self addGestureRecognizer:tap];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
- (void)startAninamtion{ // 1:获取到图片；2:未获取到图片

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tmpImgView.frame = imageScreenRect;
        bgView.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        self.tmpImgView.hidden = YES;
        
        [self initScrollViewContent];
        self.userInteractionEnabled = YES;
    }];

}

#pragma mark -
- (void)initScrollViewContent
{
    scrollViewBoundWidth = ScreenWidth + 40;
    CGRect bounds = imageScreenRect;
    bounds.size.width = scrollViewBoundWidth;
    scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    
    CGFloat x = 0;
    CGFloat height = scrollView.bounds.size.height;

    contentImageViewArr = [NSMutableArray array];
    imageViewArr = [NSMutableArray array];
    
    for (int i=0; i<[imgArr count]; ++i) {
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, ScreenWidth, height)];
        contentView.clipsToBounds = YES;
        
        imgview.clipsToBounds = YES;
        imgview.contentMode = UIViewContentModeScaleAspectFit;
        
        if (isImage) {
            imgview.image = imgArr[i];
        }else{
            [imgview sd_setImageWithURL:imgArr[i] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
        }
        
        x += scrollViewBoundWidth;
        [contentView addSubview:imgview];
        [scrollView addSubview:contentView];
        
        
        [contentImageViewArr addObject:contentView];
        [imageViewArr addObject:imgview];
    }
    scrollView.contentSize = CGSizeMake([imgArr count]*scrollViewBoundWidth, height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentOffset = CGPointMake(curIdx*scrollViewBoundWidth, 0);
    scrollView.delegate = self;
    
    // pageControl
    pageControl = [[UIPageControl alloc] init];
    
    pageControl.numberOfPages = [imgArr count];
    pageControl.currentPage = curIdx;
    
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];

    [pageControl sizeToFit];
    pageControl.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height - 25);
    
    // 选中状态
    chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-40, 10, 30, 30)];
    [self updateChooseBtnStateWithAnimated:NO];
    [chooseBtn addTarget:self action:@selector(chooseBtnClked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:scrollView];
    [self addSubview:pageControl];
    [self addSubview:chooseBtn];
}

- (void)chooseBtnClked
{
    chooseArr[curIdx] = !chooseArr[curIdx];
    [self updateChooseBtnStateWithAnimated:YES];
}

- (void)updateChooseBtnStateWithAnimated:(BOOL)animated
{
    if (chooseArr[curIdx]) {
        [chooseBtn setImage:[UIImage imageNamed:@"earn_choose"] forState:UIControlStateNormal];
        if (animated) {
            [self springAnimationWithView:chooseBtn];
        }
        
    }else{
        [chooseBtn setImage:[UIImage imageNamed:@"earn_option"] forState:UIControlStateNormal];
    }
}
- (void)springAnimationWithView:(UIView *)view
{
    view.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.transform = CGAffineTransformMakeScale(0.88, 0.88);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                view.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}
- (void)tapExitPhotosView
{
    self.userInteractionEnabled = NO;
    self.tmpImgView.hidden = NO;
    
    if (isImage) {
        self.tmpImgView.image = imgArr[curIdx];
    }else{
        [self.tmpImgView sd_setImageWithURL:imgArr[curIdx] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    
    [self bringSubviewToFront:self.tmpImgView];

    scrollView.hidden = YES;
    
    NSValue *val = frameArr[curIdx];
    CGRect endFrame = [val CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tmpImgView.frame = endFrame;
        bgView.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        completionBlock();
        [self removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
}

#pragma mark - scroll view delegate

- (void) scrollViewDidScroll:(UIScrollView *)ascrollView
{
    CGFloat offsetX = ascrollView.contentOffset.x;
    int tmpIndex = offsetX / scrollViewBoundWidth;

    if (tmpIndex != curIdx) {
        pageControl.currentPage = tmpIndex;
        curIdx = tmpIndex;
        [self updateChooseBtnStateWithAnimated:NO];
    }

    // 计算视差
    {
        for (int index=tmpIndex; index<=tmpIndex+1 && index<imageViewArr.count; ++index) {
            UIImageView *imageView = imageViewArr[index];
            CGRect frame = imageView.frame;
            frame.origin.x = (offsetX - index*scrollViewBoundWidth)*0.2;
            imageView.frame = frame;
        }
    }

}




@end
