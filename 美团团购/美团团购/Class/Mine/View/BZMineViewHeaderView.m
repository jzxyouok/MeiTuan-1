//
//  BZMineViewHeaderView.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/26.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMineViewHeaderView.h"

@interface BZMineViewHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *ticketCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionCountLabel;

@end

@implementation BZMineViewHeaderView

+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BZMineViewHeaderView" owner:nil options:nil] lastObject];
}
- (IBAction)clickTicketBtn:(id)sender {
    
}
- (IBAction)clickCollectionBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickBtn:)]) {
        [self.delegate headerViewDidClickBtn:self];
    }
}

- (void)setCollectionCount:(int)collectionCount
{
    self.collectionCountLabel.text = [NSString stringWithFormat:@"%d",collectionCount];
}
- (IBAction)clickLoginBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(headerViewDidLoginBtn:)]) {
        [self.delegate headerViewDidLoginBtn:self];
    }
}
@end
