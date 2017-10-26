//
//  PlanViewModel.h
//  Architecture
//
//  Created by xiaofeng on 17/9/12.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlanModel.h"

@interface PlanViewModel : BaseViewModel

/**
 * 巡检计划数组
 */
@property (nonatomic, strong)NSMutableArray *planList;


/**
 * model
 */
@property (nonatomic, strong)PlanModel *planModel;

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
