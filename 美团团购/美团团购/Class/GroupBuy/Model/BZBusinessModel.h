//
//  BZBusinessModel.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZBusinessModel : NSObject

/** business_id	int	商户ID */
@property (assign, nonatomic) int business_id;

/** *name	string	商户名 */
@property (copy, nonatomic) NSString *name;

/** branch_name	string	分店名 */
@property (copy, nonatomic) NSString *branch_name;

/** address	string	地址 */
@property (copy, nonatomic) NSString *address;

/** telephone	string	带区号的电话 */
@property (copy, nonatomic) NSString *telephone;

/** city	string	所在城市 */
@property (copy, nonatomic) NSString *city;

//regions	list	所在区域信息列表，如[徐汇区，徐家汇
//categories	list	所属分类信息列表，如[宁波菜，婚宴酒店]

/** latitude	float	纬度坐标 */
@property (assign, nonatomic) float latitude;

/**longitude	float	经度坐标 */
@property (assign, nonatomic) float longitude;

/** avg_rating	float	星级评分，5.0代表五星，4.5代表四星半，依此类推 */
@property (assign, nonatomic) float avg_rating;

/** rating_img_url	string	星级图片链接 */
@property (copy, nonatomic) NSString *rating_img_url;

/** rating_s_img_url	string	小尺寸星级图片链接 */
@property (copy, nonatomic) NSString *rating_s_img_url;

/** product_grade	int	产品/食品口味评价，1:一般，2:尚可，3:好，4:很好，5:非常好 */
@property (assign, nonatomic) int product_grade;

/** decoration_grade	int	环境评价，1:一般，2:尚可，3:好，4:很好，5:非常好 */
@property (assign, nonatomic) int decoration_grade;

/** service_grade	int	服务评价，1:一般，2:尚可，3:好，4:很好，5:非常好 */
@property (assign, nonatomic) int service_grade;

/** product_score	float	产品/食品口味评价单项分，精确到小数点后一位（十分制） */
@property (assign, nonatomic) float product_score;

/** decoration_score	float	环境评价单项分，精确到小数点后一位（十分制）*/
@property (assign, nonatomic) float decoration_score;

/** service_score	float	服务评价单项分，精确到小数点后一位（十分制）*/
@property (assign, nonatomic) float service_score;

/** avg_price	int	人均价格，单位:元，若没有人均，返回-1 */
@property (assign, nonatomic) int avg_price;

/** review_count	int	点评数量 */
@property (assign, nonatomic) int review_count;

/** review_list_url	list	点评页面URL链接 */

/** business_url	string	商户页面链接 */
@property (copy, nonatomic) NSString *business_url;

/** photo_url	string	照片链接，照片最大尺寸700×700 */
@property (copy, nonatomic) NSString *photo_url;

/** s_photo_url	string	小尺寸照片链接，照片最大尺寸278×200 */
@property (copy, nonatomic) NSString *s_photo_url;

/** photo_count	int	照片数量 */
@property (assign, nonatomic) int photo_count;

//photo_list_url	list	照片页面URL链接

//has_coupon	int	是否有优惠券，0:没有，1:有
//coupon_id	int	优惠券ID
/** coupon_description	string	优惠券描述 */
@property (copy, nonatomic) NSString *coupon_description;

/** coupon_url	string	优惠券页面链接  */
@property (copy, nonatomic) NSString *coupon_url;

//has_deal	int	是否有团购，0:没有，1:有
//deal_count	int	商户当前在线团购数量

//deals	list	团购列表
//deals.id	string	团购ID
/** deals.description	string	团购描述 */
@property (copy, nonatomic) NSString *dealsDescription;
/** deals.url	string	团购页面链接 */
@property (copy, nonatomic) NSString *dealsUrl;
@end
