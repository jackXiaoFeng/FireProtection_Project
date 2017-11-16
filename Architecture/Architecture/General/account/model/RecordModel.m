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
             @"Count"             : @"Count",
             @"Degree"             : @"Degree",
             @"Describe"             : @"Describe",
             @"Images"            : @"Images",
             @"Name"            : @"Name",
             @"Number"            : @"Number",
             @"Oper_flag"            : @"Oper_flag",
             @"Xtime"            : @"Xtime",
             @"page"                 : @"page"
             };
}


+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}


@end
