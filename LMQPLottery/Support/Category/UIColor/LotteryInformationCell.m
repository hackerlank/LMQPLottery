//
//  LotteryInformationCell.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LotteryInformationCell.h"
@interface LotteryInformationCell ()
@property(nonatomic, weak)UIView *shadowView;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UILabel *timeLabel;
@end
@implementation LotteryInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor clearColor];
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
    
}
-(void)setModel:(LotteryInfoModel *)model{
    _model=model;
    self.titleLabel.text=model.name;
    [self setupLabel:self.timeLabel labelText:[NSString stringWithFormat:@"第%@期",model.number]];
    [self setupResultViewWith:model];
   
    
}
-(void)dealloc{
    
    
}
-(void)setupResultViewWith:(LotteryInfoModel *)model{
    for (UIView *view in self.contentView.subviews) {
        if (!(view.tag==3001||view.tag==3002||view.tag==3003)) {
            [view removeFromSuperview];
        }
    }
    switch (model.lotteryId.intValue) {
        case 1: case 2: //1.PC蛋蛋  2.加拿大28
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
                        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                        make.height.width.mas_equalTo(30);
                        make.bottom.mas_offset(-20).priorityMedium();
                    }];
                }else if (idx==datas.count-1){
                    NSString *imgStr=model.end_color.length?[NSString stringWithFormat:@"kj_ball_%@",model.end_color]:@"kj_ball_red";
                    [btn setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateHighlighted];
                    
                    [btn.imageView setContentMode:UIViewContentModeScaleToFill];
                    [btn setTitleColor:LMHexsColor(@"FFFFFF") forState:UIControlStateNormal];
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.shadowView).mas_offset(15+30*idx);
                        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(1);
                        make.size.mas_equalTo(CGSizeMake(36, 36));
                     
                        
                    }];
                }
                else{
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.shadowView).mas_offset(15+30*idx);
                        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                        make.height.width.mas_equalTo(30);
                    }];
                    [btn setTitleColor:LMHexsColor(@"FFDC99") forState:UIControlStateNormal];
                }

                
                
            }];
        }
            
            
            
            break;
         case 3: case 12:
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(10);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 4://江苏快3
        {
            [model.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImageView *resultImage=[[UIImageView alloc]init];
                resultImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"touzi_0%@",obj]];
                [self.contentView addSubview:resultImage];
                [resultImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.shadowView).mas_offset(15+25*idx);
                    make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                    make.height.width.mas_equalTo(20);
                    make.bottom.mas_offset(-20).priorityMedium();
                }];
            }];
            
        }
            
            
            break;
        case 5://PK10
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 6:
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 13:
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 14: //济州岛赛马
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 15: case 16: case 18: //马尼拉梭哈 PK牛牛-18
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 17:
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 19://华夏牌九
        {
            NSArray *datas=model.data;
            NSArray *subTitle=@[@"庄家",@"初门",@"天门",@"末门"];
            [datas enumerateObjectsUsingBlock:^(NSString *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"pai9_%02ld",obj.integerValue]]];
                [self.contentView addSubview:imageView];
                float lineSpace=((int)(idx/2))*(16+6+16+18)+(idx%2)*(16+6);
                
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(30+lineSpace);
                    make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
                    make.size.mas_equalTo(CGSizeMake(16, 42));
                }];
                if (idx%2==0) {
                    UILabel *subLabel=[[UILabel alloc]init];
                    subLabel.text=subTitle[(int)(idx/2)];
                    subLabel.font=font(14);
                    subLabel.textColor=(int)(idx/2)==0?LMHexsColor(@"FFDC99"):LMHexsColor(@"FFFFFF");
                    subLabel.textAlignment=NSTextAlignmentCenter;
                    [self.contentView addSubview:subLabel];
                    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(imageView);
                        make.top.equalTo(imageView.mas_bottom).mas_offset(5);
                        make.width.mas_equalTo(32+6);
                        make.height.mas_equalTo(20);
                        make.bottom.mas_offset(-20).priorityMedium();
                    }];
                }
            }];
            
        }
            break;
        case 20://皇家二八杠
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 21:
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        case 22: case 23: case 24:
        {
            UIView *view=[[UIView alloc]init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shadowView).mas_offset(15+25*3);
                make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(4);
                make.height.width.mas_equalTo(50);
                make.bottom.mas_offset(-20).priorityMedium();
            }];
            
        }
            break;
        default:
        
           
            
            break;
    }
    
    
}
-(void)setupLabel:(UILabel *)label labelText:(NSString *)text{
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",text]];
    [attrString addAttributes:@{NSForegroundColorAttributeName:LMHexsColor(@"FFDC99"),
                                NSFontAttributeName:font(10),
                                NSBaselineOffsetAttributeName:@1.5}
                        range:NSMakeRange(0, text.length)];
    NSTextAttachment *attach=[[NSTextAttachment alloc]init];
    attach.image=[UIImage imageNamed:@"golden_arrow"];
    attach.bounds=CGRectMake(0, 0, 5, 9);
    NSAttributedString *imageString=[NSAttributedString attributedStringWithAttachment:attach];
    [attrString appendAttributedString:imageString];
    label.attributedText=attrString;
}
-(UIView *)shadowView{
    if (!_shadowView) {
        UIView *shadowView=[[UIView alloc]init];
        shadowView.tag=3001;
        shadowView.backgroundColor=LMColor_RGBA(0, 0, 0, 0.3);
        [self.contentView insertSubview:shadowView atIndex:0];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 12, 10, 12));
        }];
        _shadowView=shadowView;
    }
    return _shadowView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel=[[UILabel alloc]init];
        titleLabel.tag=3002;
        [self.contentView addSubview:titleLabel];
        titleLabel.font=[UIFont boldSystemFontOfSize:14];
        titleLabel.textColor=LMHexsColor(@"FFDC99");
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.shadowView).mas_offset(14);
        }];
        _titleLabel=titleLabel;
    }
    return _titleLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *timeLabel=[[UILabel alloc]init];
        timeLabel.tag=3003;
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.shadowView).mas_offset(-12);
        }];
        _timeLabel=timeLabel;
    }
    return _timeLabel;
}

@end
