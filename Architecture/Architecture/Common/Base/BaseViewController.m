//
//  BaseViewController.m
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark – life circle

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication ] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.view bringSubviewToFront:self.navBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DEF_COLOR_RGB(248, 248, 248);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;

   
    self.navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_NAVIGATIONBAR_HEIGHT)];
    self.navBar.backgroundColor = DEF_APP_MAIN_COLOR;
    self.navBar.alpha = 1;
    [self.view addSubview:self.navBar];
    
    UIImageView *navImageView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"nav_image")];
    navImageView.frame = CGRectMake(0, 0, self.navBar.width, self.navBar.height);
    [self.navBar addSubview:navImageView];
    
    self.titleLb = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, DEF_DEVICE_WIDTH - 60*2, 44)];
    self.titleLb.textColor = [UIColor whiteColor];//DEF_COLOR_FF6704;
    self.titleLb.backgroundColor = [UIColor clearColor];
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    self.titleLb.font = DEF_MyBoldFont(18.0);
    [self.navBar addSubview:self.titleLb];
    
    self.leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, 52, 36)];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_Back"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    self.leftBtn.imageView.contentMode = UIViewContentModeCenter;
    [self.leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = DEF_MyFont(14.0f);
    [self.navBar addSubview:self.leftBtn];
    
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.navBar.width - 47, 25, 52, 36)];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.imageView.contentMode = UIViewContentModeCenter;
    self.rightBtn.titleLabel.font = self.leftBtn.titleLabel.font;
    self.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:self.rightBtn];
    self.rightBtn.hidden = YES;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBar.height - 0.5, self.navBar.width, 0.5)];
    [self.navBar addSubview:self.lineView];
    self.lineView.backgroundColor = [UIColor clearColor];
    
    if (self.navigationController.visibleViewController == DEF_MyAppDelegate.tabBar) {
        //是tabBar 的viewcontroller 左边按钮隐藏
        self.leftBtn.hidden = YES;
    }else
    {
        //是tabBar 的viewcontroller 左边按钮隐藏
        self.leftBtn.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  左边按钮响应方法
 */
-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  右边按钮响应方法
 */
-(void)rightBtnClick
{
    
}

/**
 *	@brief	重写系统title方法
 *
 *	@param 	title 	标题
 *
 *	@return
 */
- (void)setTitle:(NSString *)title
{
    if (self.navigationController.visibleViewController == DEF_MyAppDelegate.tabBar) {
        self.tabBarController.title = title;
    }else
    {
        super.title = title;
    }
}

/**
 *	@brief	通用navigation 右边按钮 有图片
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    响应方法
 *	@param 	imageStr 	图片名称
 *
 *	@return	BarButtonItem
 */
- (UIBarButtonItem *)navRightBackBtn:(id)_target action:(SEL)selector imageStr:(NSString *)imageStr
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(280, 0, 50, 18);
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

/**
 *	@brief	通用navigation 右边按钮 文字
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    响应方法
 *	@param 	title 	    按钮名称
 *
 *	@return	BarButtonItem
 */
- (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(270, 0, 50, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = DEF_DOWN_NAVIGATION_TITLEFOUNT;
    
    [btn setTitleColor:DEF_DOWN_NAVIGATION_TITLECOLOER forState:UIControlStateNormal];
    [btn setTitleColor:DEF_DOWN_NAVIGATION_TITLECOLOER forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

@end
