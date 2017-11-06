//
//  LMProgressHud.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMProgressHud.h"
#import <UIView+Toast.h>
#import <MBProgressHUD.h>
@interface LMProgressHud ()
{
    BOOL _active;
}

@property(nonatomic, strong)MBProgressHUD *progressHub;
@property(nonatomic, strong)UIImageView *animationView;
@end
@implementation LMProgressHud
+(instancetype)shareInstance{
    
    static LMProgressHud *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    return instance;
}
-(void)show{
    
    [self show:YES];
}
-(void)show:(BOOL)animated{
    
    [self showHudTo:[UIApplication sharedApplication].delegate.window animated:animated];
    
}
-(void)showToast:(NSString *)message{
    if (_active) {
        return;
    }
    _active=YES;
    
    [self performSelector:@selector(changeActive) withObject:nil afterDelay:2];
    [[UIApplication sharedApplication].keyWindow makeToast:message duration:2 position:CSToastPositionCenter];
}
-(void)changeActive{
    _active=NO;
}
-(void)showHudTo:(UIView *)view animated:(BOOL)animated{
    if (self.progressHub) {
        return;
    }
    MBProgressHUD *progressHud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    [self.animationView startAnimating];
    progressHud.mode=MBProgressHUDModeCustomView;
    progressHud.bezelView.style=MBProgressHUDBackgroundStyleSolidColor;
    progressHud.bezelView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.8];
    progressHud.customView=self.animationView;
    progressHud.bezelView.layer.borderColor=LMHexsColor(@"ffdc99").CGColor;
    progressHud.bezelView.layer.borderWidth=1.0;
    self.progressHub=progressHud;
    [self.progressHub showAnimated:animated];
}
-(void)dismiss{
    if (!self.progressHub) {
        return;
    }
    [self.animationView stopAnimating];
    [self.progressHub hideAnimated:YES];
    self.progressHub=nil;
}
-(UIImageView *)animationView{
    if (!_animationView) {
        _animationView=[[UIImageView alloc]init];
        NSMutableArray *images=@[].mutableCopy;
        for (int i=2; i<16; i++) {
            UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [images addObject:image];
        
        }
        [_animationView setAnimationImages:images];
        [_animationView setAnimationDuration:0.8];
    }
    return _animationView;
}

@end
