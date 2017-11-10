//
//  CustomDefine.h
//  MoviesStore 2.0
//
//  Created by caimiao on 15/5/19.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#ifndef MoviesStore_2_0_CustomDefine_h
#define MoviesStore_2_0_CustomDefine_h

/**
 *适配
 */
#define DEF_RESIZE_UI(float)                   ((float)/375.0f*DEF_DEVICE_WIDTH)
#define DEF_RESIZE_UI_Landscape(float)         ((float)/375.0f*DEF_DEVICE_HEIGHT)

#define DEF_RESIZE_FRAME(frame)      CGRectMake(DEF_RESIZE_UI (frame.origin.x), DEF_RESIZE_UI (frame.origin.y), DEF_RESIZE_UI (frame.size.width), DEF_RESIZE_UI (frame.size.height))
#define DEF_AGAINST_RESIZE_UI(float) (float/DEF_DEVICE_WIDTH*320)

/**
 *创建controller
 */
#define DEF_VIEW_CONTROLLER_INIT(controllerName) [[NSClassFromString(controllerName) alloc] init]

/**
 *推controller
 */
#define DEF_PUSH_VIEW_CONTROLLER(name)          UIViewController *vc = DEF_VIEW_CONTROLLER_INIT(name); [DEF_MyAppDelegate.mainNav pushViewController:vc animated:YES];
#define DEF_PUSH_VIEW_CONTROLLER_WITH_XIB(name) UIViewController *vc = DEF_VIEW_CONTROLLER_INIT_WITH_XIB(name); [DEF_MyAppDelegate.mainNav pushViewController:vc animated:YES];

/**
 *字符串去左右空格
 */
#define DEF_DROP_WHITESPACE(x) [x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

/**
 *字体
 */
#define DEF_MyFont(x)     [UIFont systemFontOfSize:x]
#define DEF_MyBoldFont(x) [UIFont boldSystemFontOfSize:x]

/**
 *设置图片
 */
#define DEF_IMAGENAME(name)         [UIImage imageNamed:name]
#define DEF_BUNDLE_IMAGE(name,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]]

/**
 *根据RGB获取color
 */
#define DEF_COLOR_RGBA(r,g,b,a)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DEF_COLOR_RGB(r,g,b)         [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define DEF_UICOLORFROMRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *获取AppDelegate
 */
#define DEF_MyAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define BLOCK_SAFE(block)           if(block)block


/**
 *获取APP当前版本号
 */
#define DEF_AppCurrentVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


/**
 *获取APP当前版本号
 */
#define DEF_App_BundleId [[NSBundle mainBundle] bundleIdentifier]
/**
 *Document路径
 */
#define DEF_DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 *NSUserDefault
 */
#define DEF_UserDefaults [NSUserDefaults standardUserDefaults]

/**
 *获取屏幕宽高
 */
#define DEF_DEVICE_WIDTH                [UIScreen mainScreen].bounds.size.width
#define DEF_DEVICE_HEIGHT               (DEF_IOS7 ? [UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.height - 20)
#define DEF_CONTENT_INTABBAR_HEIGHT     (DEF_IOS7 ? ([UIScreen mainScreen].bounds.size.height - 49):([UIScreen mainScreen].bounds.size.height - 69))

#define DEF_STATUS_HEIGHT        [[UIApplication sharedApplication] statusBarFrame].size.height


#define DEF_NAVIGATIONBAR_HEIGHT        ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)
#define DEF_TABBAR_HEIGHT               ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

//比例 根据标注图尺寸计算
#define DEF_DEVICE_SCLE_WIDTH(width) DEF_DEVICE_WIDTH*width/750

#define DEF_DEVICE_SCLE_HEIGHT(height) DEF_DEVICE_HEIGHT*height/1334

/**
 *获取iphone
 */
#define DEF_DEVICE_Iphone6p              (([[UIScreen mainScreen] bounds].size.height-736)?NO:YES)
#define DEF_DEVICE_Iphone6               (([[UIScreen mainScreen] bounds].size.height-667)?NO:YES)
#define DEF_DEVICE_Iphone5               (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define DEF_DEVICE_Iphone4               (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)

//app常用功能
#define DEF_APP_NAME    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define DEF_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define DEF_APP_OS      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"DTPlatformVersion"]

//Tim添加，计算二级页面的content的高度
#define DEF_CONTENT_WITHOUTTABBAR_HEIGHT (DEF_IOS7 ? ([UIScreen mainScreen].bounds.size.height - 64):([UIScreen mainScreen].bounds.size.height - 84))

/**
 *所有类型转化成String(防止出现nill值显示在UI)
 */
#define DEF_OBJECT_TO_STIRNG(object) ((object && (object != (id)[NSNull null]) && (![object isEqualToString:@"null"]) && (![object isEqualToString:@"Null"]) && (![object isEqualToString:@"NULL"]))?([object isKindOfClass:[NSString class]]?object:[NSString stringWithFormat:@"%@",object]):@"")

/* *
 *iOS版本
 */
#define DEF_IOS7         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define DEF_IOS7Dot0     ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0 ? YES : NO)
#define DEF_IOS8         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

/**
 *设备方向
 */
#define DEF_Portrait            ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait ? YES : NO)
#define DEF_PortraitUpsideDown  ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown ? YES : NO)
#define DEF_LandscapeLeft       ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft ? YES : NO)
#define DEF_LandscapeRight      ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight ? YES : NO)

/**
 * app应用商店url
 */

#define CM_APP_ID @"1057512037"

#define CM_GRADE_URL DEF_IOS7?[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",CM_APP_ID]:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",CM_APP_ID]                    //评分
/**
 *  推送极光推送的开关
 */
#define SwitchOfJPush @"ON"

/**
 *  app切换前后端时，视频播放需要接收的通知
 */
#define N_APP_ReActive              @"N_APP_ReActive"
#define N_APP_ResignActive          @"N_APP_ResignActive"

/**
 *  添加登录成功后的通知，方便成功后的处理
 */
#define N_Login_Success         @"N_Login_Success"
#endif
