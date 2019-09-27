//
//  MSWKWebViewPool.h
//  JXBWebKit
//
//  Created by jinxiubo on 2018/5/17.
//  Copyright © 2018年 jinxiubo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KLWebView;

#define kWKWebViewReuseUrlString @"kwebkit://reuse-webView"
#define kWKWebViewReuseScheme    @"kwebkit"

@protocol JXBWKWebViewReuseProtocol
- (void)webViewWillReuse;
- (void)webViewEndReuse;
@end

@interface JXBWKWebViewPool : NSObject

/**
 是否需要在App启动时提前准备好一个可复用的WebView,默认为YES.
 prepare=YES时,可显著优化WKWebView首次启动时间.
 prepare=NO时,不会提前初始化一个可复用的WebView.
 */
@property(nonatomic, assign) BOOL prepare;

+ (instancetype)sharedInstance;

- (__kindof KLWebView *)getReusedWebViewForHolder:(id)holder;

- (void)recycleReusedWebView:(__kindof KLWebView *)webView;

- (void)cleanReusableViews;

@end
