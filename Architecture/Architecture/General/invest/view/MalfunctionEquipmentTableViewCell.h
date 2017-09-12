//
//  MalfunctionEquipmentTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MalfunctionEquipmentModel.h"
typedef void (^FixBtnClickBlock) (NSIndexPath *indexPath);


@interface MalfunctionEquipmentTableViewCell : UITableViewCell
+ (CGFloat)malfunctionEquipmentCellHeight;
    
@property (nonatomic ,strong)MalfunctionEquipmentModel *malfunctionEquipmentMode;
@property(assign,nonatomic)BOOL hidenLine;
@property (nonatomic,copy) FixBtnClickBlock fixBtnClickBlock;

- (void)malfunctionEquipmentMode:(MalfunctionEquipmentModel *)malfunctionEquipmentMode indexPath:(NSIndexPath *)indexPath;

@end
