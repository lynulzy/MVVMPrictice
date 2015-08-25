//
//  ZYRegistViewModel.m
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYRegistViewModel.h"
#import "MBProgressHUD.h"
#import "ZSXJHTTPSession.h"
@implementation ZYRegistViewModel {
    NSString *mobile_;
    NSString *password_;
    NSString *smsCode_;
}
- (BOOL)checkMobileNumber:(NSString *)phoneNum {
    if (phoneNum.length == 11) {
//        self.errorBlock(@(ZYRegistErr_Password_ERR));
        mobile_ = phoneNum;
        return YES;
    }
    return NO;
}
- (BOOL)checkMobileNumber:(NSString *)phoneNum SMSCode:(NSString *)smsCode password:(NSString *)password {
    if (phoneNum.length == 11 && smsCode.length >= 4 && smsCode.length <= 6 && password.length >= 6 && password.length <=15) {
        mobile_   = phoneNum;
        password_ = password;
        smsCode_  = smsCode;
        return YES;
    }
    
//    self.errorBlock(ZYRegistErr_Password_ERR);
    return YES;
}
- (void)requestSMSCodeInView:(UIView *)displayView {
    [MBProgressHUD showHUDAddedTo:displayView animated:YES];
    ZSXJHTTPSession *sessionManager = [ZSXJHTTPSession sharedSession];
    NSString *actStr = @"submit_user_send_mobile_code";
    NSDictionary *dict;
    if (mobile_) {
        dict = @{@"mobile" : mobile_,
                 @"from_func" : @"1"};
    }
    else{
        self.errorBlock (@"手机号码错误，请重新输入");
        return;
    }
    [sessionManager POST:actStr
               ReqParams:dict
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     [MBProgressHUD hideHUDForView:displayView animated:YES];
                     self.returnBlock(@(ZYRegistSucc_SendSMS));
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *theError) {
                     [MBProgressHUD hideHUDForView:displayView animated:YES];
                 }];
}
- (void)requestRegistInView:(UIView *)displayView {
    [MBProgressHUD showHUDAddedTo:displayView animated:YES];
    ZSXJHTTPSession *sessionManager = [ZSXJHTTPSession manager];
    NSString *actStr = @"submit_user_register";
    NSDictionary *paramDic;
    if (mobile_ && password_ && smsCode_) {
       paramDic = @{@"mobile":mobile_,
                    @"password" : password_,
                    @"sms_code" : smsCode_,
                    @"deviceid" : @"1111111",
                    @"pingtai" : @"2",
                    @"utm" : @"appstore",
                    @"ext" : @"iphone 5s",
                    @"ver" : @"1.0",
                    @"is_select" : @"1"};
    }
    else {
        self.errorBlock (@"发起请求参数有误，请检查");
        return;
    }
    [sessionManager POST:actStr
               ReqParams:paramDic
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     //处理数据
                     [MBProgressHUD hideAllHUDsForView:displayView animated:YES];
                     self.returnBlock (@(ZYRegistSucc_SendRegist));
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *theError) {
                     //查找失败原因
                     [MBProgressHUD hideAllHUDsForView:displayView animated:YES];
                 }];
}
@end
