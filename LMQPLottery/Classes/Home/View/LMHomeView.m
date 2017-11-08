//
//  LMHomeView.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMHomeView.h"
#import "HomeLotteryModel.h"
#import "LMCircleBannerView.h"
#import "LoopTextScrollView.h"
#import "HomeLotteryCell.h"
@interface LMHomeView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property(nonatomic, weak)LMCircleBannerView *bannerView;

@property(nonatomic, weak)UIView *noticeView;
@property(nonatomic, weak)LoopTextScrollView *loopView;

@property(nonatomic, weak)UIView *toolView;
@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, weak)UIButton *cpButton;
@property(nonatomic, weak)UIButton *qpButton;

@property(nonatomic, copy)NSArray *cpDatas;
@property(nonatomic, copy)NSArray *qpDatas;

@property(nonatomic, weak)UICollectionView *cpCollectionView;
@property(nonatomic, weak)UICollectionView *qpCollectionView;
@end
static NSString *const HomeLotteryCellId=@"HomeLotteryCellId";
@implementation LMHomeView

-(void)setData:(NSDictionary *)data{
    if (data) {

        [self.bannerView setImageArray:data[@"banner_list"]];
        [self.loopView animationWithTextArray:data[@"winningList"]];
        self.cpDatas=[[HomeLotteryModel mj_objectArrayWithKeyValuesArray:data[@"lotteryList"][@"unofficial"][@"lottery_play"]] copy];
        self.qpDatas=[[HomeLotteryModel mj_objectArrayWithKeyValuesArray:data[@"lotteryList"][@"unofficial"][@"chess_play"]] copy];
        
        
        [self.cpCollectionView reloadData];
        [self.qpCollectionView reloadData];
        [self scrollView];
        [self toolView];
        [self qpButton];
        [self cpButton];
        
    }else{//请求失败处理
        
    }
    
}
-(void)changePlayed:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    if (sender.tag==10001) {//qp
        self.qpButton.selected=YES;
        self.cpButton.selected=NO;
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        
    }else{
        self.qpButton.selected=NO;
        self.cpButton.selected=YES;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    
    
}
#pragma mark -
#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag==2000) {
        return self.cpDatas.count;
    }
    return _qpDatas.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeLotteryCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:HomeLotteryCellId forIndexPath:indexPath];
    if (collectionView.tag==2000) {
        cell.model=self.cpDatas[indexPath.row];
    }else{
        cell.model=self.qpDatas[indexPath.row];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeLotteryModel *model;
    if (collectionView.tag==2000) {
        model=self.cpDatas[indexPath.row];
    }else{
        model=self.qpDatas[indexPath.row];
    }
    if (self.homeLotteryClick) {
        self.homeLotteryClick(model.lotteryId);
    }  
}
#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  return CGSizeMake((kScreenWidth-38)/3, (kScreenWidth-38)/3);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   return  UIEdgeInsetsMake(34+18, 18, 18, 18);
    
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
    
}
#pragma mark -
-(LMCircleBannerView *)bannerView{
    if (!_bannerView) {
        LMCircleBannerView *bannerView=[[LMCircleBannerView alloc]init];
        
        [self addSubview:bannerView];
        [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_offset(0);
            make.height.mas_equalTo(200);
        }];
        _bannerView=bannerView;
    }
    return _bannerView;
}
-(UIView *)noticeView{
    if (!_noticeView) {
        UIView *noticeView=[[UIView alloc]init];
        UIImageView *bgImage=[[UIImageView alloc]init];
        bgImage.image=[UIImage gradientColorImageFromColors:@[LMHexsColor(@"172238"),LMHexsColor(@"20142D")] gradientType:gradientTypeTopToBottom imgSize:CGSizeMake(1, 34)];
        [noticeView insertSubview:bgImage atIndex:0];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [self addSubview:noticeView];
      
        [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bannerView.mas_bottom).mas_offset(0);
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(34);
        }];
        _noticeView=noticeView;
    }
    return _noticeView;
}
-(LoopTextScrollView *)loopView{
    if (!_loopView) {
        LoopTextScrollView *loopView=[[LoopTextScrollView alloc]initWithFrame:CGRectMake(10,0, kScreenWidth-60, 34) maxCount:1];
        
        [self.noticeView addSubview:loopView];
        _loopView=loopView;
    }
    return _loopView;
}
-(UIView *)toolView{
    if (!_toolView) {
        UIView *toolView=[[UIView alloc]init];
        UIImageView *leftImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tool_left_right"]];
        UIImageView *rightImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tool_left_right"]];
        [toolView addSubview:leftImage];
        [toolView addSubview:rightImage];
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(0);
            make.width.mas_equalTo(kScreenWidth*0.5-118);
            make.height.mas_equalTo(33);
        }];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_offset(0);
            make.width.height.equalTo(leftImage);
        }];
        
        [self insertSubview:toolView aboveSubview:self.scrollView];
        [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(33);
            make.top.equalTo(self.noticeView.mas_bottom);
            
            
        }];
        _toolView=toolView;
    }
    return _toolView;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        scrollView.pagingEnabled=YES;
        scrollView.bounces=NO;
        scrollView.tag=12345;
        scrollView.delegate=self;
        UIView *contentView=[[UIView alloc]init];
        [scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth*2);
            make.height.mas_equalTo(kScreenHeight-234-49);
        }];
        UIImageView *leftImageView=[[UIImageView alloc]init];
        leftImageView.image=[UIImage imageNamed:@"home_content_cp_bg"];
        UIImageView *rightImageView=[[UIImageView alloc]init];
        rightImageView.image=[UIImage imageNamed:@"home_content_qp"];
        [contentView addSubview:leftImageView];
        [contentView addSubview:rightImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_offset(0);
            make.width.mas_equalTo(kScreenWidth);
        }];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftImageView.mas_right).mas_offset(0);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(kScreenWidth);
        }];
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.equalTo(self.noticeView.mas_bottom).mas_offset(0);
            make.bottom.mas_offset(-49);
        }];
        _scrollView=scrollView;
    }
    return _scrollView;
}

