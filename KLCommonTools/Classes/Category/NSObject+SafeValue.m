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


- (BOOL)kl_isNilOrEmpty:(id)string
 {
     if (string == nil || string == NULL) {
         return YES;
     }
     if ([string isKindOfClass:[NSNull class]]) {
         return YES;
     }
     if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
         return YES;
     }
     if ([string isKindOfClass:[NSString class]] && ([string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])) {
         return YES;
     }
     return NO;
 }


@end
