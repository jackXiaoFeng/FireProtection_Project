//
//  MalfunctionEquipmentModel.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "MalfunctionEquipmentModel.h"

@implementation MalfunctionEquipmentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Degree"               : @"Degree",
             @"Describe"             : @"Describe",
             @"Oper_flag"            : @"Oper_flag",
             @"Xfstates"             : @"Xfstates",
             @"name"                 : @"name"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

@end
