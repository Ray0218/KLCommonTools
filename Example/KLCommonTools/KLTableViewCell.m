//
//  KLTableViewCell.m
//  KLCommonTools_Example
//
//  Created by WKL on 2019/12/24.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#import "KLTableViewCell.h"


@implementation KLBaseCell

 

@end



@implementation KLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        [self.contentView addSubview:self.rIconView];
        [self.rIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.height.mas_equalTo(80);
            
        }] ;
    }
    return self ;
}


-(UIImageView*)rIconView {
    if (!_rIconView) {
        _rIconView = [UIImageView new] ;
        _rIconView.backgroundColor = [UIColor orangeColor];
    }
    return _rIconView ;
}

-(void)setRDataModel:(NSString *)rDataModel{
    _rDataModel = rDataModel ;
    self.textLabel.text = rDataModel ;
}

@end


