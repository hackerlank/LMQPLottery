//
//  LMUserApi.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/10.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMUserApi.h"

@implementation LMUserApi
//退出登录
-(void)handleLoginout{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"" forKey:@"UserAuth"];
    [userDefault setObject:@"" forKey:@"Uid"];
    [userDefault setObject:@"" forKey:@"userName"];
    [userDefault setObject:@"" forKey:@"amount"];
    [userDefault synchronize];
    
}
@end
