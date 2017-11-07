//
//  LMHomeView.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMHomeView.h"
#import "LMCircleBannerView.h"
@interface LMHomeView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak)LMCircleBannerView *bannerView;
@property(nonatomic, weak)UIView *noticeView;
@property(nonatomic, weak)UIView *toolView;
@property(nonatomic, weak)UIScrollView *scrollView;

@property(nonatomic, weak)UICollectionView *cpCollectionView;
@property(nonatomic, weak)UICollectionView *qpCollectionView;
@end

@implementation LMHomeView

-(void)setData:(NSDictionary *)data{
    if (data) {

        [self.bannerView setImageArray:data[@"banner_list"]];
        
    }else{//请求失败处理
        
    }
    
}
#pragma mark -
#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}
#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  return CGSizeMake(100, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
    
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
        [self addSubview:noticeView];
        _noticeView=noticeView;
    }
    return _noticeView;
}
-(UIView *)toolView{
    if (!_toolView) {
        UIView *toolView=[[UIView alloc]init];
        [self.scrollView addSubview:toolView];
        [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(33);
        }];
        _toolView=toolView;
    }
    return _toolView;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        UIImageView *leftImageView=[[UIImageView alloc]init];
        UIImageView *rightImageView=[[UIImageView alloc]init];
        [scrollView addSubview:leftImageView];
        [scrollView addSubview:rightImageView];
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
            make.bottom.mas_offset(-64);
        }];
        _scrollView=scrollView;
    }
    return _scrollView;
}
-(UICollectionView *)cpCollectionView{
    if (!_cpCollectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        UICollectionView *cpCollectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        cpCollectionView.delegate=self;
        cpCollectionView.dataSource=self;
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
        [self.scrollView addSubview:qpcollectionView];
        [qpcollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cpCollectionView.mas_right).mas_offset(0);
            make.bottom.right.top.mas_offset(0);
        }];
        _qpCollectionView=qpcollectionView;
    }
    return _qpCollectionView;
}
@end
