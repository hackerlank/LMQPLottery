//
//  LMLoginViewController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/10.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMLoginViewController.h"

@interface LMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UILabel *forgetLabel;

@end

@implementation LMLoginViewController
- (IBAction)login:(id)sender {
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"userAuto" forKey:@"userAuth"];
    [userDefault setObject:@"12" forKey:@"Uid"];
    [userDefault setObject:@"" forKey:@"userName"];
    [userDefault setObject:@"" forKey:@"amount"];
    [userDefault synchronize];
  
    [SGGPresentTransition dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)back:(id)sender {
    [SGGPresentTransition dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)forgetPaaWord:(id)sender {
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI{
    [self.userName setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.userName setValue:LMColor_RGBA(255,255,255, 0.5) forKeyPath:@"_placeholderLabel.textColor"];
    [self.passWord setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.passWord setValue:LMColor_RGBA(255,255,255, 0.5) forKeyPath:@"_placeholderLabel.textColor"];
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:@"忘记密码？"];
    [attrString addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, attrString.length)];
    self.forgetLabel.attributedText=attrString;
    self.forgetLabel.userInteractionEnabled=YES;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
