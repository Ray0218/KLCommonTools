//
//  UIViewController+Transition.h
//  KLCommonTools
//
//  Created by WKL on 2019/9/25.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Transition)

@property(nonatomic,strong,readonly)UINavigationController *rNavigationController;

- (void)kl_showViewController:(UIViewController *)vc completion:(void (^)(void))completion  ;

@end


