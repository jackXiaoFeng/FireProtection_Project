//
//  DetectionViewModel.h
//  Architecture
//
//  Created by xiaofeng on 2017/11/17.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetectionModel.h"

@interface DetectionViewModel : NSObject

/**
 * 扫描设备返回信息数组
 */
@property (nonatomic, strong)NSMutableArray *detectionList;


/**
 * model
 */
@property (nonatomic, strong)DetectionModel *detectionModel;
/**
 *  nfc扫描设备返回信息
 *
 *  @return RACSignal
 */

-(RACSignal *)nfcDetectionFromDegree:(NSString *)Degree;
@end
