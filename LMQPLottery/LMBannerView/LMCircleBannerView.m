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
    NSString *imageUrl=[model valueForKey:@"imageUrl"];
    [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    
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
    _totalItemsCount=imageArray.count*100;
    
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
#pragma mark -
#pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.dataSource=self;
        collectionView.delegate=self;
        [self addSubview:collectionView];
        _collectionView=collectionView;
    }
    return _collectionView;
    
}
@end
