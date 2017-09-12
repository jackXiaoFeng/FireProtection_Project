//
//  MalfunctionEquipmentViewModel.h
//  Architecture
//
//  Created by xiaofeng on 17/9/7.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MalfunctionEquipmentModel.h"

@interface MalfunctionEquipmentViewModel : BaseViewModel

/**
 * 故障设备复归数组
 */
@property (nonatomic, strong)NSMutableArray *malfunctionList;


/**
 * model
 */
@property (nonatomic, strong)MalfunctionEquipmentModel *malfunctionEquipmentModel;


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



/**
 *  3.14	[xs014]故障设备复归确认或申请
 *
 *  @param degree 设备编号
 *
 *  @return RACSignal
 */
-(RACSignal *)alarmEquipmentMaintenanceWithDegree:(NSString *)degree;


@end
