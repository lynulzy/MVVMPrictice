//
//  ZYLoginViewModel.h
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYBasicViewModel.h"

typedef NS_ENUM(NSInteger, LoginErrorMessage) {
    ZYLoginInputErr,
};
typedef NS_ENUM(NSInteger, LoginReturnMessage) {
    ZYLoginReturnSucc_DismissView,
};
@interface ZYLoginViewModel : ZYBasicViewModel
/**
 *  @author lzy, 15-08-24 09:08:53
 *
 *  @brief  检查用户输入是否合法
 *
 *  @param userName 要检查的用户名
 *  @param password 要检查的密码
 */
- (BOOL)checkTheUserInputNameString: (NSString *) userName passwordString: (NSString *) password;
//- (void)jumpToRegistNav:(UINavigationController *)theNavgation;
/**
 *  @author lzy, 15-08-24 16:08:24
 *
 *  @brief  发起登录请求
 *
 *  @param requestView 在此页面发送请求，并且显示HUD
 */
- (void)requestLoginInView:(UIView *)requestView;

@end
