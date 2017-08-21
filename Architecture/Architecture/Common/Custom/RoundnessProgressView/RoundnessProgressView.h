//
//  RoundnessProgressView.h
//  Demo
//
//  Created by WanHongQiong on 15/7/13.
//  Copyright (c) 2015年 xinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundnessProgressView : UIView
/**
 * 总数
 */
@property (assign, nonatomic) NSInteger progressTotal;

/**
 * 已完成
 */
@property (assign, nonatomic) NSInteger progressSections;

/**
 * 画笔大小
 */
@property (assign, nonatomic) NSInteger thicknessWidth;

/**
 * 总进度条颜色
 */
@property (strong, nonatomic) UIColor *completedColor;

/**
 * 已完成进度颜色
 */
@property (strong, nonatomic) UIColor *incompletedColor;

/**
 * 是否需要显示label
 */
@property (assign, nonatomic) BOOL isShowLabel;


/**
 * 字体颜色
 */
@property (strong, nonatomic) UIColor *labelColor;

@end
