//
//  BZChangeCityCell.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BZChangeCityCell : UIView
@property (weak, nonatomic) IBOutlet UIButton *changeCityBtn;
+ (instancetype)changeCityCell;
- (void)addTarget:(id)target action:(SEL)action;
@end
