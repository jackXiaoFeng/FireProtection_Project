//
//  StatementViewController.m
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "StatementViewController.h"
#import "RoundnessProgressView.h"
#import "RecordViewController.h"
#import "PollingCompleteViewModel.h"

#define BGVIEW_TAG 300
#define ROUNDVIEW_TAG 400


@interface StatementViewController ()
@property (nonatomic, strong)PollingCompleteViewModel *viewModel;

@property(nonatomic,strong)NSArray *nameArray;
@property(nonatomic,strong)NSArray *diameterClor;
@property(nonatomic,assign)CGFloat space;
@property(nonatomic,assign)CGFloat bgWidth;
@property(nonatomic,assign)CGFloat bgHeight;
@property(nonatomic,assign)CGFloat pressDiameter;
@property(nonatomic,assign)CGFloat W;
@property(nonatomic,assign)CGFloat H;
@property(nonatomic,assign)NSInteger rank;
@property(nonatomic,assign)CGFloat rankMargin;
@property(nonatomic,assign)CGFloat rowMargin;
@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"巡检报表";
    
    self.viewModel = [[PollingCompleteViewModel alloc]init];

    self.nameArray = @[
                           @"当前巡检完成度",
                           @"查看巡检记录",
                           @"本周巡检完成度",
                           @"本月巡检完成度",
                           ];
    
    self.diameterClor = @[
                              [UIColor UIColorFromRGB:0xE75553 alpha:1],
                              @"",
                              [UIColor UIColorFromRGB:0x5CE3E2 alpha:1],
                              [UIColor UIColorFromRGB:0x63EFE9 alpha:1]
                              ];

    
    self.space = DEF_DEVICE_SCLE_WIDTH(20);
    
    self.bgWidth = (DEF_DEVICE_WIDTH - self.space *(3))/2;
    
    self.bgHeight = DEF_DEVICE_SCLE_HEIGHT(345);
    
    self.pressDiameter = DEF_DEVICE_SCLE_HEIGHT(113);
    
    //每个Item宽高
    self.W = (DEF_DEVICE_WIDTH - self.space *(3))/2;
    self.H = DEF_DEVICE_SCLE_HEIGHT(345);
    //每行列数
    self.rank = 2;
    //每列间距
    self.rankMargin = DEF_DEVICE_SCLE_WIDTH(20);;
    //每行间距
    self.rowMargin = DEF_DEVICE_SCLE_WIDTH(20);;
    //Item索引 ->根据需求改变索引
    //NSUInteger index = nameArray.count;
    
    UIImage *recordImage = DEF_IMAGENAME(@"examine_record");

    
    @weakify(self)
    [self.nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        
        //Item X轴
        CGFloat X = (idx % self.rank) * (self.W + self.rankMargin) + self.rankMargin;
        //Item Y轴
        NSUInteger Y = (idx / self.rank) * (self.H +self.rowMargin) + DEF_NAVIGATIONBAR_HEIGHT + self.rowMargin;
        //Item top
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(X,Y,self.bgWidth, self.bgHeight)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.tag = BGVIEW_TAG + idx;
        [self.view addSubview:bgView];
        
        
        if (idx != 1) {
            
            RoundnessProgressView *_roundnessProgressView = [[RoundnessProgressView alloc]initWithFrame:CGRectMake((bgView.width-self.pressDiameter)/2 , (bgView.height-self.pressDiameter)/2 - 15, self.pressDiameter, self.pressDiameter)];
            _roundnessProgressView.thicknessWidth = 4;
            _roundnessProgressView.completedColor = [UIColor UIColorFromRGB:0xE0DBDB alpha:1];
            _roundnessProgressView.labelColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
            _roundnessProgressView.incompletedColor = self.diameterClor[idx];
            
            _roundnessProgressView.backgroundColor = [UIColor clearColor];
            _roundnessProgressView.tag = ROUNDVIEW_TAG + idx;
            [bgView addSubview:_roundnessProgressView];
            
            _roundnessProgressView.progressTotal = 100;
            _roundnessProgressView.progressSections =0;
            
            NSString *pressStr = self.nameArray[idx];
            CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) font:DEF_MyFont(15) string:pressStr withSpacing:0];
            
            UILabel *_pressLab = [[UILabel alloc] initWithFrame:CGRectMake((bgView.width-contentSize.width)/2 , _roundnessProgressView.height+_roundnessProgressView.y + DEF_DEVICE_SCLE_HEIGHT(37), contentSize.width, contentSize.height)];
            _pressLab.font = DEF_MyFont(15);
            _pressLab.text = pressStr;
            _pressLab.userInteractionEnabled = YES;
            _pressLab.backgroundColor = [UIColor clearColor];
            _pressLab.textAlignment = NSTextAlignmentCenter;
            _pressLab.textColor = DEF_COLOR_RGB(67, 67, 67);
            [bgView addSubview:_pressLab];
            

        }else
        {
            UIImageView *recordIV = [[UIImageView alloc]initWithFrame:CGRectMake((bgView.width-recordImage.size.width)/2 , (bgView.height-recordImage.size.height)/2 - 15, recordImage.size.width, recordImage.size.height)];
            recordIV.image = recordImage;
            recordIV.userInteractionEnabled = YES;
            [bgView addSubview:recordIV];
            
            UITapGestureRecognizer* singleRecognizer;
            singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
            singleRecognizer.numberOfTapsRequired = 1; // 单击
            [bgView addGestureRecognizer:singleRecognizer];

            
            NSString *pressStr = self.nameArray[idx];
            CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) font:DEF_MyFont(15) string:pressStr withSpacing:0];
            
            UILabel *_pressLab = [[UILabel alloc] initWithFrame:CGRectMake((bgView.width-contentSize.width)/2 , recordIV.height+recordIV.y + DEF_DEVICE_SCLE_HEIGHT(48), contentSize.width, contentSize.height)];
            _pressLab.font = DEF_MyFont(15);
            _pressLab.text = pressStr;
            _pressLab.userInteractionEnabled = YES;
            _pressLab.backgroundColor = [UIColor clearColor];
            _pressLab.textAlignment = NSTextAlignmentCenter;
            _pressLab.textColor = DEF_COLOR_RGB(67, 67, 67);
            [bgView addSubview:_pressLab];
            
        }
        

        
    }];
    
    [self requestNowpolling];
    // Do any additional setup after loading the view.
}

