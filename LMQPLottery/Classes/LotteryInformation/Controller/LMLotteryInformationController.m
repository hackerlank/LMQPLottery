//
//  LMLotteryInformationController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMLotteryInformationController.h"

@interface LMLotteryInformationController ()
@property(nonatomic, weak)UITableView *tableView;
@end

@implementation LMLotteryInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    UIImageView *bgImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    [self.view insertSubview:bgImageView atIndex:0];
    
    
}
#pragma mark -
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
}

@end
