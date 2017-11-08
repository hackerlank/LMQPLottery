//
//  HomeLotteryModel.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMBaseModel.h"

@interface HomeLotteryModel : LMBaseModel
@property(nonatomic, assign)int lotteryId;
@property(nonatomic, copy)NSString *intro;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, assign)int is_official;
@property(nonatomic, assign)int lottery_group_id;


@end
