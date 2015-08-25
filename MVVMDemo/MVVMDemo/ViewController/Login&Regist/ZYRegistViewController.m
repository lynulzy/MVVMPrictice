//
//  ZYRegistViewController.m
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYRegistViewController.h"
#import "ZYRegistViewModel.h"
@interface ZYRegistViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *smsCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *sendSMSBT;

@end

@implementation ZYRegistViewController {
    ZYRegistViewModel *registModel_;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    registModel_ = [[ZYRegistViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    [registModel_ setBlock:^(id processResult) {
        //处理成功的数据
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //发送验证码成功
        if ([processResult  isEqual: @(ZYRegistSucc_SendRegist)]) {
            [strongSelf.sendSMSBT becomeFirstResponder];
        }
        //发送注册请求成功
        if ([processResult isEqual:@(ZYRegistSucc_SendRegist)]) {
            [strongSelf.navigationController dismissViewControllerAnimated:YES
                                                                completion:nil];
        }
    }
                     block:^(id errorMessage) {
                         //处理错误信息
                         NSLog(@"error %@",errorMessage);
                     } block:^(NSString *networkMessage) {
                         //网络请求失败
                     }];
}

#pragma mark - User Action
- (IBAction)getSMSCodeClicked:(id)sender {
    if (self.phoneNumberTF.text.length != 11) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码，然后获取验证码"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ([registModel_ checkMobileNumber:self.phoneNumberTF.text]) {
        [registModel_ requestSMSCodeInView:self.sendSMSBT.imageView];
    }
}
- (IBAction)registClicked:(id)sender {
    if (self.phoneNumberTF.text.length > 0
        && self.smsCodeTF.text.length > 0
        && self.passwordTF.text.length > 0) {
        if ([registModel_ checkMobileNumber:self.phoneNumberTF.text
                                    SMSCode:self.smsCodeTF.text
                                   password:self.passwordTF.text]) {
            [registModel_ requestRegistInView:self.view];
            return;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入相关信息，然后注册"
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UITextfield Delegate
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (textField == self.phoneNumberTF) {
        //验证手机号码格式、发送验证码
        if ([registModel_ checkMobileNumber:textField.text]) {
            [registModel_ requestSMSCodeInView:self.view];
        }
        return YES;
    }
    else if (textField == self.smsCodeTF) {
        [self.passwordTF becomeFirstResponder];
        
        return YES;
    }
    else if (textField == self.passwordTF) {
        //验证手机号码、验证码、密码格式是否正确
        if ([registModel_ checkMobileNumber:self.phoneNumberTF.text
                                    SMSCode:self.smsCodeTF.text
                                   password:self.passwordTF.text]) {
            [registModel_ requestRegistInView:self.view];
        }
        return YES;
    }
    else
        return NO;
}


@end
