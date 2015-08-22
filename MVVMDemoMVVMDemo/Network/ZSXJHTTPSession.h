//
//  ZSXJHTTPSession.h
//  AFTestDemo
//
//  Created by lynulzy on 8/21/15.
//  Copyright (c) 2015 ZSXJ. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^SuccessBlock) (NSURLSessionDataTask *task,id responseObject);
typedef void (^FailedBlcok) (NSURLSessionDataTask *task,NSError*theError);
typedef void (^NetworkChangeBlock) (AFNetworkReachabilityStatus status);
@interface ZSXJHTTPSession : AFHTTPSessionManager
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *actIndicator;
@property (nonatomic, readwrite, copy) NetworkChangeBlock networkChangeBlock;
+ (ZSXJHTTPSession *)sharedSession;

- (void)POST: (NSString *)actStr ReqParams: (NSDictionary *) params
     success: (SuccessBlock) succBlc
     failure: (FailedBlcok) failBlc;
- (void)uploadImage:(NSDictionary *) imgDict
              byAct:(NSString *) theAct
          ReqParams:(NSDictionary *) params
            success:(SuccessBlock) succBlc
            failure:(FailedBlcok) failBlc;
@end
