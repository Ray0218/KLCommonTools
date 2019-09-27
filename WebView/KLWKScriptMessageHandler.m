//
//  KLWKScriptMessageHandler.m
//  KLCommonTools
//
//  Created by WKL on 2019/9/26.
//

#import "KLWKScriptMessageHandler.h"
#import "KLMessageHandler.h"


@implementation KLWKScriptMessageHandler

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    
    //获取到js脚本传过来的参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:message.body];
    
    //获取callback的identifier
    NSString *identifier = params[@"identifier"];

    //success callback
    params[@"success"] = ^(NSDictionary *result){
        [KLMessageHandler callbackWithResult:@"success" resultData:result identifier:identifier message:message];
    };

    //fail callback
    params[@"fail"] = ^(NSDictionary *result){
        [KLMessageHandler callbackWithResult:@"fail" resultData:result identifier:identifier message:message];
    };

    //progress callback
    params[@"progress"] = ^(NSDictionary *result){
        [KLMessageHandler callbackWithResult:@"progress" resultData:result identifier:identifier message:message];
    };

    //other mark
    params[@"isFromH5"] = @(YES);
    params[@"webview"] = message.webView;
    
    //把data包裹的数据重新添加到params里,然后将data删除,这样h5和native的target-action取值方式就统一了.
    NSDictionary *jsData = params[@"data"];
    if (jsData) {
        [params removeObjectForKey:@"data"];
        [jsData enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
            [params setValue:value forKey:key];
        }];
    }
    
    //target-action
    NSString *targetName = params[@"targetName"];
    NSString *actionName = params[@"actionName"];
    
    if ([actionName isKindOfClass:[NSString class]] && actionName.length > 0) {
        [[KLMessageHandler sharedInstance] performTarget:targetName action:actionName params:params shouldCacheTarget:YES];
    }}

@end
