//
//  LMHomeView.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMHomeView : UIView
@property(nonatomic,copy)NSDictionary *data;

@property(nonatomic, copy)void(^homeLotteryClick)(int);
@end
