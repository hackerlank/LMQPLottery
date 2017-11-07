//
//  LMAppDelegate.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMAppDelegate.h"
#import "LMTabBarController.h"
@implementation LMAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor=[UIColor whiteColor];
    _window.rootViewController=[[LMTabBarController alloc]init];
    [_window makeKeyAndVisible];
    
    return YES;
}
@end
