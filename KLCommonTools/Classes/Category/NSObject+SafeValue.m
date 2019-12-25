//
//  NSObject+SafeValue.m
//  KLCommonTools
//
//  Created by WKL on 2019/12/24.
//

#import "NSObject+SafeValue.h"
#import "objc/runtime.h"

 

@implementation NSObject (SafeValue)

-(id)kl_safeValueForKey:(NSString *)key{
    if([self hasKey:key]){
        return [self valueForKey:key];
    }
    return nil;
}

-(void)kl_safeSetValue:(id)value forKey:(NSString *)key{
    if([self hasKey:key]){
        [self setValue:value forKey:key];
    }
}

-(BOOL)hasKey:(NSString *)key{
    return [self respondsToSelector:NSSelectorFromString(key)];
}


 

@end
