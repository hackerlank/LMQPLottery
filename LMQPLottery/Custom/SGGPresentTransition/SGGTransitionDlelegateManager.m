//
//  SGGTransitionDlelegateManager.m
//  JFScale
//
//  Created by iOSDev on 17/6/6.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "SGGTransitionDlelegateManager.h"
#import "SGGNormalDismissTransition.h"
#import "SGGNormalPresentTransition.h"
@interface SGGTransitionDlelegateManager ()

@property(nonatomic ,strong)SGGNormalDismissTransition *dismissTransition;

@property(nonatomic, strong)SGGNormalPresentTransition *presentTransition;


@end


@implementation SGGTransitionDlelegateManager
-(instancetype)initWithView:(UIView *)view{
    self=[super init];
    if (self) {
        
        _presentTransition=[[SGGNormalPresentTransition alloc]init];
        
        _dismissTransition=[[SGGNormalDismissTransition alloc]init];
        
        
    }
    
    return self;

}
#pragma mark  - UIViewControllerTransitioningDelegate
//present动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self.presentTransition;
    
}
//dismiss动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return self.dismissTransition;
}






@end
