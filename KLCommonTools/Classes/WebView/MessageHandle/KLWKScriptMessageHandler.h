//
//  KLWKScriptMessageHandler.h
//  KLCommonTools
//
//  Created by WKL on 2019/9/26.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


typedef void(^name)(NSDictionary *dict);

@protocol KLMessageHandlerProtocol <NSObject>

///JS传给Native的参数
@property (nonatomic, strong) NSDictionary *params;

/**
 Native业务处理成功的回调,result:回调给JS的数据
 */
@property (nonatomic, copy) void(^successCallback)(NSDictionary *result);

/**
 Native业务处理失败的回调,result:回调给JS的数据
 */
@property (nonatomic, copy) void(^failCallback)(NSDictionary *result);

/**
 Native业务处理的回调,result:回调给JS的数据
 */
@property (nonatomic, copy) void(^progressCallback)(NSDictionary *result);

@end


@interface KLWKScriptMessageHandler : NSObject <WKScriptMessageHandler>

@property(nonatomic,strong)name  rname;
@end



