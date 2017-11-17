//
//  DetectionModel.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/17.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "DetectionModel.h"

@implementation DetectionModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Eqname"        : @"Eqname",
             @"Faulttypes"         : @"Faulttypes",
             @"Floorsn"           : @"Floorsn",
             @"Standard"             : @"Standard"
             };
}


+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

@end
