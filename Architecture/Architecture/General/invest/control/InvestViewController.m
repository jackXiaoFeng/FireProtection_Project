//
//  InvestViewController.m
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "InvestViewController.h"
#import "InvestTableViewCell.h"
#import "InvestModel.h"

#import "EquipmentWarningViewController.h"
#import "WarningHistoryViewController.h"
#import "MalfunctionEquipmentViewController.h"
#import "DetectionViewController.h"

@interface InvestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation InvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"告警";
    
    [self.rightBtn setImage:DEF_IMAGENAME(@"scan") forState:UIControlStateNormal];
    self.rightBtn.hidden = NO;

    self.tableView.backgroundColor = [UIColor clearColor];
    CGFloat headviewHeight = DEF_DEVICE_SCLE_HEIGHT(16);
    UIView *headView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, headviewHeight)];
    headView.backgroundColor = DEF_COLOR_RGB(237, 237, 237);
    self.tableView.tableHeaderView = headView;
}
- (void)rightBtnClick
{
    NSLog(@"二维码btn点击");
    DetectionViewController *controller = [[DetectionViewController alloc]init];
    controller.nfcDetectionStatus = NFC_DETECTION_AFFIRNM;
    [self.navigationController pushViewController:controller animated:YES];
    
}
#pragma mark - delegate  dataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InvestTableViewCell investCellHeight];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"InvestCellIdentify";
    InvestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[InvestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    InvestModel *model = [[InvestModel alloc]init];
    model.row = indexPath.row;
    cell.investModel = model;
    
    @weakify(self)
    cell.InvestTableCellclick = ^(int index){
        @strongify(self)
        NSLog(@"index----%d-----",index);
        //[self.tableView reloadData];
        
        UIViewController *controller;
        if (index == 1) {
            controller = [[EquipmentWarningViewController alloc]init];
        }else if (index == 2)
        {
            controller = [[WarningHistoryViewController alloc]init];
        }else if (index == 3)
        {
            controller = [[MalfunctionEquipmentViewController alloc]init];
        }
        [self.navigationController pushViewController:controller animated:YES];

    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UIViewController *controller;
//    controller = [[MalfunctionEquipmentViewController alloc]init];
//    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT , DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT - DEF_TABBAR_HEIGHT) style:UITableViewStylePlain];
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


@end
