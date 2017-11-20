//
//  AccountViewController.m
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#define BTN_SPACE DEF_DEVICE_SCLE_WIDTH(25)
#define RoundViewTAG  300
#define RoundLabTAG   400

#import "AccountViewController.h"
#import "PlanViewController.h"
#import "UploadingViewController.h"
#import "StatementViewController.h"
#import "RecordViewController.h"
#import "InfoViewController.h"
#import "RoundnessProgressView.h"
#import "DrawView.h"

#import "MoreViewController.h"
#import "DetectionViewController.h"
#import "PollingCompleteViewModel.h"

@interface AccountViewController ()
@property (nonatomic, strong)PollingCompleteViewModel *viewModel;
@property (nonatomic, strong)UIView *pressView;

@property (nonatomic, assign)CGFloat diameter_y;
@property (nonatomic, assign)CGFloat lineWidth;
@property (nonatomic, assign)CGFloat space;
@property (nonatomic, strong)NSArray *diameterArray;
@property (nonatomic, strong)NSArray *strArray;
@property (nonatomic, strong)NSArray *diameterClor;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"巡检";
    
    self.viewModel = [[PollingCompleteViewModel alloc]init];

    [self.rightBtn setImage:DEF_IMAGENAME(@"scan") forState:UIControlStateNormal];
    self.rightBtn.hidden = NO;
    
    NSArray *nameArray = @[
                           @"巡检\n计划",
                           @"上传\n巡检",
                           @"巡检\n报表",
                           @"巡检\n记录",
                           @"设备\n信息"
                           ];
    
    NSArray *normalArray = @[
                           @"plan_normal",
                           @"uploading_normal",
                           @"statement_normal",
                           @"record_normal",
                           @"info_normal"
                           ];
    
    NSArray *selectedArray = @[
                               @"plan_selected",
                               @"uploading_selected",
                               @"statement_selected",
                               @"record_selected",
                               @"info_selected"
                            ];
    
    
    CGFloat btnWidth = (DEF_DEVICE_WIDTH - BTN_SPACE*(nameArray.count+1))/nameArray.count;
    
    
    @weakify(self)
    [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat btnX = (BTN_SPACE + btnWidth)*idx + BTN_SPACE;
        btn.frame = CGRectMake(btnX, DEF_DEVICE_SCLE_HEIGHT(20) + DEF_NAVIGATIONBAR_HEIGHT, btnWidth, btnWidth);
        
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

    
    
    self.pressView =[[UIView alloc]initWithFrame:CGRectMake(DEF_DEVICE_SCLE_WIDTH(15), btnWidth + DEF_NAVIGATIONBAR_HEIGHT + DEF_DEVICE_SCLE_HEIGHT(40), DEF_DEVICE_WIDTH -DEF_DEVICE_SCLE_WIDTH(15)*2 , DEF_DEVICE_SCLE_HEIGHT(656))];
    self.pressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pressView];
    
    
