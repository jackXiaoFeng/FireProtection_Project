//
//  TabBarViewController.m
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainViewController.h"
#import "InvestViewController.h"
#import "AccountViewController.h"
#import "MoreViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setupChildControllers];
    
    self.tabbarItemIndex = 0;
    
}

-(void)setupChildControllers{
    // 添加电影
    UIViewController *HomeVc = DEF_VIEW_CONTROLLER_INIT(@"MainViewController");
    [self addChildVCWith:HomeVc title:@"首页" nmlImgName:@"icon_film" selImgName:@"icon_film_selected"];
    
    //添加影院
    UIViewController *CinemaVc = DEF_VIEW_CONTROLLER_INIT(@"InvestViewController");
    [self addChildVCWith:CinemaVc title:@"投资" nmlImgName:@"icon_cinema" selImgName:
     @"icon_cinema_selected"];
    
    //添加发现
    UIViewController *OrderVc = DEF_VIEW_CONTROLLER_INIT(@"AccountViewController");
    [self addChildVCWith:OrderVc title:@"账户" nmlImgName:@"icon_Activity" selImgName:@"icon_Activity_selected"];
    
    //添加我的
    UIViewController *MineVc = DEF_VIEW_CONTROLLER_INIT(@"MoreViewController");
    [self addChildVCWith:MineVc title:@"更多" nmlImgName:@"icon_my" selImgName:@"icon_my_selected"];
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
 }

-(void)addChildVCWith:(UIViewController *)vc title:(NSString *)title nmlImgName:(NSString *)nmlImgName selImgName:(NSString *)selImgName {
    
    
    [self addChildViewController:vc];
    //设置标题
    vc.tabBarItem.title = title;
    
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           DEF_APP_MAIN_COLOR, NSForegroundColorAttributeName,
                                           nil] forState:UIControlStateSelected];
    
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIColor grayColor], NSForegroundColorAttributeName,
                                           nil] forState:UIControlStateNormal];
    
    //设置普通状态图片
    vc.tabBarItem.image = [UIImage imageNamed:nmlImgName];
    UIImage *selImg = [UIImage imageNamed:selImgName];
    selImg = [selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selImg;
}

#pragma mark - tabbar delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    //判断是否登录，未登录则弹出登录框
//    if (!CMMemberEntity.isLogined && [viewController isKindOfClass:[CMMineViewController class]]) {
//        HPWLoginViewController *loginVC = [[HPWLoginViewController alloc]init];
//        CMBaseNavigationController *nav = [[CMBaseNavigationController alloc]initWithRootViewController:loginVC];
//        [DEF_MyAppDelegate.mainNav presentViewController:nav animated:YES completion:nil];
//        _tabbarItemIndex = 3;
//        return NO;
//    }
    
    _tabbarItemIndex = [tabBarController.viewControllers indexOfObject:viewController];
    
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
