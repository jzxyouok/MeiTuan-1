//
//  BZCommonSearchControllerSearchTipView.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

@protocol BZCommonSearchControllerSearchTipViewDelegate <NSObject>

- (void)searchTipViewClickBtnWithTitle:(NSString *)btnTitle;

@end

#import <UIKit/UIKit.h>

@interface BZCommonSearchControllerSearchTipView : UIView

@property (weak, nonatomic) id <BZCommonSearchControllerSearchTipViewDelegate> delegate;


@end
