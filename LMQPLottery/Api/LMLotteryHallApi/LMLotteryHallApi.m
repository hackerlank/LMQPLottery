//
//  LMLotteryHallApi.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMLotteryHallApi.h"

@implementation LMLotteryHallApi
-(void)requestLotteryHallDetailWith:(int)lotteryId completion:(void(^)(LMResponse *response))completion failure:(void(^)(NSError *error))failure{
    
    NSDictionary *parameters=[self getApp_sign:@{@"id":[NSNumber numberWithInt:lotteryId]}];
    [[LMNetworkingManager shareInstance] postUrl:Lottery_Detail parameters:parameters onCompletion:^(LMResponse *response) {
        completion(response);
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    } requestAnimation:requestAnimationGoldenCoin];
                                                 
    
    
    
    
}
@end
