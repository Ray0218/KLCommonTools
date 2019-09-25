//
//  NSDate+Extern.h
//  KLCommonTools
//
//  Created by WKL on 2019/9/25.
//

#import <Foundation/Foundation.h>

extern NSString *kl_DateFormatter_yyyy_MM_dd_HH_mm_ss;
extern NSString *kl_DateFormatter_yyyy_MM_dd_HH_mm;
extern NSString *kl_DateFormatter_yyyy_MM_dd;
extern NSString *kl_DateFormatter_MM_dd_HH_mm;
extern NSString *kl_DateFormatter_MM_dd;
extern NSString *kl_DateFormatter_HH_mm;

@interface NSDate (Extern)


+(NSDate*)kl_getCurrentDate ;
/**
 *  根据日期字符串生成日期对象
 *
 *  @param string [in]日期字符串 e.g. @"2014-06-07 13:36:07"
 *  @param format [in]日期格式  e.g. @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return NSDate
 */
+ (NSDate *)kl_dateFromString:(NSString *)string withFormat:(NSString *)format;

/**
 *  将日期格式化为字符串
 *
 *  @param format [in]日期格式  e.g. @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 格式化后的字符串 e.g. @"2014-06-07 13:36:07"
 */
- (NSString *)kl_stringWithFormat:(NSString *)format;

/**
 *  将日期字符串转化为指定格式的字符串
 *
 *  @param string     [in]日期字符串  e.g. @"2014-06-07 13:36:07"
 *  @param srcFormat  [in]原格式   e.g. @"yyyy-MM-dd HH:mm:ss"
 *  @param destFormat [in]目标格式   e.g. @"HH:mm"
 *
 *  @return e.g. @"13:36"
 */
+ (NSString *)kl_coverDateString:(NSString *)string fromFormat:(NSString *)srcFormat toFormat:(NSString *)destFormat;
/**
 *  计算传入日期与当前时间的差距
 *
 *  @param theDate 日期
 *
 *  @return “刚刚”，”几分钟前“，”昨天“，”前天“，”日期“
 */
+ (NSString *)humanableInfoFromDate: (NSDate *) theDate ;

+(NSDate *)beforYear:(NSInteger)year  andCurrentTime:(NSDate *)currentTime ;

@property (nonatomic, assign, readonly) int kl_nearestHour;
@property (nonatomic, assign, readonly) int kl_hour;
@property (nonatomic, assign, readonly) int kl_minute;
@property (nonatomic, assign, readonly) int kl_seconds;
@property (nonatomic, assign, readonly) int kl_day;
@property (nonatomic, assign, readonly) int kl_month;
@property (nonatomic, assign, readonly) int kl_week;
@property (nonatomic, assign, readonly) int kl_weekday;    // e.g. Saturday weekday == 7, Sunday weekday == 1, Monday weekday == 2
@property (nonatomic, strong, readonly) NSString *kl_weekdayName;//星期一....
@property (nonatomic, strong, readonly) NSString *kl_weekdayNameSimple;//周一...
@property (nonatomic, assign, readonly) int kl_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (nonatomic, assign, readonly) int kl_year;

@end


