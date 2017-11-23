//
//  UploadingViewController.m
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "UploadingViewController.h"
#import "UploadingTableViewCell.h"
#import "UploadingModel.h"
#import "UploadingViewModel.h"

@interface UploadingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) UploadingModel *model;
@property (nonatomic, strong) UploadingViewModel *viewModel;

@property (nonatomic, strong)NSMutableArray *selectArray;

@end


@implementation UploadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"上传巡检记录";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.selectArray = [NSMutableArray arrayWithCapacity:10];
    
    
    
    
    
    NSArray *nameArray = @[
                           @"上传选中信息",
                           @"上传全部记录"
                           ];
    NSArray *normalArray = @[
                             @"uploading_bottom_one_normal",
                             @"uploading_bottom_all_normal"
                             ];
    
    NSArray *selectedArray = @[
                               @"uploading_bottom_one_selected",
                               @"uploading_bottom_all_selected"
                               ];
    
    CGFloat btnSpace = DEF_DEVICE_SCLE_WIDTH(42);
    
    CGFloat btnLineSpace = DEF_DEVICE_SCLE_WIDTH(62);

    
    CGFloat btnWidth = (DEF_DEVICE_WIDTH -btnSpace - btnLineSpace*nameArray.count)/nameArray.count;

    CGFloat btnHeight = DEF_DEVICE_SCLE_HEIGHT(83);

    @weakify(self)
    [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat btnX = idx == 0? btnLineSpace : btnLineSpace +btnWidth +btnSpace;
        btn.frame = CGRectMake(btnX, DEF_DEVICE_HEIGHT - DEF_DEVICE_SCLE_HEIGHT(37) - btnHeight, btnWidth, btnHeight);
        
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
    
    
    //添加刷新
    self.viewModel  = [[UploadingViewModel alloc]init];
    
    NSString *path = [UploadingModel filePath];
    NSMutableDictionary *tmpDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (tmpDic == nil) {
        tmpDic = [NSMutableDictionary dictionaryWithCapacity:10];;
    }

    [tmpDic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        NSLog(@"====key:%@",obj);
        UploadingModel *modelALL = [tmpDic objectForKey:obj];
        NSLog(@"====Degree:%@===State:%@===Eqname:%@===State:%@===modelALL.images:%@",modelALL.Degree,modelALL.State,modelALL.Eqname,modelALL.State,modelALL.images);
        [self.viewModel.uploadingList addObject:modelALL];
    }];

    if (self.viewModel.uploadingList.count == 0) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 50)];
        lab.text = @"暂无巡检记录";
        lab.font = DEF_MyFont(15);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor lightGrayColor];
        self.tableView.tableFooterView = lab;
    }else
    {
        self.tableView.tableFooterView = [UIView new];
    }
    
    
    //首次刷新数据
    //[self headerWithRefreshing];
    //mj刷新
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self headerWithRefreshing];
//    }];
//    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self footerWithRefreshing];
//    }];

    
}

