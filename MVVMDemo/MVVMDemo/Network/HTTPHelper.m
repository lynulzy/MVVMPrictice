//
//  HTTPHelper.m
//  AFTestDemo
//
//  Created by lynulzy on 8/21/15.
//  Copyright (c) 2015 ZSXJ. All rights reserved.
//

#import "HTTPHelper.h"
#import "MD5.h"
#define APPID_AS    @"979802402"
@implementation HTTPHelper
@synthesize thePOSTParams;
- (instancetype)init
{
    self = [super init];
    if (self) {
        thePOSTParams = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (NSDictionary *)constructPOSTDict:(NSDictionary *)theBodyDict actParam:(NSString *)theAct {
    if (thePOSTParams) {
        //设置基本参数
        [self setCommonParams:theAct];
        //将特定参数字典转换
        NSData *bodyData = [NSJSONSerialization dataWithJSONObject:theBodyDict
                                                           options:0
                                                             error:nil];
        NSString *dataJSONStr = [[NSString alloc] initWithData:bodyData
                                                      encoding:NSUTF8StringEncoding];
        //sig字段
        [self setUniqueParams:dataJSONStr];
    }
    return thePOSTParams;
}
- (void)setCommonParams:(NSString *)actParam {
    if (!thePOSTParams) {
        thePOSTParams = [NSMutableDictionary dictionary];
    }
    [thePOSTParams setValue:actParam forKey:@"act"];
    [thePOSTParams setValue:APPID_AS forKey:@"app_id"];
    [thePOSTParams setValue:@"7f5lexkqxdlz8mah5ojqi1ml7cg6y0k9" forKey:@" app_secret"];
    [thePOSTParams setValue:@"u2fsdgvkX18" forKey:@"session_key"];
    [thePOSTParams setValue:[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]]
                 forKey:@"timestamp"];
    return;
}
- (void)setUniqueParams:(NSString *)dataJSONStr {
    [thePOSTParams setValue:dataJSONStr forKey:@"data"];
    [thePOSTParams setValue:[self signWithParam3:thePOSTParams] forKey:@"sig"];
}
static NSString *signKey = @"";

#define API_SIGN_KEY                @"*)8.~1`@X=^7!%#K;_$-"
#define DOMAIN_AS                   @"www.guancheyi.com"

- (NSString *)signWithParam3:(NSDictionary *)theParam {
    NSString *act = [theParam objectForKey:@"act"];
    //    NSString *app_id = [theParam objectForKey:@"app_id"];
    NSString *app_secret = @"7f5lexkqxdlz8mah5ojqi1ml7cg6y0k9";
    //    NSString *session_key = [theParam objectForKey:@"session_key"];
    NSString *timestamp  = [theParam objectForKey:@"timestamp"];
    NSString *data = [theParam objectForKey:@"data"];
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",act,API_SIGN_KEY,DOMAIN_AS,APPID_AS,timestamp,app_secret,data];
    
    //    NSString *str = [NSString stringWithFormat:@"%@%@",act,API_SIGN_KEY];
    return [[MD5 md5:str] lowercaseString];
}

@end
