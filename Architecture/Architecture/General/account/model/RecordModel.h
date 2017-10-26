//
//  RecordModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/30.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : MTLModel <MTLJSONSerializing>

//操作标志	Oper_flag	Int	1
//设备编号	Degree	String
//描述	    Describe	String
//名称	    Name	String


@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Name;

@end
