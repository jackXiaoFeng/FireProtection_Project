//
//  EquipmentWarningTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentWarningModel.h"

typedef void (^FixBtnClickBlock) (NSIndexPath *indexPath);

@interface EquipmentWarningTableViewCell : UITableViewCell
+ (CGFloat)equipmentWarningCellHeight;
@property (nonatomic ,strong)EquipmentWarningModel *equipmentWarningModel;

@property (nonatomic ,strong)EquipmentWarningModel *temEquipmentWarningModel;
@property(assign,nonatomic)BOOL hidenLine;

@property (nonatomic,copy) FixBtnClickBlock fixBtnClickBlock;

- (void)setEquipmentWarningModel:(EquipmentWarningModel *)equipmentWarningModel indexPath:(NSIndexPath *)indexPath;

@end
