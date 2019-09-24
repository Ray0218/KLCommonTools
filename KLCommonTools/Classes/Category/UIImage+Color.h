//
//  UIImage+Color.h
//  KLCommonTools
//
//  Created by WKL on 2019/9/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;


- (UIImage *)jy_imageWithTintColor:(UIColor *)tintColor  ;

+(UIImage *)jy_creatGradualImageWithLeftColor:(UIColor*)leftColor rightColor:(UIColor*)rightColor ;

+(UIImage *)jy_creatGradualImageWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor ;

@end

NS_ASSUME_NONNULL_END
