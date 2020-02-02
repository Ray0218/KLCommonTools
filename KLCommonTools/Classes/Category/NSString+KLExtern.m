//
//  NSString+KLExtern.m
//  KLCommonTools
//
//  Created by WKL on 2020/2/2.
//

#import "NSString+KLExtern.h"
#import <CommonCrypto/CommonDigest.h>
 
@implementation NSString (KLExtern)


//邮箱校验(标准邮箱格式)
- (BOOL)kl_stringCheckEmail {
    
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailString=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailString evaluateWithObject:self];
}


//手机格式校验(11位,数字)
- (BOOL)kl_stringCheckMobile {
    
    NSString* mobile   = [self stringByReplacingOccurrencesOfString:@" "withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        
        /**
         * 正则：手机号（精确）
         * <p>移动：134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、178、182、183、184、187、188、198</p>
         * <p>联通：130、131、132、145、155、156、175、176、185、186、166</p>
         * <p>电信：133、153、173、177、180、181、189、199</p>
         * <p>全球星：1349</p>
         * <p>虚拟运营商：170</p>
         */
        
        //        NSString *REGEX_MOBILE_EXACT = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";
        
        NSString *REGEX_MOBILE_EXACT = @"^1(3[0-9]|4[56789]|5[0-9]|6[6]|7[0-9]|8[0-9]|9[189])\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_MOBILE_EXACT];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        
        if (isMatch1 ) {
            return YES;
        }else{
            return NO;
        }
    }
    
}

//身份证校验(只包含数字和字母)
//- (BOOL)kl_stringCheckIDCard{
//
//    if (self.length <= 0) {
//        return NO;
//    }
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    return [identityCardPredicate evaluateWithObject:self];
//
// }
//



-(BOOL)kl_checkPassWord
{
    // 验证密码长度
    if(self.length < 6 || self.length > 18) {
        NSLog(@"请输入8-16的密码");
        return NO;
    }
    
    // 验证密码是否包含数字
    NSString *numPattern = @".*\\d+.*";
    NSPredicate *numPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numPattern];
    if (![numPred evaluateWithObject:self]) {
        NSLog(@"密码必须包含数字");
        return NO;
    }
    
    // 验证密码是否包含小写字母
    NSString *lowerPattern = @".*[a-z]+.*";
    NSPredicate *lowerPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lowerPattern];
    if (![lowerPred evaluateWithObject:self]) {
        NSLog(@"密码必须包含小写字母");
        return NO;
    }
    
    // 验证密码是否包含大写字母
    NSString *upperPattern = @".*[A-Z]+.*";
    NSPredicate *upperPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", upperPattern];
    if (![upperPred evaluateWithObject:self]) {
        NSLog(@"密码必须包含大写字母");
        return NO;
    }
    return YES;
    
    
    //    //6-18位数字和字母组成
    ////    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    //    NSString *regex = @"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,18}$";
    //
    //    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //    if ([pred evaluateWithObject:self]) {
    //        return YES ;
    //    }else
    //        return NO;
}

-(BOOL)kl_containcLowerCharacter
{
    // 验证密码是否包含小写字母
    NSString *lowerPattern = @".*[a-z]+.*";
    NSPredicate *lowerPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lowerPattern];
    if (![lowerPred evaluateWithObject:self]) {
        NSLog(@"包含大写字母");
        return NO;
        
    }
    
    return YES ;
    
}
-(BOOL)kl_containUpCharacter{
    
    // 验证密码是否包含大写字母
    NSString *upperPattern = @".*[A-Z]+.*";
    NSPredicate *upperPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", upperPattern];
    if (![upperPred evaluateWithObject:self]) {
        NSLog(@"包含小写字母");
        return NO;
    }
    return YES;
    
}

-(BOOL)kl_stringCheckIDCard
{
    //长度不为18的都排除掉
    if (self.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:self];
    
    if (!flag) {
        return flag;  //格式错误
    }else {
        //格式正确在判断是否合法
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++){
            NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]){
                return YES;
            }else{
                return NO;
            }
        }
    }
}

//同时包含数字和字符
- (BOOL)kl_containCharacterAndNumber{
    BOOL result = false;
    NSString *regex = @"((?=.*\\d)(?=.*[a-zA-Z]))[\\da-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:self];
    return result;
}


- (BOOL)kl_stringCheckNumber {
    
    if (self.length <= 0) {
        return NO;
    }
    
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO ;
}

- (NSString *)kl_MD5String  {
    
    const char *original_str=[self UTF8String];
    //    unsigned char result[32];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash=[NSMutableString string];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return hash;
}

-(NSString*)kl_Base64String {
    
    NSData *encodeData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return  [encodeData base64EncodedStringWithOptions:0];
    
}

-(NSString*)kl_Base64DencodeString {
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
    
}

-(NSString*)kl_SpaceString  {
    
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


@end



