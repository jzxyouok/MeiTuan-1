//
//  BZMoreFeedBackViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/8/11.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZFeedBackViewController.h"

@interface BZFeedBackViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UIView *messageView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIView *feedTextView;
@property (strong, nonatomic) UIButton *sendBtn;
@property (strong, nonatomic) UILabel *countLabel;

@property (assign, nonatomic,getter=isKeyboardUP) BOOL keyboardUP;
@end

static NSString *_lastStr;

@implementation BZFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BZBgColor;
    self.keyboardUP = NO;
    [self setUpNoti];
    [self setUpUI];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWith:@"意见反馈" target:self action:@selector(back)];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpNoti
{
    [BZNotificationCenter addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [BZNotificationCenter addObserver:self selector:@selector(keyBoardWillhide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoardWillShow:(NSNotification *)noti
{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyBoardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"%f",keyBoardHeight);
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:7 >> 16 animations:^{
        
        self.feedTextView.transform = CGAffineTransformMakeTranslation(0, -keyBoardHeight );
        self.keyboardUP = YES;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyBoardWillhide:(NSNotification *)noti
{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:7 >> 16 animations:^{
        
        self.feedTextView.transform = CGAffineTransformIdentity;
        self.keyboardUP = NO;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)setUpUI
{
    UIView *messageView = [[UIView alloc]init];
    messageView.width = self.view.width;
    messageView.y = 64;
    messageView.height = self.view.height - 64 * 2;
    self.messageView = messageView;
    messageView.backgroundColor = [UIColor clearColor];
    
    UIButton *tipBtn = [[UIButton alloc]init];
    tipBtn.width = 100;
    tipBtn.height = 30;
    tipBtn.center = CGPointMake(messageView.width / 2, 50);
    [tipBtn setTitle:@"载入较早的信息" forState:UIControlStateNormal];
    [tipBtn setTitleColor:BZTabBarBtnTitleColor forState:UIControlStateNormal];
    tipBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [messageView addSubview:tipBtn];
    [self.view addSubview:messageView];
    
    [self setUpFeedTextView];
}

- (void)setUpFeedTextView
{
    
    CGFloat margin = 5;
    
    UIView *feedTextView = [[UIView alloc]init];
    feedTextView.width = self.view.width;
    feedTextView.height = 35;
    feedTextView.y = self.view.height - feedTextView.height;
    feedTextView.backgroundColor =[UIColor blackColor];
    [self.view addSubview:feedTextView];
    
    UITextView *textView = [[UITextView alloc]init];
    textView.font = [UIFont systemFontOfSize:14];
    textView.width = feedTextView.width - 60;
    textView.height = feedTextView.height - margin * 2;
    textView.x = margin;
    textView.y = margin;
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    self.textView = textView;
    [feedTextView addSubview:textView];
    
    UIButton *sendBtn = [[UIButton alloc]init];
    sendBtn.width = 45 + 4;
    sendBtn.height = 25 + 4;
    sendBtn.layer.cornerRadius = 5;
    sendBtn.clipsToBounds = YES;
    sendBtn.y = feedTextView.height - sendBtn.height - margin + 2;
    sendBtn.x = CGRectGetMaxX(textView.frame) + margin - 2;
    sendBtn.backgroundColor = BZTabBarBtnTitleColor;
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendBtn = sendBtn;
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *countLabel = [[UILabel alloc]init];
    countLabel.width = 45;
    countLabel.height = 25;
    countLabel.y = feedTextView.height - countLabel.height - margin + 2;
    countLabel.x = CGRectGetMaxX(textView.frame) + margin - 2;
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.hidden = YES;
    countLabel.textColor = [UIColor whiteColor];
    self.countLabel = countLabel;
    [feedTextView addSubview:countLabel];
    
    self.feedTextView = feedTextView;
    [feedTextView addSubview:sendBtn];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize textSize = [textView.text sizeWithfont:[UIFont systemFontOfSize:14] maxWidth:textView.width maxHeight:MAXFLOAT];
    self.countLabel.text = [NSString stringWithFormat:@"%ld",300-textView.text.length];
    [self textViewLengthRestriction:textView.text.length];
    NSLog(@"%lf",textSize.height);
    if ((textSize.height > self.textView.height && self.feedTextView.height <= 60) || ((textSize.height < self.textView.height && self.feedTextView.height > 0))) {
        if (textSize.height < 25) {
            textSize.height = 25;
        }
        if (textSize.height > 50) {
            self.countLabel.hidden = NO;
        }
        else
        {
            self.countLabel.hidden = YES;
        }
        self.textView.height = textSize.height;
        NSLog(@"-------------%lf",self.textView.height);
        self.feedTextView.height = self.textView.height + 10;
        if (self.isKeyboardUP) {
            self.feedTextView.y = self.view.height - self.feedTextView.height - 252;
        }
        else
        {
        self.feedTextView.y = self.view.height - self.feedTextView.height;
        }
        NSLog(@"feedTextViewYYY====%lf",self.feedTextView.y);
        self.sendBtn.y = self.feedTextView.height - self.sendBtn.height - 5 + 2;
    }
}

- (void)textViewLengthRestriction:(long int)count
{
    NSLog(@"%ld",count);
    if (count > 300) {
        self.textView.text = [self.textView.text substringToIndex:300];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
