//
//  BZMoreCharacterViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/8/11.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMoreCharacterViewController.h"

@interface BZMoreCharacterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *smallBtn;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *bigBtn;
@property (weak, nonatomic) IBOutlet UIButton *veryBigBtn;
@property (strong, nonatomic) UIButton *lastBtn;
@end

@implementation BZMoreCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"字号大小" target:self action:@selector(back)];
    [self loadSelectedBtn];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadSelectedBtn
{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:BZSettingCharacterSize]) {
        case 14:
            self.smallBtn.enabled = NO;
            self.lastBtn = self.smallBtn;
            break;
            case 15:
            self.defaultBtn.enabled = NO;
            self.lastBtn = self.defaultBtn;
            break;
            case 16:
            self.bigBtn.enabled = NO;
            self.lastBtn = self.bigBtn;
            break;
            case 17:
            self.veryBigBtn.enabled = NO;
            self.lastBtn = self.veryBigBtn;
            break;
        default:
            self.defaultBtn.enabled = NO;
            self.lastBtn = self.defaultBtn;

            break;
    }
}

- (IBAction)characterSizeSelect:(UIButton *)sender {
    sender.enabled = NO;
    self.lastBtn.enabled = YES;
    self.lastBtn = sender;
    [[NSUserDefaults standardUserDefaults] setInteger:(sender.tag + 13) forKey:BZSettingCharacterSize];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
