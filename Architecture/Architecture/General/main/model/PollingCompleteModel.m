//
//  PollingCompleteModel.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/15.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "PollingCompleteModel.h"

@implementation PollingCompleteModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Complete"        : @"Complete",
             @"Odate"         : @"Odate",
             @"Sdate"           : @"Sdate",
             @"Type"             : @"Type",
             @"Unfinishe"            : @"Unfinishe"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

@end
