//
//  WarningHistoryTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WarningHistoryModel.h"

@interface WarningHistoryTableViewCell : UITableViewCell
+ (CGFloat)warningHistoryCellHeight;

@property (nonatomic ,strong)WarningHistoryModel *WarningHistoryModel;
@property(assign,nonatomic)BOOL hidenLine;

@end
