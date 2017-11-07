//
//  LMBaseApi.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 林宏敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMNetworkingManager.h"
@interface LMBaseApi : NSObject
//签名
-(NSDictionary *)getApp_sign:(NSDictionary *)dic;

//Auth
-(NSString *)getUserAuthWithUid:(NSString *)uid
                          token:(NSString *)token;
@end
