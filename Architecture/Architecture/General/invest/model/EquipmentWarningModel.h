//
//  EquipmentWarningModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/24.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//告警状态
//0:正常
//1:异常
#define Warning_Status_Normal      @"0"
#define Warning_Status_Malfunction @"1"

//申请检修状态
//0:正常
//1:故障
//2:等待维修
//3:等待复归
//4:申请复归
#define Warning_Fix_Normal      @"0"
#define Warning_Fix_Malfunction @"1"
#define Warning_Fix_Maintain    @"2"
#define Warning_Fix_Wait        @"3"
#define Warning_Fix_Apply       @"4"


@interface EquipmentWarningModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Xfnumericals;
@property (nonatomic,strong)NSString *Xfstates;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *Time;
@property (nonatomic,strong)NSString *AFmaintenance;
@property (nonatomic,strong)NSString *Degree;

//{
//    Describe = "\U6d4b\U8bd5";
//    "Oper_flag" = 1;
//    Time = 123;
//    Xfnumericals = 3;
//    Xfstates = 1;
//    name = "\U6c34\U538b";
//}


@end
