//
//  UploadingViewModel.h
//  Architecture
//
//  Created by xiaofeng on 2017/11/16.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadingModel.h"
@interface UploadingViewModel : BaseViewModel

/**
 * 3.32    [xs032]上传巡检记录
 */
@property (nonatomic, strong)NSMutableArray *uploadingList;


/**
 * model
 */
@property (nonatomic, strong)UploadingModel *uploadingModel;

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

-(RACSignal *)uploadingDataWithUploadingModel:(NSArray *)modelArray;

-(RACSignal *)uploadingDataWithModel:(UploadingModel *)uploadingModel;
@end
