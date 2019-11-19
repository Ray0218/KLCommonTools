//
//  KLConst.h
//  KLCommonTools
//
//  Created by WKL on 2019/9/23.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#ifndef KLConst_h
#define KLConst_h

// 日志输出
#ifdef DEBUG
#define NSSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSSLog(...)
#endif


/************************ 屏幕尺寸宏定义 ************************/
//设备屏幕宽度(320)
#define SCREEN_WIDTH   CGRectGetWidth([[UIScreen mainScreen] bounds])
//设备屏幕高度(480/568)
#define SCREEN_HEIGHT  CGRectGetHeight([[UIScreen mainScreen] bounds])

/************************ 颜色宏定义 ************************/

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0x00FF0000) >> 16)) / 255.0     green:((float)((rgbValue & 0x0000FF00) >>  8)) / 255.0 blue:((float)((rgbValue & 0x000000FF) >>  0)) / 255.0 alpha:1.0]

/************************ 图片宏定义 ************************/
#define kIMAGE(name) \
[UIImage imageNamed:name]
/************************ 颜色宏定义机型判断************************/
#pragma mark  机型判断
// 判断是否是ipad
#define isPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhoneX
#define kIS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define kIS_IPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define kIS_IPHONE_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define kIS_IPHONE_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断是否是IphoneX 系列
#define kIS_IPhoneX_All (kIS_IPHONE_X == YES || kIS_IPHONE_XR == YES || kIS_IPHONE_XS == YES || kIS_IPHONE_XS_MAX == YES)
//状态栏高度
#define kStatuBarHeight (kIS_IPhoneX_All ? 44.0 : 20.0)
//状态栏 + 导航栏高度44
#define kNavBarHeight (kIS_IPhoneX_All ? 88.0 : 64.0)

//底部安全区高度
#define kBottomSafeHeight (kIS_IPhoneX_All ? 34.0 : 0.0)

//tabbar高度
#define kTabBarHeight (kIS_IPhoneX_All ? 83.0 : 49.0)


#endif /* KLConst_h */




FOUNDATION_STATIC_INLINE UIViewController * KCurrentViewController() {
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (viewController) {
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tbvc = (UITabBarController*)viewController;
            viewController = tbvc.selectedViewController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nvc = (UINavigationController*)viewController;
            viewController = nvc.topViewController;
        } else if (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        } else if ([viewController isKindOfClass:[UISplitViewController class]] &&
                   ((UISplitViewController *)viewController).viewControllers.count > 0) {
            UISplitViewController *svc = (UISplitViewController *)viewController;
            viewController = svc.viewControllers.lastObject;
        } else  {
            return viewController;
        }
    }
    return viewController;
}


FOUNDATION_STATIC_INLINE BOOL kIsEmptyString(NSString* string){
    
    if (!string) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [string stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
    
}
