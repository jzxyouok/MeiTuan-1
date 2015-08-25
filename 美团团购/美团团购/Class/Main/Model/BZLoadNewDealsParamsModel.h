//
//  BZLoadNewDealsParamsModel.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/21.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZLoadNewDealsParamsModel : NSObject

+ (instancetype)params;

/** 包含团购信息的城市 */
@property (copy, nonatomic) NSString *city;

/** 指定目的地城市名称，适用于“酒店”、“旅游”等分类 */
@property (copy, nonatomic) NSString *destination_city;

/** 纬度坐标 */
@property (assign, nonatomic) float latitude;

/** 经度坐标 */
@property (assign, nonatomic) float longitude;

/**	搜索半径 */
@property (assign, nonatomic) int radius;

/** 包含团购信息的城市区域名*/
@property (copy, nonatomic) NSString *region;

/** 包含团购信息的分类名，支持多个category合并查询，多个category用逗号分割 */
@property (copy, nonatomic) NSString *category;

/** is_local	int	根据是否是本地单来筛选返回的团购，1:是，0:不是 */
@property (assign, nonatomic) int is_local;

/** keyword	string	关键词，搜索范围包括商户名、商品名、地址等 */
@property (copy, nonatomic) NSString *keyword;

/** sort	int	结果排序，1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先 */
@property (assign, nonatomic) int sort;

/** limit	int	每页返回的团单结果条目数上限，最小值1，最大值40，如不传入默认为20*/
@property (assign, nonatomic) int limit;

/** page	int	页码，如不传入默认为1，即第一页 */
@property (assign, nonatomic) int page;

@end
