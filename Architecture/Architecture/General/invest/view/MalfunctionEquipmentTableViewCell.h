//
//  MalfunctionEquipmentTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MalfunctionEquipmentModel.h"

@interface MalfunctionEquipmentTableViewCell : UITableViewCell
+ (CGFloat)malfunctionEquipmentCellHeight;
    
@property (nonatomic ,strong)MalfunctionEquipmentModel *malfunctionEquipmentMode;
@property(assign,nonatomic)BOOL hidenLine;

@end
