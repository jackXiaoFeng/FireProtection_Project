//
//  InvestTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvestModel.h"

@interface InvestTableViewCell : UITableViewCell

+ (CGFloat)investCellHeight;
@property (nonatomic, copy) void(^InvestTableCellclick)(int);
@property (nonatomic ,strong)InvestModel *investModel;

@end
