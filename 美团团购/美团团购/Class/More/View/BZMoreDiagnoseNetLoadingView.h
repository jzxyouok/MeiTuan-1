//
//  BZMoreDiagnoseNetLoadingView.h
//  美团团购
//
//  Created by 尚承教育 on 15/8/1.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZMoreDiagnoseNetLoadingView;

@protocol BZMoreDiagnoseNetLoadingViewDelegate <NSObject>

- (void)loadingViewDidStopLoading:(BZMoreDiagnoseNetLoadingView *)loadingView;

@end

@interface BZMoreDiagnoseNetLoadingView : UIView

@property (weak, nonatomic) id <BZMoreDiagnoseNetLoadingViewDelegate> delegate;

+ (instancetype)loadingView;
- (void)beginLoading;

@end
