//
//  BZMoreDiagnoseNetLoadingView.m
//  美团团购
//
//  Created by 尚承教育 on 15/8/1.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMoreDiagnoseNetLoadingView.h"
@interface BZMoreDiagnoseNetLoadingView ()

@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UISlider *sliderView;

@end


@implementation BZMoreDiagnoseNetLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        
        UILabel *tipLabel = [[UILabel alloc]init];
        tipLabel.textColor = BZTabBarBtnTitleColor;
        tipLabel.text = @"正在为你诊断，请耐心等待...";
        tipLabel.font = [UIFont systemFontOfSize:16];
        self.tipLabel = tipLabel;
        [self addSubview:tipLabel];
        
        UISlider *sliderView = [[UISlider alloc]init];
        sliderView.minimumTrackTintColor = BZTabBarBtnTitleColor;
        sliderView.maximumTrackTintColor = [UIColor clearColor];
        sliderView.thumbTintColor = [UIColor clearColor];
        self.sliderView = sliderView;
        [self addSubview:sliderView];
    }
    return self;
}

+ (instancetype)loadingView
{
    return [[self alloc]init];
}

- (void)beginLoading
{
    self.hidden = NO;
    self.sliderView.value = 0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.25 target:self selector:@selector(addSlider) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stopLoading];
    });
}

- (void)addSlider
{
    self.sliderView.value += 0.05;
}

- (void)stopLoading
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(loadingViewDidStopLoading:)]) {
        [self.delegate loadingViewDidStopLoading:self];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:16]};
    CGSize tipLableSize = [self.tipLabel.text sizeWithAttributes:dict];
    self.tipLabel.size = tipLableSize;
    self.tipLabel.centerY = self.height * 0.4;
    self.tipLabel.centerX = self.width * 0.5;
    
    self.sliderView.width = self.width - 20;
    self.sliderView.height = 40;
    self.sliderView.centerX = self.tipLabel.centerX;
    self.sliderView.centerY = self.tipLabel.centerY + 40;
}

@end
