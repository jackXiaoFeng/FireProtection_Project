//
//  EquipmentViewModel.h
//  Architecture
//
//  Created by xiaofeng on 17/9/12.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EquipmentModel.h"

@interface EquipmentViewModel : BaseViewModel

/**
 * 3.12	[xs012]设备列表
 */
@property (nonatomic, strong)NSMutableArray *equipmentList;


/**
 * model
 */
@property (nonatomic, strong)EquipmentModel *equipmentModel;

/**
 * 请求数据内容
 */
//-(id)initWithParametersDic:(NSDictionary *)dic;


/**
 *  获取用户下拉刷新或者上提加载更多函数
 *
 *  @param loadType LoadData 下拉刷新 LoadMore 上提加载更多
 *
 *  @return RACSignal
 */
-(RACSignal *)feedDataWithType:(LoadType)loadType;

@end
