//
//  AppDelegate.h
//  BaseProject
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) YSBaseNavigationController *mainNav;
@property (strong, nonatomic)YSTabBarViewController *tabBar;
@end

