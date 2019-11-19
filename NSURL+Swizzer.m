//
//  NSURL+Swizzer.m
//  KLCommonTools
//
//  Created by WKL on 2019/11/14.
//

#import "NSURL+Swizzer.h"
#import <objc/runtime.h>

@implementation NSURL (Swizzer)

+(void)load{
    
    Method sysMethod = class_getInstanceMethod(self, @selector(URLWithString:)) ;
    
    Method cusMethod = class_getInstanceMethod(self, @selector(kl_URLWithString:)) ;

    method_exchangeImplementations(sysMethod, cusMethod);
}

+(instancetype)kl_URLWithString:(NSString*)URLString{
    
    NSURL *url = [NSURL kl_URLWithString:URLString] ;
    if (url == nil) {
        URLString  = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    url = [NSURL kl_URLWithString:URLString];
   
    return url;
}


@end
