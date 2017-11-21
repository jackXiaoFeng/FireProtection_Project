//
//  DetectionViewController.h
//  Architecture
//
//  Created by xiaofeng on 2017/10/31.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

//NFC扫描弹窗
//0:3个按钮：确认巡检，申请检修，取消
//1:2个按钮：确认巡检，取消
//2:2个按钮：申请检修，取消
typedef enum {
    NFC_DETECTION_WARNING,
    NFC_DETECTION_POLLING,
    NFC_DETECTION_DEVICE
} NFC_DETECTION_STATUS;


@interface DetectionViewController : BaseViewController
@property (nonatomic, assign) NFC_DETECTION_STATUS nfcDetectionStatus;

@end
