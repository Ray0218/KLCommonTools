#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSDate+Extern.h"
#import "NSObject+SafeValue.h"
#import "NSString+KLExtern.h"
#import "NSURL+Swizzer.h"
#import "UIImage+Color.h"
#import "UINavigationController+TabBarHidden.h"
#import "UIViewController+Transition.h"
#import "KLConst.h"
#import "KLImageCollectionViewCell.h"
#import "KLImageScrollView.h"
#import "KLPageIndicator.h"
#import "KLProgressManager.h"
#import "KLTextField.h"
#import "KLGetProperty.h"
#import "KLTableView.h"
#import "JXBWKWebViewPool.h"
#import "KLWebView.h"
#import "UIProgressView+WKWebView.h"
#import "KLWebViewController.h"
#import "KLMessageHandler.h"
#import "KLWKScriptMessageHandler.h"
#import "JXBWKCustomProtocol.h"
#import "NSURLProtocol+WebKitSupport.h"
#import "WKWebView+ClearWebCache.h"
#import "WKWebView+CookiesManager.h"
#import "WKWebView+ExternalNavigationDelegates.h"
#import "WKWebView+SupportProtocol.h"
#import "WKWebView+SyncUserAgent.h"
#import "WKWebViewExtension.h"

FOUNDATION_EXPORT double KLCommonToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char KLCommonToolsVersionString[];

