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

@interface EquipmentWarningViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UIView *headView;

@end

@implementation EquipmentWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLb.text = @"设备告警信息";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, HeadView_height)];
//    self.headView.backgroundColor = [UIColor yellowColor];
//    
//    self.tableView.tableHeaderView = self.headView;
//
//    [self.view addSubview:self.headView];
    
}

#pragma mark - delegate  dataSource -

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    NSArray *nameArray = @[@"时间",@"设备+地点",@"告警状态",@"复检申请检修"];
    [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //设置 title 区域
        UILabel *titleLabel = [[UILabel alloc] init];
        
        CGFloat lab_x = (tableView.contentSize.width/4)*idx;
        CGFloat width = tableView.contentSize.width/4;
        if (idx == 0) {
            width -= 20;
            titleLabel.textAlignment =  NSTextAlignmentCenter;

        }else if (idx == 3)
        {
            lab_x -= 20;
            width += 20;
            titleLabel.textAlignment =  NSTextAlignmentLeft;

        }else
        {
            lab_x -= 20;
        }
        
        titleLabel.frame = CGRectMake(lab_x, 10,width, 20);
        
        //设置 title 文字内容
        titleLabel.text =nameArray[idx];
        //设置 title 颜色
        titleLabel.textColor =  [UIColor blackColor];
        titleLabel.font = DEF_MyFont(15);
        
        view.backgroundColor = [UIColor redColor];
        [view addSubview:titleLabel];

    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //设置 title 区域高度
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EquipmentWarningTableViewCell equipmentWarningCellHeight];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"EquipmentWarningCellIdentify";
    EquipmentWarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[EquipmentWarningTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, DEF_NAVIGATIONBAR_HEIGHT + 10, DEF_DEVICE_WIDTH-20, DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT - 20) style:UITableViewStylePlain];
        //_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        _tableView.tableFooterView = [UIView new];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.layer.shadowColor = [UIColor blackColor].CGColor;
        _tableView.layer.shadowOffset = CGSizeMake(0, 10);
        _tableView.layer.shadowOpacity = 0.3;
        _tableView.clipsToBounds = false; //这句最重要了，不然就显示不出来

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
