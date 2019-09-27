//
//  KLJSViewController.m
//  KLCommonTools_Example
//
//  Created by WKL on 2019/9/26.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#import "KLJSViewController.h"

@interface KLJSViewController ()

@end

@implementation KLJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [btn setTitle:@"测试OC调JS本地交互" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor purpleColor] ;
    btn.frame = CGRectMake(40, 150, 200, 45);
    [btn addTarget:self action:@selector(pvt_loadJS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
}

-(void)pvt_loadJS {
    
    if (self.successCallback) {
        NSLog(@"%@",self.successCallback) ;
        self.successCallback(@{
                                @"value":@"success result from GoodListController"
                                });
    }
}
 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
