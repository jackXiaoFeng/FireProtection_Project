//
//  PlanModel.m
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "PlanModel.h"

@implementation PlanModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Describe"             : @"Describe",
             @"Oper_flag"            : @"Oper_flag",
             @"Cycle"                : @"Cycle",
             @"Xfstates"             : @"Xfstates",
             @"Name"                 : @"Name",
             @"Overtime"             : @"Overtime"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

@end
