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
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = object_getClass((id)self);
 
        SEL sysSelector = @selector(URLWithString:) ;
        SEL cusSelector = @selector(kl_URLWithString:) ;
        
        Method sysMethod = class_getClassMethod(class, sysSelector);
        Method cusMethod = class_getClassMethod(class, cusSelector);
        
        BOOL add = class_addMethod(class, sysSelector, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        
        if (add) {
            class_replaceMethod(class,cusSelector, method_getImplementation(sysMethod), method_getTypeEncoding(sysMethod));
        }else {
            
            method_exchangeImplementations(sysMethod, cusMethod) ;
        }
 
    });
    
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
