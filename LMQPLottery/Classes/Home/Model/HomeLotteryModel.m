//
//  HomeLotteryModel.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "HomeLotteryModel.h"

@implementation HomeLotteryModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"lotteryId":@"id"};
}
@end
