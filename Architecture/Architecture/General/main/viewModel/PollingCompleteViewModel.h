//
//  PollingCompleteViewModel.h
//  Architecture
//
//  Created by xiaofeng on 2017/11/15.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PollingCompleteModel.h"

@interface PollingCompleteViewModel : BaseViewModel

@property (nonatomic, strong)NSMutableArray *pollingCompleteList;


/**
 * model
 */
@property (nonatomic, strong)PollingCompleteModel *pollingCompleteModel;

/**
 *  巡检完成度
 *
 *  @return RACSignal
 */

-(RACSignal *)feedData;
@end
