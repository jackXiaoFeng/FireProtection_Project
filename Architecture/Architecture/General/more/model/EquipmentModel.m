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
             @"AFmaintenance"           : @"AFmaintenance",
             @"Count"                   : @"Count",
             @"Degree"                  : @"Degree",
             @"Describe"                : @"Describe",
             @"Name"                    : @"Name",
             @"Oper_flag"               : @"Oper_flag",
             @"XY"                      : @"XY",
             @"Xfstates"                : @"Xfstates",
             @"page"                    : @"page",
             @"warningrecordsn"         : @"warningrecordsn",
             @"xfnumericals"            : @"xfnumericals"
             };

}


+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

@end
