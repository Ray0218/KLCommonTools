//
//  KLMessageHandler.h
//  KLCommonTools
//
//  Created by WKL on 2019/9/26.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 转发Js事件
 */
@interface KLMessageHandler : NSObject

//全局唯一访问点
+ (instancetype)sharedInstance;

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;


+ (void)callbackWithResult:(NSString *)result resultData:(NSDictionary *)resultData identifier:(NSString *)identifier message:(WKScriptMessage *)message;

@end

NS_ASSUME_NONNULL_END
