//
//  LMBaseApi.m
//  LMQPLottery
//
//  Created by 林宏敏 on 2017/11/5.
//  Copyright © 2017年 林宏敏. All rights reserved.
//

#import "LMBaseApi.h"
#import <CommonCrypto/CommonDigest.h>
@implementation LMBaseApi
-(NSDictionary *)getApp_sign:(NSDictionary *)dic{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionaryWithDictionary:dic];
    
    [parameters setValue:@((int)[[NSDate date] timeIntervalSince1970]) forKey:@"_timestamp"];
    NSArray *keys=[[parameters allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *mstr=[[NSMutableString alloc]init];
    for (int i=0; i<keys.count; i++) {
        NSString *key=keys[i];
        if ([key isEqualToString:@"item"]) {
            NSMutableString *itemString=[NSMutableString stringWithFormat:@""];
            NSArray *items=parameters[key];
            for (int i = 0; i<items.count; i++) {
                
                NSDictionary *itemDic = items[i];
                NSArray *itemKeys = [[itemDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
                
                for (int j = 0; j<itemKeys.count; j++) {
                    
                    NSString *itemKey = itemKeys[j];
                    
                    NSString *str123 = [NSString stringWithFormat:@"item[%d][%@]=%@",i,itemKey,itemDic[itemKey]];
                    
                    [itemString appendString:str123];
                    
                    if (!(i == items.count-1 && j == itemKeys.count-1 )) {
                        
                        [itemString appendString:@"&"];
                    }
                }
            }
            [mstr appendFormat:@"%@",[[self encodeParameter:itemString] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"]];
            
        }else{
            if ([parameters[key] isKindOfClass:[NSString class]]) {
                NSString *value=[parameters[key] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                if (@available(iOS 9.0,*)) {
                    [mstr appendFormat:@"%@=%@",key,[[value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"]];
                    
                }else{
                     [mstr appendFormat:@"%@=%@",key,[[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"%20" withString:@"+"]];
                }
               
            }else{
                [mstr appendFormat:@"%@=%@",key,parameters[key]];
            }
        }
        if (i !=keys.count-1) {
            [mstr appendFormat:@"&"];
        }
    }
    [mstr appendFormat:@"%@%@%@",Api_secretKey1,Api_secretKey2,Api_secretKey3];
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    
    [temp setObject:[self md5:mstr] forKey:@"app_sign"];
    return [temp copy];
}
-(NSString *)getUserAuthWithUid:(NSString *)uid
                          token:(NSString *)token{
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",Api_Key1,Api_Key2,Api_Key3,uid,token];
    return [self md5:str];
}

- (NSString *)encodeParameter:(NSString *)originalPara {
    CFStringRef encodeParaCf = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)originalPara, NULL, CFSTR(",|*"), kCFStringEncodingUTF8);
    NSString *encodePara = (__bridge NSString *)(encodeParaCf);
    CFRelease(encodeParaCf);
    return encodePara;
}
- (NSString *) md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
