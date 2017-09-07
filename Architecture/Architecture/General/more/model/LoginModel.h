//
//  LoginModel.h
//  Architecture
//
//  Created by xiaofeng on 17/9/4.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FailToCheckNum       @"获取验证码出错"


typedef void(^CompleteBlock)(NSString *);
typedef void(^FailBlock)(NSError *);

@interface LoginModel : NSObject

/**
 * 获取验证码,接口
 */
- (void)fetchVericode:(NSString *)phoneNum withCompleteBlock:(CompleteBlock)complete;

/**
 * 登录接口
 */
- (void)loginWithPhoneNum:(NSString *)phoneNum
               tfVericode:(NSString *)tfVericode
               Vericode:(NSString *)vericode
        isAgreeProtocol:(BOOL)isAgreeProtocol
               complete:(CompleteBlock)complete
                   fail:(FailBlock)fail;

@end
