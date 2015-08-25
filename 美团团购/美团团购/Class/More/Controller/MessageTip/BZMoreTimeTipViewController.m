//
//  BZMoreTimeTipViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/31.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZMoreTimeTipViewController.h"
#import "BZLocalNotificationTool.h"

@interface BZMoreTimeTipViewController ()
@property (weak, nonatomic) IBOutlet UIButton *autoBtn;
@property (weak, nonatomic) IBOutlet UIButton *setTimeBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) UIButton *lastBtn;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) NSUserDefaults *ud;
@end

@implementation BZMoreTimeTipViewController


- (NSUserDefaults *)ud
{
    if (!_ud) {
        _ud = [NSUserDefaults standardUserDefaults];
    }
    return _ud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setTimeBtn.selected = ![self.ud boolForKey:BZMoreSetTimeTipAuto];
    self.autoBtn.selected = !self.setTimeBtn.selected;
    self.dateView.hidden = !self.setTimeBtn.selected;
    self.lastBtn = [self.ud boolForKey:BZMoreSetTimeTipAuto] ? self.autoBtn : self.setTimeBtn;
    NSData *timeData = [self.ud dataForKey:BZMoreSetTimeTipDate];
    if (timeData) {
    self.datePicker.date = [NSKeyedUnarchiver unarchiveObjectWithData:timeData];
    }
    [self.datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"提醒时间" target:self action:@selector(back)];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)clickAtuoBtn:(UIButton *)sender {
    
    sender.selected = YES;
    self.lastBtn.selected = NO;
    self.lastBtn = sender;
    if (sender.tag == 0) {
        self.dateView.hidden = YES;
    }
    else
    {
        self.dateView.hidden = NO;
    }
    [self.ud setBool:self.autoBtn.selected forKey:BZMoreSetTimeTipAuto];
}

- (IBAction)clickOkBtn:(id)sender {
    [BZLocalNotificationTool sendLocalNorificationToolSinceNow];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeDate:(UIDatePicker *)datePicker
{
    NSData *dateData = [NSKeyedArchiver archivedDataWithRootObject:datePicker.date];
    [self.ud setValue:dateData forKey:BZMoreSetTimeTipDate];
}

@end