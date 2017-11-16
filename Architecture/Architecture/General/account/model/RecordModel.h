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

//Count = 3;
//Degree = ba4c5804;
//Describe = undefined;
//Images = undefined;
//Name = "\U5de1\U68c0\U70b95F";
//Number = 2;
//"Oper_flag" = 1;
//Xtime = 1510135425;
//page = 1;


@property (nonatomic,strong)NSString *Count;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Images;
@property (nonatomic,strong)NSString *Name;
@property (nonatomic,strong)NSString *Number;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Xtime;
@property (nonatomic,strong)NSString *page;



@end
