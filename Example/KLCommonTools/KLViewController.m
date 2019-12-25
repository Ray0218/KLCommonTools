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
#import <KLTableView.h>
#import "KLTableViewCell.h"


@interface KLViewController ()<UITableViewDelegate>

@property(nonatomic,strong)KLTableView *rTableView;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    [KLProgressManager showLoading];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    UITextField *textField = [[UITextField alloc]init];
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:textField];
    
    
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    
    
    self.rTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight );
    //    self.rTableView.rowHeight = 100;
    self.rTableView.estimatedRowHeight = 100;
    //    self.rTableView.kl_setCellHAtIndexPath = ^CGFloat(NSIndexPath * _Nonnull indexPath) {
    //        return 100 ;
    //    }  ;
    
    
    [self.view addSubview:self.rTableView];
    self.rTableView.kl_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nonnull indexPath) {
        
        if (indexPath.row %2 == 0) {
            return [KLTableViewCell class] ;
        }
        return nil ;
    };
    
    self.rTableView.kl_getCellAtIndexPath = ^(NSIndexPath * _Nonnull indexPath, id  _Nonnull cell, id  _Nonnull model) {
        
        if (indexPath.row%2 == 0) {
            ((UITableViewCell*)cell).backgroundColor = [UIColor lightGrayColor] ;
        }
    } ;
    //    self.rTableView.kl_setCellAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
    //
    //        if (indexPath.row %2 == 1) {
    //
    //
    //        KLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dd"] ;
    //        if (!cell) {
    //            cell = [[KLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dd"];
    //            NSLog(@"######%ld#####",indexPath.row) ;
    //
    //        }
    //        return cell ;
    //        }
    //        return nil ;
    //
    //    };
    //
    //    self.rTableView.kl_setCellHAtIndexPath = ^CGFloat(NSIndexPath * _Nonnull indexPath) {
    //
    //        if (indexPath.row %3 == 0) {
    //            return 40;
    //        }
    //        return 80 ;
    //    };
    
    
    
    
    self.rTableView.zxDatas = @[@"测试本地交互",@"直接跳转链接",@"直接跳转视频链接",@"post跳转链接"];
    
    
    __weak typeof(self) weakSelf = self ;
    self.rTableView.kl_didSelectedAtIndexPath = ^(NSIndexPath * _Nonnull indexPath, id  _Nonnull model, id  _Nonnull cell) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (indexPath.row == 0) {
            [strongSelf pvt_loadJS];
            
        }else if (indexPath.row == 1){
            [strongSelf pvt_web] ;
        }
        else if (indexPath.row == 2){
            
            [strongSelf pvt_vqq];
            
        }else if (indexPath.row == 3){
            [strongSelf pvt_post];
        }
        
    };
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 ;
}

-(KLTableView*)rTableView {
    if (!_rTableView) {
        _rTableView = [[KLTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped] ;
        //        _rTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;
    }
    return _rTableView ;
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
