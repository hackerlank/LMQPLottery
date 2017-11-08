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
-(void)setModel:(HomeLotteryModel *)model{
    _model=model;
    self.effectView.alpha=0.5;
    self.iconImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"lottery_%02d",model.lotteryId]];
    self.lotteryLabel.text=model.name;
    
}
-(UIVisualEffectView *)effectView{
    if (!_effectView) {
        UIBlurEffect *effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView=[[UIVisualEffectView alloc]initWithEffect:effect];
        
        [self.contentView insertSubview:effectView atIndex:0];
        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
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
            make.width.height.mas_equalTo(80);
        }];
        _iconImage=iconImage;
    }
    return _iconImage;
    
}
-(UILabel *)lotteryLabel{
    if (!_lotteryLabel) {
        UILabel *lotteryLabel=[[UILabel alloc]init];
        lotteryLabel.textColor=LMHexsColor(@"FFDC99");
        lotteryLabel.font=font(12);
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
