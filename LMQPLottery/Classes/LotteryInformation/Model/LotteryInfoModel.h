//
//  LotteryInfoModel.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/9.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMBaseModel.h"

@interface LotteryInfoModel : LMBaseModel
@property(nonatomic, strong)NSNumber *lotteryId;
@property(nonatomic, copy)NSString *create_time;
@property(nonatomic, copy)NSArray *data;
@property(nonatomic, copy)NSString *end_color;
@property(nonatomic, strong)NSNumber *lottery_group_id;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, strong)NSNumber *number;

@end
