//
//  EquipmentWarningViewController.m
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//
#define HeadView_height 100

#import "EquipmentWarningViewController.h"
#import "EquipmentWarningTableViewCell.h"
#import "EquipmentWarningModel.h"
#import "EquipmentWarningViewModel.h"
#import "DetectionViewController.h"


@interface EquipmentWarningViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) EquipmentWarningModel *model;
@property (nonatomic, strong) EquipmentWarningViewModel *viewModel;

@end

@implementation EquipmentWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"设备告警信息";
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //添加刷新
    self.viewModel  = [[EquipmentWarningViewModel alloc]init];
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
        
        return self.viewModel.equipmentList;
        
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
        if (self.viewModel.equipmentList.count == 0) {
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
        
        return self.viewModel.equipmentList;
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    NSArray *nameArray = @[@"时间",@"设备+地点",@"告警状态",@"操作"];
    
    NSArray *widthArray = @[
                            @(DEF_DEVICE_SCLE_WIDTH(134)),
                            @(DEF_DEVICE_SCLE_WIDTH(214)),
                            @(DEF_DEVICE_SCLE_WIDTH(164)),
                            @(DEF_DEVICE_SCLE_WIDTH(241))];
    NSArray *xArray = @[@0,
                            @(DEF_DEVICE_SCLE_WIDTH(134)),
                            @(DEF_DEVICE_SCLE_WIDTH(134)+DEF_DEVICE_SCLE_WIDTH(214)),
                            @(DEF_DEVICE_SCLE_WIDTH(134)+DEF_DEVICE_SCLE_WIDTH(214)+DEF_DEVICE_SCLE_WIDTH(164)),
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EquipmentWarningTableViewCell equipmentWarningCellHeight];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.equipmentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"EquipmentWarningCellIdentify11";
    EquipmentWarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[EquipmentWarningTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //cell.hidenLine= (indexPath.row== group.items.count-1); //通过组模型数组来拿到每组最后一行
    if (self.viewModel.equipmentList.count > 0) {
        EquipmentWarningModel *model  = self.viewModel.equipmentList[indexPath.row];
        [cell setEquipmentWarningModel:model indexPath:indexPath];
        cell.hidenLine= (indexPath.row== self.viewModel.equipmentList.count-1); //通过组模型数组来拿到每组最后一行
        
        @weakify(self);
        cell.fixBtnClickBlock = ^(NSIndexPath *indexPath){
            @strongify(self);
            EquipmentWarningModel *model = self.viewModel.equipmentList[indexPath.row];
            if (model.involutionOrRecondition.length > 0) {
                
            //fix_debug:暂时调试
                if ([model.involutionOrRecondition isEqualToString:FUGUI]) {
                    [self cellClickIndexPath:indexPath];
                }else if ([model.involutionOrRecondition isEqualToString:JIANXIU])
                {
//                    DetectionViewController *controller = [[DetectionViewController alloc]init];
//                    controller.nfcDetectionStatus = NFC_DETECTION_JIANXIU;
//                    [self.navigationController pushViewController:controller animated:YES];
                }else
                {
                    
                }
                 
            }
           
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
    EquipmentWarningModel *model  = self.viewModel.equipmentList[indexPath.row];
//    model.AFmaintenance =@"2";
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [[self.viewModel alarmEquipmentMaintenanceWithDegree:model.Degree] subscribeNext:^(NSString *str) {
        
            @strongify(self);
        if ([str isEqualToString:SUCCESS_MSG]) {
            [self headerWithRefreshing];
//            if ([self.viewModel.equipmentList containsObject:model])
//            {
//                [self.viewModel.equipmentList removeObject:model];
//            }
//            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
            [CMUtility showTips:@"复归成功"];
        }else
        {
            [CMUtility showTips:@"复归失败"];
        }

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

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat offset = scrollView.contentOffset.y;
//    
//    if (scrollView.contentOffset.y < 0) {
//        self.headView.frame = CGRectMake(offset,0, DEF_DEVICE_WIDTH - offset * 2, HeadView_height - offset);
//    }else {
//        self.headView.frame = CGRectMake(0,-offset, DEF_DEVICE_WIDTH, HeadView_height);
//    }
//}


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
