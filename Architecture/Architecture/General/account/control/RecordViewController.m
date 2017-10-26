//
//  RecordViewController.m
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordTableViewCell.h"
#import "RecordModel.h"
#import "RecordViewModel.h"

@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) RecordModel *model;
@property (nonatomic, strong) RecordViewModel *viewModel;
@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"巡检计划";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //添加刷新
    self.viewModel  = [[RecordViewModel alloc]init];
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
        
        return self.viewModel.recordList;
        
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
        
        return self.viewModel.recordList;
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
    return [RecordTableViewCell RecordCellHeight];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.recordList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"RecordTableViewCellIdentify";
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[RecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.viewModel.recordList.count > 0) {
        cell.RecordMode  = self.viewModel.recordList[indexPath.row];
        cell.hidenLine= (indexPath.row== self.viewModel.recordList.count-1); //通过组模型数组来拿到每组最后一行
    }

    
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
