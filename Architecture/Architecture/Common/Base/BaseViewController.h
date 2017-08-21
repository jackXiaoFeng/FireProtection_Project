//
//  BaseViewController.h
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  nav背景视图
 */
@property (nonatomic, strong)UIView *navBar;

/**
 *  nav 左边按钮
 */
@property (nonatomic, strong)UIButton *leftBtn;

/**
 *  nav 右边按钮
 */
@property (nonatomic, strong)UIButton *rightBtn;

/**
 *  nav 标题
 */
@property (nonatomic, strong)UILabel *titleLb;

/**
 *  nav 下划线
 */
@property (nonatomic, strong)UIView *lineView;

/**
 *  返回按钮方法
 */
-(void)leftBtnClick;

/**
 *  右边按钮响应方法
 */
-(void)rightBtnClick;

/**
 *	@brief	通用navigation 右边按钮 有图片
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    响应方法
 *	@param 	imageStr 	图片名称
 *
 *	@return	BarButtonItem
 */
- (UIBarButtonItem *)navRightBackBtn:(id)_target action:(SEL)selector imageStr:(NSString *)imageStr;

/**
 *	@brief	通用navigation 右边按钮 文字
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    响应方法
 *	@param 	title 	    按钮名称
 *
 *	@return	BarButtonItem
 */
- (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector;


@end
