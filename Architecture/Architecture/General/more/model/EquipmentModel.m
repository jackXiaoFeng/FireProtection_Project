//
//  EquipmentModel.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "EquipmentModel.h"

@implementation EquipmentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Oper_flag"            : @"Oper_flag",
             @"Name"                 : @"Name",
             //@"Xfnumericals"         : @"Xfnumericals",
             @"Describe"         : @"Describe",
             @"Xfstates"             : @"Xfstates",
             @"Degree"               : @"Degree"
             };
}


+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

@end
