//
//  YSBaseNavigationController.h
//  MyProject
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSBaseNavigationController : UINavigationController<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property(nonatomic,weak) UIViewController* currentShowVC;//防止一次触发多个手势时造成navigationBar的错乱甚至崩溃


@end
