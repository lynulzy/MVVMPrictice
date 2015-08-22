//
//  MD5.h
//  JiayuanIPad
//
//  Created by TONG YU on 11-9-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#ifndef HJSM_MD5
#define HJSM_MD5

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
//#import "Define.h"


@interface MD5 : NSObject {
	
}
+ (NSString *)md5:(NSString *)str;

@end

#endif
