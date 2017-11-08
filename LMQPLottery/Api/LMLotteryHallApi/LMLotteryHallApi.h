//
//  LMLotteryHallApi.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMBaseApi.h"

@interface LMLotteryHallApi : LMBaseApi
//购彩大厅详情
-(void)requestLotteryHallDetailWith:(int)lotteryId completion:(void(^)(LMResponse *response))completion failure:(void(^)(NSError *error))failure;
@end
