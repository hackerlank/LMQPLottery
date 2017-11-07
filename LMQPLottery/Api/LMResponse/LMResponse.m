//
//  LMResponse.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMResponse.h"

@implementation LMResponse
-(BOOL)isSuccess{
    return (self.code && self.code.intValue ==0);
}
-(BOOL)isFail{
    return (self.code && self.code.intValue ==-1);
}
-(BOOL)isNeedLogin{
    return (self.code && self.code.intValue ==10001);
}
-(BOOL)isNeedRecharge{
    return (self.code && self.code.intValue ==10002);
}
-(BOOL)isRequestOften{
    return (self.code && self.code.intValue ==20001);
}
@end
