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
             @"Describe"             : @"Describe",
             @"Oper_flag"            : @"Oper_flag",
             @"Xfnumericals"         : @"Xfnumericals",
             @"Xfstates"             : @"Xfstates",
             @"name"                 : @"name",
             @"Time"                 : @"Time"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}


@end
