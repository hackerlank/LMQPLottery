//
//  SGGNormalDismissTransition.m
//  JFScale
//
//  Created by iOSDev on 17/6/6.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "SGGNormalDismissTransition.h"

@implementation SGGNormalDismissTransition
#pragma mark  - UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //toview
    UIViewController *toViewController=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView=toViewController.view;
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView sendSubviewToBack:toView];
    CGRect toFinalFrame=[transitionContext finalFrameForViewController:toViewController];
    CGRect toInitFrame =CGRectOffset(toFinalFrame, -toFinalFrame.size.width/3, 0);
    toView.frame=toInitFrame;
    
    
    //fromview
    UIViewController *fromViewController =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView=fromViewController.view;
    CGRect fromInitFrame =[transitionContext initialFrameForViewController:fromViewController];
    CGRect fromFinalFrame =CGRectOffset(fromInitFrame, kScreenWidth, 0);
    
    
    //animted
    void(^anmationBlock)()=^{
        fromView.frame=fromFinalFrame;
       toView.frame=toFinalFrame;

    };
    void(^animationCompleteBlock)(BOOL finished)=^(BOOL finished){
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    
    };
    
    
    UIViewAnimationOptions opts=transitionContext.isInteractive? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseOut;
    //无手势的情况下
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionOverrideInheritedOptions | opts |UIViewAnimationOptionTransitionNone animations:anmationBlock completion:animationCompleteBlock];
 
}

@end
