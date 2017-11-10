//
//  SGGPresentTransition.h
//  JFScale
//
//  Created by iOSDev on 17/6/6.
//  Copyright © 2017年 iOSDev. All rights reserved.
//  自定义转场动画(适配商城)(无手势--待改进)

#import <Foundation/Foundation.h>

@interface SGGPresentTransition : NSObject
//present
+(void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)())completion;

//dismiss
+(void)dismissViewControllerAnimated:(BOOL)anmated completion:(void(^)())completion;
@end
