//
//  NSString+KLExtern.h
//  KLCommonTools
//
//  Created by WKL on 2020/2/2.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KLExtern)

//邮箱校验(标准邮箱格式)
- (BOOL)kl_stringCheckEmail;

//手机格式校验(11位,数字)
- (BOOL)kl_stringCheckMobile;

//身份证校验(只包含数字和字母)
- (BOOL)kl_stringCheckIDCard;

//数字校验(只包含数字和小数点)
- (BOOL)kl_stringCheckNumber;

//包含字符和数字
- (BOOL)kl_containCharacterAndNumber;

///  md5加密字符串
- (NSString *)kl_MD5String ;

//密码校验
-(BOOL)kl_checkPassWord ;

/// 是否包含小写字母
-(BOOL)kl_containcLowerCharacter ;

/// 是否包含大写字母
-(BOOL)kl_containUpCharacter ;

/// 去掉前后空格
-(NSString*)kl_SpaceString  ;

/// base64加密
-(NSString*)kl_Base64String  ;

/// base64解密
-(NSString*)kl_Base64DencodeString  ;

@end

NS_ASSUME_NONNULL_END
