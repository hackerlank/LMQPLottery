//
//  LMProgressHud.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMProgressHud : NSObject
+(instancetype)shareInstance;
//文字
-(void)showToast:(NSString *)message;


//动画
-(void)show;
-(void)dismiss;
@end
