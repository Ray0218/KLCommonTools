//
//  KLImageScrollView.h
//  KLCommonTools
//
//  Created by WKL on 2019/12/26.
//

#import <UIKit/UIKit.h>

 
@interface KLImageScrollView : UIView

@property(nonatomic,strong)NSMutableArray *rDataArray;


/// 背景图
@property(nonatomic,strong)NSString *rBackImgUrlString;


/// 默认图
 @property(nonatomic,strong)UIImage *rPlaceHolderImage;

 



@end

 
