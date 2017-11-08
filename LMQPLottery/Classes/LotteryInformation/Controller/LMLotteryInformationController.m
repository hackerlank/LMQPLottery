//
//  LMLotteryInformationController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMLotteryInformationController.h"
#import "LotteryInformationCell.h"
@interface LMLotteryInformationController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, weak)UILabel *amountLabel;
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
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(63);
        make.centerX.equalTo(self.view);
    }];
    self.amountLabel.text=@"432433";
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.centerX.equalTo(titleLabel);
    }];
    
    
    
}
#pragma mark -
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LotteryInformationCell *cell=[tableView dequeueReusableCellWithIdentifier:LotteryInformationCellId forIndexPath:indexPath];
    return cell;
}


#pragma mark -
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        
        [tableView registerClass:[LotteryInformationCell class] forCellReuseIdentifier:LotteryInformationCellId];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.amountLabel.mas_bottom);
            make.left.right.mas_offset(0);
            make.bottom.mas_offset(49);
        }];
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
