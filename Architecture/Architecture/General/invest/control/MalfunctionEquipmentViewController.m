//
//  MalfunctionEquipmentViewController.m
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "MalfunctionEquipmentViewController.h"
#import "MalfunctionEquipmentTableViewCell.h"
#import "MalfunctionEquipmentModel.h"

@interface MalfunctionEquipmentViewController ()<UITableViewDelegate,UITableViewDataSource>
    
    @property (nonatomic, strong)UITableView *tableView;

@end


@implementation MalfunctionEquipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"故障设备复归";
    self.tableView.backgroundColor = [UIColor clearColor];
    
}
    
#pragma mark - delegate  dataSource -
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return [MalfunctionEquipmentTableViewCell malfunctionEquipmentCellHeight];
    }
    
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *cellIdentify = @"MalfunctionEquipmentTableViewCellIdentify";
        MalfunctionEquipmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[MalfunctionEquipmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
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
