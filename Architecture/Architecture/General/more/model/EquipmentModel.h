//
//  EquipmentModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentModel : MTLModel<MTLJSONSerializing>
//
//操作标志	Oper_flag	Int	1
//设备名	    Name	String
//数值	    Xfnumericals	String
//状态	    Xfstates	Sting
//设备编号	Degree	String

//AFmaintenance = 1;
//Count = 686;
//Degree = "\U6caaA010\U00b7F01\U00b701";
//Describe = undefined;
//Name = "\U70df\U611f";
//"Oper_flag" = 1;
//XY = "24,23";
//Xfstates = 1;
//page = 1;
//warningrecordsn = undefined;
//xfnumericals = null;



@property (nonatomic,strong)NSString *AFmaintenance;
@property (nonatomic,strong)NSString *Count;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *XY;
@property (nonatomic,strong)NSString *Xfstates;
@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)NSString *warningrecordsn;
@property (nonatomic,strong)NSString *xfnumericals;

@end
