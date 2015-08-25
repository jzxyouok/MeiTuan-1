//
//  BZLoginViewController.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/29.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZLoginViewController.h"
#import "BZThirdLoginBtn.h"
#import "UMSocial.h"
#import "BZUserModel.h"
#import "BZUserTool.h"
#import "MBProgressHUD+MJ.h"


@interface BZLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet BZThirdLoginBtn *xinlangLogin;
@property (weak, nonatomic) IBOutlet BZThirdLoginBtn *weixinLogin;
@property (weak, nonatomic) IBOutlet BZThirdLoginBtn *QQLogin;

@end

@implementation BZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpLoginTextField];
    [self setUpThirdLoginBtn];
    
}

- (void)setUpNavBar
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"登陆" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    btn.width = 60;
    btn.height = 35;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)setUpThirdLoginBtn
{
    self.xinlangLogin.socialSnsType = UMSocialSnsTypeSina;
    self.weixinLogin.socialSnsType = UMSocialSnsTypeWechatSession;
    self.QQLogin.socialSnsType = UMSocialSnsTypeMobileQQ;
}

- (void)setUpLoginTextField
{
    UIView *userleftView = [[UIView alloc]init];
    userleftView.width = 10;
//
    self.userLabel.leftView = userleftView;
    self.userLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passwordLeftView = [[UIView alloc]init];
    passwordLeftView.width = 10;
    self.passwordLabel.leftView = passwordLeftView;
    self.passwordLabel.leftViewMode = UITextFieldViewModeAlways;
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (IBAction)ClickThirdLoginBtn:(BZThirdLoginBtn *)sender {
    NSLog(@"--------");
    
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:[UMSocialSnsPlatformManager getSnsPlatformString:(sender.socialSnsType)]];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:[UMSocialSnsPlatformManager getSnsPlatformString:sender.socialSnsType]];
            
            BZUserModel *user = [[BZUserModel alloc]init];
            user.platformName = snsAccount.platformName;
            NSLog(@"%@",snsAccount.platformName);
            user.userName = snsAccount.userName;
            user.usid = snsAccount.usid;
            user.accessToken = snsAccount.accessToken;
            user.iconUrl = snsAccount.iconURL;
            [BZUserTool saveUser:user];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [MBProgressHUD showSuccess:@"登陆成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }});

/**
 @brief 获取已经授权后的用户的信息
 */
//    [[UMSocialDataService defaultDataService] requestSnsInformation:[UMSocialSnsPlatformManager getSnsPlatformString:sender.socialSnsType]  completion:^(UMSocialResponseEntity *response){
//        NSLog(@"SnsInformation is %@",response.data);
//    }];
}


@end
