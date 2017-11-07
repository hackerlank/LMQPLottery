//
//  LMTabBarController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 林宏敏. All rights reserved.
//

#import "LMTabBarController.h"
#import "LMNavigationController.h"

#import "LMHomeViewController.h"
#import "LMLotteryInformationController.h"
#import "LMRechargeRoomController.h"
#import "LMBettingRecordController.h"
#import "LMMineViewController.h"


@interface LMTabBarController ()

@end

@implementation LMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
   
}
-(void)setupChildControllers{
    LMHomeViewController *home=[[LMHomeViewController alloc]init];
    
    [self addOneChildControllerToTabBar:home title:@"首页" normalImageName:@"001" selectedImageName:@"001"];
    
    LMLotteryInformationController *infomationControlller=[[LMLotteryInformationController alloc]init];
    [self addOneChildControllerToTabBar:infomationControlller title:@"开奖信息" normalImageName:@"001" selectedImageName:@"001"];
    
    LMBettingRecordController *recordController=[[LMBettingRecordController alloc]init];
    [self addOneChildControllerToTabBar:recordController title:@"投注记录" normalImageName:@"001" selectedImageName:@"001"];
    
    LMMineViewController *mineController=[[LMMineViewController alloc]init];
    [self addOneChildControllerToTabBar:mineController title:@"我的" normalImageName:@"001" selectedImageName:@"001"];
    
    
    
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


@end
