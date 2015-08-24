//
//  ViewController.m
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import "ViewController.h"
#import "ZSXJHTTPSession.h"
#import "ZYLoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)userClicked:(id)sender {
//    //Test network
//    NSString *actStr = @"submit_user_send_mobile_code";
//    NSDictionary *parameters = @{@"mobile": @"18601015532",@"from_func":@"1"};
//    ZSXJHTTPSession *session = [ZSXJHTTPSession sharedSession];
//    [session POST:actStr
//        ReqParams:parameters
//          success:^(NSURLSessionDataTask *task, id responseObject) {
//              NSLog(@"succ %@",responseObject);
//          }
//          failure:^(NSURLSessionDataTask *task, NSError *theError) {
//              NSLog(@"failed %@",theError);
//          }];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ZYLoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"com.lynulzy.LoginViewController"];
    [self presentViewController:loginViewController animated:YES completion:nil];
}

@end
