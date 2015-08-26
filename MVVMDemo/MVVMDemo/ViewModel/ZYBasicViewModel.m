//
//  ZYBasicViewModel.m
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYBasicViewModel.h"
#import "ZSXJHTTPSession.h"
@implementation ZYBasicViewModel
- (void)networkState:(NetworkBlock)theNetWorkBlock serverURL:(NSString *)serverURL {
    if (serverURL) {
        
    }
    ZSXJHTTPSession *sessionManager = [ZSXJHTTPSession sharedSession];
    sessionManager.networkChangeBlock = theNetWorkBlock;
}
- (void)setBlockReturnBlock:(ResultBlock)theReturnBlock errorBlock:(ErrorBlock)theErrorBlock failureBlock:(FailureBlock)theFailureBlock {
    _returnBlock  = theReturnBlock;
    _errorBlock   = theErrorBlock;
    _failureBlock = theFailureBlock;
}
@end
