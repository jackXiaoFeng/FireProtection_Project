//
//  NoneRecordTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 2017/11/17.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoneRecordModel.h"

@interface NoneRecordTableViewCell : UITableViewCell
+ (CGFloat)NoneRecordHeight;
@property (nonatomic ,strong)NoneRecordModel *noneRecordModel;
@property(assign,nonatomic)BOOL hidenLine;
@end
