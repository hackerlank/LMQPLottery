//
//  LMLotteryHistoryInformationController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/9.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMLotteryHistoryInformationController.h"
#import "LotteryHistoryInfomationTableViewCell.h"
#import "LMLotteryInfoApi.h"
#import "LotteryHistoryInfomationModel.h"
@interface LMLotteryHistoryInformationController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, weak)UIView *naviView;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UIImageView *bgView;
@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, weak)UIButton *backButton;

@property(nonatomic, assign)int page;
@property(nonatomic, strong)NSMutableArray *datas;
@end

static NSString *const LotteryHistoryInfomationTableViewCellId=@"LotteryHistoryInfomationTableViewCellId";
@implementation LMLotteryHistoryInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}
-(void)setupSubviews{
    self.navigationController.navigationBar.hidden=YES;
    self.bgView.image=[UIImage imageNamed:@"home_content_qp_bg"];
    self.titleLabel.text=self.lotteryName;
    [self tableView];
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)refreshingData{
    [self refreshDataWith:YES];
}
-(void)loadingData{
    [self refreshDataWith:NO];
}
-(void)refreshDataWith:(BOOL)refresh{
    if (refresh) {
        self.page=1;
        [self.datas removeAllObjects];
    }
    [[[LMLotteryInfoApi alloc]init] requestLotteryInfoWithLotteryId:self.lotteryId.intValue page:self.page completion:^(LMResponse *response) {
        
        if (refresh) {
            self.datas=[LotteryHistoryInfomationModel mj_objectArrayWithKeyValuesArray:response.data[@"data"]];
            [self.tableView.mj_header endRefreshing];
        }else{
            NSNumber *lastPage=response.data[@"last_page"];
            self.tableView.mj_footer.hidden=self.page>=lastPage.intValue?YES:NO;
            [self.tableView.mj_footer endRefreshing];
            [self.datas addObjectsFromArray:[LotteryHistoryInfomationModel mj_objectArrayWithKeyValuesArray:response.data[@"data"]]];
            self.page++;
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        if (refresh) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
    }];
    
    
    
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LotteryHistoryInfomationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:LotteryHistoryInfomationTableViewCellId forIndexPath:indexPath];
    cell.lotteryId=self.lotteryId.intValue;
    cell.model=self.datas[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark -
#pragma mark -懒加载
-(UIImageView *)bgView{
    if (!_bgView) {
        UIImageView *bgView=[[UIImageView alloc]init];
        [self.view insertSubview:bgView atIndex:0];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(0);
        }];
        _bgView=bgView;
    }
    return _bgView;
}
-(UIView *)naviView{
    if (!_naviView) {
        UIView *naviView=[[UIView alloc]init];
        [self.view addSubview:naviView];
        [naviView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(64);
        }];
        _naviView=naviView;
    }
    return  _naviView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel=[[UILabel alloc]init];
        titleLabel.font=[UIFont boldSystemFontOfSize:16];
        titleLabel.textColor=[UIColor whiteColor];
        [self.naviView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.naviView);
            make.centerY.equalTo(self.backButton);
        }];
        _titleLabel=titleLabel;
    }
    return _titleLabel;
}
-(UIButton *)backButton{
    if (!_backButton) {
        UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"icon_my_back"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"icon_my_back"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.naviView addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(25);
            make.left.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(34, 36));
        }];
        _backButton=backButton;
    }
    return _backButton;
}
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.backgroundColor=[UIColor clearColor];
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableView.delegate=self;
        tableView.dataSource=self;
        [tableView registerClass:[LotteryHistoryInfomationTableViewCell class] forCellReuseIdentifier:LotteryHistoryInfomationTableViewCellId];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.top.equalTo(self.naviView.mas_bottom);
        }];
        
        MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshingData)];
        header.stateLabel.textColor=LMHexsColor(@"FFDC99");
        header.lastUpdatedTimeLabel.textColor=LMHexsColor(@"FFDC99");
        tableView.mj_header=header;
        [tableView.mj_header beginRefreshing];
        
        MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingData)];
        footer.stateLabel.textColor=LMHexsColor(@"FFDC99");
        tableView.mj_footer=footer;
        _tableView=tableView;
    }
    return _tableView;
}
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas=@[].mutableCopy;
    }
    return _datas;
}
@end
