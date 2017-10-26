//
//  FixRecordModel.m
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "FixRecordModel.h"

@implementation FixRecordModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Oper_flag"        : @"Oper_flag",
             @"Describe"         : @"Describe",
             @"Degree"           : @"Degree",
             @"Name"             : @"Name",
             @"Stime"            : @"Stime",
             @"Uname"            : @"Uname",
             @"Utime"            : @"Utime"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}


@end
