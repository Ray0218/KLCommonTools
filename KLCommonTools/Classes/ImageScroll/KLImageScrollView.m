//
//  KLImageScrollView.m
//  KLCommonTools
//
//  Created by WKL on 2019/12/26.
//

#import "KLImageScrollView.h"
#import "KLImageCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface KLImageScrollView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *rCollectionView;

@property(nonatomic,strong)NSMutableArray *rBaseArray;

@property(nonatomic,assign)NSInteger rCurrentIndex;

@property(nonatomic,strong)UIImageView *rBackImage;

@property(nonatomic,strong)UIVisualEffectView *rEffectView;

@end


static NSString *cellIdentify = @"KLImageScrollView";


@implementation KLImageScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(0, @"请使用initWithFrame,并指定宽度") ;
    }
    return self;
}



-(void)setRBackImgUrlString:(NSString *)rBackImgUrlString{
    _rBackImgUrlString = rBackImgUrlString ;
    if ([rBackImgUrlString hasPrefix:@"http"]) {
        [self.rBackImage sd_setImageWithURL:[NSURL URLWithString:rBackImgUrlString]] ;
    }else{
        self.rBackImage.image = [UIImage imageNamed:rBackImgUrlString];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.rBackImage];
        [self addSubview:self.rCollectionView];
        _rBaseArray = [NSMutableArray array] ;
        
    }
    return self;
}



-(void)setRDataArray:(NSMutableArray *)rDataArray{
    _rDataArray = rDataArray;
    
    [self.rBaseArray removeAllObjects];
    
    if (rDataArray) {
        
        if (!self.rBackImgUrlString) {
            if ([rDataArray[0] hasPrefix:@"http"]) {
                [self.rBackImage sd_setImageWithURL:[NSURL URLWithString:rDataArray[0]]] ;
            }else{
                self.rBackImage.image = [UIImage imageNamed:rDataArray[0]];
            }
        }
        
        [self.rBaseArray addObjectsFromArray:rDataArray];
        if (rDataArray.count > 1) {
            [self.rBaseArray insertObject:rDataArray[rDataArray.count-1] atIndex:0];
            [self.rBaseArray addObject:rDataArray[0]];
        }
        
    }
    
    [self.rCollectionView reloadData];
    if (rDataArray.count >1) {
        
        [self.rCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.rCurrentIndex = 1;
    }
}


#pragma mark - UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    KLImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    
    
    if ([self.rBaseArray[indexPath.row] hasPrefix:@"http"]) {
        
        [cell.rImageView sd_setImageWithURL:[NSURL URLWithString:self.rBaseArray[indexPath.row]] placeholderImage:self.rPlaceHolderImage];
    }else{
        cell.rImageView.image = [UIImage imageNamed:self.rBaseArray[indexPath.row]] ;
    }
    
    
    return cell ;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rBaseArray.count ;
}


#pragma mark-

-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES ;
}

#pragma mark- ScrollviewDelegate


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x <= 0) {
        [self.rCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.rBaseArray.count-2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.rCurrentIndex = self.rBaseArray.count - 2;
        
    }else if (scrollView.contentOffset.x >= self.frame.size.width*(self.rBaseArray.count - 1)){
        
        [self.rCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.rCurrentIndex = 1;
    }
}




-(UICollectionView*)rCollectionView {
    if (!_rCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        layout.minimumLineSpacing = 0 ;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
        
        _rCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout] ;
        _rCollectionView.pagingEnabled = YES ;
        _rCollectionView.dataSource = self ;
        _rCollectionView.delegate = self ;
        [_rCollectionView registerClass:[KLImageCollectionViewCell class] forCellWithReuseIdentifier:cellIdentify] ;
        _rCollectionView.backgroundColor = [UIColor clearColor] ;
        
    }
    return _rCollectionView ;
}


-(UIImageView*)rBackImage {
    if (!_rBackImage) {
        _rBackImage = [[UIImageView alloc]initWithFrame:self.bounds];
        _rBackImage.contentMode = UIViewContentModeScaleAspectFill;
        _rBackImage.clipsToBounds = YES ;
        [_rBackImage addSubview:self.rEffectView];
        _rBackImage.backgroundColor = [UIColor blackColor];
        
    }
    return _rBackImage ;
}
-(UIVisualEffectView*)rEffectView {
    if (!_rEffectView) {
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        _rEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        _rEffectView.frame = self.bounds;
        _rEffectView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
        _rEffectView.contentView.backgroundColor = [UIColor clearColor] ;
        for (UIView *subview in _rEffectView.subviews) {
            
            if ([NSStringFromClass([subview class]) containsString:@"UIVisualEffectSubview"]) {
                subview.backgroundColor = [UIColor clearColor];
                break;
            }
        }
        
    }
    return _rEffectView ;
}
@end
