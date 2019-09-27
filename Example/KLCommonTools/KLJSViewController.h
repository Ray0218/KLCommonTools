//
//  KLJSViewController.h
//  KLCommonTools_Example
//
//  Created by WKL on 2019/9/26.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KLWKScriptMessageHandler.h>

@interface KLJSViewController : UIViewController
//<KLMessageHandlerProtocol>
//@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, copy) void(^successCallback)(NSDictionary *result);
//@property (nonatomic, copy) void(^failCallback)(NSDictionary *result);
//@property (nonatomic, copy) void(^progressCallback)(NSDictionary *result);


@end

 
