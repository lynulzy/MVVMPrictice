//
//  ZYRegistViewModel.h
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYBasicViewModel.h"

typedef NS_ENUM(NSInteger, RegistErrorMessage) {
    //验证出错
    ZYRegistErr_PhoneNum_ERR,
    ZYRegistErr_SMSCODE_ERR,
    ZYRegistErr_Password_ERR,
    //服务器返回错误
    ZYRegistErr_SMS_ERR,
    ZYRegistErr_Request_ERR
};
typedef NS_ENUM(NSInteger, RegistRequestSucc) {
    ZYRegistSucc_SendSMS,//发送验证码成功
    ZYRegistSucc_SendRegist //发送注册成功
};

@interface ZYRegistViewModel : ZYBasicViewModel

- (BOOL)checkMobileNumber: (NSString *) phoneNum;
- (BOOL)checkMobileNumber: (NSString *) phoneNum SMSCode: (NSString *) smsCode password:(NSString *)password;
- (void)requestSMSCodeInView: (UIView *) displayView;
- (void)requestRegistInView: (UIView *) displayView;


@end
