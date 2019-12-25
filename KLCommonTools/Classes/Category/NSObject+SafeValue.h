//
//  NSObject+SafeValue.h
//  KLCommonTools
//
//  Created by WKL on 2019/12/24.
//

 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SafeValue)

-(id)kl_safeValueForKey:(NSString *)key;
-(void)kl_safeSetValue:(id)value forKey:(NSString *)key;

 

@end

NS_ASSUME_NONNULL_END
