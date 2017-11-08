//
//  LMNavigationController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 林宏敏. All rights reserved.
//

#import "LMNavigationController.h"
#import "LMHomeViewController.h"
#import "LMLotteryInformationController.h"
@interface LMNavigationController ()

@end

@implementation LMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([viewController isKindOfClass:[LMHomeViewController class]]||[viewController isKindOfClass:[LMLotteryInformationController class]]) {
        self.navigationBarHidden=YES;
    }
    if (self.viewControllers.count>0) {
        self.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
  
}

@end
