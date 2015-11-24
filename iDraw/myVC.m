//
//  myVC.m
//  iDraw
//
//  Created by 翁志方 on 15/5/4.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#import "myVC.h"

@implementation myVC

@synthesize webView;
- (void) viewDidLoad
{
    // 在这里插入对应label变化代码
    
    
    _label = [[UILabel alloc] init];
    _label.backgroundColor = [UIColor yellowColor];
    
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_label];
    
    

    
     _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    
//    _btn = [[UIButton alloc] init];
    
    NSDictionary *dic=@{@"w":[NSNumber numberWithInt:10]};
    [self.view addSubview:_btn];
    [_btn setTitle:@"click me" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnClked) forControlEvents:UIControlEventTouchUpInside];

    
    
    // 在此处添加label对应约束
    NSDictionary *views = NSDictionaryOfVariableBindings(_label,_btn);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-w-[_label]-80-[_btn]"
                                                                      options:0
                                                                      metrics:dic
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_label]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];

    
    
    _labelContent = @"100000";
    _label.text = _labelContent;
    
    
    //        self.view.translatesAutoresizingMaskIntoConstraints = NO;
    {
//    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    
//    [self.view addSubview:webView];
//    
//    NSURL *url = [[NSURL alloc] initWithString:@"http://www.yonglibao.com/a/692.html"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    [webView loadRequest:request];
//
//    [self performSelector:@selector(btnClked) withObject:nil afterDelay:2];
    }
}


- (void) btnClked
{
    _labelContent = [_labelContent stringByAppendingString:@"hello"];
    _label.text = _labelContent;
    
    [_label sizeToFit];
    NSLog(@"%f %f",_label.frame.size.height,_label.frame.size.width);
    
    
    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    NSLog(@"%@",str);
}



@end
