//
//  MainViewController.m
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "MainViewController.h"
#import "SDCycleScrollView.h"
#import "MainTableViewCell.h"
#include "MainModel.h"
#import "EquipmentWarningViewController.h"

@interface MainViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

//轮播图
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong)UITableView *tableView;


@property (assign, nonatomic)int controlHeight;

@property (assign, nonatomic) NSInteger progressSections;

@end

@implementation MainViewController
{
    NSArray *_imagesURLStrings;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progressSections = 20;
    
    self.titleLb.text = @"巡检操作";
    self.view.backgroundColor = DEF_COLOR_RGB(248, 248, 248);
    
    [self.rightBtn setImage:DEF_IMAGENAME(@"scan") forState:UIControlStateNormal];
    self.rightBtn.hidden = NO;
    
    self.controlHeight = DEF_DEVICE_SCLE_HEIGHT(222);
    
    /*
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
    */
    
   [self.view addSubview:self.cycleScrollView];
    
    self.tableView.backgroundColor = DEF_COLOR_RGB(248, 248, 248);
    
    
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

- (void)rightBtnClick
{
    NSLog(@"二维码btn点击");
}

#pragma mark - delegate  dataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MainTableViewCell mainCellHeight];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"MainCellIdentify";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MainModel *model = [[MainModel alloc]init];
    model.progressSections = self.progressSections;
    model.row = indexPath.row;
    cell.mainModel = model;
    
    @weakify(self)
    cell.mainTablecellclick = ^(int index){
        @strongify(self)
        NSLog(@"index----%d-----",index);
        [self.tableView reloadData];
        
        UIViewController *controller;
        if (index == 1) {
            controller = [[EquipmentWarningViewController alloc]init];
        }else if (index == 2)
        {
            //controller = [[WarningHistoryViewController alloc]init];
        }
        [self.navigationController pushViewController:controller animated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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




#pragma mark - get -
-(SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        // 情景一：采用本地图片实现
        NSArray *imageNames = @[@"banner_image",@"banner_image",@"banner_image"];

        
        // 网络加载 --- 创建带标题的图片轮播器
       // _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, self.view.width, self.controlHeight) delegate:self placeholderImage:[UIImage imageNamed:@"bannerPlacehoder"]];
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, self.view.width, self.controlHeight) shouldInfiniteLoop:YES imageNamesGroup:imageNames];

        _cycleScrollView.autoScrollTimeInterval = 4.0;
        
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        //cycleScrollView2.titlesGroup = titles;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        
    }
    return _cycleScrollView;
}



#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT + self.controlHeight, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT - DEF_TABBAR_HEIGHT- self.controlHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        //_tableView.tableFooterView = [UIView new];
    }
    return _tableView;
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