-(UIButton *)qpButton{
    if (!_qpButton) {
        UIButton *qpButton=[[UIButton alloc]init];
        qpButton.adjustsImageWhenHighlighted=NO;
        [qpButton setBackgroundImage:[UIImage imageNamed:@"home_tool_qp_select"] forState:UIControlStateNormal];
        [qpButton setBackgroundImage:[UIImage imageNamed:@"home_tool_qp_selected"] forState:UIControlStateSelected];
        qpButton.tag=10001;
        [qpButton addTarget:self action:@selector(changePlayed:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolView addSubview:qpButton];
        [qpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.equalTo(self.cpButton.mas_right).mas_offset(0);
            make.width.mas_equalTo(118);
            make.height.mas_equalTo(33);
        }];
        _qpButton=qpButton;
    }
    return _qpButton;
}
-(UIButton *)cpButton{
    if (!_cpButton) {
        UIButton *cpButton=[[UIButton alloc]init];
        cpButton.adjustsImageWhenHighlighted=NO;
        [cpButton setBackgroundImage:[UIImage imageNamed:@"home_tool_cp_select"] forState:UIControlStateNormal];
        [cpButton setBackgroundImage:[UIImage imageNamed:@"home_tool_cp_selected"] forState:UIControlStateSelected];
        [cpButton addTarget:self action:@selector(changePlayed:) forControlEvents:UIControlEventTouchUpInside];
        cpButton.selected=YES;
        [self.toolView addSubview:cpButton];
        [cpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(-kScreenWidth*0.5);
            make.width.mas_equalTo(118);
            make.height.mas_equalTo(33);
            
        }];
        _cpButton=cpButton;
    }
    return _cpButton;
}
-(UICollectionView *)cpCollectionView{
    if (!_cpCollectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        UICollectionView *cpCollectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        cpCollectionView.delegate=self;
        cpCollectionView.dataSource=self;
        cpCollectionView.tag=2000;
        [cpCollectionView registerClass:[HomeLotteryCell class] forCellWithReuseIdentifier:HomeLotteryCellId];
        cpCollectionView.backgroundColor=[UIColor clearColor];
        [self.scrollView addSubview:cpCollectionView];
        [cpCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_offset(0);
            make.width.mas_equalTo(kScreenWidth);
        }];
        _cpCollectionView=cpCollectionView;
        
    }
    return _cpCollectionView;
}
-(UICollectionView *)qpCollectionView{
    if (!_qpCollectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        UICollectionView *qpcollectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        qpcollectionView.delegate=self;
        qpcollectionView.dataSource=self;
        [qpcollectionView registerClass:[HomeLotteryCell class] forCellWithReuseIdentifier:HomeLotteryCellId];
        qpcollectionView.backgroundColor=[UIColor clearColor];
        [self.scrollView addSubview:qpcollectionView];
        
        [qpcollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cpCollectionView.mas_right).mas_offset(0);
            make.bottom.right.top.mas_offset(0);
        }];
        _qpCollectionView=qpcollectionView;
    }
    return _qpCollectionView;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag==12345) {
        if (scrollView.contentOffset.x<=0) {
            [self changePlayed:self.cpButton];
        }else{
            [self changePlayed:self.qpButton];
        }
    }
}
@end
