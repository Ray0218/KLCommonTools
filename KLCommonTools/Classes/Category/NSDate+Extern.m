//
//  NSDate+Extern.m
//  KLCommonTools
//
//  Created by WKL on 2019/9/25.
//

#import "NSDate+Extern.h"
// EEEE - weekday
const NSString *kl_DateFormatter_yyyy_MM_dd_HH_mm_ss = @"yyyy-MM-dd HH:mm:ss";
const NSString *kl_DateFormatter_yyyy_MM_dd_HH_mm = @"yyyy-MM-dd HH:mm";
const NSString *kl_DateFormatter_yyyy_MM_dd = @"yyyy-MM-dd";
const NSString *kl_DateFormatter_MM_dd_HH_mm = @"MM-dd HH:mm";
const NSString *kl_DateFormatter_MM_dd = @"MM-dd";
const NSString *kl_DateFormatter_HH_mm = @"HH:mm";

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)

#define CURRENT_CALENDAR [NSCalendar currentCalendar]

#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

@implementation NSDate (Extern)

+(NSDate*)kl_getCurrentDate {
    
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
    
}


+ (NSDate *)kl_dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:string];
}

+ (NSString *)kl_coverDateString:(NSString *)string fromFormat:(NSString *)srcFormat toFormat:(NSString *)destFormat {
    return [[NSDate kl_dateFromString:string withFormat:srcFormat] kl_stringWithFormat:destFormat];
}

- (NSString *)kl_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

- (int)kl_nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate * newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents * components = [CURRENT_CALENDAR components:NSCalendarUnitHour fromDate:newDate];
    return (int)components.hour;
}

- (int)kl_hour
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.hour;
}

- (int)kl_minute
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.minute;
}

- (int)kl_seconds
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.second;
}

- (int)kl_day
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.day;
}

- (int)kl_month
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.month;
}

- (int)kl_week
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.weekOfMonth;
}

- (int)kl_weekday
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.weekday;
}

- (NSString *)kl_weekdayName {
    static NSString *names[] = {@"", @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"};
    return names[self.kl_weekday];
}
- (NSString *)kl_weekdayNameSimple {
    static NSString *names[] = {@"", @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"};
    return names[self.kl_weekday];
}

- (int)kl_nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.weekdayOrdinal;
}

- (int)kl_year
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.year;
}

+ (NSString *)humanableInfoFromDate: (NSDate *) theDate {
    NSString *info;
    
    NSTimeInterval deltas = - [theDate timeIntervalSinceNow];
    NSNumber *deltaNum = [NSNumber numberWithDouble:deltas];
    int delta = [deltaNum intValue];
    if (delta < 60) {
        // 1分钟之内
        info = @"Just now";
    } else {
        delta = delta / 60;
        if (delta < 60) {
            // n分钟前
            info = [NSString stringWithFormat:@"%d分钟之前", delta];
        } else {
            delta = delta / 60;
            if (delta < 24) {
                // n小时前
                info = [NSString stringWithFormat:@"%d分钟之前",delta];
            } else {
                delta = delta / 24;
                if ((NSInteger)delta == 1) {
                    //昨天
                    info = @"昨天";
                } else if ((NSInteger)delta == 2) {
                    info = @"前天";
                } else {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
                    info = [dateFormatter stringFromDate:theDate];
                    //                    info = [NSString stringWithFormat:@"%d天前", (NSUInteger)delta];
                }
            }
        }
    }
    return info;
}

+(NSDate *)beforYear:(NSInteger)year  andCurrentTime:(NSDate *)currentTime{
    
    
    
    //先定义一个遵循某个历法的日历对象 (历法就是 推算日月星辰之运行以定岁时节候的方法 就看成日历好了)
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSDateComponents *comps = nil;
    
    
    comps = [calendar components:NSCalendarUnitYear fromDate:currentTime];
    
    
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    
    
    [adcomps setYear:year];
    
    
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentTime options:0];
    
    
    
    //NSString *beforDate = [dateFormatter stringFromDate:newdate];
    
    
    //NSLog(@"---前2年 =%@",beforDate);
    
    
    return newdate;
    
    
}



+(NSDate *)beforYear:(NSInteger)year andBeforMonth:(NSInteger)month andBeforDay:(NSInteger)day andCurrentTime:(NSDate *)currentTime{
    
    
    //先定义一个遵循某个历法的日历对象 (历法就是 推算日月星辰之运行以定岁时节候的方法 就看成日历好了)
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    
    
    NSDateComponents *comps = nil;
    
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentTime];
    
    
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    
    
    [adcomps setYear:year];
    
    
    
    [adcomps setMonth:month];
    
    
    
    [adcomps setDay:day];
    
    
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentTime options:0];
    
    
    
    //NSString *beforDate = [dateFormatter stringFromDate:newdate];
    
    
    //NSLog(@"---前2年 =%@",beforDate);
    
    
    
    return newdate;
    
    
}

@end

