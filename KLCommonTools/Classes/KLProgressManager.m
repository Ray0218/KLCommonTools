//
//  KLProgressManager.m
//  KLCommonTools_Example
//
//  Created by WKL on 2019/9/23.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#import "KLProgressManager.h"
#import "KLConst.h"

#if __has_include (<MBProgressHUD/MBProgressHUD.h>)

#import <MBProgressHUD/MBProgressHUD.h>

#endif




#define kDefaultView [[UIApplication sharedApplication] keyWindow]

#define kGloomyBlackColor  [UIColor clearColor]

#define kGloomyClearCloler  [UIColor colorWithRed:1 green:1 blue:1 alpha:0]

#define kDefaultRect     CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)


/* 默认网络提示，可在这统一修改 */
static NSString *const kLoadingMessage = @"Loading...";

/* 默认简短提示语显示的时间，在这统一修改 */
static CGFloat const   kShowTime  = 2.0f;

/* 默认超时时间，30s后自动去除提示框 */
static NSTimeInterval const interval = 30.0f;

/* 手势是否可用，默认yes，轻触屏幕提示框隐藏 */
static BOOL isAvalibleTouch = YES;


@implementation KLProgressManager

UIView *gloomyView;//深色背景
UIView *prestrainView;//预加载view
BOOL isShowGloomy;//是否显示深色背景
#pragma mark -   类初始化
+ (void)initialize {
    if (self == [KLProgressManager self]) {
        //该方法只会走一次
        [self customView];
        
    }
}
#pragma mark - 初始化gloomyView
+(void)customView {
    gloomyView = [[GloomyView alloc] initWithFrame:kDefaultRect];
    gloomyView.backgroundColor = kGloomyBlackColor;
    gloomyView.hidden = YES;
    isShowGloomy = YES;
    
    gloomyView.userInteractionEnabled = YES ;
}
+ (void)showGloomy:(BOOL)isShow {
    isShowGloomy = isShow;
}

#if HasMBProgress

#pragma mark - 简短提示语
+ (void) showBriefAlert:(NSString *) message inView:(UIView *) view{
    
    
    [self hideAlert] ;
    
    if (message.length <= 0) {
        return ;
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        hud.labelText = @"";
        
        hud.detailsLabelText = message;
        hud.detailsLabelFont = [UIFont systemFontOfSize:16] ;
        
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeText;
        hud.margin = 15.f;
        //HUD.yOffset = 200;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:kShowTime];
    });
}
#pragma mark - 长时间的提示语
+ (void) showPermanentMessage:(NSString *)message inView:(UIView *) view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:gloomyView animated:YES];
        hud.labelText = message;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeText;
        [gloomyView addSubview:hud];
        [self showClearGloomyView];
        [hud show:YES];
    });
}
#pragma mark - 网络加载提示用
+ (void) showLoadingInView:(UIView *) view{
    
    [self hideAlert] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.labelText =  kLoadingMessage;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud show:YES];
        [self hideAlertDelay];
    });
}
+ (void)showWaitingWithTitle:(NSString *)title inView:(UIView *)view {
    
    
    [self hideAlert] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.labelText = title;
        
        hud.userInteractionEnabled = NO ;
        hud.removeFromSuperViewOnHide = YES;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud show:YES];
        [self hideAlertDelay];
    });
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title inView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        prestrainView = view;
        gloomyView.frame = view ? CGRectMake(0, 0, view.frame.size.width, view.frame.size.height):
        kDefaultRect;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:imageName];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.labelText = title;
        hud.mode = MBProgressHUDModeCustomView;
        [hud show:YES];
        [hud hide:YES afterDelay:kShowTime];
    });
}
#pragma mark - 加载在window上的提示框
+(void)showLoading{
    [self showLoadingInView:nil];
}
+ (void)showWaitingWithTitle:(NSString *)title{
    [self showWaitingWithTitle:title inView:nil];
}
+(void)showBriefAlert:(NSString *)alert{
    [self showBriefAlert:alert inView:nil];
}
+(void)showPermanentAlert:(NSString *)alert{
    [self showPermanentMessage:alert inView:nil];
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title {
    [self showAlertWithCustomImage:imageName title:title inView:nil];
}

#pragma mark -   GloomyView背景色
+ (void)showBlackGloomyView {
    gloomyView.backgroundColor = kGloomyBlackColor;
    [self gloomyConfig];
}
+ (void)showClearGloomyView {
    gloomyView.backgroundColor = kGloomyClearCloler;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self gloomyConfig];
    });
}
#pragma mark -   决定GloomyView add到已给view或者window上
+ (void)gloomyConfig {
    gloomyView.hidden = NO;
    gloomyView.alpha = 1;
    if (prestrainView) {
        [prestrainView addSubview:gloomyView];
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:gloomyView]) {
            [window addSubview:gloomyView];
        }
    }
}
#pragma mark - 隐藏提示框
+(void)hideAlert{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [KLProgressManager HUDForView:gloomyView];
        
        gloomyView.frame = CGRectZero;
        gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
        gloomyView.alpha = 0;
        hud.alpha = 0;
        [hud removeFromSuperview];
        
    });
    
}


+(BOOL)isShowingHUD {
    
    MBProgressHUD *hud = [KLProgressManager HUDForView:gloomyView];
    
    return  hud ;
    
}

#pragma mark -   超时后（默认30s）自动隐藏加载提示
+ (void)hideAlertDelay {
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self hideAlert];
    //    });
}
#pragma mark -   获取view上的hud
+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}

#endif

@end


@implementation GloomyView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    if (isAvalibleTouch) {
    //        [KLProgressManager hideAlert];
    //    }
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    return  NO ;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    return  NO ;
}

@end
