//
//  EquipmentWarningModel.m
//  Architecture
//
//  Created by xiaofeng on 17/8/24.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "EquipmentWarningModel.h"

@implementation EquipmentWarningModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"AFmaintenance"        : @"AFmaintenance",
             @"Count"                : @"Count",
             @"Degree"               : @"Degree",
             @"Describe"             : @"Describe",
             @"Oper_flag"            : @"Oper_flag",
             @"Time"                 : @"Time",
             @"XY"                   : @"XY",
             @"Xfstates"             : @"Xfstates",
             @"floorsn"              : @"floorsn",
             @"name"                 : @"name",
             @"page"                 : @"page",

             @"warningrecordsn"         : @"warningrecordsn"
             
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}


@end
