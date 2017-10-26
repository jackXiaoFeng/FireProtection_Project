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

@interface StatementViewController ()

@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"巡检报表";
    
    NSArray *nameArray = @[
                           @"当前巡检完成度",
                           @"查看巡检记录",
                           @"本周巡检完成度",
                           @"本月巡检完成度",
                           ];
    
    NSArray *diameterClor = @[
                              [UIColor UIColorFromRGB:0xE75553 alpha:1],
                              @"",
                              [UIColor UIColorFromRGB:0x5CE3E2 alpha:1],
                              [UIColor UIColorFromRGB:0x63EFE9 alpha:1]
                              ];

    
    CGFloat space = DEF_DEVICE_SCLE_WIDTH(20);
    
    CGFloat bgWidth = (DEF_DEVICE_WIDTH - space *(3))/2;
    
    CGFloat bgHeight = DEF_DEVICE_SCLE_HEIGHT(345);
    
    CGFloat pressDiameter = DEF_DEVICE_SCLE_HEIGHT(113);
    
    //每个Item宽高
    CGFloat W = (DEF_DEVICE_WIDTH - space *(3))/2;
    CGFloat H = DEF_DEVICE_SCLE_HEIGHT(345);
    //每行列数
    NSInteger rank = 2;
    //每列间距
    CGFloat rankMargin = DEF_DEVICE_SCLE_WIDTH(20);;
    //每行间距
    CGFloat rowMargin = DEF_DEVICE_SCLE_WIDTH(20);;
    //Item索引 ->根据需求改变索引
    //NSUInteger index = nameArray.count;
    
    UIImage *recordImage = DEF_IMAGENAME(@"examine_record");

    
    @weakify(self)
    [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        
        //Item X轴
        CGFloat X = (idx % rank) * (W + rankMargin) + rankMargin;
        //Item Y轴
        NSUInteger Y = (idx / rank) * (H +rowMargin) + DEF_NAVIGATIONBAR_HEIGHT + rowMargin;
        //Item top
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(X,Y,bgWidth, bgHeight)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        
        if (idx != 1) {
            
            RoundnessProgressView *_roundnessProgressView = [[RoundnessProgressView alloc]initWithFrame:CGRectMake((bgView.width-pressDiameter)/2 , (bgView.height-pressDiameter)/2 - 15, pressDiameter, pressDiameter)];
            _roundnessProgressView.thicknessWidth = 4;
            _roundnessProgressView.completedColor = [UIColor UIColorFromRGB:0xE0DBDB alpha:1];
            _roundnessProgressView.labelColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
            _roundnessProgressView.incompletedColor = diameterClor[idx];
            
            _roundnessProgressView.backgroundColor = [UIColor clearColor];
            [bgView addSubview:_roundnessProgressView];
            
            _roundnessProgressView.progressTotal = 100;
            _roundnessProgressView.progressSections =60 + 10*idx;
            
            NSString *pressStr = nameArray[idx];
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

            
            NSString *pressStr = nameArray[idx];
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
    
    // Do any additional setup after loading the view.
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
