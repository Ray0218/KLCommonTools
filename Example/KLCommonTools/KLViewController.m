//
//  KLViewController.m
//  KLCommonTools
//
//  Created by ray_ios@163.com on 09/23/2019.
//  Copyright (c) 2019 ray_ios@163.com. All rights reserved.
//

#import "KLViewController.h"
#import <KLProgressManager.h>

@interface KLViewController ()

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [KLProgressManager showLoading];

 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
