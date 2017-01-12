//
//  TestCoreImageViewController.m
//  iDraw
//
//  Created by 翁志方 on 2017/1/11.
//  Copyright © 2017年 翁志方. All rights reserved.
//

#import "TestCoreImageViewController.h"
#import <GLKit/GLKit.h>

@interface TestCoreImageViewController ()
{
    
}
@property (nonatomic, strong) GLKView *glkView;
@property (nonatomic, strong) CIImage *ciImage;
@property (nonatomic, strong) CIFilter *filter;
@property (nonatomic, strong) CIContext *ciCicontext;

@end

@implementation TestCoreImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self complexFilter];
    
    [self openGLES];
}


- (void)openGLES
{
    UIImage *showImage = [UIImage imageNamed:@"renwohua"];
    CGRect rect = CGRectMake(0, 0, showImage.size.width, showImage.size.height);
    
    // 获取OpenGLES渲染的上下文
    EAGLContext *eagContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    // 创建出渲染的buffer
    _glkView = [[GLKView alloc] initWithFrame:rect
                                      context:eagContext];
    [_glkView bindDrawable];
    [self.view addSubview:_glkView];
    
    // 创建出CoreImage用的上下文
    _ciCicontext = [CIContext contextWithEAGLContext:eagContext
                                             options:@{kCIContextWorkingColorSpace: [NSNull null]}];
    // CoreImage的相关设置
    _ciImage = [[CIImage alloc] initWithImage:showImage];
    
    _filter = [CIFilter filterWithName:@"CISepiaTone"];
    
    [_filter setValue:_ciImage forKey:kCIInputImageKey];
    [_filter setValue:@0 forKey:kCIInputIntensityKey];
    
    // 开始渲染
    [_ciCicontext drawImage:[_filter outputImage]
                     inRect:CGRectMake(0, 0, _glkView.drawableWidth, _glkView.drawableHeight)
                   fromRect:[_ciImage extent]];
    [_glkView display];
    
    // 添加滑动条
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 400, 320, 20)];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
 }
- (void)sliderValueChanged:(UISlider *)slider
{
    [_filter setValue:@(slider.value) forKey:kCIInputIntensityKey];
    
    // 开始渲染
    [_ciCicontext drawImage:[_filter outputImage]
                     inRect:CGRectMake(0, 0, _glkView.drawableWidth, _glkView.drawableHeight)
                   fromRect:[_ciImage extent]];
    [_glkView display];
}

- (void)basicFilter
{
    // 0. 导入CIImagge图片
    CIImage *ciImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"4.jpg"]];
    
    // 1. 创建filter滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setDefaults];
    
    CIImage *outImage = [filter valueForKey:kCIOutputImageKey];
    
    // 2. 使用CIContext将滤镜中的图片渲染出来
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outImage fromRect:[outImage extent]];
    
    // 3. 导出UIImage图片
    UIImage *img = [[UIImage alloc] initWithCGImage:cgImage];
    CGImageRelease(cgImage);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    imgView.image = img;
    [self.view addSubview:imgView];
}
- (void)complexFilter
{
    // 0. 导入CIImagge图片
    CIImage *ciImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"4.jpg"]];
    
    // 1. 创建filter滤镜
    CIFilter *filterOne = [CIFilter filterWithName:@"CIPixellate"];
    [filterOne setValue:ciImage forKey:kCIInputImageKey];
    [filterOne setDefaults];
    CIImage *outImage = [filterOne valueForKey:kCIOutputImageKey];
    
    CIFilter *filterTwo = [CIFilter filterWithName:@"CIHueAdjust"];
    
    NSLog(@"%@",filterTwo.attributes);
    [filterTwo setValue:outImage forKey:kCIInputImageKey];
    [filterTwo setDefaults];
    [filterTwo setValue:@-3.14 forKey:kCIInputAngleKey];
    CIImage *outputImage = [filterTwo valueForKey:kCIOutputImageKey];
    
    // 2. 使用CIContext将滤镜中的图片渲染出来
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    // 3. 导出UIImage图片
    UIImage *img = [[UIImage alloc] initWithCGImage:cgImage];
    CGImageRelease(cgImage);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:ScreenBounds];
    imgView.image = img;
    [self.view addSubview:imgView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
