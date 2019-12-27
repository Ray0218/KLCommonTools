//
//  KLPageIndicator.m
//  KLCommonTools
//
//  Created by WKL on 2019/12/27.
//

#import "KLPageIndicator.h"
#import <Masonry/Masonry.h>

//圆点间距
static NSInteger rSpace = 5;
//圆点宽度
static NSInteger rItemWidth  = 6;


@interface KLPageIndicator ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *rCollectionView;

@property(nonatomic,strong)UILabel *rTitleLabel;


@end

static NSString *cellIdentify = @"KLPageCollectionCell";

@implementation KLPageIndicator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor] ;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES ;
        [self addSubview:self.rTitleLabel];
        [self addSubview:self.rCollectionView];
        _rCurrentIndex = -1;
        
        [self.rTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(rSpace);
            make.top.equalTo(self).offset(rSpace);
            make.bottom.equalTo(self).offset(-rSpace);
            
        }];
        
        [self.rCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rTitleLabel.mas_right).offset(rSpace);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(rSpace*2 + rItemWidth);
            make.width.mas_lessThanOrEqualTo(5*rItemWidth + rSpace*4);
            make.right.equalTo(self).offset(-rSpace);
            
        }];
        
    }
    return self;
}



-(void)setRTotalCount:(NSInteger)rTotalCount{
    _rTotalCount = rTotalCount ;
    
    if (rTotalCount <= 1) {
        self.rCollectionView.hidden = YES ;
        self.rTitleLabel.text = @"图片  共1张";
        [self.rCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(0);
        }];
        return ;
    }
    self.rTitleLabel.text = @"图片";
    self.rCollectionView.hidden = NO ;
    
    if (rTotalCount <= 5) {
        [self.rCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_lessThanOrEqualTo(rTotalCount*rItemWidth + rSpace*(rTotalCount -1));
        }];
    }else{
        [self.rCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_lessThanOrEqualTo(5*rItemWidth + rSpace*4);
        }];
    }
    [self.rCollectionView reloadData];
    self.rCurrentIndex = 0;
    
    
}

-(void)setRCurrentIndex:(NSInteger)rCurrentIndex{
    
    if (_rCurrentIndex == rCurrentIndex) {
        return ;
    }
    _rCurrentIndex = rCurrentIndex ;
    [self.rCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:rCurrentIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
}

#pragma mark- UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.rTotalCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KLPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath] ;
    return cell ;
}
-(UICollectionView*)rCollectionView {
    if (!_rCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.itemSize = CGSizeMake(rItemWidth,rItemWidth);
        layout.minimumLineSpacing = rSpace ;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
        
        _rCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout] ;
        _rCollectionView.dataSource = self ;
        _rCollectionView.delegate = self ;
        [_rCollectionView registerClass:[KLPageCollectionCell class] forCellWithReuseIdentifier:cellIdentify] ;
        _rCollectionView.backgroundColor = [UIColor clearColor] ;
        
        [_rCollectionView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_rCollectionView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
    }
    return _rCollectionView ;
}

-(UILabel*)rTitleLabel {
    if (!_rTitleLabel) {
        _rTitleLabel = [[UILabel alloc]init] ;
        _rTitleLabel.text = @"图片";
        _rTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_rTitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_rTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [_rTitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_rTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _rTitleLabel.textColor = [UIColor blackColor];
        _rTitleLabel.font = [UIFont systemFontOfSize:10] ;
    }
    return _rTitleLabel ;
}
@end



@implementation KLPageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.rIndicatorImg];
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    
    self.rIndicatorImg.highlighted = selected ;
}

-(UIImageView*)rIndicatorImg {
    if (!_rIndicatorImg) {
        _rIndicatorImg = [[UIImageView  alloc]initWithFrame:self.bounds] ;
        _rIndicatorImg.image = [UIImage kl_ImageWithColor:[UIColor lightGrayColor]  size:CGSizeMake(CGRectGetWidth(self.bounds),CGRectGetWidth(self.bounds))  ];
        _rIndicatorImg.highlightedImage = [UIImage kl_ImageWithColor:[UIColor blackColor]  size:CGSizeMake(CGRectGetWidth(self.bounds),CGRectGetWidth(self.bounds))  ]  ;
        _rIndicatorImg.contentMode = UIViewContentModeCenter;
        
    }
    return _rIndicatorImg ;
}




@end


@implementation UIImage  (round)

+ (UIImage *)kl_ImageWithColor:(UIColor *)color  size:(CGSize)size  {
    
    // 描述矩形
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    
    // 获取位图上下文
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGPathRelease(path);
    
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

@end
