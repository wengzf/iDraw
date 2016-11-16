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

@interface FSScanQRCodeViewController ()
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
    
    [self setupCamera];
}


- (void)viewWillAppear:(BOOL)animated
{
    _preview.frame = ScreenBounds;
    // Start
    [_session startRunning];
    
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
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer insertSublayer:self.preview atIndex:0];
}

- (IBAction)backBtnClked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
    [_session stopRunning];

    
    NSURL *url =  [NSURL URLWithString:stringValue ];
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


@end
