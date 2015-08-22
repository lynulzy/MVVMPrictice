//
//  ZSXJHTTPSession.h
//  AFTestDemo
//
//  Created by lynulzy on 8/21/15.
//  Copyright (c) 2015 ZSXJ. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^successBlock)(NSURLSessionDataTask *task,id responseObject);
typedef void (^failedBlcik)(NSURLSessionDataTask *task,NSError*theError);
@interface ZSXJHTTPSession : AFHTTPSessionManager
@property (nonatomic, strong) UIActivityIndicatorView *actIndicator;
+ (ZSXJHTTPSession *)sharedSession;

- (void)POST:(NSString *)actStr ReqParams:(NSDictionary *)params success:(successBlock) succBlc failure:(failedBlcik)failBlc;
- (void)uploadImage:(NSDictionary *)imgDict byAct:(NSString *)theAct ReqParams:(NSDictionary *)params success:(successBlock) succBlc failure:(failedBlcik)failBlc;
@end
