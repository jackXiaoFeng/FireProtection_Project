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

@property (nonatomic,strong)NSString *Count;
@property (nonatomic,strong)NSString *Eqname;
@property (nonatomic,strong)NSString *Floorsn;
@property (nonatomic,strong)NSString *Number;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *page;

//Count = 27;
//Eqname = "\U5de1\U68c0\U70b94F";
//Floorsn = 4F;
//Number = 2;
//"Oper_flag" = 1;
//page = 1;


@end
