//
//  LMResponse.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMResponse : NSObject

@property(nonatomic, strong)NSNumber *code;
@property(nonatomic, assign)id data;
@property(nonatomic, copy)NSString *message;

-(BOOL)isSuccess;//成功
-(BOOL)isFail;//失败
-(BOOL)isNeedLogin;//需要登录
-(BOOL)isNeedRecharge;//需要绑定手机号
-(BOOL)isRequestOften;//请求太频繁
@end
