//
//  MalfunctionEquipmentModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MalfunctionEquipmentModel : MTLModel<MTLJSONSerializing>

//操作标志	Oper_flag	Int	1
//设备编号	Degree	String
//描述	    Describe	String
//名称	    Name	String
//状态	    Xfstates	Int

@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *Xfstates;

@end
