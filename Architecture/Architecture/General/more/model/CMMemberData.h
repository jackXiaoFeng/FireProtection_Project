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
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *unitname;
@property (nonatomic,strong)NSString *unitsn;
@property (nonatomic,strong)NSString *username;


//phone = 12345;
//token = BOGMq9RLKyDDsFEBPEqkc;
//unitname = "\U6d88\U9632\U5c40";
//unitsn = 1234; 企业编号
//username = 12345;

@end
