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


@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Xfnumericals;
@property (nonatomic,strong)NSString *Xfstates;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *Time;
@property (nonatomic,strong)NSString *AFmaintenance;
@property (nonatomic,strong)NSString *Degree;


@end
