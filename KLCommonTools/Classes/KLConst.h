//
//  KLConst.h
//  KLCommonTools
//
//  Created by WKL on 2019/9/23.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#ifndef KLConst_h
#define KLConst_h

/************************ 屏幕尺寸宏定义 ************************/
//设备屏幕宽度(320)
#define SCREEN_WIDTH   CGRectGetWidth([[UIScreen mainScreen] bounds])
//设备屏幕高度(480/568)
#define SCREEN_HEIGHT  CGRectGetHeight([[UIScreen mainScreen] bounds])

/************************ 颜色宏定义 ************************/

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0x00FF0000) >> 16)) / 255.0     green:((float)((rgbValue & 0x0000FF00) >>  8)) / 255.0 blue:((float)((rgbValue & 0x000000FF) >>  0)) / 255.0 alpha:1.0]



#endif /* KLConst_h */
