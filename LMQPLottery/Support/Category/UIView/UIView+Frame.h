//
//  UIView+Frame.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/** x值 */
@property (nonatomic,assign) CGFloat x;
/** y值 */
@property (nonatomic,assign) CGFloat y;
/** 宽度 */
@property (nonatomic,assign) CGFloat w;
/** 高度 */
@property (nonatomic,assign) CGFloat h;
/** 大小size */
@property (nonatomic,assign) CGSize size;
/** 中心点Y值 */
@property (nonatomic,assign) CGFloat centerY;
/** 中心点X值 */
@property (nonatomic,assign) CGFloat centerX;
@end
