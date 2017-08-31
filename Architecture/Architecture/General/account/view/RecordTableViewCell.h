//
//  RecordTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface RecordTableViewCell : UITableViewCell
+ (CGFloat)RecordCellHeight;

@property (nonatomic ,strong)RecordModel *RecordMode;
@property(assign,nonatomic)BOOL hidenLine;

@end