#pragma mark - 圆绘制进度
//    11.43 9.07 6.70 90／3.18
//    
//    323.5
    
    self.diameter_y = DEF_DEVICE_SCLE_HEIGHT(90);
    self.lineWidth = DEF_DEVICE_SCLE_HEIGHT(20);
    
    self.space = DEF_DEVICE_SCLE_HEIGHT(13);
    
    self.diameterArray = @[
                               @(DEF_DEVICE_SCLE_HEIGHT(323.5)),
                               @(DEF_DEVICE_SCLE_HEIGHT(256.7)),
                               @(DEF_DEVICE_SCLE_HEIGHT(189.6))
                               ];
    
    self.strArray = @[
                           @"当天\n",
                           @"本周\n",
                           @"本月\n"
                          ];
    
    self.diameterClor = @[
                              [UIColor UIColorFromRGB:0x1EBFF0 alpha:1],
                              [UIColor UIColorFromRGB:0xFB7943 alpha:1],
                              [UIColor UIColorFromRGB:0xABF85A alpha:1]
                               ];
    

    
    
    [self.diameterArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        NSNumber *num = (NSNumber *)obj;
        CGFloat diameter = num.floatValue;
        NSLog(@"dddd----%f",diameter);
        
        RoundnessProgressView *roundnessProgressView = [[RoundnessProgressView alloc]initWithFrame:CGRectMake((self.pressView.width-diameter)/2 ,(self.lineWidth+self.space)*idx + self.diameter_y, diameter, diameter)];
        roundnessProgressView.thicknessWidth = self.lineWidth;
        //    roundnessProgressView.completedColor = [UIColor UIColorFromRGB:0x1EBFF0 alpha:1];
        roundnessProgressView.completedColor = [UIColor clearColor];
        roundnessProgressView.incompletedColor = self.diameterClor[idx];
        roundnessProgressView.backgroundColor = [UIColor clearColor];
        roundnessProgressView.isShowLabel = NO;
        //roundnessProgressView.labelColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
        
        [self.pressView addSubview:roundnessProgressView];
        
        roundnessProgressView.progressTotal = 100;
        roundnessProgressView.progressSections =0;
        roundnessProgressView.tag =  RoundViewTAG +idx;
        
        if (idx == 2) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(roundnessProgressView.x +self.lineWidth, roundnessProgressView.y + self.lineWidth, roundnessProgressView.width - self.lineWidth*2, roundnessProgressView.width - self.lineWidth*2)];
            lab.text = @"完成度";
            lab.textColor = [UIColor UIColorFromRGB:0xE85151 alpha:1];
            lab.textAlignment = NSTextAlignmentCenter;
            
            [self.pressView addSubview:lab];

        }
        
        CGFloat yuandianWidth = DEF_DEVICE_SCLE_WIDTH(30);
        
        CGFloat yuandianSpace = DEF_DEVICE_SCLE_WIDTH(10);

        
        NSString *str = [NSString stringWithFormat:@"%@%ld%%",self.strArray[idx],(long)0];
        
        CGSize size = [CMUtility calculateStringSize:str font:[UIFont fontWithName:@"Helvetica-Bold" size:15] constrainedSize:CGSizeMake(MAXFLOAT,MAXFLOAT)];
        
        CGFloat space = (self.pressView.width - (yuandianWidth + yuandianSpace + size.width)*self.diameterArray.count)/(self.diameterArray.count+1);
        
        
        UILabel *yuandianLab = [[UILabel alloc]initWithFrame:CGRectMake((space + yuandianWidth + yuandianSpace)*(idx + 1) +size.width *idx, self.pressView.height - DEF_DEVICE_SCLE_HEIGHT(100), size.width + 10, size.height)];
        yuandianLab.text = str;//@"当天\n72%";
        yuandianLab.textAlignment = NSTextAlignmentCenter;
        yuandianLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        yuandianLab.numberOfLines = 0; // 关键一句
        yuandianLab.tag = RoundLabTAG +idx;
        [self.pressView addSubview:yuandianLab];
        
        yuandianLab.textColor = self.diameterClor[idx];
        
        
        //开始图像绘图
        UIGraphicsBeginImageContext(self.pressView.bounds.size);
        //获取当前CGContextRef
        CGContextRef gc = UIGraphicsGetCurrentContext();
        //填充当前绘画区域内的颜色
        [[UIColor whiteColor] set];
        //填充当前矩形区域
        CGContextFillRect(gc, CGRectMake(yuandianLab.x - yuandianWidth -yuandianSpace, yuandianLab.y + (yuandianLab.height - yuandianWidth)/2, yuandianWidth, yuandianWidth));
        //以矩形frame为依据画一个圆
        CGContextAddEllipseInRect(gc, CGRectMake(yuandianLab.x - yuandianWidth -yuandianSpace, yuandianLab.y + (yuandianLab.height - yuandianWidth)/2, yuandianWidth, yuandianWidth));
        //填充当前绘画区域内的颜色
        UIColor *color = self.diameterClor[idx];
        [color set];
        //填充(沿着矩形内围填充出指定大小的圆)
        CGContextFillPath(gc);
        
        //从Context中获取图像，并显示在界面上
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        [self.pressView addSubview:imgView];
        
        
//        DrawView*yuandian =[[DrawView alloc]initWithFrame:CGRectMake(yuandianLab.x - yuandianWidth -5, yuandianLab.y + (yuandianLab.height - yuandianWidth)/2, yuandianWidth, yuandianWidth)];
//        [pressView addSubview:yuandian];
    }];
    

    
    

    
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_SCLE_WIDTH(518), DEF_DEVICE_SCLE_HEIGHT(78), DEF_DEVICE_SCLE_WIDTH(150), DEF_DEVICE_SCLE_HEIGHT(24))];
    lab.text = @"巡检完成度";
    lab.textColor = [UIColor UIColorFromRGB:0xFB7943 alpha:1];
    lab.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    lab.textAlignment = NSTextAlignmentCenter;
    
    [self.pressView addSubview:lab];


    
    [self requestNowpolling];
