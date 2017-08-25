//
//  WarningHistoryViewController.m
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "WarningHistoryViewController.h"
#import "WarningHistoryTableViewCell.h"
#import "WarningHistoryModel.h"
@interface WarningHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
    @property (nonatomic, strong)UITableView *tableView;

@end

@implementation WarningHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"告警历史记录";

    self.tableView.backgroundColor = [UIColor clearColor];

}

#pragma mark - delegate  dataSource -
        
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return [WarningHistoryTableViewCell warningHistoryCellHeight];
    }
    
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *cellIdentify = @"WarningHistoryTableViewCellIdentify";
        WarningHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[WarningHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.hidenLine= (indexPath.row== 5-1); //通过组模型数组来拿到每组最后一行

        return cell;
    }
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    
#pragma mark - get
- (UITableView *)tableView
    {
        if (!_tableView) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
            _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            _tableView.delegate =self;
            _tableView.dataSource = self;
            
            /*
             //cell 线左对齐
             if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
             
             [_tableView setSeparatorInset:UIEdgeInsetsZero];
             }
             
             if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
             
             [_tableView setLayoutMargins:UIEdgeInsetsZero];
             }
             */
            [self.view addSubview:_tableView];
            
            _tableView.tableFooterView = [UIView new];
            
 }
        return _tableView;
}

@end
