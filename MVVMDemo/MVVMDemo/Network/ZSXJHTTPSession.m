//
//  ZSXJHTTPSession.m
//  AFTestDemo
//
//  Created by lynulzy on 8/21/15.
//  Copyright (c) 2015 ZSXJ. All rights reserved.
//

#import "ZSXJHTTPSession.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "HTTPHelper.h"

@interface ZSXJHTTPSession()
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ZSXJHTTPSession
static NSString *baseURL = @"http://121.199.38.85/logistics_app/api.php";
@synthesize actIndicator;
@synthesize sessionManager;
+ (ZSXJHTTPSession *)sharedSession {
    static ZSXJHTTPSession *shareaSession = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareaSession = [[ZSXJHTTPSession alloc] initWithBaseURL:[NSURL URLWithString:baseURL]
                                            sessionConfiguration:nil];
    });
    return shareaSession;
}
-(instancetype)initWithBaseURL: (NSURL *) url sessionConfiguration: (NSURLSessionConfiguration *) configuration {
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (self) {
        sessionManager = [AFHTTPSessionManager manager];
        actIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //TODO  此处添加提示（全局通知），当网络状况发生改变的时候告知用户
        __weak typeof (self) weakSelf = self;
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            strongSelf.networkChangeBlock(status);
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable: {
                    //网络不可用
                    [strongSelf.operationQueue setSuspended:YES];
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWWAN: {
                    //手机网络
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    //wifi
                    break;
                }
                default:
                    [strongSelf.operationQueue setSuspended:NO];
                    break;
            }
        }];
        [self.reachabilityManager startMonitoring];
    }
    return self;
}
- (void)POST: (NSString *) actStr ReqParams: (NSDictionary *) params success: (SuccessBlock) succBlc failure: (FailedBlcok) failBlc {
    //Show network indicator in status bar.
    AFNetworkActivityIndicatorManager *indicatorManager = [AFNetworkActivityIndicatorManager sharedManager];
    indicatorManager.enabled = YES;
    [indicatorManager incrementActivityCount];
    
    //Contruct the post Params
    NSDictionary *postData = [[[HTTPHelper alloc] init] constructPOSTDict:params
                                                                 actParam:actStr];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager POST:baseURL
       parameters:postData
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [indicatorManager decrementActivityCount];
              succBlc(task,responseObject);
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              [indicatorManager decrementActivityCount];
              failBlc(task,error);
          }];
}

- (void)uploadImage: (NSDictionary *) imgDict
              byAct: (NSString *) theAct
          ReqParams: (NSDictionary *) params
            success: (SuccessBlock) succBlc
            failure: (FailedBlcok) failBlc {
        //上传图片
    NSDictionary *postData = [[[HTTPHelper alloc] init] constructPOSTDict:params
                                                                 actParam:theAct];
    [sessionManager POST:baseURL
              parameters:postData
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
}
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     NSLog(@"上传成功");
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     NSLog(@"上传失败");
                 }];
}

@end
