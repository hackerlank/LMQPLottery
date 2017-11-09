//
//  LMLotteryInfoApi.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/9.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMBaseApi.h"

@interface LMLotteryInfoApi : LMBaseApi
//开奖信息列表
-(void)requestLotteryInfo:(void(^)(LMResponse *response))completion
                  failure:(void(^)(NSError *error))failure;

//某个彩种的开奖历史
-(void)requestLotteryInfoWithLotteryId:(int)lotteryId
                                  page:(int)page
                            completion:(void(^)(LMResponse *response))completion
                               failure:(void(^)(NSError *error))failure;
@end
