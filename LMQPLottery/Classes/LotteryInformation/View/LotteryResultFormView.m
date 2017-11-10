//
//  LotteryResultFormView.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/9.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LotteryResultFormView.h"
@interface LotteryResultFormView ()
@property(nonatomic, weak)UIView *backView;
@property(nonatomic, weak)UIView *topView;
@property(nonatomic, weak)UIView *bottomView;

@end
@implementation LotteryResultFormView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
       self.backView.backgroundColor=LMColor_RGBA(0, 0, 0, 0.3);
    }
    return self;
}
-(void)configData:(NSArray *)kjResult lotteryId:(int)lotteryId{

    [self.topView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.bottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (lotteryId) {
        case 1: case 2:
            [self setupPCDD:kjResult];
            break;
        case 3: case 12:
            [self setupXLHC:kjResult];
            
        default:
            break;
    }
    
    
    
}
-(void)setupXLHC:(NSArray *)kjResult
{
    
    NSArray *firstArray=kjResult[0];
    NSArray *lastArray=kjResult[1];
    [firstArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:LMHexsColor(@"FFFFFF") forState:UIControlStateNormal];
        btn.titleLabel.font=font(12);
        btn.layer.borderColor=LMColor_RGBA(255, 255, 255, 0.3).CGColor;
        btn.layer.borderWidth=0.25;
        [self.topView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(idx*(kScreenWidth-48)/3);
            make.width.mas_equalTo((kScreenWidth-48)/3);
            make.bottom.top.mas_offset(0);
        }];
        
    }];
    
    [lastArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:LMHexsColor(@"FFFFFF") forState:UIControlStateNormal];
        btn.titleLabel.font=font(12);
        btn.layer.borderColor=LMColor_RGBA(255, 255, 255, 0.3).CGColor;
        btn.layer.borderWidth=0.25;
        [self.bottomView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(idx*(kScreenWidth-48)/3);
            make.width.mas_equalTo((kScreenWidth-48)/3);
            make.top.bottom.mas_offset(0);
        }];
    }];
    
    
}
//PCDD
-(void)setupPCDD:(NSArray *)kjResult{
    NSArray *firstArray=kjResult[0];
    NSArray *lastArray=kjResult[1];
    [firstArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:LMHexsColor(@"FFFFFF") forState:UIControlStateNormal];
        btn.titleLabel.font=font(12);
        btn.layer.borderColor=LMColor_RGBA(255, 255, 255, 0.3).CGColor;
        btn.layer.borderWidth=0.25;
        [self.topView addSubview:btn];
        float btnSpace=idx==0?0:(kScreenWidth-48)*2/3;
        float btnWidth=idx==0?(kScreenWidth-48)*2/3:(kScreenWidth-48)/3;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(btnSpace);
            make.width.mas_equalTo(btnWidth);
            make.bottom.top.mas_offset(0);
        }];
        
    }];
    
    [lastArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:LMHexsColor(@"FFFFFF") forState:UIControlStateNormal];
        btn.titleLabel.font=font(12);
        btn.layer.borderColor=LMColor_RGBA(255, 255, 255, 0.3).CGColor;
        btn.layer.borderWidth=0.25;
        [self.bottomView addSubview:btn];
        float btnSpace=idx==lastArray.count-1?(kScreenWidth-48)*2/3:(kScreenWidth-48)*idx/6;
        float btnWidth=idx==lastArray.count-1?(kScreenWidth-48)/3:(kScreenWidth-52)/6;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(btnSpace);
            make.width.mas_equalTo(btnWidth);
            make.top.bottom.mas_offset(0);
        }];
    }];
}
-(UIView *)backView{
    if (!_backView) {
        UIView *backView=[[UIView alloc]init];
        [self insertSubview:backView atIndex:0];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        backView.layer.borderColor=LMColor_RGBA(255, 255, 255, 0.3).CGColor;
        backView.layer.borderWidth=0.25;
        
        
        _backView=backView;
    }
    return _backView;
}
-(UIView *)topView{
    if (!_topView) {
        UIView *topView=[[UIView alloc]init];
        [self addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(28);
            make.left.top.right.mas_offset(0);
        }];
        _topView=topView;
    }
    return _topView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        UIView *bottomView=[[UIView alloc]init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(28);
            make.top.equalTo(self.topView.mas_bottom);
            make.left.right.mas_offset(0);
        }];
        _bottomView=bottomView;
    }
    return _bottomView;
}
@end
