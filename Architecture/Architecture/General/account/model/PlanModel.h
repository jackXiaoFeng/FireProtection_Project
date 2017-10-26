//
//  PlanModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanModel : MTLModel <MTLJSONSerializing>
//操作标志	Oper_flag	Int	1
//描述	    Describe	String
//周期	    Cycle	String
//区域	    Name	String
//完成时间	Overtime	String

@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Cycle;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)NSString *Overtime;

@end
