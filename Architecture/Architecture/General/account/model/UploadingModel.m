//
//  UploadingModel.m
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "UploadingModel.h"

@implementation UploadingModel

+ (NSString *)filePath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"course.plist"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.Eqname = [aDecoder decodeObjectForKey:@"Eqname"];
        self.Floorsn = [aDecoder decodeObjectForKey:@"Floorsn"];
        self.timeT = [aDecoder decodeObjectForKey:@"timeT"];
        self.Degree = [aDecoder decodeObjectForKey:@"Degree"];
        self.State = [aDecoder decodeObjectForKey:@"State"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
        self.Describe = [aDecoder decodeObjectForKey:@"Describe"];
        self.Actegories = [aDecoder decodeObjectForKey:@"Actegories"];
        
        self.Oper_flag = [aDecoder decodeObjectForKey:@"Oper_flag"];
        self.Warningrecordsn = [aDecoder decodeObjectForKey:@"Warningrecordsn"];
        self.AFmaintenance = [aDecoder decodeObjectForKey:@"AFmaintenance"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Eqname forKey:@"Eqname"];
    [aCoder encodeObject:self.Floorsn forKey:@"Floorsn"];
    [aCoder encodeObject:self.timeT forKey:@"timeT"];
    
    [aCoder encodeObject:self.Degree forKey:@"Degree"];
    [aCoder encodeObject:self.State forKey:@"State"];
    [aCoder encodeObject:self.images forKey:@"images"];
    [aCoder encodeObject:self.Describe forKey:@"Describe"];
    [aCoder encodeObject:self.Actegories forKey:@"Actegories"];
    
    [aCoder encodeObject:self.Oper_flag forKey:@"Oper_flag"];
    [aCoder encodeObject:self.Warningrecordsn forKey:@"Warningrecordsn"];
    [aCoder encodeObject:self.AFmaintenance forKey:@"AFmaintenance"];
}
////设置默认选择
//- (BOOL)isSelect
//{
//    return NO;
//}
@end
