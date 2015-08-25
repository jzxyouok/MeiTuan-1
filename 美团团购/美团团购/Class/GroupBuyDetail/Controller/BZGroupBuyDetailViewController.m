//
//  BZGroupBuyDetailViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyDetailViewController.h"
#import "BZGroupBuyDetailDataModel.h"
#import "DPAPI.h"
#import "BZGroupBuyDetailHeaderView.h"
#import "BZGroupBuyDetailBuyCell.h"
#import "BZGroupBuyDetailCommentCell.h"
#import "BZDealBusinessModel.h"
#import "BZCellConfig.h"
#import "BZGroupBuyDetailMessageCell.h"
#import "BZGroupBuyDetailBusinessCell.h"
#import "BZGroupBuyDetailTextCell.h"
#import "BZGroupBuyDetailCommentViewController.h"
#import "UMSocial.h"
#import "BZGroupBuyDetailShareView.h"
#import "BZGroupBuyDetailFooterViewController.h"
#import "BZGroupBuyDetailShareBtn.h"
#import "MBProgressHUD+MJ.h"
#import "BZDealLocalTool.h"
#import "BZGroupBuyDetailShareValueEditingViewController.h"



@interface BZGroupBuyDetailViewController ()<DPRequestDelegate,BZGroupBuyDetailShareViewDelegate>

/** tableView 的cellConfig数据源 */
@property (strong, nonatomic) NSMutableArray *configArr;

/** cell数据源 */
@property (strong, nonatomic) BZGroupBuyDetailDataModel   *detailData;
@property (strong, nonatomic) BZGroupBuyDetailCommentCell *commentCell;
@property (strong, nonatomic) BZGroupBuyDetailHeaderView  *headerView;
@property (strong, nonatomic) UIButton                    *collectionBtn;
@property (strong, nonatomic) UIActivityIndicatorView     *ActiveView;
@end

@implementation BZGroupBuyDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.backgroundColor = BZBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setUpActiveView];
    [self detailData];
    [self setUpHeaderView];
    [self loadDetailData];
    [self setUpNavBar];
}

- (void)setDeal:(BZDeal *)deal
{
    _deal = deal;
}

- (NSMutableArray *)configArr
{
    if (!_configArr) {
        
        BZCellConfig *comment = [BZCellConfig cellConfigWithClassName:NSStringFromClass([BZGroupBuyDetailCommentCell class]) title:@"comment" showInfoMethod:@selector(showInfo:) heightOfCell:40];
        
        BZCellConfig *Detailtext = [BZCellConfig cellConfigWithClassName:NSStringFromClass([BZGroupBuyDetailTextCell class]) title:@"Detailtext" showInfoMethod:@selector(showInfo:) heightOfCell:30];
        
        BZCellConfig *message = [BZCellConfig cellConfigWithClassName:NSStringFromClass( [BZGroupBuyDetailMessageCell class]) title:@"message" showInfoMethod:@selector(showInfo:) heightOfCell:50];
        
        
        BZCellConfig *business = [BZCellConfig cellConfigWithClassName:NSStringFromClass([BZGroupBuyDetailBusinessCell class]) title:@"business" showInfoMethod:@selector(showInfo:) heightOfCell:132];
        
//        NSArray *group1 = @[message];
//        NSArray *group2 = @[comment,Detailtext];
//        NSArray *group3 = @[business];
//        
        NSMutableArray *tempArr = [NSMutableArray array];
//        [tempArr addObjectsFromArray:@[group1,group2,group3]];
        [tempArr addObjectsFromArray:@[message,comment,Detailtext,business]];
        _configArr = tempArr;
    }
    return _configArr;
}

- (BZGroupBuyDetailDataModel *)detailData
{
    if (!_detailData) {
        BZGroupBuyDetailDataModel *detailData = [[BZGroupBuyDetailDataModel alloc]init];
        _detailData = detailData;
    }
    return _detailData;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
    }
    return self;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 初始化控件

