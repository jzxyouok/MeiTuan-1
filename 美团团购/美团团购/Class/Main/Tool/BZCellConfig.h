//
//  BZCellConfig.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/22.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZCellConfig : NSObject


@property (nonatomic, strong) NSString *className;

/** cell的判断标识 */
@property (nonatomic, strong) NSString *title;

/** 显示数据模型的方法 */
@property (nonatomic, assign) SEL showInfoMethod;

/** cell高度 */
@property (nonatomic, assign) double heightOfCell;


+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell;

/** 根据cellConfig生成cell，重用ID为cell类名 */
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel;

@end
