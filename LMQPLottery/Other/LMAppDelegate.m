//
//  LMAppDelegate.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMAppDelegate.h"
#import "LMTabBarController.h"
#import "LMUserApi.h"
#import "LMBaseController.h"
#import "LMLoginViewController.h"

@implementation LMAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor=[UIColor whiteColor];
    _window.rootViewController=[[LMTabBarController alloc]init];
    [_window makeKeyAndVisible];
    
    
    
    
    
    [self setupAppears];
    return YES;
}
-(void)showLoginController{
    [[[LMUserApi alloc]init] handleLoginout];
    LMBaseController *vc=(LMBaseController *)[self getCurrentViewControllerFormRootController:self.window.rootViewController];
    if ([vc isKindOfClass:[LMLoginViewController class]]) {
        return;
    }
    LMLoginViewController *loginController=[[LMLoginViewController alloc]init];
    [SGGPresentTransition presentViewController:loginController animated:YES completion:nil];
    
    
    
    
}
-(UIViewController *)getCurrentViewControllerFormRootController:(UIViewController *)rootController{
    UIViewController *currentController;
    if ([rootController presentedViewController]) {//present
        rootController=[rootController presentedViewController];
    }
    if ([rootController isKindOfClass:[UITabBarController class]]) {
        //根控制器为TabbarController
     currentController=[self getCurrentViewControllerFormRootController:[(UITabBarController*)rootController selectedViewController]];
    }else if ([rootController isKindOfClass:[UINavigationController class]]){
        //根控制器为导航控制器
        currentController=[self getCurrentViewControllerFormRootController:[(UINavigationController *)rootController visibleViewController]];
    }else{
        //非容器类控制器
        currentController=rootController;
    }
    return currentController;
}
-(void)setupAppears{
    
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    
    
    
    
}
@end
