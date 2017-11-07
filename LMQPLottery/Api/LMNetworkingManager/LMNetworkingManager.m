//
//  LMNetworkingManager.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 我的彩票. All rights reserved.
//

#import "LMNetworkingManager.h"
/** 是否为https */
#define kIsHttpsRequest YES
/** SSL证书名称，仅支持cer格式，需要自己导入 */
#define kCertificationName @"httpsServerAuth"
@implementation LMNetworkingManager
+(instancetype)shareInstance{
    
    static LMNetworkingManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[self alloc]initWithBaseURL:[NSURL URLWithString:SERVER_HOST]];
    });
    return manager;
}
#pragma mark method
//get请求
-(void)getUrl:(NSString *)url
   parameters:(NSDictionary *)parameters
 onCompletion:(void(^)(LMResponse *response))completion
      failure:(void(^)(NSError *error))failure{
    
    [self getUrl:url parameters:parameters onCompletion:completion failure:failure requestAnimation:requestAnimationNone];
}

-(void)getUrl:(NSString *)url
   parameters:(NSDictionary *)parameters
 onCompletion:(void(^)(LMResponse *response))completion
      failure:(void(^)(NSError *error))failure
requestAnimation:(requestAnimation )animation{
    
    [LMNetworkingManager requestWithUrl:url parameters:parameters method:@"GET" onCompletion:completion failure:failure requestAnimation:animation];
    
}

//post请求
-(void)postUrl:(NSString *)url
    parameters:(NSDictionary *)parameters
  onCompletion:(void(^)(LMResponse *response))completion
       failure:(void(^)(NSError *error))failure{
    
    [self postUrl:url parameters:parameters onCompletion:completion failure:failure requestAnimation:requestAnimationNone];
}
-(void)postUrl:(NSString *)url
    parameters:(NSDictionary *)parameters
  onCompletion:(void(^)(LMResponse *response))completion
       failure:(void(^)(NSError *error))failure
requestAnimation:(requestAnimation )anmimation{
    
    [LMNetworkingManager requestWithUrl:url parameters:parameters method:@"POST" onCompletion:completion failure:failure requestAnimation:anmimation];
}

#pragma  mark override
-(instancetype)initWithBaseURL:(NSURL *)url{
    self=[super initWithBaseURL:url];
    if (self==nil) {
        return nil;
    }
    //超时时间
    self.requestSerializer.timeoutInterval=5;
    
    self.requestSerializer.cachePolicy=NSURLRequestUseProtocolCachePolicy;
    
    //请求
    self.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    //设置请求头
    [self.requestSerializer setValue:@"ios" forHTTPHeaderField:@"AppType"];
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"];
    if (!str.length || !str) {
        str=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    [self.requestSerializer setValue:str forHTTPHeaderField:@"DeviceToken"];
    
    NSString *app_Version=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [self.requestSerializer setValue:app_Version forHTTPHeaderField:@"APPVERSION"];
    
    [self.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserAuth"] forHTTPHeaderField:@"UserAuth"];
    
    [self.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"Uid"] forHTTPHeaderField:@"uid"];
    
    //响应
    self.responseSerializer=[AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/plain", nil];
    if (kIsHttpsRequest) {
        //[self setSecurityPolicy:[self customSecurityPolicy]];
    }
    return self;
}
#pragma https请求
-(AFSecurityPolicy *)customSecurityPolicy{
    NSString *cerPath=[[NSBundle mainBundle] pathForResource:kCertificationName ofType:@"cer"];
    NSData *cerData=[NSData dataWithContentsOfFile:cerPath];
    
    AFSecurityPolicy *securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates=YES;
    securityPolicy.validatesDomainName=YES;
    NSSet *cerDataSet=[NSSet setWithArray:@[cerData]];
    securityPolicy.pinnedCertificates=cerDataSet;
    
    return securityPolicy;
}
#pragma mark privateMethod
+(void)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters method:(NSString *)method onCompletion:(void(^)(LMResponse *response))completion failure:(void(^)(NSError *error))failure requestAnimation:(requestAnimation)animation{
    if ([LMNetworkingManager shareInstance].reachabilityManager.networkReachabilityStatus ==AFNetworkReachabilityStatusNotReachable) {//没有网络
        if (animation) {
            LMToast(@"请检查设备是否联网");
        }
        if (failure) {
            NSError *error=[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorNotConnectedToInternet userInfo:nil];
            failure(error);
        }
        return;
    }
    if (animation) {
        [[LMProgressHud shareInstance] show];
    }
    if ([method isEqualToString:@"GET"]) {
        [[LMNetworkingManager shareInstance] GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [[LMNetworkingManager shareInstance] requestSuccessData:responseObject onCompletion:completion failure:failure requestAnimation:animation];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[LMNetworkingManager shareInstance] requestFailureError:error onCompletion:completion failure:failure requestAnimation:animation];
            
        }];
    }else if ([method isEqualToString:@"POST"]){
        [[LMNetworkingManager shareInstance] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [[LMNetworkingManager shareInstance] requestSuccessData:responseObject onCompletion:completion failure:failure requestAnimation:animation];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[LMNetworkingManager shareInstance] requestFailureError:error onCompletion:completion failure:failure requestAnimation:animation];
        }];
        
        
    }else{
        [[LMProgressHud shareInstance] dismiss];
        LMToast(@"请求方法错误");
    }
    
    
}
//请求成功
-(void)requestSuccessData:(id)responseObject onCompletion:(void(^)(LMResponse *response))completion failure:(void(^)(NSError *error))failure requestAnimation:(requestAnimation)aniamtion{
    if (aniamtion) {
        [[LMProgressHud shareInstance] dismiss];
    }
    LMResponse *response=[LMResponse mj_objectWithKeyValues:responseObject];
    if ([response isSuccess]) {
        if (completion) {
            completion(response);
        }
    }else if ([response isNeedLogin]){//需要登录
        
        
        if (failure) {
            NSError *error=[NSError errorWithDomain:NSURLErrorDomain code:response.code.intValue userInfo:@{@"data":response.message}];
            
            failure(error);
        }
    }else if ([response isNeedRecharge]){
        completion(response);
    }else{
        if ([response isFail]) {//请求失败
            LMToast(response.message);
        }else if ([response isRequestOften]){
            
            LMToast(@"操作频繁，请稍后重试");
        }else{
            LMToast(response.message);
        }
        if (failure) {
            response.message=response.message.length?response.message:@"";
            
            NSError *error=[NSError errorWithDomain:NSURLErrorDomain code:response.code.intValue userInfo:@{@"data":response.message}];
            
            failure(error);
        }
    }
}
//请求失败
-(void)requestFailureError:(NSError *)error onCompletion:(void(^)(LMResponse *response))completion failure:(void(^)(NSError *error))failure requestAnimation:(requestAnimation)animation{
    if (animation) {
        [[LMProgressHud shareInstance] dismiss];
    }
    if (error.code>0) {
        LMToast(@"服务器错误，请重试");
    }else{
        LMToast(@"连接服务器失败,请检查设备是否联网");
    }
    if (failure) {
        failure(error);
    }
}
@end
