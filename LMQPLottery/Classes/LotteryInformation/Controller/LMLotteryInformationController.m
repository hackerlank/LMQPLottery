//
//  LMLotteryInformationController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMLotteryInformationController.h"
#import "LotteryInformationCell.h"
#import "LMLotteryInfoApi.h"
#import "LotteryInfoModel.h"
#import "LMLotteryHistoryInformationController.h"
@interface LMLotteryInformationController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, weak)UILabel *amountLabel;
@property(nonatomic, strong)NSArray *datas;
@end
static NSString *const LotteryInformationCellId=@"LotteryInformationCellId";
@implementation LMLotteryInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
-(void)initUI{
    UIImageView *bgImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_content_qp_bg"]];
    [self.view insertSubview:bgImageView atIndex:0];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.text=@"棋牌彩票已为用户赢得";
    titleLabel.textColor=LMHexsColor(@"FFDC99");
    titleLabel.font=[UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    self.tableView.backgroundColor=[UIColor clearColor];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(63);
        make.centerX.equalTo(self.view);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.centerX.equalTo(titleLabel);
    }];
   
}
-(void)refreshData{
    [[[LMLotteryInfoApi alloc]init] requestLotteryInfo:^(LMResponse *response) {
        [self.tableView.mj_header endRefreshing];
        if (response.isSuccess) {
            NSString *money=response.data[@"money"];
            self.amountLabel.text=money;
            self.datas=[LotteryInfoModel mj_objectArrayWithKeyValuesArray:response.data[@"lottery_list"]];
            [self.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}
#pragma mark -
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LotteryInformationCell *cell=[tableView dequeueReusableCellWithIdentifier:LotteryInformationCellId forIndexPath:indexPath];
    cell.model=self.datas[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LotteryInfoModel *model=self.datas[indexPath.row];
    LMLotteryHistoryInformationController *historyController=[[LMLotteryHistoryInformationController alloc]init];
    historyController.lotteryName=model.name;
    historyController.lotteryId=model.lotteryId;
    [self .navigationController pushViewController:historyController animated:YES];

}
#pragma mark -
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableView.delegate=self;
        tableView.dataSource=self;
        
        [tableView registerClass:[LotteryInformationCell class] forCellReuseIdentifier:LotteryInformationCellId];
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.amountLabel.mas_bottom).mas_offset(20);
            make.left.right.mas_offset(0);
            make.bottom.mas_offset(-49);
        }];
        
        MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        header.stateLabel.textColor=LMHexsColor(@"FFDC99");
        header.lastUpdatedTimeLabel.textColor=LMHexsColor(@"FFDC99");
        tableView.mj_header=header;
        [tableView.mj_header beginRefreshing];
        _tableView=tableView;
    }
    return _tableView;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        UILabel *amountLabel=[[UILabel alloc]init];
        amountLabel.textColor=LMHexsColor(@"FFDC99");
        amountLabel.textAlignment=NSTextAlignmentCenter;
        amountLabel.font=[UIFont fontWithName:@"LcdD" size:40];
        [self.view addSubview:amountLabel];
        _amountLabel=amountLabel;
    }
    return _amountLabel;
    
}
@end
