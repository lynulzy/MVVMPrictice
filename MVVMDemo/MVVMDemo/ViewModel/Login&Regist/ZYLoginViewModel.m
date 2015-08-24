//
//  ZYLoginViewModel.m
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYLoginViewModel.h"
#import "ZSXJHTTPSession.h"
#import "MBProgressHUD.h"
@implementation ZYLoginViewModel {
    NSString *userName_;
    NSString *password_;
}
- (BOOL)checkTheUserInputNameString:(NSString *)userName passwordString:(NSString *)password {
    //长度判断
    if (userName.length == 11 && password.length >= 6 && password.length <= 15) {
        userName_ = userName;
        password_ = password;
        return YES;
    }
    self.errorBlock(@"您输入的超过限制，请修改后重新输入");
    return NO;
}

- (void)requestLoginInView:(UIView *)requestView {
    NSLog(@"Fake 正在发起请求");
    ZSXJHTTPSession *sessionManager = [ZSXJHTTPSession sharedSession];
    NSString *actString = @"submit_user_login";
    NSDictionary *paramsDict = @{@"mobile" : userName_, @"password" : password_};
    __weak typeof (self) weakSelf = self;
    [sessionManager POST:actString
               ReqParams:paramsDict
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     [MBProgressHUD hideHUDForView:requestView animated:YES];
                     NSLog(@"登录成功，HUD停止");
                     __strong typeof(weakSelf) strongSelf = weakSelf;
                     strongSelf.returnBlock(ZYLoginReturnSucc_DismissView);
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *theError) {
                     [MBProgressHUD hideHUDForView:requestView animated:YES];
                     NSLog(@"失败 %@",theError);
                 }];
    [MBProgressHUD showHUDAddedTo:requestView animated:YES];
}

//- (void)jumpToRegistNav:(UINavigationController *)theNavgation {
//    
//}
@end
