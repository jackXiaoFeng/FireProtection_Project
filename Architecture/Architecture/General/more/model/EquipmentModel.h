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

//{
//    Degree = f10035;
//    Describe = undefined;
//    Name = "\U5377\U5e18\U95e8";
//    "Oper_flag" = 1;
//    Xfstates = 3;
//}

@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Name;
//@property (nonatomic,strong)NSString *Xfnumericals;
@property (nonatomic,strong)NSString *Xfstates;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *Describe;

@end
