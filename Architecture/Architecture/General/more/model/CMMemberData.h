//
//  CMMemberData.h
//  MoviesStore 2.0
//
//  Created by hongren on 15/6/11.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "Mantle.h"

/**
 * 用户数据
 */
@interface CMMemberData : MTLModel <MTLJSONSerializing>
@property (nonatomic,strong)NSString *uid;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *telphone;
@property (nonatomic,strong)NSString *identity;
@property (nonatomic,strong)NSString *headurl;
@property (nonatomic,strong)NSString *role;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *ownkfId;
@property (nonatomic,strong)NSString *owntid;

//uid ：用户编号
//nickname : 用户昵称
//telphone : 手机号
//identity : 数字ID
//headurl : 头像地址
//role : 角色id (0客户，1管理用户，2老师)
//status : 账号状态 (0正常注册用户，1禁止登录，2禁止发言)
//ownkfId : 专属客服编号
//owntid : 专属老师编号

@end
