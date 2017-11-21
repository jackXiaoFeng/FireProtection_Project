//
//  EquipmentTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentModel.h"
typedef void (^FixBtnClickBlock) (NSIndexPath *indexPath);

@interface EquipmentTableViewCell : UITableViewCell
+ (CGFloat)equipmentCellHeight;
@property (nonatomic ,strong)EquipmentModel *equipmentModel;
@property (nonatomic ,strong)EquipmentModel *tmpEquipmentModel;

@property(assign,nonatomic)BOOL hidenLine;

@property (nonatomic,copy) FixBtnClickBlock fixBtnClickBlock;

- (void)setEquipmentModel:(EquipmentModel *)equipmentModel indexPath:(NSIndexPath *)indexPath;

@end
