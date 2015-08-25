//
//  BZBusinessViewLeftItems.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/28.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZBusinessViewLeftItems.h"

@interface BZBusinessViewLeftItems ()
@property (weak, nonatomic) IBOutlet UIView *leftLine;
@property (weak, nonatomic) IBOutlet UIView *rightLine;
@property (weak, nonatomic) IBOutlet UIButton *allBusinessBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodBusinessBtn;
@property (strong, nonatomic) UIButton *lastSelectBtn;
@end


@implementation BZBusinessViewLeftItems

- (void)awakeFromNib
{
    self.allBusinessBtn.enabled = NO;
    self.goodBusinessBtn.enabled = YES;
    self.leftLine.hidden = NO;
    self.rightLine.hidden = YES;
    self.lastSelectBtn = self.allBusinessBtn;
}

+ (instancetype)leftItems
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BZBusinessViewLeftItems" owner:nil options:nil] lastObject];
}

- (IBAction)clickBtn:(UIButton *)sender {
    sender.enabled = NO;
    self.lastSelectBtn.enabled = YES;
    self.lastSelectBtn = sender;
    self.leftLine.hidden = self.allBusinessBtn.enabled;
    self.rightLine.hidden = self.goodBusinessBtn.enabled;
}




@end
