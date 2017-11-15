//
//  ApplicationForInspectionViewController.h
//  Architecture
//
//  Created by xiaofeng on 2017/11/14.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationForInspectionViewController : BaseViewController


/**
 *  更新头像
 *
 *  @param headImage
 *
 *  @return 更新头像信号
 */
- (RACSignal *)updateHeadImage:(UIImage *)headImage;
@end
