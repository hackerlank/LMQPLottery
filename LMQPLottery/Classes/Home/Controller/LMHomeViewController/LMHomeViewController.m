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
#import "LMLotteryHallApi.h"
#import "LMXLXCLotteryController.h"
@interface LMHomeViewController ()
@property(nonatomic, weak)LMHomeView *homeView;
@end

@implementation LMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self homeView];
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
        @weakify(self);
        homeView.homeLotteryClick = ^(int lottery) {
            @strongify(self);
            [self openLotteryHall:lottery];
            
        };
        [self.view addSubview:homeView];
        [homeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _homeView=homeView;
    }
    return _homeView;
}
-(void)openLotteryHall:(int)lotteryId{
    
    [[[LMLotteryHallApi alloc]init] requestLotteryHallDetailWith:lotteryId completion:^(LMResponse *response) {
        NSNumber *status=response.data[@"status"];
        if (!status.intValue) {
            //展示暂停销售
            return ;
        }
        NSNumber *lotteryId=response.data[@"lottery_id"];
        
      LMPlayBaseController *vc=[self getControllerWithLotteryId:lotteryId.intValue];
        vc.data=response.data;
        [self .navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
-(LMPlayBaseController *)getControllerWithLotteryId:(int)lotteryId{
    LMPlayBaseController *vc;
    switch (lotteryId) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3://新六合彩
            vc=[[LMXLXCLotteryController alloc]init];
            
            break;
        case 4://江苏快三
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        case 8:
            
            break;
        case 9:
            
            break;
        case 10:
            
            break;
        case 11:
            
            break;
        case 12:
            
            break;
        case 13://俄罗斯轮盘
            
            break;
        case 14:
            
            break;
        case 15:
            
            break;
        case 16://云顶扎金花
            
            break;
        case 17:
            
            break;
        case 18:
            
            break;
        case 19:
            
            break;
        case 20:
            
            break;
        case 21:
            
            break;
        case 22:
            
            break;
        case 23:
            
            break;
        case 24:
            
            break;
            
        default:
            vc=nil;
            break;
    }
    if (!vc) {
        LMToast(@"敬请期待");
    }
    
    return vc;
}
@end