- (void)setUpNavBar
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage resizeImageWithName:@"bg_navigationBar_white@2x"] forBarMetrics:UIBarMetricsDefault];
    // 返回button
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"团购详情" target:self action:@selector(back)];
    
    // 分享按钮
    UIBarButtonItem *shareItem = [UIBarButtonItem creatBarButtonItemWithNorImage:[UIImage scaleFromImage:[UIImage imageNamed:@"icon_share"]] higImage:[UIImage scaleFromImage:[UIImage imageNamed:@"icon_share_highlighted"]] target:self active:@selector(share)];
    
    // 收藏按钮
    UIButton *collectBtn = [[UIButton alloc]init];
    collectBtn.width = 50;
    collectBtn.height = 35;
    [collectBtn setImage:[UIImage imageNamed:@"btn_collection_normal_solid"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"btn_collection_selected_solid"] forState:UIControlStateSelected];
    self.collectionBtn = collectBtn;
    // 判断是否已经收藏
    NSArray *collectionDeals = [BZDealLocalTool collectDeals];
    for (BZDeal *deal in collectionDeals) {
        if ([deal isEqual: self.deal]) {
            self.collectionBtn.selected = YES;
            break;
        }
    }
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithCustomView:collectBtn];
    [collectBtn addTarget:self action:@selector(clickCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[shareItem,collectItem];
}

- (void)setUpFooterView
{
    BZGroupBuyDetailFooterViewController *footerViewControler = [[BZGroupBuyDetailFooterViewController alloc]init];
    [self addChildViewController:footerViewControler];
    footerViewControler.data = self.detailData;
    self.tableView.tableFooterView = footerViewControler.tableView;
    self.tableView.tableFooterView.height = footerViewControler.tableView.height;
    footerViewControler.tableView.scrollEnabled = NO;
    NSLog(@"----------------%f",footerViewControler.tableView.height);
}

- (void)setUpActiveView
{
    UIActivityIndicatorView *ActiveView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    ActiveView.size = CGSizeMake(50, 50);
    ActiveView.center = self.view.center;
    self.ActiveView = ActiveView;
    [ActiveView startAnimating];
}

- (void)setUpHeaderView
{
    BZGroupBuyDetailHeaderView *headerView = [BZGroupBuyDetailHeaderView headerView];
    headerView.deal = self.deal;
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - 触发事件

- (void)clickCollectionBtn:(UIButton *)collectionBtn
{
    collectionBtn.selected = !collectionBtn.selected;
    if (collectionBtn.isSelected) {
        [BZDealLocalTool saveCollectDeal:self.deal];
        [MBProgressHUD showSuccess:@"收藏成功！" toView: self.view];
    }
    else
    {
        [BZDealLocalTool cancelCollectDeal:self.deal];
        [MBProgressHUD showSuccess:@"取消收藏成功！" toView:self.view];
    }
}

- (void)share
{
    // 分享的文字
    NSString *text = [NSString stringWithFormat:@"【%@】%@ 详情查看：%@",self.deal.title, self.deal.desc, self.deal.deal_url];
    
    UIImage *image = nil;
    if (self.headerView.ImageView.image != [UIImage imageNamed:@"icon_defaultimage_movielistcell_merchant"]) {
        image = self.headerView.ImageView.image;
    }
    
    BZGroupBuyDetailShareView *shareView = [[BZGroupBuyDetailShareView alloc]init];
    shareView.delegate = self;
    [shareView startShareWithText:text image:image];
}

- (void)shareViewDidClickShareBtn:(BZGroupBuyDetailShareView *)shareView selBtn:(BZGroupBuyDetailShareBtn *)shareBtn
{
    
//    //判断是否授权
//    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
//    [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina];
//    //进入授权页面
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            //获取微博用户名、uid、token等
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
//            NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
//            //进入你的分享内容编辑页面
//            BZGroupBuyDetailShareValueEditingViewController *shareVc = [[BZGroupBuyDetailShareValueEditingViewController alloc]init];
//            [self.navigationController pushViewController:shareVc animated:YES];
//        }
//    });
    

    [[UMSocialControllerService defaultControllerService] setShareText:shareView.shareText shareImage:shareView.shareImage socialUIDelegate:nil];
    if (shareBtn.socalSnsType == UMSocialSnsTypeWechatSession) {
         [UMSocialData defaultData].extConfig.wechatSessionData.url = self.deal.deal_url;
    }
    if (shareBtn.socalSnsType == UMSocialSnsTypeWechatTimeline) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.deal.deal_url;
    }
    if (shareBtn.socalSnsType == UMSocialSnsTypeMobileQQ)
    {
        [UMSocialData defaultData].extConfig.qqData.url = self.deal.deal_url;
    }
    if ((shareBtn.socalSnsType == UMSocialSnsTypeQzone)) {
        if ((shareView.shareImage != nil) && (shareView.shareText != nil)) {
        [UMSocialData defaultData].extConfig.qzoneData.url = self.deal.deal_url;
        }
        else
        {
            [MBProgressHUD showError:@"分享到Qzone必须有图片和文字,请重新输入!"];
            return;
        }

    }
    
    UMSocialSnsPlatform *platform = [UMSocialSnsPlatformManager getSocialPlatformWithName:[UMSocialSnsPlatformManager getSnsPlatformString:(shareBtn.socalSnsType)]];
    
    platform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}

#pragma mark - 网络加载数据
- (void)loadDetailData
{
    DPAPI *aip = [[DPAPI alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (0 == self.deal.businesses.count) {
        [MBProgressHUD showError:@"未能找到商家数据"];
        return;
    }
    BZDealBusinessModel *dealBusiness = [self.deal.businesses firstObject];
    NSLog(@"--------------------%d",dealBusiness.ID);
    params[@"business_id"] = @(dealBusiness.ID);
    [aip requestWithURL:@"v1/business/get_single_business" params:params delegate:self];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error");
    [self.ActiveView stopAnimating];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"%@",result);
    self.detailData.business = [BZBusinessModel objectWithKeyValues:result[@"businesses"][0]];
    self.detailData.deal = self.deal;
//    NSLog(@"%@",self.detailData.business.name);
    [self refreshSubView];
    [self setUpFooterView];
    [self.tableView reloadData];
    [self.ActiveView stopAnimating];
}

- (void)refreshSubView
{
    self.commentCell.data = self.detailData;
}

#pragma mark - collectionView数据源协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.detailData.business) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray *arr = self.configArr[section];
//    return arr.count;
    return self.configArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *arr = self.configArr[indexPath.section];
    BZCellConfig *cellConfig = self.configArr[indexPath.row];
    UITableViewCell *cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.detailData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
//    BZCellConfig *cellConfig = self.configArr[indexPath.section][indexPath.row];
    BZCellConfig *cellConfig = self.configArr[indexPath.row];
    if ([cellConfig.title isEqualToString:@"comment"]) {
        BZGroupBuyDetailCommentViewController *commentViewController = [[BZGroupBuyDetailCommentViewController alloc]init];
        commentViewController.commentUrl = self.detailData.business.business_url;
        [self.navigationController pushViewController:commentViewController animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *arr = self.configArr[indexPath.section];
    BZCellConfig *cellConfig = self.configArr[indexPath.row];
    return cellConfig.heightOfCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        BZGroupBuyDetailBuyCell *buyCell = [BZGroupBuyDetailBuyCell buyCell];
        buyCell.deal = self.deal;
        return buyCell;
    }
    UIView *view = [[UIView alloc]init];
    view.height = 10;
    view.backgroundColor = BZBgColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    return 10;
}

@end
