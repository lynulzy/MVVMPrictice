//
//  ZYBasicViewModel.h
//  MVVMDemo
//
//  Created by lynulzy on 8/22/15.
//  Copyright (c) 2015 http://lynulzy.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//与View层次(xxViewController)交互的block

/**
 *  @author lzy, 15-08-22 16:08:58
 *
 *  @brief  由ViewModel返回给View的数据，id类型
 *
 *  @param processResult 返回的结果，可以是Dictionary或者是Array，这个数据在view中应该是可以直接使用的
 */
typedef void (^ResultBlock) (id processResult);
/**
 *  @author lzy, 15-08-22 16:08:29
 *
 *  @brief  如果出现服务器返回了错误码，这时候逻辑在ViewModel中处理，并告知View
 *
 *  @param errorMessage 返回错误信息
 */
typedef void (^ErrorBlock) (id errorMessage);
/**
 *  @author lzy, 15-08-22 16:08:40
 *
 *  @brief  出现因为网络状况而失败的请求时告诉View
 *
 *  @param networkMessage 当前的网络状态
 */
typedef void (^FailureBlock) (NSString *networkMessage);
typedef void (^NetworkBlock) (AFNetworkReachabilityStatus networkStatus);

@interface ZYBasicViewModel : NSObject

@property (nonatomic, readwrite, copy) ResultBlock returnBlock;
@property (nonatomic, readwrite, copy) ErrorBlock errorBlock;
@property (nonatomic, readwrite, copy) FailureBlock failureBlock;

/**
 *  @author lzy, 15-08-22 16:08:04
 *
 *  @brief  设置与ViewController通信的block
 *
 *  @param theReturnBlock  成功返回数据
 *  @param theErrorBlock   返回数据有误
 *  @param theFailureBlock 网络状况
 */
- (void)setBlock: (ResultBlock) theReturnBlock
           block: (ErrorBlock) theErrorBlock
           block: (FailureBlock) theFailureBlock;

- (void)networkState: (NetworkBlock) theNetWorkBlock
           serverURL:(NSString *) serverURL;

@end
