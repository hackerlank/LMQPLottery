//
//  LMHomeApi.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMHomeApi.h"

@implementation LMHomeApi
-(void)requestHomeApi:(void(^)(LMResponse *response))completion
              failure:(void(^)(NSError *error))failure{
    NSDictionary *parameters=[self getApp_sign:@{}];
    [[LMNetworkingManager shareInstance] postUrl:Home_Api parameters:parameters onCompletion:^(LMResponse *response) {
        if (completion) {
            completion(response);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

}
@end
