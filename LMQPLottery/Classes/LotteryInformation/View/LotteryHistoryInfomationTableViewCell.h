//
//  LotteryHistoryInfomationTableViewCell.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/9.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryHistoryInfomationModel.h"

@interface LotteryHistoryInfomationTableViewCell : UITableViewCell

@property(nonatomic, strong)LotteryHistoryInfomationModel *model;
@property(nonatomic, assign)int lotteryId;
@end
