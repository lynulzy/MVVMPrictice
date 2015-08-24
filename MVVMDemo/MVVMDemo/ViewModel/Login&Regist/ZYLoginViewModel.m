//
//  ZYLoginViewModel.m
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYLoginViewModel.h"

@implementation ZYLoginViewModel
- (BOOL)checkTheUserInputNameString:(NSString *)userName passwordString:(NSString *)password {
    //长度判断
    if (userName.length > 5 && userName.length < 10 && password.length >= 6 && password.length <= 15) {
        return YES;
    }
    self.errorBlock(@"您输入的超过限制，请修改后重新输入");
    return NO;
}

- (void)requestLogin {
    NSLog(@"Fake 正在发起请求");
}
@end
