//
//  UIProgressView+WKWebView.h
//  JXBWebKit
//
//  Created by jinxiubo on 2018/5/4.
//  Copyright © 2018年 jinxiubo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLWebViewController;

@interface UIProgressView (WKWebView)

@property(nonatomic, assign) BOOL hiddenWhenWebDidLoad;

@property(nonatomic, strong) KLWebViewController *webViewController;

@end
