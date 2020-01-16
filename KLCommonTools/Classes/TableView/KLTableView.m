//
//  KLTableView.m
//  KLCommonTools
//
//  Created by WKL on 2019/12/24.
//

#import "KLTableView.h"
#import "KLGetProperty.h"
#import "NSObject+SafeValue.h"

///model默认去匹配的cell高度属性名 若不存在则动态生成cellHRunTime的属性名
static NSString *const CELLH = @"cellH";


@interface KLTableView()


@end




@implementation KLTableView

#pragma mark - 快速构建
#pragma mark 声明cell的类并返回cell对象
//-(void)kl_setCellClassAtIndexPath:(Class (^)(NSIndexPath * indexPath)) setCellClassCallBack returnCell:(void (^)(NSIndexPath * indexPath,id cell,id model))returnCellCallBack{
//    self.kl_setCellClassAtIndexPath = setCellClassCallBack;
//    self.kl_getCellAtIndexPath = returnCellCallBack;
//}
//
//#pragma mark 声明HeaderView的类并返回HeaderView对象
//-(void)kl_setHeaderClassInSection:(Class (^)(NSInteger)) setHeaderClassCallBack returnHeader:(void (^)(NSUInteger section,id headerView,NSMutableArray *secArr))returnHeaderCallBack{
//    self.kl_setHeaderClassInSection = setHeaderClassCallBack;
//    self.kl_getHeaderViewInSection = returnHeaderCallBack;
//}
//
//#pragma mark 声明FooterView的类并返回FooterView对象
//-(void)kl_setFooterClassInSection:(Class (^)(NSInteger)) setFooterClassCallBack returnHeader:(void (^)(NSUInteger section,id headerView,NSMutableArray *secArr))returnFooterCallBack{
//    self.kl_setFooterClassInSection = setFooterClassCallBack;
//    self.kl_getFooterViewInSection = returnFooterCallBack;
//}

#pragma mark - Private
#pragma mark 判断是否是多个section的情况
-(BOOL)isMultiDatas{
    return self.zxDatas.count && [[self.zxDatas objectAtIndex:0] isKindOfClass:[NSArray class]];
}

#pragma mark 获取对应indexPath的model
-(id)getModelAtIndexPath:(NSIndexPath *)indexPath{
    id model = nil;;
    if([self isMultiDatas]){
        if(indexPath.section < self.zxDatas.count){
            NSArray *sectionArr = self.zxDatas[indexPath.section];
            if(indexPath.row < sectionArr.count){
                model = sectionArr[indexPath.row];
            }else{
                NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
            }
        }else{
            NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
        }
    }else{
        if(indexPath.row < self.zxDatas.count){
            model = self.zxDatas[indexPath.row];
        }else{
            return nil ;
//            NSAssert(NO, [NSString stringWithFormat:@"数据源异常，请检查数据源！"]);
        }
    }
    return model;
}


#pragma mark 判断对应类名的xib是否存在
-(BOOL)hasNib:(NSString *)clsName{
    return [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.nib",[[NSBundle mainBundle]resourcePath],clsName]];
}

#pragma mark 根据section获取headerView
-(UIView *)getHeaderViewInSection:(NSUInteger)section{
    Class headerClass = self.kl_setHeaderClassInSection(section);
    BOOL isExist = [self hasNib:NSStringFromClass(headerClass)];
    UIView *headerView = nil;
    if(isExist){
        headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(headerClass) owner:nil options:nil]lastObject];
    }else{
        headerView = [[headerClass alloc]init];
    }
    return headerView;
}

#pragma mark 根据section获取footerView
-(UIView *)getFooterViewInSection:(NSUInteger)section{
    Class footerClass = self.kl_setFooterClassInSection(section);
    BOOL isExist = [self hasNib:NSStringFromClass(footerClass)];
    UIView *footerView = nil;
    if(isExist){
        footerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(footerClass) owner:nil options:nil]lastObject];
    }else{
        footerView = [[footerClass alloc]init];
    }
    return footerView;
}

