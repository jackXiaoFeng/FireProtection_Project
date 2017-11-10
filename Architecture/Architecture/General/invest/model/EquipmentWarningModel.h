//
//  EquipmentWarningModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/24.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EquipmentWarningModel : MTLModel<MTLJSONSerializing>

//设备名	    Name	String
//地点（描述）	Describe	String
//复检申请检修	AFmaintenance	String
//状态	    Xfstates	String

@property (nonatomic,strong)NSString *AFmaintenance;
@property (nonatomic,strong)NSString *Count;
@property (nonatomic,strong)NSString *Degree;//程度等级
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Time;
@property (nonatomic,strong)NSString *XY;
@property (nonatomic,strong)NSString *Xfstates;
@property (nonatomic,strong)NSString *floorsn;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)NSString *warningrecordsn;

//{
//    AFmaintenance = 1;
//    Count = 15;
//    Degree = "\U6caaA010\U00b7F07\U00b707";
//    Describe = null;
//    "Oper_flag" = 1;
//    Time = null;
//    XY = "79,41";
//    Xfstates = 0;
//    floorsn = 7F;
//    name = "\U70df\U611f";
//    page = 1;
//    warningrecordsn = undefined;
//},

//操作标志    Oper_flag    Int    1    M    1：设备告警信息
//设备名    Name    String
//地点（描述）    Describe    String
//复检申请检修    AFmaintenance    String
//时间    Time
//状态    Xfstates    String
//最新异常编号    Warningrecords


@end
