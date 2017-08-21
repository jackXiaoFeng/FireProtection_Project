//
//  MainTableViewCell.h
//  Architecture
//
//  Created by xiaofeng on 16/8/11.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainTableViewCell : UITableViewCell
+ (CGFloat)mainCellHeight;
@property (nonatomic ,strong)MainModel *mainModel;

@end
