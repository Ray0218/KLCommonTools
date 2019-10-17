//
//  KLJSManager.m
//  KLCommonTools_Example
//
//  Created by WKL on 2019/9/27.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#import "KLJSManager.h"
#import "KLJSViewController.h"
#import <KLWebViewController.h>


@implementation KLJSManager

-(void)pvt_show:(NSDictionary *)params {
    
 
    KLJSViewController *jsVC = [[KLJSViewController alloc]init];
    //        jsVC.successCallback = ^(NSDictionary *result) {
    //
    //            NSLog(@"%@"),result ;
    //        };
    
    jsVC.successCallback =params[@"success"];
    
    [(UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:jsVC animated:YES];
    
    
}
-(void)pvt_detail:(NSDictionary *)params {
    
    
    NSLog(@"detail");
  
    
}


@end
