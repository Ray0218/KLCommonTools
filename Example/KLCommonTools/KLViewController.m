//
//  KLViewController.m
//  KLCommonTools
//
//  Created by ray_ios@163.com on 09/23/2019.
//  Copyright (c) 2019 ray_ios@163.com. All rights reserved.
//

#import "KLViewController.h"
#import <KLProgressManager.h>
#import <KLWebViewController.h>
  @interface KLViewController ()

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [KLProgressManager showLoading];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn setTitle:@"测试本地交互" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor purpleColor] ;
    btn.frame = CGRectMake(40, 150, 200, 45);
    [btn addTarget:self action:@selector(pvt_loadJS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn2 setTitle:@"直接跳转链接" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor purpleColor] ;
    btn2.frame = CGRectMake(40, 250, 200, 45);
    [btn2 addTarget:self action:@selector(pvt_web) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
   
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn3 setTitle:@"直接跳转视频链接" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor purpleColor] ;
    btn3.frame = CGRectMake(40, 350, 200, 45);
    [btn3 addTarget:self action:@selector(pvt_vqq) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn4 setTitle:@"post跳转链接" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor purpleColor] ;
    btn4.frame = CGRectMake(40, 450, 200, 45);
    [btn4 addTarget:self action:@selector(pvt_post) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
 }

-(void)pvt_loadJS {
    NSString *urlStr = [NSString stringWithFormat:@"file://%@",[[NSBundle mainBundle] pathForResource:@"h5" ofType:@"html"]];
    
    KLWebViewController *webVC = [[KLWebViewController alloc] initWithURLString:urlStr];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

-(void)pvt_web {
    KLWebViewController *webVC = [[KLWebViewController alloc] initWithURLString:@"https://www.baidu.com"];
    
    
    [(UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:webVC animated:YES];
    
}


-(void)pvt_vqq {
    KLWebViewController *webVC = [[KLWebViewController alloc] initWithURLString:@"https://v.qq.com"];
    
    
    [(UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:webVC animated:YES];

}

-(void)pvt_post {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mocky.io/v2/5adef15a3300002500e4d6bb"]];
    request.HTTPMethod = @"POST";
    NSString *str = @"username=jxb&password=123456";
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    KLWebViewController *webVC = [[KLWebViewController alloc] initWithURLRequest:request];
    
         [(UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:webVC animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
