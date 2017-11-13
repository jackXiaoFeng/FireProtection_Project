//
//  WarningHistoryModel.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "WarningHistoryModel.h"

@implementation WarningHistoryModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Count"                : @"Count",
             @"Degree"              : @"Degree",
             @"Detailed"             : @"Detailed",
             @"Mdetailed"                  : @"Mdetailed",
             @"Mtime"                 : @"Mtime",
             @"Musername"                 : @"Musername",
             @"Name"                 : @"Name",
             @"Oper_flag"                 : @"Oper_flag",
             @"Stime"                 : @"Stime",
             @"Udetailed"                 : @"Udetailed",
             @"Username"                 : @"Username",
             @"Utime"                 : @"Utime",
             @"Uusername"                 : @"Uusername"
             };

}


+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

@end
