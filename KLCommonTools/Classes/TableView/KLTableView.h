//
//  KLTableView.h
//  KLCommonTools
//
//  Created by WKL on 2019/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLTableView : UITableView<UITableViewDelegate,UITableViewDataSource>


#pragma mark - UITableViewDataSource & UITableViewDelegate
///tableView的DataSource 设置为当前控制器即可重写对应数据源方法
@property (nonatomic, weak, nullable) id <UITableViewDataSource> klDataSource;
///tableView的Delegate 设置为当前控制器即可重写对应代理方法
@property (nonatomic, weak, nullable) id <UITableViewDelegate> klDelegate;

#pragma mark - 数据设置
///设置所有数据数组
@property(nonatomic, strong)NSMutableArray *zxDatas;

///声明cell
@property (nonatomic, copy) UITableViewCell* (^kl_setCellAtIndexPath)(UITableView* tableView, NSIndexPath *indexPath);
///声明cell的类
@property (nonatomic, copy) Class (^kl_setCellClassAtIndexPath)(NSIndexPath *indexPath);


///设置cell的高度(非必须，若设置了，则内部的自动计算高度无效)
@property (nonatomic, copy) CGFloat (^kl_setCellHAtIndexPath)(NSIndexPath *indexPath);
///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property (nonatomic, copy) CGFloat (^kl_setNumberOfSectionsInTableView)(UITableView *tableView);
///设置对应section中row的数量(非必须，若设置了，则内部自动设置对应section中row的数量无效)
@property (nonatomic, copy) CGFloat (^kl_setNumberOfRowsInSection)(NSUInteger section);
///根据HeaderView类名设置HeaderView，写了此方法则kl_setHeaderViewInSection无效，无需实现kl_setHeaderHInSection，自动计算高度
@property (nonatomic, copy) Class (^kl_setHeaderClassInSection)(NSInteger section);
///根据FooterView类名设置FooterView，写了此方法则kl_setFooterViewInSection无效，无需实现kl_setFooterHInSection，自动计算高度
@property (nonatomic, copy) Class (^kl_setFooterClassInSection)(NSInteger section);
///设置HeaderView，必须实现kl_setHeaderHInSection
@property (nonatomic, copy) UIView *(^kl_setHeaderViewInSection)(NSInteger section);
///设置FooterView，必须实现kl_setFooterHInSection
@property (nonatomic, copy) UIView *(^kl_setFooterViewInSection)(NSInteger section);
///设置HeaderView高度，非必须，若设置了则自动设置的HeaderView高度无效
@property (nonatomic, copy) CGFloat (^kl_setHeaderHInSection)(NSInteger section);
///设置FooterView高度，非必须，若设置了则自动设置的FooterView高度无效
@property (nonatomic, copy) CGFloat (^kl_setFooterHInSection)(NSInteger section);

///无数据是否显示HeaderView，默认为YES
@property(nonatomic, assign)BOOL kl_showHeaderWhenNoMsg;
///无数据是否显示FooterView，默认为YES
@property(nonatomic, assign)BOOL kl_showFooterWhenNoMsg;

///sectionHeader背景色是否透明，默认为clear
@property(nonatomic, strong)UIColor *kl_sectionHeaderBackColor;

///sectionFooter背景色是否透明，默认为rclear
@property(nonatomic, strong)UIColor *kl_sectionFooterBackColor;


#pragma mark - 数据获取
/////获取对应行的cell，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^kl_getCellAtIndexPath)(NSIndexPath *indexPath,id cell,id model);
///获取对应section的headerView，把id改成对应类名即可无需强制转换，secArr为对应section的model数组
@property (nonatomic, copy) void (^kl_getHeaderViewInSection)(NSUInteger section,id headerView,NSMutableArray *secArr);
///获取对应section的footerView，把id改成对应类名即可无需强制转换，secArr为对应section的model数组
@property (nonatomic, copy) void (^kl_getFooterViewInSection)(NSUInteger section,id footerView,NSMutableArray *secArr);

#pragma mark - 代理事件相关
///选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^kl_didSelectedAtIndexPath)(NSIndexPath *indexPath,id model,id cell);


#pragma mark - 滚动
///scrollView滚动事件
@property (nonatomic, copy) void (^kl_scrollViewDidScroll)(UIScrollView *scrollView);
///scrollView缩放事件
@property (nonatomic, copy) void (^kl_scrollViewDidZoom)(UIScrollView *scrollView);
///scrollView滚动到顶部事件
@property (nonatomic, copy) void (^kl_scrollViewDidScrollToTop)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^kl_scrollViewWillBeginDragging)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^kl_scrollViewDidEndDragging)(UIScrollView *scrollView, BOOL willDecelerate);
 
 @end


@interface KLNormalTableView : KLTableView

@end



@interface KLEstimateTableView : KLTableView

@end




NS_ASSUME_NONNULL_END

/*
 对于行高固定的表格视图，开发者可以直接设置TableView的固定行高，如下：

_tableView.rowHeight = 200;
 
 如果行高是不固定了，则应该想办法让heightForRowAtIndexPath方法完成最少的工作，其实最少的工作莫过于拿过一个高度，直接返回，因此开发者通常会将对应行的行高计算一次后，把值进行保存，之后在执行heightForRowAtIndexPath方法拉取行高时，直接返回已经计算过的行高数据，具体如何操作比较灵活，可以对应一个数组属性，将计算后的行高放入数组中，每次取行高时，检查数组中是否已经有计算过的行高数据，如果有直接返回。我个人更倾向将行高数据封装进cell的数据模型Model中。
 
 在iOS11以下的系统，使用自动布局 UITableViewAutomaticDimension 必须实现
 - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath；
 如下：

  - (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     return 60;
 }
  
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
      return UITableViewAutomaticDimension;
 }

  

*/
