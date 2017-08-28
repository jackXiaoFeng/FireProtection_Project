//
//  FixRecordTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixRecordModel.h"

@interface FixRecordTableViewCell : UITableViewCell
+ (CGFloat)fixRecordCellHeight;

@property (nonatomic ,strong)FixRecordModel *FixRecordModel;
@property(assign,nonatomic)BOOL hidenLine;

@end
