//
//  PollingCompleteModel.h
//  Architecture
//
//  Created by xiaofeng on 2017/11/15.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PollingCompleteModel : MTLModel <MTLJSONSerializing>

//Complete = 0;
//Odate = 1510873200;
//Sdate = 1509490800;
//Type = 3;
//Unfinishe = 100;

@property (nonatomic,strong)NSString *Complete;
@property (nonatomic,strong)NSString *Odate;
@property (nonatomic,strong)NSString *Sdate;
@property (nonatomic,strong)NSString *Type;
@property (nonatomic,strong)NSString *Unfinishe;

@end
