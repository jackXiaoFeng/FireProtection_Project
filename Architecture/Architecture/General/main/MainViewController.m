//
//  MainViewController.m
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "MainViewController.h"
#import "DYMRollingBannerVC.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"

@interface MainViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;


@property (assign, nonatomic)int controlHeight;

@end

@implementation MainViewController
{
    NSArray *_imagesURLStrings;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"巡检操作";
    
    self.controlHeight = (self.view.height-DEF_NAVIGATIONBAR_HEIGHT-DEF_TABBAR_HEIGHT)/3;
    
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"http://img.zcool.cn/community/012913577243b50000018c1bc29917.jpg",
                                  @"http://img.zcool.cn/community/0188fd5699f69232f87574bed8dc90.jpg",
                                  @"http://img.zcool.cn/community/01a66457551b416ac72525aeeaa9cd.jpg",
                                  @"http://img.zcool.cn/community/01a2e056a4897132f875520ffc6c25.jpg"
                                  ];
    _imagesURLStrings = imagesURLStrings;
    // 模拟加载延迟
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });
    
    /*
     block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
     NSLog(@">>>>>  %ld", (long)index);
     };
     
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    //    [你的CycleScrollview adjustWhenControllerViewWillAppera];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}


/*
 
 // 滚动到第几张图回调
 - (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
 {
 NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
 }
 
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get -
-(SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        // 网络加载 --- 创建带标题的图片轮播器
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, self.view.width, self.controlHeight) delegate:self placeholderImage:[UIImage imageNamed:@"bannerPlacehoder"]];
        _cycleScrollView.autoScrollTimeInterval = 4.0;
        
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //cycleScrollView2.titlesGroup = titles;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self.view addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
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
