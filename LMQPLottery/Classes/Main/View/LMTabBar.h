//
//  LMTabBar.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LMTabBarDelegate<NSObject>

@optional
-(void)tabBarCenterButtonClicked;

@end

@interface LMTabBar : UITabBar

@property(nonatomic, weak)id<LMTabBarDelegate>tabBarDelegate;
@end
