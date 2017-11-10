//
//  SGGTransitionDlelegateManager.h
//  JFScale
//
//  Created by iOSDev on 17/6/6.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import <Foundation/Foundation.h>

static const void *SGGTransitionKey =@"SGGTransitionKey";
@interface SGGTransitionDlelegateManager : NSObject<UIViewControllerTransitioningDelegate>

-(instancetype)initWithView:(UIView *)view;
@end
