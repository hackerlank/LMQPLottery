//
//  LMTabBarController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 林宏敏. All rights reserved.
//

#import "LMTabBarController.h"
#import "LMNavigationController.h"
#import "LMAppDelegate.h"

#import "LMHomeViewController.h"
#import "LMLotteryInformationController.h"
#import "LMRechargeRoomController.h"
#import "LMBettingRecordController.h"
#import "LMMineViewController.h"

#import "LMTabBar.h"
@interface LMTabBarController ()<LMTabBarDelegate,UITabBarControllerDelegate>

@end

@implementation LMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    [self setupChildControllers];
   
}
-(void)setupTabBar{
    LMTabBar *customTabBar=[[LMTabBar alloc]init];
    customTabBar.tabBarDelegate=self;
    [self setValue:customTabBar forKey:@"tabBar"];
    self.delegate=self;
}
-(void)setupChildControllers{
    LMHomeViewController *home=[[LMHomeViewController alloc]init];
    
    [self addOneChildControllerToTabBar:home title:@"首页" normalImageName:@"tabbar_01_select" selectedImageName:@"tabbar_01_selected"];
    
    LMLotteryInformationController *infomationControlller=[[LMLotteryInformationController alloc]init];
    [self addOneChildControllerToTabBar:infomationControlller title:@"开奖信息" normalImageName:@"tabbar_02_select" selectedImageName:@"tabbar_02_selected"];
    
    LMBettingRecordController *recordController=[[LMBettingRecordController alloc]init];
    [self addOneChildControllerToTabBar:recordController title:@"投注记录" normalImageName:@"tabbar_03_select" selectedImageName:@"tabbar_03_selected"];
    
    LMMineViewController *mineController=[[LMMineViewController alloc]init];
    [self addOneChildControllerToTabBar:mineController title:@"我的" normalImageName:@"tabbar_04_select" selectedImageName:@"tabbar_04_selected"];
    
    
    
}
-(void)addOneChildControllerToTabBar:(UIViewController *)controller
                               title:(NSString *)title
                     normalImageName:(NSString *)normalName
                   selectedImageName:(NSString *)selectedName{
    controller.tabBarItem.title=title;
    //图片设置
    if (title.length) {
        controller.tabBarItem.image=[[UIImage imageNamed:normalName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *selectedImage=[[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        controller.tabBarItem.selectedImage=selectedImage;
    }
    
    
    //文字颜色设置
    NSMutableDictionary *selectedDic=@{}.mutableCopy;
    selectedDic[NSForegroundColorAttributeName]=[UIColor colorWithHexString:@"ffdc99"];
    [controller.tabBarItem setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    NSMutableDictionary *normalDic=@{}.mutableCopy;
    normalDic[NSForegroundColorAttributeName]=[UIColor colorWithHexString:@"3a86e5"];
    [controller.tabBarItem setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    
    //位置调整
    [controller.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    [controller.tabBarItem setImageInsets:UIEdgeInsetsMake(-10, 0, 10, 0)];
    LMNavigationController *navi=[[LMNavigationController alloc]initWithRootViewController:controller];
    
    [self addChildViewController:navi];
    
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[LMNavigationController class]]) {
        LMNavigationController *vc=(LMNavigationController *)viewController;
        if ([vc.topViewController isKindOfClass:[LMBettingRecordController class]]||[vc.topViewController isKindOfClass:[LMMineViewController class]]) {
            
            if (![[Utility shareInstance] isLogin]) {
                LMAppDelegate *appDelegate=(LMAppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate showLoginController];
                return NO;
            }
            
        }
    }
    
    
 
    return YES;
}
#pragma mark LMTabBarDelegate
-(void)tabBarCenterButtonClicked{
    if ([[Utility shareInstance] isLogin]) {
        LMRechargeRoomController *rechargeController=[[LMRechargeRoomController alloc]init];
        [SGGPresentTransition presentViewController:rechargeController animated:YES completion:nil];
        
        
    }else{
        
        LMAppDelegate *delegate=(LMAppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate showLoginController];
    }

}

@end
