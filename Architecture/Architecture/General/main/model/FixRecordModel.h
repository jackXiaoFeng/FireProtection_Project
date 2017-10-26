//
//  FixRecordModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixRecordModel : MTLModel <MTLJSONSerializing>

//操作标志	Oper_flag	Int	1	M
//设备编号	Degree	String
//描述	    Describe	String
//名称	    Name	String
//告警时间	Stime	String
//人员名	    Uname	String
//复归时间	Utime	String

@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)NSString *Stime;
@property (nonatomic,strong)NSString *Uname;
@property (nonatomic,strong)NSString *Utime;

@end
