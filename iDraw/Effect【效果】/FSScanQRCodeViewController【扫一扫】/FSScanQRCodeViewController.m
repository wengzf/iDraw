//
//  FSScanQRCodeViewController.m
//  NewProject
//
//  Created by 翁志方 on 15/7/7.
//  Copyright (c) 2015年 Steven. All rights reserved.
//

#import "FSScanQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface FSScanQRCodeViewController ()<UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate>
{
    CGRect captureBounds;
    BOOL flagAnimationUpDir;
    
    UIImageView *contentView;

    BOOL flagNavBackShow;
}

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;


@end

@implementation FSScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            // 许可对话没有出现，发起授权许可
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                //*******************先回主线程
                if (granted) {
                    //第一次用户接受
                    [self setupCamera];
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //用户拒绝
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你已阻止任我花访问你的相机，请前往设置-隐私-相机中打开" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        alert.delegate = self;
                        [alert show];
                    });
                    return;
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            // 已经开启授权，可继续
            
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:{
            // 用户明确地拒绝授权，或者相机设备无法访问
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你已阻止任我花访问你的相机，请前往设置-隐私-相机中打开" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];
            
            return ;
        }
            break;
        default:
            break;
    }
    
    //判断相机权限和是否可用
    {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            
            for (UIView *view in self.view.subviews) {
                view.hidden = YES;
            }
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你已阻止任我花访问你的相机，请前往设置-隐私-相机中打开" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        else
        {
            
            for (UIView *view in self.view.subviews) {
                view.hidden = NO;
            }
        }
        
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] || [mediaTypes count] <= 0)
        {
            for (UIView *view in self.view.subviews) {
                view.hidden = YES;
            }
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"相机不可用" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        else
        {
            for (UIView *view in self.view.subviews) {
                view.hidden = NO;
            }
        }
    }
    
    // 添加扫描图片
    {
        captureBounds = self.captureView.bounds;
        
        flagAnimationUpDir = YES;
        
        // 开始播放动画
        contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 290)];
        contentView.image = [UIImage imageNamed:@"sao"];
        [self.captureView addSubview:contentView];
        
        [self startAnimation];
    }
    
    // 设置白边为一个像素
    {
//        [self.view resetDeviderLineToOnePixel];
    }
    
    self.activityIndicatorView.hidden = YES;
 
}



- (void)viewWillAppear:(BOOL)animated
{
    self.preview.frame = ScreenBounds;
    // Start
    [self.session startRunning];
    
    if (self.navigationController.navigationBar.hidden == NO){
        self.navigationController.navigationBar.hidden = YES;
        flagNavBackShow = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (flagNavBackShow) {
        self.navigationController.navigationBar.hidden = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimation
{
    contentView.frame = CGRectMake(0, -290, 290, 290);
    contentView.alpha = 0.1;
    [UIView animateWithDuration:1.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        contentView.frame = CGRectMake(0, -15, 290, 290);
        contentView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            contentView.frame = CGRectMake(0, 0, 290, 290);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                contentView.alpha = 0;
                
            } completion:^(BOOL finished) {
                
                [self startAnimation];
            }];
            
        }];
    }];
}

- (void)setupCamera
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    self.output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    self.preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer insertSublayer:self.preview atIndex:0];
}

- (IBAction)backBtnClked:(id)sender {

    if (self.navigationController) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    
    }
    [self.session stopRunning];

    
//    NSURL *url =  [NSURL URLWithString:stringValue ];
//    BOOL canOpen = [url checkResourceIsReachableAndReturnError:nil];
    BOOL canOpen = YES;
    if (canOpen) {
        // 添加代码跳转到对应的WebView
    }
    
    // 播放成功扫码音效
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"weixinScan" ofType:@"mp3"];
        
        SystemSoundID soundID;
        
        NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
        AudioServicesPlaySystemSound(soundID);
        
    }
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self backBtnClked:nil];
}

@end
