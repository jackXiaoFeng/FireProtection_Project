//
//  EquipmentWarningViewModel.h
//  Architecture
//
//  Created by xiaofeng on 17/9/6.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EquipmentWarningModel.h"

@interface EquipmentWarningViewModel : BaseViewModel


//申请检修状态
//0:正常
//1:故障
//2:需维修
//3:等待复归
//4:申请复归

/**
 * 设备告警信息数组
 */
@property (nonatomic, strong)NSMutableArray *equipmentList;


/**
 * model
 */
@property (nonatomic, strong)EquipmentWarningModel *equipmentWarningModel;

/**
 * 请求数据内容
 */
-(id)initWithParametersDic:(NSDictionary *)dic;


/**
 *  获取用户下拉刷新或者上提加载更多函数
 *
 *  @param loadType LoadData 下拉刷新 LoadMore 上提加载更多
 *  @param urlType  接口类型
 *  @param filmId   影片ID
 *
 *  @return RACSignal
 */
-(RACSignal *)feedDataWithType:(LoadType)loadType;

@end
