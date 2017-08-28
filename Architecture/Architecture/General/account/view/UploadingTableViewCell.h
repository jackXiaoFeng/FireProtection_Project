//
//  UploadingTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadingModel.h"

@interface UploadingTableViewCell : UITableViewCell
+ (CGFloat)UploadingCellHeight;

@property (nonatomic ,strong)UploadingModel *UploadingMode;
@property(assign,nonatomic)BOOL hidenLine;

@end
