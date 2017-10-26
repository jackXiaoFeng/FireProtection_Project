//
//  PlanTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanModel.h"

@interface PlanTableViewCell : UITableViewCell
+ (CGFloat)PlanCellHeight;
@property (nonatomic ,strong)PlanModel *planModel;
@property(assign,nonatomic)BOOL hidenLine;
@end
