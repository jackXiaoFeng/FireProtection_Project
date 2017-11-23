//
//  UploadingModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadingModel : NSObject <NSCoding>
@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,strong)NSString *Eqname;
@property (nonatomic,strong)NSString *Floorsn;
@property (nonatomic,strong)NSString *timeT;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *State;
@property (nonatomic,strong)NSString *images;
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Actegories;


//@"Oper_flag":@1,//1，告警和设备模块 2，巡检模块
//@"Warningrecordsn":@"",//告警和设备模块需要加上这个字段
//@"AFmaintenance":@"4",//0正常巡检4申请检修
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *Warningrecordsn;
@property (nonatomic,strong)NSString *AFmaintenance;



- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)encodeWithCoder:(NSCoder *)aCoder;

+ (NSString *)filePath;

@end
