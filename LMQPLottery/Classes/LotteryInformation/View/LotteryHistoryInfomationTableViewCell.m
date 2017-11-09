//
//  LotteryHistoryInfomationTableViewCell.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/9.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LotteryHistoryInfomationTableViewCell.h"
#import "LotteryResultFormView.h"
@interface LotteryHistoryInfomationTableViewCell ()
@property(nonatomic, weak)UILabel *lotteryLabel;
@property(nonatomic, weak)UILabel *dateLabel;
@property(nonatomic, weak)UIView *shadowView;

@end
@implementation LotteryHistoryInfomationTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
    
}
-(void)setupSubviews{
    self.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor clearColor];
    
    
}
-(void)setModel:(LotteryHistoryInfomationModel *)model{
    _model=model;
    self.lotteryLabel.text=[NSString stringWithFormat:@"第%@期",model.number];
    self.dateLabel.text=model.create_time;
    [self setupResultViewWith:model];
}
-(void)setupResultViewWith:(LotteryHistoryInfomationModel *)model{
    for (UIView *view in self.contentView.subviews) {
        if (!(view.tag==1001||view.tag==1002||view.tag==1003)) {
            [view removeFromSuperview];
        }
    }
    switch (self.lotteryId) {
        case 1: case 2:
            {
                NSMutableArray *datas=[NSMutableArray arrayWithArray:model.data];
                [datas insertObject:@"+" atIndex:1];
                [datas insertObject:@"+" atIndex:3];
                [datas insertObject:@"=" atIndex:5];
                [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setTitle:[NSString stringWithFormat:@"%@",obj] forState:UIControlStateNormal];
                    btn.titleLabel.font=font(14);
                    [self.contentView addSubview:btn];
                    if (!(idx==1||idx==3||idx==5||idx==datas.count-1)) {
                        btn.layer.cornerRadius=15;
                        [btn setTitleColor:LMHexsColor(@"63000C") forState:UIControlStateNormal];
                        btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage gradientColorImageFromColors:@[LMHexsColor(@"F0DDAE"),LMHexsColor(@"DCB976")] gradientType:GradientTypeUpleftToLowright imgSize:CGSizeMake(30, 30)]];
                        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.shadowView).mas_offset(15+30*idx);
                            make.top.equalTo(self.lotteryLabel.mas_bottom).mas_offset(4);
                            make.height.width.mas_equalTo(30);
                           
                        }];
                    }else if (idx==datas.count-1){
                        NSString *imgStr=model.end_color.length?[NSString stringWithFormat:@"kj_ball_%@",model.end_color]:@"kj_ball_red";
                        [btn setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
                        [btn setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateHighlighted];
                        
                        [btn.imageView setContentMode:UIViewContentModeScaleToFill];
                        [btn setTitleColor:LMHexsColor(@"FFFFFF") forState:UIControlStateNormal];
                        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.shadowView).mas_offset(15+30*idx);
                            make.top.equalTo(self.lotteryLabel.mas_bottom).mas_offset(1);
                            make.size.mas_equalTo(CGSizeMake(36, 36));
                            
                            
                        }];
                    }
                    else{
                        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.shadowView).mas_offset(15+30*idx);
                            make.top.equalTo(self.lotteryLabel.mas_bottom).mas_offset(4);
                            make.height.width.mas_equalTo(30);
                        }];
                        [btn setTitleColor:LMHexsColor(@"FFDC99") forState:UIControlStateNormal];
                    }
                }];
                //表格视图
                LotteryResultFormView *formView=[[LotteryResultFormView alloc]init];
                [self.contentView addSubview:formView];
                [formView configData:model.kj_result lotteryId:self.lotteryId];
                [formView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.lotteryLabel.mas_bottom).mas_offset(50);
                    make.left.equalTo(self.lotteryLabel);
                    make.right.equalTo(self.dateLabel);
                    make.height.mas_equalTo(56 );
                    make.bottom.mas_offset(-20).priorityMedium();
                }];
            }
            break;
            
        default:
        {
            UIView *blankView=[[UIView alloc]init];
            [self.contentView addSubview:blankView];
            [blankView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lotteryLabel.mas_bottom);
                make.left.right.mas_offset(0);
                make.height.mas_equalTo(30);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
        }
            break;
    }
}
-(UIView *)shadowView{
    if (!_shadowView) {
        UIView *shadowView=[[UIView alloc]init];
        shadowView.backgroundColor=LMColor_RGBA(0, 0, 0, 0.3);
        shadowView.tag=1003;
        [self.contentView insertSubview:shadowView atIndex:0];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 12, 10, 12));
        }];
        _shadowView=shadowView;
    }
    return _shadowView;
}
-(UILabel *)lotteryLabel{
    if (!_lotteryLabel) {
        UILabel *lotteryLabel=[[UILabel alloc]init];
        lotteryLabel.tag=1001;
        lotteryLabel.textColor=LMHexsColor(@"FFDC99");
        lotteryLabel.font=[UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:lotteryLabel];
        [lotteryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shadowView).mas_offset(14);
            make.left.equalTo(self.shadowView).mas_offset(14);
        }];
        _lotteryLabel=lotteryLabel;
    }
    return _lotteryLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *dateLabel=[[UILabel alloc]init];
        dateLabel.tag=1002;
        dateLabel.textColor=LMHexsColor(@"FFDC99");
        dateLabel.font=font(10);
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shadowView).mas_offset(-10);
            make.centerY.equalTo(self.lotteryLabel);
            
        }];
        _dateLabel=dateLabel;
    }
    return _dateLabel;
}
@end
