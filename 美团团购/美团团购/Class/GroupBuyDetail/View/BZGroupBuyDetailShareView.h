//
//  BZGroupBuyDetailShareView.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/23.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZGroupBuyDetailShareView,BZGroupBuyDetailShareBtn;
@protocol BZGroupBuyDetailShareViewDelegate  <NSObject>

- (void)shareViewDidClickShareBtn:(BZGroupBuyDetailShareView *)shareView selBtn:(BZGroupBuyDetailShareBtn *)shareBtn;

@end

@interface BZGroupBuyDetailShareView : UIImageView
- (void)startShareWithText:(NSString *)text image:(UIImage *)image;
@property (copy, nonatomic) NSString *shareText;
@property (strong, nonatomic) UIImage *shareImage;

@property (weak, nonatomic) id<BZGroupBuyDetailShareViewDelegate> delegate;
@end
