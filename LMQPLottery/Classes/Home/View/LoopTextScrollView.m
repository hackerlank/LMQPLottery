//
//  LoopTextScrollView.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/8.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LoopTextScrollView.h"
static float item_height=34.0;
@interface LoopTextScrollView ()
{
    NSInteger flagIndex;
    
}

@property(nonatomic, assign)int maxCount;
@property(nonatomic, copy)NSArray *contentsArray;
@property(nonatomic, strong)NSTimer *timer;

@end

@implementation LoopTextScrollView

-(instancetype)initWithFrame:(CGRect)frame maxCount:(int)maxCount{
    self=[super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, maxCount*item_height)];
    if (self) {
        self.scrollEnabled=NO;
        self.contentSize=CGSizeMake(frame.size.width, item_height*(maxCount+1));
        for (int i=0; i<maxCount+1; i++) {
            [self addNoticeLabelWithTag:i];
        }
    }
    return self;
}
-(void)animationWithTextArray:(NSArray *)textArray{
    self.contentsArray=textArray;
    [self startAnimation];
    
}
-(void)startAnimation{
    
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(changeAnimation) userInfo:nil repeats:YES];
    }
}
-(void)stopAnimation{
    if (self.timer) {
        [self.timer invalidate];
        self.timer=nil;
    }
}
-(void)changeAnimation{
    if (!self.contentsArray.count) {
        return;
    }
    [self setContentOffset:CGPointMake(0, item_height) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i=0; i<self.maxCount+1; i++) {
            [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[UILabel class]]) {
                    UILabel *label=(UILabel *)obj;
                    NSDictionary *dic=self.contentsArray[(flagIndex+i)%self.contentsArray.count];
                    label.text=[self changeLabelWithDictionary:dic];
                    // * stop=YES;
//                    if (label.tag==1000+i) {
//
//                    }
                    
                }
                
            }];
        }
        flagIndex++;
        flagIndex %=self.contentsArray.count;
        [self setContentOffset:CGPointMake(0, 0) animated:NO];
    });
    
    
}
-(void)addNoticeLabelWithTag:(int)tag{
    
    UILabel *label=[[UILabel alloc]init];
    
    label.textColor=LMHexsColor(@"FFDC99");
    label.font=font(12);
    label.tag=1000+tag;
    label.frame=CGRectMake(0, tag*item_height, self.frame.size.width, item_height);
    [self addSubview:label];

}
-(NSString *)changeLabelWithDictionary:(NSDictionary *)dic{
    NSString *amount=dic[@"amount"];
    NSString *lotteryName=dic[@"lottery_name"];
    NSString *userName=dic[@"username"];
    return [NSString stringWithFormat:@"恭喜: %@【%@】中奖%@元",userName,lotteryName,amount];
}
@end