- (void)headerWithRefreshing
{
    @weakify(self)
    [[[[self.viewModel feedDataWithType:LoadData] map:^id(NSDictionary * dic) {
        @strongify(self);
        
        [CMUtility removeFailViewWith:self.view];
        
        return self.viewModel.uploadingList;
        
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
        if (self.viewModel.uploadingList.count == 0) {
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
        
        return self.viewModel.uploadingList;
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


- (void)xunjianBtnclick:(UIButton *)btn
{
    NSUInteger BtnTag = btn.tag;
    if (self.viewModel.uploadingList.count == 0) {
        [CMUtility showTips:@"暂无巡检记录"];
        return;
    }
    NSLog(@"BtnTag----%lu",(unsigned long)BtnTag);
    __block NSMutableArray *array =[NSMutableArray arrayWithCapacity:10];
    if (BtnTag == 100) {
        if (self.selectArray.count == 0) {
            [CMUtility showTips:@"请选择巡检记录"];
            return ;
        }else
        {
            array = [NSMutableArray arrayWithArray:self.selectArray];
            
        }
    }else
    {
        [self.viewModel.uploadingList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:[NSString stringWithFormat:@"%ld",idx]];
        }];
        
    }
    
    @weakify(self)
    [[self.viewModel uploadingDataWithUploadingModel:array] subscribeNext:^(id x) {
        @strongify(self);
        if ([x isEqualToString:SUCCESS_MSG]) {
            [CMUtility showTips:@"上传成功"];
        }
        
        if(BtnTag == 100)
        {
            //清空全局数组
            [self.selectArray removeAllObjects];
        }
        
        //上传成功删除本地记录
        NSString *path = [UploadingModel filePath];
        NSMutableDictionary *tmpDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (tmpDic == nil) {
            tmpDic = [NSMutableDictionary dictionaryWithCapacity:10];;
        }
        
        NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:10];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSLog(@"obj-%@--idx-%ld",obj,idx);

            @strongify(self);
            
            NSInteger objIndex;
            if (BtnTag == 100) {
                NSString *objStr = (NSString *)obj;
                objIndex = [objStr integerValue];
            }else
            {
                objIndex = (self.viewModel.uploadingList.count - 1) < idx ? 0 :self.viewModel.uploadingList.count - 1 - idx;
            }
            
            UploadingModel *uploadingModel = self.viewModel.uploadingList[objIndex];
            [tmpDic removeObjectForKey:uploadingModel.Degree];
            [tmpArray addObject:uploadingModel];
            
//            //删除数据源
//            [self.viewModel.uploadingList removeObject:uploadingModel];
            
            //删除选中行
 //           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:objIndex inSection:0];
            
//            if (self.viewModel.uploadingList.count == 0) { // 要根据情况直接删除section或者仅仅删除row
//                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//
//            } else {
//                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            }
            
        }];
        BOOL isSave = [NSKeyedArchiver archiveRootObject:tmpDic toFile:path];
        
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UploadingModel *uploadingModel = (UploadingModel*)obj;
            if ([self.viewModel.uploadingList containsObject:uploadingModel]) {
                [self.viewModel.uploadingList removeObject:uploadingModel];
            }
        }];
        
        if (self.viewModel.uploadingList.count == 0) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 50)];
            lab.text = @"暂无巡检记录";
            lab.font = DEF_MyFont(15);
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = [UIColor lightGrayColor];
            self.tableView.tableFooterView = lab;
        }else
        {
            self.tableView.tableFooterView = [UIView new];
        }
        
//        [self.viewModel.uploadingList removeAllObjects];
//        NSMutableDictionary *newTmpDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        if (newTmpDic == nil) {
//            newTmpDic = [NSMutableDictionary dictionaryWithCapacity:10];;
//        }
//
//        [newTmpDic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            @strongify(self)
//            NSLog(@"====key:%@",obj);
//            UploadingModel *modelALL = [tmpDic objectForKey:obj];
//            NSLog(@"====Degree:%@===State:%@===Eqname:%@===State:%@",modelALL.Degree,modelALL.State,modelALL.Eqname,modelALL.State);
//            [self.viewModel.uploadingList addObject:modelALL];
//        }];
        [self.tableView reloadData];

        
    }error:^(NSError *error) {
        [CMUtility showTips:@"上传失败"];
    }];
}


#pragma mark - delegate  dataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UploadingTableViewCell UploadingCellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    
    return 1;// 分组
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.uploadingList.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"UploadingTableViewCellIdentify";
    UploadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UploadingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.viewModel.uploadingList.count > 0) {
        
        UploadingModel *model = self.viewModel.uploadingList[indexPath.row];
        cell.UploadingMode  = model;
        cell.hidenLine= (indexPath.row== self.viewModel.uploadingList.count-1); //通过组模型数组来拿到每组最后一行
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UploadingModel *model = self.viewModel.uploadingList[indexPath.row];
    NSString *rowStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    if (model.isSelect) {
        if ([self.selectArray containsObject:rowStr]) {
            [self.selectArray removeObject:rowStr];
        }
    }else
    {
        [self.selectArray addObject:rowStr];
    }
    
    
    //self.selectArray
    model.isSelect = !model.isSelect;
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    [self.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"self.selectArray=====%ld==值：%@",idx,obj);
    }];
    NSLog(@"=====%ld",indexPath.row);
    
}


#pragma mark - get
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT - DEF_DEVICE_SCLE_HEIGHT(150))];
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
