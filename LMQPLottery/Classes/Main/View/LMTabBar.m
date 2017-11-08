//
//  LMTabBar.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMTabBar.h"
@interface LMTabBar ()

@property(nonatomic, weak)UIButton *centerButton;

@end
@implementation LMTabBar
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setupTabbarItemFrame];
    [self setupCenterFrame];
//    [self.centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.size.mas_equalTo(self.centerButton.currentImage.size);
//    }];
    
}
-(void)setupTabbarItemFrame{
    NSInteger index=0;
    CGFloat width=kScreenWidth/(self.items.count+1);
    for (UIView *tabbarButton in self.subviews) {
        if ([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            tabbarButton.w=width;
            tabbarButton.x=index*width;
            if (index>=2) {
                tabbarButton.x=width*(index+1);
            }
            index++;
        }
    }
}
-(void)setupCenterFrame{
    self.centerButton.size=self.centerButton.currentImage.size;
    self.centerButton.center=CGPointMake(self.w*0.5, self.h*0.5-15);
}
-(void)setupSubviews{
    UIImageView *bgImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_bg"]];
    [self insertSubview:bgImageView atIndex:0];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
-(UIButton *)centerButton{
    if (!_centerButton) {
        UIButton *centerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [centerButton setImage:[UIImage imageNamed:@"tabbar_00"] forState:UIControlStateNormal];
        [centerButton setImage:[UIImage imageNamed:@"tabbar_00"] forState:UIControlStateHighlighted];
        [centerButton addTarget:self action:@selector(centerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerButton];
        
        _centerButton=centerButton;
    }
    return _centerButton;
}
-(void)centerButtonClicked{
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarCenterButtonClicked)]) {
        [self.tabBarDelegate tabBarCenterButtonClicked];
    }
}
@end
