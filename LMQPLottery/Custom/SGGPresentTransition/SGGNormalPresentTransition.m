//
//  SGGNormalPresentTransition.m
//  JFScale
//
//  Created by iOSDev on 17/6/6.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "SGGNormalPresentTransition.h"

@implementation SGGNormalPresentTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //toView
    UIViewController *toViewController=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView=toViewController.view;
    [transitionContext.containerView addSubview:toView];
    CGRect toFinalFrame =[transitionContext finalFrameForViewController:toViewController];
    CGRect toInitFrame =CGRectOffset(toFinalFrame, kScreenWidth, 0);
    toView.frame=toInitFrame;
    
    //fromView
    UIViewController *fromViewController= [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView=fromViewController.view;
    CGRect fromInitFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromFinalFrame = CGRectOffset(fromInitFrame, -fromInitFrame.size.width/3, 0);
    
    //animated
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionOverrideInheritedOptions | UIViewAnimationOptionTransitionNone animations:^{
        
        
        fromView.frame=fromFinalFrame;
        toView.frame=toFinalFrame;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        
    }];




}
@end
