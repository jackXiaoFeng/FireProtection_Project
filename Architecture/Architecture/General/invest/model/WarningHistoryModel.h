//
//  WarningHistoryModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WarningHistoryModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Xfnumericals;
@property (nonatomic,strong)NSString *Xfstates;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *Time;


@end
