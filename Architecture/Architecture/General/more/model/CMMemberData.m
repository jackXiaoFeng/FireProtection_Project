//
//  CMMemberData.m
//  MoviesStore 2.0
//
//  Created by hongren on 15/6/11.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "CMMemberData.h"

@implementation CMMemberData

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid"             : @"uid",
             @"nickname"        : @"nickname",
             @"telphone"        : @"telphone",
             @"identity"        : @"identity",
             @"headurl"         : @"headurl",
             @"role"            : @"role",
             @"status"          : @"status",
             @"ownkfId"         : @"ownkfId",
             @"owntid"          : @"owntid",
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return DEF_OBJECT_TO_STIRNG(value);
    }];
}

////设置用户没有昵称时，用手机号替代
//- (NSString *)nickname
//{
//    if ([_nickname isEqualToString:@""]) {
//        if(![_username isEqualToString:@""]) return _username;
//        if (![_phone isEqualToString:@""]) return _phone;
//    }
//    return _nickname;
//}

@end