#pragma mark 获取当前默认的header footer
-(UITableViewHeaderFooterView*)getDefaultSectionHaderFooterView {
    
    static NSString *headerIdentifier = @"headerIdentifier" ;
    
    UITableViewHeaderFooterView *rDefaultheaderView = [self dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier] ;
    if (rDefaultheaderView == nil) {
        rDefaultheaderView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        rDefaultheaderView.contentView.backgroundColor =  [UIColor clearColor];
        rDefaultheaderView.backgroundView = ({
            UIView *view = [[UIView alloc]init] ;
            view.backgroundColor = [UIColor clearColor] ;
            view ;
        });
    }
    
    return rDefaultheaderView ;
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    if(self.klDataSource && [self.klDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]){
        return [self.klDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    } else{
        
        NSString *className  = @"default";
        Class cellClass = [UITableViewCell class];
        
        UITableViewCell *cell = nil ;
        
        if (self.kl_setCellAtIndexPath){
            cell =  self.kl_setCellAtIndexPath(tableView ,indexPath) ;
        }
        
        if (cell) {
            cellClass = [cell class];
        }else {
            
            if(self.kl_setCellClassAtIndexPath){
                cellClass = self.kl_setCellClassAtIndexPath(indexPath);
                if (cellClass) {
                    className = NSStringFromClass(cellClass);
                }else{
                    
                    cellClass = [UITableViewCell class];
                }
            }
            
            cell = [tableView dequeueReusableCellWithIdentifier:className];
            
            if (!cell) {
                
                cell = [[cellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
            }
        }
        
        BOOL cellContainsModel = NO;
        
        
        id model = [self getModelAtIndexPath:indexPath];
        if (model) {
            NSArray *cellProNames = [KLGetProperty getCustomerProperties:cellClass];
            
            for (NSString *proStr in cellProNames) {
                if([proStr.uppercaseString containsString:@"model".uppercaseString]){
                    [cell kl_safeSetValue:model forKey:proStr];
                    cellContainsModel = YES;
                    break;
                }
            }
            
            if (!cellContainsModel) {
                cell.textLabel.text = [NSString stringWithFormat:@" indexpath : %ld - %ld",indexPath.section,indexPath.row];
            }
            
        }
        
        !self.kl_getCellAtIndexPath ? : self.kl_getCellAtIndexPath(indexPath,cell,model);
        
        
        return cell;
        
    }
    
    return nil ;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if( self.klDataSource && [self.klDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]){
        return [self.klDataSource tableView:tableView numberOfRowsInSection:section];
    }else {
        
        if(self.kl_setNumberOfRowsInSection){
            return self.kl_setNumberOfRowsInSection(section);
        }else{
            if([self isMultiDatas]){
                NSArray *sectionArr = [self.zxDatas objectAtIndex:section];
                if(![sectionArr isKindOfClass:[NSArray class]]){
                    NSAssert(NO, @"数据源内容不符合要求，多section情况数据源中必须皆为数组！");
                    return 0;
                }
                return sectionArr.count;
            }else{
                return self.zxDatas.count;
            }
        }
        
    }
    
    return 0 ;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.klDataSource && [self.klDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
        return [self.klDataSource numberOfSectionsInTableView:tableView];
    }else{
        if(self.kl_setNumberOfSectionsInTableView){
            return self.kl_setNumberOfSectionsInTableView(tableView);
        }else{
            return [self isMultiDatas] ? self.zxDatas.count : 1;
        }
    }
}


#pragma mark - UITableViewDelegate

#pragma mark tableView HeaderView & FooterView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = nil;
    if(self.klDelegate &&  [self.klDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]){
        headerView = [self.klDelegate tableView:tableView viewForHeaderInSection:section];
        
    }else{
        
        if(self.kl_setHeaderViewInSection){
            headerView = self.kl_setHeaderViewInSection(section);
        } else if(self.kl_setHeaderClassInSection){
            headerView = [self getHeaderViewInSection:section];
            
        }else{
            
            headerView = [self getDefaultSectionHaderFooterView] ;
            ((UITableViewHeaderFooterView *)headerView).backgroundView.backgroundColor = _kl_sectionHeaderBackColor;
            
        }
    }
    NSMutableArray *secArr = self.zxDatas.count ? [self isMultiDatas] ? self.zxDatas[section] : self.zxDatas : nil;
    
    if (self.kl_getHeaderViewInSection) {
        self.kl_getHeaderViewInSection(section,headerView,secArr);
    }
    
    return !secArr.count ? (self.kl_showHeaderWhenNoMsg ? headerView : nil ): headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = nil;
    if(self.klDelegate && [self.klDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]){
        footerView = [self.klDelegate tableView:tableView viewForFooterInSection:section];
        
    }else{
        
        if(self.kl_setFooterViewInSection){
            footerView = self.kl_setFooterViewInSection(section);
        }else  if(self.kl_setFooterClassInSection){
            footerView = [self getFooterViewInSection:section];
            
        }else{
            
            
            footerView = [self getDefaultSectionHaderFooterView] ;
            ((UITableViewHeaderFooterView *)footerView).backgroundView.backgroundColor = _kl_sectionFooterBackColor;
            
        }
    }
    NSMutableArray *secArr = self.zxDatas.count ? [self isMultiDatas] ? self.zxDatas[section] : self.zxDatas : nil;
    
    if (self.kl_getFooterViewInSection) {
        self.kl_getFooterViewInSection(section,footerView,secArr);
    }
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if( self.klDelegate && [self.klDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]){
        return [self.klDelegate tableView:tableView heightForHeaderInSection:section];
        
    }else  if(self.kl_setHeaderHInSection){
        return self.kl_setHeaderHInSection(section);
    }else {
        
        UIView *headerView = nil;
        
        if(self.kl_setHeaderViewInSection){
            headerView = self.kl_setHeaderViewInSection(section);
        } else if(self.kl_setHeaderClassInSection){
            headerView = [self getHeaderViewInSection:section];
            
        }
        if(headerView && (section < self.zxDatas.count || (self.kl_showHeaderWhenNoMsg &&  section == 0))){
            
            return headerView.frame.size.height;
        }
        
    }
    
    return CGFLOAT_MIN;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(self.klDelegate &&  [self.klDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]){
        return [self.klDelegate tableView:tableView heightForFooterInSection:section];
        
    }else if(self.kl_setFooterHInSection){
        return self.kl_setFooterHInSection(section);
    }else{
        
        UIView *footerView = nil;
        
        if(self.kl_setFooterViewInSection){
            footerView = self.kl_setFooterViewInSection(section);
        } else if(self.kl_setFooterClassInSection){
            footerView = [self getFooterViewInSection:section];
        }
        
        if(footerView &&  (section < self.zxDatas.count || (self.kl_showFooterWhenNoMsg &&  section == 0))){
            return footerView.frame.size.height;
        }
        
        
    }
    return CGFLOAT_MIN;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.kl_setCellHAtIndexPath){
        return self.kl_setCellHAtIndexPath(indexPath);
    }
    
    return self.estimatedRowHeight ;
}

#pragma mark tableView cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(self.kl_setCellHAtIndexPath){
        return self.kl_setCellHAtIndexPath(indexPath);
    }
    
    if(self.klDelegate && [self.klDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]){
        return [self.klDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return UITableViewAutomaticDimension;
    
}

#pragma mark tableView 选中某一indexPath
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self deselectRowAtIndexPath:indexPath animated:YES];
    if([self.klDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.klDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else{
        [self deselectRowAtIndexPath:indexPath animated:YES];
        if (self.kl_didSelectedAtIndexPath) {
            
            id model = [self getModelAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            self.kl_didSelectedAtIndexPath(indexPath,model,cell);
        }
        
    }
}


#pragma mark - scrollView相关代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.klDelegate && [self.klDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        return [self.klDelegate scrollViewDidScroll:scrollView];
        
    }else{
        if(self.kl_scrollViewDidScroll){
            self.kl_scrollViewDidScroll(scrollView);
        }
    }
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if(self.klDelegate && [self.klDelegate  respondsToSelector:@selector(scrollViewDidZoom:)]){
        return [self.klDelegate scrollViewDidZoom:scrollView];
        
    }else{
        if(self.kl_scrollViewDidZoom){
            self.kl_scrollViewDidZoom(scrollView);
        }
    }
}
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    if(self.klDelegate && [self.klDelegate  respondsToSelector:@selector(scrollViewDidScrollToTop:)]){
        return [self.klDelegate scrollViewDidScrollToTop:scrollView];
        
    }else{
        if(self.kl_scrollViewDidScrollToTop){
            self.kl_scrollViewDidScrollToTop(scrollView);
        }
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(self.klDelegate && [self.klDelegate  respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        return [self.klDelegate scrollViewWillBeginDragging:scrollView];
        
    }else{
        if(self.kl_scrollViewWillBeginDragging){
            self.kl_scrollViewWillBeginDragging(scrollView);
        }
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.klDelegate && [self.klDelegate  respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        return [self.klDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        
    }else{
        if(self.kl_scrollViewDidEndDragging){
            self.kl_scrollViewDidEndDragging(scrollView,decelerate);
        }
    }
}


#pragma mark-

#pragma mark zxDatas Setter
-(void)setZxDatas:(NSMutableArray *)zxDatas{
    _zxDatas = zxDatas;
    if(zxDatas){
        NSAssert([_zxDatas isKindOfClass:[NSArray class]], @"zxDatas必须为数组");
    }
    [self reloadData];
}

#pragma mark ZXTableView默认初始化设置
-(void)privateSetZXTableView{
    self.zxDatas = [NSMutableArray array];
    self.delegate = self;
    self.dataSource = self;
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00] ;
    
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.kl_showHeaderWhenNoMsg = NO;
    self.kl_showFooterWhenNoMsg = NO ;
    
}


#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self privateSetZXTableView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self = [super initWithFrame:frame style:style]){
        [self privateSetZXTableView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self privateSetZXTableView];
}
-(void)dealloc{
    self.delegate = nil;
    self.dataSource = nil;
}



@end
