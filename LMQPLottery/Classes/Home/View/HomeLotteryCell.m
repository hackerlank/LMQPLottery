//
//  HomeLotteryCell.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "HomeLotteryCell.h"
@interface HomeLotteryCell ()

@property(nonatomic, weak)UIVisualEffectView *effectView;
@property(nonatomic, weak)UIImageView *iconImage;
@property(nonatomic, weak)UILabel *lotteryLabel;

@end
@implementation HomeLotteryCell
-(UIVisualEffectView *)effectView{
    if (!_effectView) {
        UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView=[[UIVisualEffectView alloc]initWithEffect:effect];
        effectView.alpha=0.5;
        [self.contentView addSubview:effectView];
        _effectView=effectView;
    }
    return _effectView;
}
-(UIImageView *)iconImage{
    if (!_iconImage) {
        UIImageView *iconImage=[[UIImageView alloc]init];
        [self.contentView addSubview:iconImage];
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.mas_offset(7);
        }];
        _iconImage=iconImage;
    }
    return _iconImage;
    
}
-(UILabel *)lotteryLabel{
    if (!_lotteryLabel) {
        UILabel *lotteryLabel=[[UILabel alloc]init];
        [self.contentView addSubview:lotteryLabel];
        [lotteryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImage);
            make.top.equalTo(self.iconImage.mas_bottom).mas_offset(1);
        }];
        _lotteryLabel=lotteryLabel;
    }
    return _lotteryLabel;
}
@end
