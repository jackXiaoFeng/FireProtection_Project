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
#import "MalfunctionEquipmentViewModel.h"


@interface MalfunctionEquipmentViewController ()<UITableViewDelegate,UITableViewDataSource>
    
    @property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) MalfunctionEquipmentModel *model;
@property (nonatomic, strong) MalfunctionEquipmentViewModel *viewModel;
@end


@implementation MalfunctionEquipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"故障设备复归";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //添加刷新
    self.viewModel  = [[MalfunctionEquipmentViewModel alloc]init];
    //首次刷新数据
    [self headerWithRefreshing];
    //mj刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerWithRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footerWithRefreshing];
    }];
}

- (void)headerWithRefreshing
{
    @weakify(self)
    [[[[self.viewModel feedDataWithType:LoadData] map:^id(NSDictionary * dic) {
        @strongify(self);
        
        [CMUtility removeFailViewWith:self.view];
        
        return self.viewModel.malfunctionList;
        
    }] map:^id(NSMutableArray *arr) {
        if ([arr count] < 10) {
            return @(YES);
        }else{
            return @(NO);
        }
    }] subscribeNext:^(id x) {
        @strongify(self);
        //            self.footer.hidden = [x boolValue];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        BOOL hidden = self.tableView.contentSize.height > self.tableView.height?NO:YES;
        //数据不超出屏幕不显示foot
        self.tableView.mj_footer.hidden = hidden;
        //最后一页加提示语
        if ([x boolValue]) {
            //提示没有更多的数据
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } error:^(NSError *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [CMUtility createHttpRequestFailViewWithView:self.view].rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            [self.tableView.mj_header beginRefreshing];
            return [RACSignal empty];
        }];
    }];
}

- (void)footerWithRefreshing
{
    @weakify(self)
    [[[[self.viewModel feedDataWithType:LoadMore] map:^id(NSDictionary * dic) {
        
        [CMUtility removeFailViewWith:self.view];
        
        return self.viewModel.malfunctionList;
    }] map:^id(NSMutableArray * arr) {
        return @([arr count] % 10 != 0 ? YES : NO);
    }] subscribeNext:^(id x) {
        @strongify(self);
        //            self.footer.hidden = [x boolValue];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        BOOL hidden = self.tableView.contentSize.height > self.tableView.height?NO:YES;
        //数据不超出屏幕不显示foot
        self.tableView.mj_footer.hidden = hidden;
        //最后一页加提示语
        if ([x boolValue]) {
            //提示没有更多的数据
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }error:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [CMUtility createHttpRequestFailViewWithView:self.view].rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            [self.tableView.mj_footer beginRefreshing];
            return [RACSignal empty];
        }];
    }];
}

#pragma mark - delegate  dataSource -
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return [MalfunctionEquipmentTableViewCell malfunctionEquipmentCellHeight];
    }
    
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.malfunctionList.count;
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
        //cell.hidenLine= (indexPath.row== group.items.count-1); //通过组模型数组来拿到每组最后一行
        if (self.viewModel.malfunctionList.count > 0) {
            MalfunctionEquipmentModel *model  = self.viewModel.malfunctionList[indexPath.row];
            [cell malfunctionEquipmentMode:model indexPath:indexPath];
            cell.hidenLine= (indexPath.row== self.viewModel.malfunctionList.count-1); //通过组模型数组来拿到每组最后一行
            
            @weakify(self);
            cell.fixBtnClickBlock = ^(NSIndexPath *indexPath){
                @strongify(self);
                [self cellClickIndexPath:indexPath];
            };
        }

        
        return cell;
    }
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)cellClickIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    MalfunctionEquipmentModel *model  = self.viewModel.malfunctionList[indexPath.row];
    model.AFmaintenance =@"2";
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    NSLog(@"===============%@",model.Describe);
    [[self.viewModel alarmEquipmentMaintenanceWithDegree:model.Degree] subscribeNext:^(NSString *str) {
        
        @strongify(self);
        //            if ([activityModel.isJoin integerValue] == 1) {
        //                self.isCanJoinActivity = 1;
        //                [self pushToSeatSelectionViewControllerWithIndexPath:indexPath];
        //
        //            }else {
        //                self.isCanJoinActivity = 2;
        //                [CMUtility showTips:@"当前用户不能参加此次活动"];
        //            }
    } error:^(NSError *error) {
        
    }];
    
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
