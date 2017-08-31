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

@interface UploadingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end


@implementation UploadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"上传巡检记录";
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
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
        btn.frame = CGRectMake(btnX, DEF_DEVICE_HEIGHT - DEF_DEVICE_SCLE_HEIGHT(57) - btnHeight, btnWidth, btnHeight);
        
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

    
}
- (void)xunjianBtnclick:(UIButton *)btn
{
    NSUInteger BtnTag = btn.tag;
    NSLog(@"BtnTag----%lu",(unsigned long)BtnTag);
  
    
}


#pragma mark - delegate  dataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UploadingTableViewCell UploadingCellHeight];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
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