//    SocketIO_Singleton.connectSuccess = ^{
//        @strongify(self)
//        //获取当前巡检度
//        [self requestNowpolling];
//    };
    // Do any additional setup after loading the view.
}

- (void)requestNowpolling
{
    @weakify(self)
    [[self.viewModel feedData] subscribeNext:^(id x) {
        @strongify(self);
        [self.diameterArray
         enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self)
             if (self.viewModel.pollingCompleteList.count < 3) {
                 [CMUtility showTips:@"完成度获取失败"];
                 return ;
             }
             PollingCompleteModel*model = (PollingCompleteModel *)self.viewModel.pollingCompleteList[idx];

             NSInteger progressSections = [model.Complete intValue] + 20*(4 - idx);
             
             RoundnessProgressView *rpView = [self.pressView viewWithTag:RoundViewTAG +idx];
             [rpView removeFromSuperview];
             
            NSNumber *num = (NSNumber *)obj;
            CGFloat diameter = num.floatValue;
            NSLog(@"dddd----%f",diameter);
            
            RoundnessProgressView *roundnessProgressView = [[RoundnessProgressView alloc]initWithFrame:CGRectMake((self.pressView.width-diameter)/2 ,(self.lineWidth+self.space)*idx + self.diameter_y, diameter, diameter)];
            roundnessProgressView.thicknessWidth = self.lineWidth;
            //    roundnessProgressView.completedColor = [UIColor UIColorFromRGB:0x1EBFF0 alpha:1];
            roundnessProgressView.completedColor = [UIColor clearColor];
            roundnessProgressView.incompletedColor = self.diameterClor[idx];
            roundnessProgressView.backgroundColor = [UIColor clearColor];
            roundnessProgressView.isShowLabel = NO;
            //roundnessProgressView.labelColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
            
            [self.pressView addSubview:roundnessProgressView];
            
            roundnessProgressView.progressTotal = 100;
            roundnessProgressView.progressSections =progressSections;
            roundnessProgressView.tag =  RoundViewTAG +idx;
            
             
             NSString *str = [NSString stringWithFormat:@"%@%ld%%",self.strArray[idx],progressSections];
             UILabel *yuandianlab = [self.pressView viewWithTag:RoundLabTAG +idx];
             yuandianlab.text = str;
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

- (void)rightBtnClick
{
    NSLog(@"二维码btn点击");
    DetectionViewController *controller = [[DetectionViewController alloc]init];
    controller.nfcDetectionStatus = NFC_DETECTION_AFFIRNM;
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (void)xunjianBtnclick:(UIButton *)btn
{
    NSUInteger BtnTag = btn.tag;
    NSLog(@"btn----%lu",(unsigned long)BtnTag);
    UIViewController *controller;
    if (BtnTag == 100) {
        controller = [[PlanViewController alloc]init];
    }else if (BtnTag == 101)
    {
        controller = [[UploadingViewController alloc]init];

    }else if (BtnTag == 102)
    {
        controller = [[StatementViewController alloc]init];
        
    }else if (BtnTag == 103)
    {
        controller = [[RecordViewController alloc]init];
        
    }else if (BtnTag == 104)
    {
        MoreViewController *mv = [[MoreViewController alloc]init];
        mv.isNoneTabber = YES;
        controller = mv;
        
    }
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
