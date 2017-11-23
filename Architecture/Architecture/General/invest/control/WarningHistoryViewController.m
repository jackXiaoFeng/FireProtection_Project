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
#import "WarningHistoryViewModel.h"

@interface WarningHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
    @property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) WarningHistoryModel *model;
@property (nonatomic, strong) WarningHistoryViewModel *viewModel;

@end

@implementation WarningHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"告警历史记录";

    self.tableView.backgroundColor = [UIColor clearColor];
    
    //添加刷新
    self.viewModel  = [[WarningHistoryViewModel alloc]init];
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
        
        return self.viewModel.warningHistoryList;
        
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
        
        BOOL hidden;
        if (self.viewModel.warningHistoryList.count == 0) {
            hidden = NO;
        }else
        {
            hidden = self.tableView.contentSize.height > self.tableView.height?NO:YES;
        }
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
        
        return self.viewModel.warningHistoryList;
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    NSArray *nameArray = @[@"时间",@"设备信息",@"状态",@"处理时间",@"处理人"];
    
    NSArray *widthArray = @[
                            @(DEF_DEVICE_SCLE_WIDTH(134)),
                            @(DEF_DEVICE_SCLE_WIDTH(174)),
                            @(DEF_DEVICE_SCLE_WIDTH(134)),
                            @(DEF_DEVICE_SCLE_WIDTH(171)),
                            @(DEF_DEVICE_SCLE_WIDTH(140))];
    NSArray *xArray = @[@0,
                        @(DEF_DEVICE_SCLE_WIDTH(134)),
                        @(DEF_DEVICE_SCLE_WIDTH(134)+DEF_DEVICE_SCLE_WIDTH(174)),
                        @(DEF_DEVICE_SCLE_WIDTH(134)+DEF_DEVICE_SCLE_WIDTH(174)+DEF_DEVICE_SCLE_WIDTH(134)),
                        @(DEF_DEVICE_SCLE_WIDTH(134)+DEF_DEVICE_SCLE_WIDTH(174)+DEF_DEVICE_SCLE_WIDTH(134)+DEF_DEVICE_SCLE_WIDTH(171))
                        ];
    
    [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        NSNumber *xNumber = xArray[idx];
        CGFloat lab_x = xNumber.floatValue;
        
        //设置 title 区域
        UILabel *titleLabel = [[UILabel alloc] init];
        //CGFloat lab_x = (tableView.contentSize.width/4)*idx;
        NSNumber *numberWidth = widthArray[idx];
        CGFloat width = numberWidth.floatValue;
        titleLabel.frame = CGRectMake(lab_x, 0,width, DEF_DEVICE_SCLE_HEIGHT(75));
        //设置 title 文字内容
        titleLabel.text =nameArray[idx];
        //设置 title 颜色
        titleLabel.textColor =  DEF_COLOR_RGB(67, 67, 67);
        titleLabel.backgroundColor =  [UIColor whiteColor];
        //titleLabel.font = DEF_MyFont(15);
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        titleLabel.textAlignment =  NSTextAlignmentCenter;
        view.backgroundColor = COLOR_APP_CELL_LINE;
        [view addSubview:titleLabel];
        
    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //设置 title 区域高度
    return DEF_DEVICE_SCLE_HEIGHT(78);
}

#pragma mark - delegate  dataSource -
        
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return [WarningHistoryTableViewCell warningHistoryCellHeight];
    }
    
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.warningHistoryList.count;
;
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
        
        if (self.viewModel.warningHistoryList.count > 0) {
            cell.WarningHistoryModel  = self.viewModel.warningHistoryList[indexPath.row];
            cell.hidenLine= (indexPath.row== self.viewModel.warningHistoryList.count-1); //通过组模型数组来拿到每组最后一行
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

@end
