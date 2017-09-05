//
//  CMMemberEntity.h
//  MoviesStore 2.0
//
//  Created by hongren on 15/6/3.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMMemberData.h"

/**
 *
 * 菜苗用户管理类，包含了用户登录信息，登录类型，是否登录，以及对用户登录情况的监听及回调
 *
 **/

//宏
#define CMMemberEntity           [CMMember sharedMember]
typedef enum {
    E_CM = 0,   //黄金甲账号登录
    E_WX,       //QQ联合登录
    E_QQ,       //微信联合登录
    E_WB,       //微博联合登录
}E_LoginType;


@interface CMMember : NSObject

/**
 * 登录类型
 */
@property (nonatomic,assign)E_LoginType   loginType;

/**
 * 是否登录
 */
@property (nonatomic,assign)BOOL          isLogined;

/**
 * 登录成功用户验证token
 */
@property (nonatomic,assign)NSString       *token;

/**
 * 用户信息
 */
@property (nonatomic,strong)CMMemberData    *user;

/**
 *  用户性别
 */
@property (nonatomic,strong)NSString        *sex;

/**
 *  用户修改过后的头像
 */
@property (nonatomic,strong)UIImage         *headerImg;

/**
 * 菜苗用户ID
 */
@property (nonatomic,strong)NSString        *cmid;

/**
 * 是否打开微博分享登陆(1.开启 0.隐藏)
 */
@property (nonatomic,strong)NSString        *isopenSina;

/**
 * 是否打开影院(1.开启 0.隐藏)
 */
@property (nonatomic,strong)NSString        *isopencinema;

/**
 *  单例方法
 */
+(instancetype)sharedMember;

/**
 *  是否第一次打开app
 */
- (BOOL)isFirstTimeOpen;


@end
