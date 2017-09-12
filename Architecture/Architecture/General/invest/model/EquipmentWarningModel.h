//
//  EquipmentWarningModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/24.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>


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
