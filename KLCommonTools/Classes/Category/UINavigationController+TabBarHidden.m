//
//  UINavigationController+TabBarHidden.m
//  KLCommonTools
//
//  Created by WKL on 2019/9/25.
//

#import "UINavigationController+TabBarHidden.h"
#import <objc/runtime.h>

@implementation UINavigationController (TabBarHidden)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class] ;
        
        SEL originalSelector = @selector(pushViewController:animated:) ;
        SEL swizzledSelector = @selector(kl_pushViewController:animated:);
        
        Method originalMethod =  class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
    
}

-(void)kl_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (!viewController) {
        return;
    }
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES ;
    }
    [self kl_pushViewController:viewController animated:animated];
}

@end
