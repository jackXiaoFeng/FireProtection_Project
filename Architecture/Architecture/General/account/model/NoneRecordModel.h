//
//  NoneRecordModel.h
//  Architecture
//
//  Created by xiaofeng on 2017/11/17.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoneRecordModel : MTLModel <MTLJSONSerializing>


//Count = 1;
//Eqname = "\U5de1\U68c0\U70b91F";
//Floorsn = 1F;
//Number = 2;
//"Oper_flag" = 1;
//page = 1;

@property (nonatomic,strong)NSString *Count;
@property (nonatomic,strong)NSString *Eqname;
@property (nonatomic,strong)NSString *Floorsn;
@property (nonatomic,strong)NSString *Number;
@property (nonatomic,strong)NSString *Oper_flag;
@property (nonatomic,strong)NSString *page;


@end
