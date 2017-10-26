//
//  RecordModel.m
//  Architecture
//
//  Created by xiaofeng on 17/8/30.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Describe"             : @"Describe",
             @"Oper_flag"            : @"Oper_flag",
             @"Degree"               : @"Degree",
             @"Name"                 : @"Name"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}


@end
