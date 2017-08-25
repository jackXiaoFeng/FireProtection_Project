//
//  EquipmentTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentModel.h"
@interface EquipmentTableViewCell : UITableViewCell
+ (CGFloat)equipmentCellHeight;
@property (nonatomic ,strong)EquipmentModel *equipmentModel;
@property(assign,nonatomic)BOOL hidenLine;
@end
