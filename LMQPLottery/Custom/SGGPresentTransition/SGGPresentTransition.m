//
//  SGGPresentTransition.m
//  JFScale
//
//  Created by iOSDev on 17/6/6.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "SGGPresentTransition.h"
#import "SGGTransitionDlelegateManager.h"
#import <objc/runtime.h>

@implementation SGGPresentTransition
#pragma mark  - present
+(void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)())completion{
    if (viewController==nil) {
        return;
    }
    UIView *rootView=[self rootView:viewController];
    SGGTransitionDlelegateManager *manager=[[SGGTransitionDlelegateManager alloc]initWithView:rootView];
    viewController.transitioningDelegate=manager;
    objc_setAssociatedObject(viewController, SGGTransitionKey, manager, OBJC_ASSOCIATION_RETAIN);
    UIViewController *topViewController=self.topViewController;
    if (!topViewController.isBeingDismissed &&
        !topViewController.isBeingPresented) {
        [topViewController presentViewController:viewController animated:animated completion:completion];
    }

}

#pragma mark  - dismiss
+(void)dismissViewControllerAnimated:(BOOL)anmated completion:(void(^)())completion{
    UIViewController *vcToDismiss=self.topViewController;
    if (!vcToDismiss.isBeingDismissed && !vcToDismiss.isBeingPresented) {
        [vcToDismiss dismissViewControllerAnimated:anmated completion:completion];
    }
}

#pragma mark  - private method

+(UIView *)rootView:(UIViewController *)viewController{
    
    
    return viewController.view;
}

+(UIViewController *)topViewController{
    UIViewController *topViewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    while (YES) {
        if ([topViewController presentedViewController]==nil) {
            break;
        }
        topViewController=[topViewController presentedViewController];
    }
    return topViewController;

}


@end
