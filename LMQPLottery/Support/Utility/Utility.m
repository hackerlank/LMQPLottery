//
//  Utility.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/10.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+(instancetype)shareInstance{
    static Utility *insatnce=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        insatnce=[[self alloc]init];
    });
    return insatnce;
    
}
-(BOOL)isLogin{
    NSString *userAuto=[[NSUserDefaults standardUserDefaults] objectForKey:@"userAuth"];
    if (!userAuto || !userAuto.length) {
        return NO;
    }
    return YES;
}
@end
