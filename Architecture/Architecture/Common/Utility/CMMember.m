//
//  CMMemberEntity.m
//  MoviesStore 2.0
//
//  Created by hongren on 15/6/3.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "CMMember.h"
#define  DEF_StoredAppVersion  @"CMStoredAppVersion"

@implementation CMMember


/** 登录后用户信息实体
 * 单例
 */
+(instancetype)sharedMember{
    
    static CMMember* shareInstance;
    static dispatch_once_t onceToken;
    
    @synchronized(self){
        dispatch_once(&onceToken, ^{
            shareInstance = [[self alloc]init];
            shareInstance.isLogined = NO;
            shareInstance.userInfo = [[CMMemberData alloc]init];
        });
    }
    
    return shareInstance;
}



/**
 *  判断是否第一次打开app
 */
- (BOOL)isFirstTimeOpen {
    
    BOOL fistTimeOpen;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *storedAppVersion = [userDefaults objectForKey:DEF_StoredAppVersion];
    
    if (!storedAppVersion || ![storedAppVersion isEqualToString:DEF_APP_VERSION]) {
        fistTimeOpen = YES;
    } else {
        fistTimeOpen = NO;
    }
    [userDefaults setObject:DEF_APP_VERSION forKey:DEF_StoredAppVersion];
    [userDefaults synchronize];
    
    return fistTimeOpen;
}

@end
