//
//  BZSearchResultBtn.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/19.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZSearchResultBtn.h"
@interface BZSearchResultBtn ()
@property (strong, nonatomic) UILabel *myTitleLabel;
@end


@implementation BZSearchResultBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *myTitleLabel = [[UILabel alloc]init];
        [self addSubview:myTitleLabel];
        self.myTitleLabel = myTitleLabel;
        myTitleLabel.textColor = [UIColor blackColor];
        myTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setMyTitle:(NSString *)myTitle
{
    self.myTitleLabel.text = myTitle;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.myTitleLabel.width = self.width - 10;
    self.myTitleLabel.height = self.height;
    self.myTitleLabel.x = 5;
}

@end
