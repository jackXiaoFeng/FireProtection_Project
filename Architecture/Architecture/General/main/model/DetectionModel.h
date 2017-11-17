//
//  DetectionModel.h
//  Architecture
//
//  Created by xiaofeng on 2017/11/17.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetectionModel : MTLModel <MTLJSONSerializing>

//Eqname = "\U5de1\U68c0\U70b922F"; 设备名称
//Faulttypes = ""; 错误类型
//Floorsn = 22F; 楼层
//Standard = ""; 巡检要求


@property (nonatomic,strong)NSString *Eqname;
@property (nonatomic,strong)NSString *Faulttypes;
@property (nonatomic,strong)NSString *Floorsn;
@property (nonatomic,strong)NSString *Standard;

@end
