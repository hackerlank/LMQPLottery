//
//  LMHomeApi.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMBaseApi.h"
@interface LMHomeApi : LMBaseApi
//首页信息
-(void)requestHomeApi:(void(^)(LMResponse *response))completion
              failure:(void(^)(NSError *error))failure;
@end