- (void)requestNowpolling
{
    @weakify(self)
    [[self.viewModel feedData] subscribeNext:^(id x) {
        @strongify(self);
        [self.nameArray
         enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             @strongify(self)
             if (self.viewModel.pollingCompleteList.count < 3) {
                 [CMUtility showTips:@"完成度获取失败"];
                 return ;
             }
             NSInteger tmpIdx = idx - 1;
             tmpIdx = tmpIdx < 0?0:tmpIdx;
             PollingCompleteModel*model = (PollingCompleteModel *)self.viewModel.pollingCompleteList[tmpIdx];
             
             NSInteger progressSections = [model.Complete intValue];
             NSInteger progressTotal = [model.Complete intValue]+[model.Unfinishe intValue];

             
             UIView *bgView = [self.view viewWithTag:BGVIEW_TAG + idx];
             
             if (idx != 1) {
                 
                 RoundnessProgressView *rpView = [self.view viewWithTag:ROUNDVIEW_TAG +idx];
                 [rpView removeFromSuperview];
                 
                 RoundnessProgressView *_roundnessProgressView = [[RoundnessProgressView alloc]initWithFrame:CGRectMake((bgView.width-self.pressDiameter)/2 , (bgView.height-self.pressDiameter)/2 - 15, self.pressDiameter, self.pressDiameter)];
                 _roundnessProgressView.thicknessWidth = 4;
                 _roundnessProgressView.completedColor = [UIColor UIColorFromRGB:0xE0DBDB alpha:1];
                 _roundnessProgressView.labelColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
                 _roundnessProgressView.incompletedColor = self.diameterClor[idx];
                 
                 _roundnessProgressView.backgroundColor = [UIColor clearColor];
                 [bgView addSubview:_roundnessProgressView];
                 
                 _roundnessProgressView.progressTotal = progressTotal;
                 _roundnessProgressView.progressSections =progressSections;
                 _roundnessProgressView.tag =  ROUNDVIEW_TAG +idx;
             
             }
         }];
        
        //            self.footer.hidden = [x boolValue];
        //        if ([model.Type isEqualToString:@"1"])//代表当前时间完成度
        //        {
        //            self.progressSections = model.Complete;
        //            [self.tableView reloadData];
        //        }
    }error:^(NSError *error) {
        [CMUtility showTips:@"当前巡检完成度获取失败"];
    }];
}


#pragma mark - 单击双击 -

- (void)handleSingleTapFrom:(UIGestureRecognizer *)gestureRecognizer {
    RecordViewController *controller = [[RecordViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];

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
