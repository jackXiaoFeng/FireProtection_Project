//
//  AccountViewController.m
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#define BTN_SPACE DEF_DEVICE_SCLE_WIDTH(25)

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"巡检";
    
    NSArray *nameArray = @[
                           @"巡检\n计划",
                           @"上传\n巡检",
                           @"巡检\n报表",
                           @"巡检\n记录",
                           @"设备\n信息"
                           ];
    
    NSArray *normalArray = @[
                           @"plan_normal",
                           @"uploading_normal",
                           @"statement_normal",
                           @"record_normal",
                           @"info_normal"
                           ];
    
    NSArray *selectedArray = @[
                               @"plan_selected",
                               @"uploading_selected",
                               @"statement_selected",
                               @"record_selected",
                               @"info_selected"
                            ];
    
    
    CGFloat btnWidth = (DEF_DEVICE_WIDTH - BTN_SPACE*(nameArray.count+1))/nameArray.count;
    
    
    @weakify(self)
    [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        CGFloat btnX = (BTN_SPACE + btnWidth)*idx + BTN_SPACE;
        btn.frame = CGRectMake(btnX, DEF_DEVICE_SCLE_HEIGHT(20) + DEF_NAVIGATIONBAR_HEIGHT, btnWidth, btnWidth);
        
        [btn setTitle:nameArray[idx] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:DEF_IMAGENAME(normalArray[idx]) forState:UIControlStateNormal];
        [btn setBackgroundImage:DEF_IMAGENAME(selectedArray[idx]) forState:UIControlStateSelected];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        btn.titleLabel.font = DEF_MyFont(15);
        btn.titleLabel.backgroundColor = [UIColor clearColor];
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        btn.titleLabel.lineBreakMode = 0;//这句话很重要，不加这句话加上换行符也没用
        
        btn.tag  = 100 + idx;
        [btn addTarget:self action:@selector(xunjianBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }];

    
    

    // Do any additional setup after loading the view.
}

- (void)xunjianBtnclick:(UIButton *)btn
{
    NSUInteger BtnTag = btn.tag;
    NSLog(@"btn----%lu",(unsigned long)BtnTag);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
