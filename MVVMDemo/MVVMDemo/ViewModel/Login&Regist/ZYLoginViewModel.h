//
//  ZYLoginViewModel.h
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYBasicViewModel.h"

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
- (void)jumpToRegist;
/**
 *  @author lzy, 15-08-24 09:08:05
 *
 *  @brief  验证用户输入之后的成功数据直接保存，请求时使用历史数据
 */
- (void)requestLogin;

@end
