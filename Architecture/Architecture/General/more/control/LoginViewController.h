//
//  LoginViewController.h
//  Architecture
//
//  Created by xiaofeng on 17/8/30.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : BaseViewController
@property (nonatomic, copy) void (^completion)();

@end
