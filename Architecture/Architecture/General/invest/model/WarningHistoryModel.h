//
//  WarningHistoryModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WarningHistoryModel : MTLModel<MTLJSONSerializing>


//操作标志	Oper_flag	Int	1
//设备编号	Degree	    String
//描述	    Describe	String
//名称	    Name	String
//告警时间	Stime	String
//人员名	    Uname	String
//复归时间	Utime	String

//Count = 2;
//Degree = ba646f04;
//Detailed = null;
//Mdetailed = null;
//Mtime = null;
//Musername = null;
//Name = "\U6c34\U6cf5A";
//"Oper_flag" = 1;
//Stime = 0;
//Udetailed = "\U590d\U4f4d";
//Username = "\U738b\U9e4f";
//Utime = 1510559952;
//Uusername = "\U738b\U9

@property (nonatomic,strong)NSString *Count;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *Detailed;
@property (nonatomic,strong)NSString *Mdetailed;
@property (nonatomic,strong)NSString *Mtime;
@property (nonatomic,strong)NSString *Musername;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Stime;
@property (nonatomic,strong)NSString *Udetailed;
@property (nonatomic,strong)NSString *Username;
@property (nonatomic,strong)NSString *Utime;
@property (nonatomic,strong)NSString *Uusername;


@end
