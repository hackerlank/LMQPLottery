//
//  UIImage+GradientColor.h
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger ,gradientType) {
    gradientTypeTopToBottom =0,
    gradientTypeLeftToRight ,
    GradientTypeUpleftToLowright ,
    GradientTypeUprightToLowleft
};
@interface UIImage (GradientColor)
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(gradientType)gradientType imgSize:(CGSize)imgSize;
@end
