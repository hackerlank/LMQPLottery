//
//  LMCircleBannerView.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/6.
//  Copyright © 2017年 林宏敏. All rights reserved.
//

#import "LMCircleBannerView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@interface LMCycleBannerCollectionCell: UICollectionViewCell

@property(nonatomic, strong)id model;
@property(nonatomic, weak)UIImageView *bannerImage;

@end

@implementation LMCycleBannerCollectionCell

-(void)setModel:(id)model{
    _model=model;
    if ([model isKindOfClass:[NSDictionary class]]) {
        [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:model[@"path"]] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    
}


-(UIImageView *)bannerImage{
    if (!_bannerImage) {
        UIImageView *bannerImage=[[UIImageView alloc]init];
        [self.contentView addSubview:bannerImage];
        [bannerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _bannerImage=bannerImage;
    }
    return _bannerImage;
    
}

@end



@interface LMCircleBannerView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger _itemindex;
}
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic, assign)NSUInteger totalItemsCount;

@end
static NSString *const LMCycleBannerCollectionCellId=@"LMCycleBannerCollectionCellId";
@implementation LMCircleBannerView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

-(void)setImageArray:(NSArray *)imageArray{
    _imageArray=imageArray;
    _totalItemsCount=imageArray.count*4;
    [self.collectionView reloadData];
    
}
//获取当前的index
-(NSInteger)getCurrentIndex{
    if (self.collectionView.mas_width==0 ||self.collectionView.mas_height==0) {
        return 0;
    }
    NSInteger index=0;
    index=(self.collectionView.contentOffset.x/[UIScreen mainScreen].bounds.size.width)+0.5;
   return MAX(0, index);
}
#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalItemsCount;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LMCycleBannerCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:LMCycleBannerCollectionCellId forIndexPath:indexPath];
    NSUInteger itemIndex=indexPath.item%self.imageArray.count;
    cell.model=self.imageArray[itemIndex];
    return cell;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _itemindex=[self getCurrentIndex];
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    NSUInteger halfTotalItemsCount=_totalItemsCount*0.5;
    if (_itemindex>=_totalItemsCount-self.imageArray.count) {
        NSUInteger padding=_itemindex%self.imageArray.count;
        CGFloat leftInset=(halfTotalItemsCount +padding-1) *[UIScreen mainScreen].bounds.size.width;
        CGFloat rightInset=(halfTotalItemsCount+padding -1)*kScreenWidth -(padding *2+1)*kScreenWidth;
        
        
        LMLog(@"%ld--padding:%ld,left:%f---right:%f",(long)_itemindex,padding,leftInset,rightInset);
        self.collectionView.contentInset=UIEdgeInsetsMake(0, -leftInset, 0, -rightInset);
        NSUInteger targetIndex=_totalItemsCount*0.5;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x-[UIScreen mainScreen].bounds.size.width, 0)];

    }
    
    
}
#pragma mark -
#pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing=0;
        layout.minimumInteritemSpacing=0;
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.pagingEnabled=YES;
        collectionView.dataSource=self;
        collectionView.delegate=self;
        [self addSubview:collectionView];
        
        [collectionView registerClass:[LMCycleBannerCollectionCell class] forCellWithReuseIdentifier:LMCycleBannerCollectionCellId];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _collectionView=collectionView;
    }
    return _collectionView;
    
}
@end
