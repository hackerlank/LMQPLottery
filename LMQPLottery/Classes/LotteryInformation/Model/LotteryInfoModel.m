//
//  LotteryInfoModel.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/9.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LotteryInfoModel.h"

@implementation LotteryInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"lotteryId":@"id"};
}
@end
