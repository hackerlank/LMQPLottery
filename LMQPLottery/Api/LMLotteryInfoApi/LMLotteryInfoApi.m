//
//  LMLotteryInfoApi.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/9.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMLotteryInfoApi.h"

@implementation LMLotteryInfoApi
-(void)requestLotteryInfo:(void(^)(LMResponse *response))completion
                  failure:(void(^)(NSError *error))failure{
    NSDictionary *parameters=[self getApp_sign:@{}];
    [[LMNetworkingManager shareInstance] postUrl:LotteryInfo_list parameters:parameters onCompletion:^(LMResponse *response) {
        completion(response);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
-(void)requestLotteryInfoWithLotteryId:(int)lotteryId
                                  page:(int)page
                            completion:(void(^)(LMResponse *response))completion
                               failure:(void(^)(NSError *error))failure{
    NSDictionary *parameters=[self getApp_sign:@{@"id":[NSNumber numberWithInt:lotteryId],
                                                 @"page":[NSNumber numberWithInt:page]
                                                 }];
    [[LMNetworkingManager shareInstance] postUrl:LotteryInfo_Single_list parameters:parameters onCompletion:^(LMResponse *response) {
        completion(response);
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
@end
