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
//左右渐变
+(UIImage *)jy_creatGradualImageWithLeftColor:(UIColor*)leftColor rightColor:(UIColor*)rightColor ;
//上下渐变
+(UIImage *)jy_creatGradualImageWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor ;

+(UIImage *)ps_creatGradualColorImage ;

@end

NS_ASSUME_NONNULL_END
