//
//  LMHomeViewController.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/7.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMHomeViewController.h"
#import "LMHomeView.h"
#import "LMHomeApi.h"
@interface LMHomeViewController ()
@property(nonatomic, weak)LMHomeView *homeView;
@end

@implementation LMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHomeData];
}
-(void)loadHomeData{
    [[[LMHomeApi alloc]init] requestHomeApi:^(LMResponse *response) {
        
        self.homeView.data=response.data;
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
-(LMHomeView *)homeView{
    if (!_homeView) {
        LMHomeView *homeView=[[LMHomeView alloc]init];
        
        [self.view addSubview:homeView];
        [homeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _homeView=homeView;
    }
    return _homeView;
}

@end
