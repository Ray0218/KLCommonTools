//
//  KLGetProperty.m
//  KLCommonTools
//
//  Created by WKL on 2019/12/24.
//

#import "KLGetProperty.h"
#import <objc/runtime.h>// 导入运行时文件

@interface KLGetProperty()

//缓存
@property(nonatomic,strong)NSMutableDictionary *rProperCacheMapper;;

@end
@implementation KLGetProperty


+ (instancetype)shareManager{
    static KLGetProperty * _manager = nil ;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[KLGetProperty alloc]init];
    });
    return _manager ;
    
}


//返回当前类的所有属性
+ (NSMutableArray*)getProperties:(Class)cls{
    
    NSMutableDictionary *cacheMapper = [KLGetProperty shareManager].rProperCacheMapper;
    NSString *objCls = NSStringFromClass(cls);
    if([cacheMapper.allKeys containsObject:objCls]){
        return [cacheMapper[objCls] mutableCopy];
    }
    
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    [cacheMapper setValue:[mArray mutableCopy] forKey:objCls];
    
    return mArray;
}

+ (NSMutableArray*)getCustomerProperties:(Class )obj{
    
    
 
    NSMutableArray *propertyNamesArr = [self getProperties:obj];
    
    if([self isSysClass:obj]){
        return propertyNamesArr;
    }
    
    
    Class class = [obj superclass];
    while (true) {
        if(![self isSysClass:class]){
            NSMutableArray *superclassproArr = [self getProperties:class];
            [propertyNamesArr addObjectsFromArray:superclassproArr];
        }else{
            break;
        }
        class = class.superclass;
    }
    
 
    return propertyNamesArr;
    
    
}



+(BOOL)isSysClass:(Class)obj{
    return !([NSBundle bundleForClass:obj] == [NSBundle mainBundle]);
}

#pragma mark- getter
-(NSMutableDictionary *)rProperCacheMapper{
    if(!_rProperCacheMapper){
        _rProperCacheMapper = [NSMutableDictionary dictionary];
    }
    return _rProperCacheMapper;
}

@end
