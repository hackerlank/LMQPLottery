//
//  LMLoginBaseController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/10.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMLoginBaseController.h"
#import "SGGPresentTransition.h"
@interface LMLoginBaseController ()
@property(nonatomic, weak)UIImageView *bgImageView;
@property(nonatomic, weak)UIImageView *contentImageView;
@property(nonatomic, weak)UIButton *backButton;

@end

@implementation LMLoginBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}
-(void)setupSubviews{
    [self userNameTextField];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"icon_my_back"] forState:UIControlStateNormal];
    
}
-(void)back{
    [SGGPresentTransition dismissViewControllerAnimated:YES completion:nil];
    
}
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        UIImageView *bgImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
        [self.view insertSubview:bgImageView atIndex:0];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _bgImageView=bgImageView;
    }
    return _bgImageView;
}
-(UIImageView *)contentImageView{
    
    if (!_contentImageView) {
        UIImageView *contentImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_content_bg"]];
        [self.view insertSubview:contentImageView aboveSubview:self.bgImageView];
        [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            //12, 0, SCREEN_WIDTH-24, 552
            make.left.mas_offset(12);
            make.right.mas_offset(-12);
            make.top.mas_offset(64);
            make.height.mas_equalTo(552);
        }];
        _contentImageView=contentImageView;
    }
    return _contentImageView;
}
-(UIButton *)backButton{
    if (!_backButton) {
        UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentImageView);
            make.top.mas_offset(25);
            make.size.mas_equalTo(CGSizeMake(34, 36));
        }];
        _backButton=backButton;
    }
    return _backButton;
}
-(UITextField *)userNameTextField{
    

    
    if (!_userNameTextField) {
        UITextField *userNameTextField=[[UITextField alloc]init];
        userNameTextField.backgroundColor=LMColor_RGBA(0, 0, 0, 0.3);
        userNameTextField.placeholder=@" 请输入用户名";
        userNameTextField.borderStyle=UITextBorderStyleNone;
        [userNameTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [userNameTextField setValue:LMColor_RGBA(255,255,255, 0.5) forKeyPath:@"_placeholderLabel.textColor"];
        
    [userNameTextField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.backgroundColor"];
        
        
       
        [self.view addSubview:userNameTextField];
        [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(260);
            make.left.equalTo(self.contentImageView).mas_offset(80);
            make.height.mas_equalTo(40);
            make.right.equalTo(self.contentImageView).mas_offset(-40);
            
        }];
        _userNameTextField=userNameTextField;
    }
    return _userNameTextField;
    
}
@end
