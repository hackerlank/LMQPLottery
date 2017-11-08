//
//  LoopTextScrollView.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopTextScrollView : UIScrollView
-(instancetype)initWithFrame:(CGRect)frame maxCount:(int)maxCount;
-(void)animationWithTextArray:(NSArray *)textArray;
@end
