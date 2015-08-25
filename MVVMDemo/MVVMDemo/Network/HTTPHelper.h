//
//  HTTPHelper.h
//  AFTestDemo
//
//  Created by lynulzy on 8/21/15.
//  Copyright (c) 2015 ZSXJ. All rights reserved.
//
/**
 *  @author lzy, 15-08-21 09:08:15
 *
 *  @brief  HTTPHelper class is used to construct the POST data for a common URL request
 */
#import <Foundation/Foundation.h>

@interface HTTPHelper : NSObject
@property (nonatomic,readwrite,copy) NSMutableDictionary *thePOSTParams;
/**
 *  @author lzy, 15-08-21 09:08:43
 *
 *  @brief  This method will covers the params that all request will need to start a URL request.
 *
 *  @param actParam The basic params.
 */
- (void)setCommonParams:(NSString *)actParam;
- (void)setUniqueParams:(NSString *)dataJSONStr;
- (NSDictionary *)constructPOSTDict:(NSDictionary *)theBodyDict actParam:(NSString *)theAct;
@end
