//
//  MSWKWebViewPool.m
//  JXBWebKit
//
//  Created by jinxiubo on 2018/5/17.
//  Copyright © 2018年 jinxiubo. All rights reserved.
//

#import "JXBWKWebViewPool.h"
#import "KLWebView.h"
#import "WKWebViewExtension.h"
#import "JXBWKCustomProtocol.h"
#import "KLWKScriptMessageHandler.h"

@interface JXBWKWebViewPool()
@property(nonatomic, strong, readwrite) dispatch_semaphore_t lock;
@property(nonatomic, strong, readwrite) NSMutableSet<__kindof KLWebView *> *visiableWebViewSet;
@property(nonatomic, strong, readwrite) NSMutableSet<__kindof KLWebView *> *reusableWebViewSet;
@end

@implementation JXBWKWebViewPool

+(void)load {
//    NSLog(@"load JXBWKWebViewPool") ;
      __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self prepareWebView];
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

+ (void)prepareWebView {
    [[JXBWKWebViewPool sharedInstance] _prepareReuseWebView];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static JXBWKWebViewPool *webViewPool = nil;
    dispatch_once(&once,^{
        webViewPool = [[JXBWKWebViewPool alloc] init];
     });
    return webViewPool;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _prepare = YES;
        _visiableWebViewSet = [NSSet set].mutableCopy;
        _reusableWebViewSet = [NSSet set].mutableCopy;
        
        _lock = dispatch_semaphore_create(1);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_clearReusableWebViews) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

#pragma mark - Public Method
- (__kindof KLWebView *)getReusedWebViewForHolder:(id)holder{
    if (!holder) {
        #if DEBUG
        NSLog(@"MSWKWebViewPool must have a holder");
        #endif
        return nil;
    }
    
    [self _tryCompactWeakHolders];
    
    KLWebView *webView;
    
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    
    if (_reusableWebViewSet.count > 0) {
        webView = (KLWebView *)[_reusableWebViewSet anyObject];

        [_reusableWebViewSet removeObject:webView];
        [_visiableWebViewSet addObject:webView];
        
        [webView webViewWillReuse];
    } else {
        webView = [[KLWebView alloc] initWithFrame:CGRectZero configuration:[self webViewConfiguration]];
        [_visiableWebViewSet addObject:webView];
    }
    webView.holderObject = holder;
    
    dispatch_semaphore_signal(_lock);
    
    return webView;
}

- (void)recycleReusedWebView:(__kindof KLWebView *)webView{
    if (!webView) {
        return;
    }
    
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    
    if ([_visiableWebViewSet containsObject:webView]) {
        //将webView重置为初始状态
        [webView webViewEndReuse];
        
        [_visiableWebViewSet removeObject:webView];
        [_reusableWebViewSet addObject:webView];
        
    } else {
        if (![_reusableWebViewSet containsObject:webView]) {
            #if DEBUG
            NSLog(@"MSWKWebViewPool没有在任何地方使用这个webView");
            #endif
        }
    }
    dispatch_semaphore_signal(_lock);
}

- (void)cleanReusableViews{
    [self _clearReusableWebViews];
}

#pragma mark - Private Method
- (void)_tryCompactWeakHolders {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    
    NSMutableSet<KLWebView *> *shouldreusedWebViewSet = [NSMutableSet set];
    
    for (KLWebView *webView in _visiableWebViewSet) {
        if (!webView.holderObject) {
            [shouldreusedWebViewSet addObject:webView];
        }
    }
    
    for (KLWebView *webView in shouldreusedWebViewSet) {
        [webView webViewEndReuse];
        
        [_visiableWebViewSet removeObject:webView];
        [_reusableWebViewSet addObject:webView];
    }
    
    dispatch_semaphore_signal(_lock);
}

- (void)_clearReusableWebViews {
    [self _tryCompactWeakHolders];
    
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_reusableWebViewSet removeAllObjects];
    dispatch_semaphore_signal(_lock);
    
    [KLWebView clearAllWebCache];
}

- (void)_prepareReuseWebView {
    if (!_prepare) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        KLWebView *webView = [[KLWebView alloc] initWithFrame:CGRectZero configuration:[self webViewConfiguration]];
        [self->_reusableWebViewSet addObject:webView];
    });
}

- (WKWebViewConfiguration *)webViewConfiguration {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
 
    NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"KLCommonTools" ofType:@"bundle"];
    
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
 
    NSString *scriptPath = [NSString stringWithFormat:@"%@/%@/%@",resourceBundle.resourcePath,@"JSResources.bundle", @"JXBJSBridge.js"];
    
    NSString *bridgeJSString = [[NSString alloc] initWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:NULL];
    
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:bridgeJSString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    
    [configuration.userContentController addUserScript:userScript];
    
    
    
    [configuration.userContentController addScriptMessageHandler:[[KLWKScriptMessageHandler alloc] init] name:@"WKNativeMethodMessage"];
    
    
    //3.视频播放相关
    
    if ([configuration respondsToSelector:@selector(setAllowsInlineMediaPlayback:)]) {
        [configuration setAllowsInlineMediaPlayback:YES];
    }
    
    //视频播放
    if (@available(iOS 10.0, *)) {
        if ([configuration respondsToSelector:@selector(setMediaTypesRequiringUserActionForPlayback:)]){
            [configuration setMediaTypesRequiringUserActionForPlayback:WKAudiovisualMediaTypeNone];
        }
    } else if (@available(iOS 9.0, *)) {
        if ([configuration respondsToSelector:@selector(setRequiresUserActionForMediaPlayback:)]) {
            [configuration setRequiresUserActionForMediaPlayback:NO];
        }
    } else {
        if ([configuration respondsToSelector:@selector(setMediaPlaybackRequiresUserAction:)]) {
            [configuration setMediaPlaybackRequiresUserAction:NO];
        }
    }
    
    return configuration;
}

#pragma mark - Other
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
