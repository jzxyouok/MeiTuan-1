//
//  BZGroupBuyCategoryBtn.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/17.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BZGroupBuyCategoryBtn : UIView

@property (strong, nonatomic) UIImage *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)categroyBtn;

- (void)addTarget:(id)target action:(SEL)action;
@end
