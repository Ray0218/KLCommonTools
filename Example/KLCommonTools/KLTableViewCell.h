//
//  KLTableViewCell.h
//  KLCommonTools_Example
//
//  Created by WKL on 2019/12/24.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface KLBaseCell : UITableViewCell

@property(nonatomic,strong)NSString *rtitle;


@end



@interface KLTableViewCell : KLBaseCell

@property(nonatomic,strong)NSString *rDataModel;

@property(nonatomic,strong)UIImageView *rIconView;


@end

NS_ASSUME_NONNULL_END
