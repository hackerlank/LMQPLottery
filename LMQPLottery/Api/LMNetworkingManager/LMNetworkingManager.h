//
//  LMNetworkingManager.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "LMResponse.h"
typedef NS_ENUM(NSUInteger,requestAnimation){//请求时动画
   requestAnimationNone =0,
   requestAnimationGoldenCoin
};

@interface LMNetworkingManager : AFHTTPSessionManager
+(instancetype)shareInstance;

//get请求
-(void)getUrl:(NSString *)url
   parameters:(NSDictionary *)parameters
 onCompletion:(void(^)(LMResponse *response))completion
      failure:(void(^)(NSError *error))failure;

-(void)getUrl:(NSString *)url
   parameters:(NSDictionary *)parameters
 onCompletion:(void(^)(LMResponse *response))completion
      failure:(void(^)(NSError *error))failure
requestAnimation:(requestAnimation )animation;


//post请求
-(void)postUrl:(NSString *)url
    parameters:(NSDictionary *)parameters
  onCompletion:(void(^)(LMResponse *response))completion
       failure:(void(^)(NSError *error))failure;


-(void)postUrl:(NSString *)url
    parameters:(NSDictionary *)parameters
  onCompletion:(void(^)(LMResponse *response))completion
       failure:(void(^)(NSError *error))failure
requestAnimation:(requestAnimation )anmimation;
@end
