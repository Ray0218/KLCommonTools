//
//  KLImageCollectionViewCell.m
//  KLCommonTools
//
//  Created by WKL on 2019/12/26.
//

#import "KLImageCollectionViewCell.h"

@implementation KLImageCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.rImageView];
        [self.rImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.centerY.equalTo(self.contentView);
            make.height.equalTo(self.contentView) ;
        }] ;
    }
    return self;
}

-(UIImageView*)rImageView {
    if (!_rImageView) {
        _rImageView = [UIImageView new] ;
        _rImageView.backgroundColor = [UIColor clearColor];
        _rImageView.contentMode =  UIViewContentModeScaleAspectFit;
    }
    return _rImageView ;
}

@end
