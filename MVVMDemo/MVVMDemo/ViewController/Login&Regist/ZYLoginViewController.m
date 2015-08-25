//
//  ZYLoginViewController.m
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ZYLoginViewController.h"
#import "ZYLoginViewModel.h"

#define TAG_USERNAME_TF     1001
#define TAG_PASSWORD_TF     1002

@interface ZYLoginViewController ()<UITextFieldDelegate>

@end
@implementation ZYLoginViewController {
    ZYLoginViewModel *loginViewModel_;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.view hasAmbiguousLayout]) {
//        NSArray *conflict = [self.view constraintsAffectingLayoutForAxis:<#(UILayoutConstraintAxis)#>]
    }
    loginViewModel_ = [[ZYLoginViewModel alloc] init];
    __weak typeof (self) weakSelf = self;
    [loginViewModel_ setBlock:^(id processResult) {
                            //成功返回
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if ([processResult isEqual: @(ZYLoginReturnSucc_DismissView)]){
            [strongSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                NSLog(@"页面消失");
            }];
        }
        else {
            //Handle the data;
        }
        
                        }
                       block:^(id errorMessage) {
                           //失败信息
                           if([errorMessage isKindOfClass:[NSString class]]) {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorMessage message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                               [alert show];
                           }
                       }
                       block:^(NSString *networkMessage) {
                           //网络请求失败
                       }];
}
#pragma mark - UserAction
- (IBAction)loginButtonClicked:(id)sender {
    UITextField *userNameTF = (UITextField *)[self.view viewWithTag:TAG_USERNAME_TF];
    UITextField *passwordTF = (UITextField *)[self.view viewWithTag:TAG_PASSWORD_TF];
    if (userNameTF.text.length != 0 && passwordTF.text.length != 0) {
        if ([loginViewModel_ checkTheUserInputNameString:userNameTF.text passwordString:passwordTF.text]) {
            [loginViewModel_ requestLoginInView:self.view];
            return;
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入用户名和密码，然后登录"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
}

#pragma mark - UserInput & TextFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == TAG_PASSWORD_TF) {
//        if (loginViewModel_) {
//            NSString *userNameString = [(UITextField *)[self.view viewWithTag:TAG_USERNAME_TF] text];
//            [loginViewModel_ checkTheUserInputNameString:userNameString
//                                          passwordString:textField.text];
//        }
    }
    else if (textField.tag == TAG_USERNAME_TF) {
        UITextField *passwordTF = (UITextField *)[self.view viewWithTag:TAG_PASSWORD_TF];
        [passwordTF becomeFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == TAG_USERNAME_TF) {
        UITextField *passwordTF = (UITextField *)[self.view viewWithTag:TAG_PASSWORD_TF];
        [passwordTF becomeFirstResponder];
    }
    else if (textField.tag == TAG_PASSWORD_TF) {
        [self.view endEditing:YES];
        if (loginViewModel_) {
            UITextField *userNameTF = (UITextField *)[self.view viewWithTag:TAG_USERNAME_TF];
            BOOL verySucc = [loginViewModel_ checkTheUserInputNameString:userNameTF.text
                                          passwordString:textField.text];
            if (verySucc) {
                [loginViewModel_ requestLoginInView:self.view];
            }
        }
    }
    return YES;
}
@end
