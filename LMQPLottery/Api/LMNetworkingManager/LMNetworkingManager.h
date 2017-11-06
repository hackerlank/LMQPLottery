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

@end
