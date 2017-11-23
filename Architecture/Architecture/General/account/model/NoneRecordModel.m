//
//  NoneRecordModel.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/17.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "NoneRecordModel.h"

@implementation NoneRecordModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Count"            : @"Count",
             @"Eqname"           : @"Eqname",
             @"Floorsn"          : @"Floorsn",
             @"Number"           : @"Number",
             @"Oper_flag"        : @"Oper_flag",
             @"page"             : @"page"
             };
}


+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

@end
