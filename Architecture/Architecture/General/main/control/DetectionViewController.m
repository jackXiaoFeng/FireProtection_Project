//
//  BeCentraliewController.m
//  BleDemo
//
//  Created by ZTELiuyw on 15/9/7.
//  Copyright (c) 2015年 liuyanwei. All rights reserved.

//旋转动画
//http://blog.csdn.net/xinxisxx/article/details/45694063
#import "DetectionViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ApplicationForInspectionViewController.h"
#import "DetectionViewModel.h"
#import "UploadingModel.h"

//蓝牙sdk
#import "DKBleNfc.h"
#import "NSData+Hex.h"
#import "SZTCard.h"

#define SEARCH_BLE_NAME   @"BLE_NFC"

@interface DetectionViewController ()<DKBleManagerDelegate, DKBleNfcDeviceDelegate>

@property (nonatomic, strong) DKBleManager     *bleManager;
//@property (nonatomic, strong) DKbleNfcDevice  *bleNfcDevice;
@property (nonatomic, strong) DKBleNfcDevice   *bleNfcDevice;
@property (nonatomic, strong) CBPeripheral     *mNearestBle;
@property (nonatomic, strong) NSMutableString  *msgBuffer;

@property (nonatomic, strong) UITextView *msgTextView;



@property (nonatomic, strong)UIImageView *device_scan;
@property (nonatomic, strong)UIImageView *device_rotate;
@property (nonatomic,strong)CALayer * layertime;
@property (nonatomic,strong)UIImage *rotateImage;

@property (nonatomic,assign)BOOL isPause;

@property (nonatomic,strong)UILabel *nfcLab;

@property (nonatomic,strong)UILabel *scanLab;

@property (nonatomic,strong)UILabel *companyLab;


@property (nonatomic,strong)DetectionViewModel *viewModel;

@end

NSInteger lastRssi = -100;
Byte      tradeN   = 1;
@implementation DetectionViewController

//获取当前屏幕显示的viewcontroller
-(UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}

-(UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    if ([self.bleManager isConnect] ) {
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            @try {
//                //关闭自动寻卡
//                BOOL isSuc = [self.bleNfcDevice stoptAutoSearchCard];
//                if (isSuc) {
//
//                    [self.msgBuffer appendString:@"自动寻卡已开启，正在寻卡..\r\n"];
//                    [self getDeviceMsg];
//
//                }
//                else {
//                    [self.msgBuffer appendString:@"自动寻卡已关闭！\r\n"];
//                }
//
//            } @catch (NSException *exception) {
//                [self.msgBuffer appendString:[exception reason]];
//
//            } @finally {
//            }
//        });
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    IAlertView *alertView = [[IAlertView alloc] init]; // 无标题
    self.viewModel = [[DetectionViewModel alloc]init];
    
    
    self.isPause = NO;
    self.navImageView.image = [UIImage imageNamed:@""];
    
    UIColor *startColor = DEF_COLOR_RGB(238, 122, 92);
    UIColor *endColor = DEF_COLOR_RGB(232, 83, 82);
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,  (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0.0,  @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT);
    [self.view.layer addSublayer:gradientLayer];
    
    
    UIImage *scanImage = DEF_IMAGENAME(@"device_scan");
    self.device_scan = [[UIImageView alloc]initWithImage:scanImage];
    self.device_scan.frame = CGRectMake((DEF_DEVICE_WIDTH - scanImage.size.width)/2, DEF_STATUS_HEIGHT+DEF_DEVICE_SCLE_HEIGHT(256), scanImage.size.width, scanImage.size.height);
    [self.view addSubview:self.device_scan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.device_scan addGestureRecognizer:tap];
    [self.device_scan setUserInteractionEnabled:YES];
    
    
    self.rotateImage= DEF_IMAGENAME(@"device_rotate");
    
    
    
    self.device_rotate = [[UIImageView alloc]initWithImage:self.rotateImage];
    //self.device_rotate.frame = CGRectMake((DEF_DEVICE_WIDTH - self.rotateImage.size.width)/2, DEF_STATUS_HEIGHT+DEF_DEVICE_SCLE_HEIGHT(256) + (scanImage.size.height/2) - self.rotateImage.size.height- 20, self.rotateImage.size.width , self.rotateImage.size.height);
    [self.view addSubview:self.device_rotate];
    
    self.device_rotate.layer.frame = CGRectMake((DEF_DEVICE_WIDTH - self.rotateImage.size.width)/2, DEF_STATUS_HEIGHT+DEF_DEVICE_SCLE_HEIGHT(256) + (scanImage.size.height/2) - self.rotateImage.size.height, self.rotateImage.size.width , self.rotateImage.size.height);
    self.device_rotate.layer.position = CGPointMake(self.device_scan.centerX, self.device_scan.centerY);
    self.device_rotate.layer.anchorPoint = CGPointMake(0.5, 1);
    
    //动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = ULLONG_MAX;
    rotationAnimation.removedOnCompletion = NO;
    [self.device_rotate.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    [self.view addSubview:self.nfcLab];
    [self.view addSubview:self.scanLab];
    [self.view addSubview:self.companyLab];
    
    
    self.msgTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - DEF_NAVIGATIONBAR_HEIGHT)];
    self.msgTextView.textColor = [UIColor blueColor];
    self.msgTextView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.msgTextView];
    
    //初始化 blue_nfc_sdk
    self.msgBuffer = [[NSMutableString alloc] init];
    lastRssi = -100;
    self.mNearestBle = nil;
    
    self.bleManager = [DKBleManager sharedInstance];
    self.bleManager.delegate = self;
    self.bleNfcDevice = [[DKBleNfcDevice alloc] initWithDelegate:self];
    
    [self.msgTextView setText:@"BLE_NFC Demo v2.0.0使用说明：\r\n1、点击搜索设备按键会自动搜索最近的蓝牙设备并连接上\r\n2、读取数据目前支持深圳通余额和交易记录读取、M1卡（S50/S70）卡扇区读写增加值、身份证相关信息读取、NFC标签（例如ntag21x）NDEF Text格式数据读取。读取方法：连接设备后，将卡片放到读卡区，然后点击读取数据按键即会自动读取\r\n3、写入数据按键针对NTAG21X系列和M1卡，如果是NTAG21x会将编辑区的文本以NDEF Text格式写入。写入方法：连接设备后，在此区域编辑文本，然后点击写入数据，等待写入完成。如果是M1卡则初始化块1为电子钱包，初始化金额10000\r\n4、打开防丢器功能蓝牙指示灯会免掉，如果断开连接，设备蜂鸣器会报警\r\n5、按键按下会显示是长按还是短按"];
    
    //设置设备按键监听
    @weakify(self)
    [self.bleNfcDevice setOonReceiveButtonEnterListenerBlock:^(Byte keyValue) {
        @strongify(self)
        if (keyValue == BUTTON_VALUE_SHORT_ENTER) { //按键短按
            [self.msgBuffer appendString:@"按键短按\r\n"];
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.msgTextView.text = self.msgBuffer;
            });
        }
        else if (keyValue == BUTTON_VALUE_LONG_ENTER) { //按键长按
            [self.msgBuffer appendString:@"按键长按\r\n"];
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.msgTextView.text = self.msgBuffer;
            });
        }
    }];
    
}

- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 根据设备degree获取 设备信息
- (void)requestNFCDetection:(NSString *)degreeStr
{
    UIViewController * viewControllerNow = [self currentViewController];
    if ([viewControllerNow  isKindOfClass:[DetectionViewController class]]) {   //如果是页面XXX，则执行下面语句
        NSLog(@"%@是扫描界面,显示识别信息!!!!!!!!!!!!",viewControllerNow);
    }else
    {
        NSLog(@"%@不是扫描界面,不显示识别信息,直接跳出!!!!!!!!!!!!",viewControllerNow);

        return;
    }
    
    @weakify(self)
    
    [[self.viewModel nfcDetectionFromDegree:degreeStr] subscribeNext:^(id result) {
        @strongify(self);
        
        DetectionModel *model = self.viewModel.detectionList[0];
        
        NSArray *buttonTitles;
        NSArray *buttonTitlesColor;
        NSArray *buttonTitlesBackGroundColor;
        
        if (self.nfcDetectionStatus == NFC_DETECTION_WARNING) {
            buttonTitles = @[ @"复位", @"申请检修", @"取消" ];
            buttonTitlesColor = @[[UIColor whiteColor], [UIColor whiteColor],[UIColor whiteColor] ];
            buttonTitlesBackGroundColor = @[ DEF_COLOR_RGB(83,207,176),DEF_COLOR_RGB(233,129,113),DEF_COLOR_RGB(171,171,171)];
        }else if (self.nfcDetectionStatus == NFC_DETECTION_POLLING)
        {
            buttonTitles = @[ @"确认巡检", @"申请检修", @"取消" ];
            buttonTitlesColor = @[[UIColor whiteColor], [UIColor whiteColor],[UIColor whiteColor] ];
            buttonTitlesBackGroundColor = @[ DEF_COLOR_RGB(83,207,176),DEF_COLOR_RGB(233,129,113),DEF_COLOR_RGB(171,171,171)];
        }else if (self.nfcDetectionStatus == NFC_DETECTION_DEVICE)
        {
            buttonTitles = @[ @"设备复归", @"取消" ];
            buttonTitlesColor = @[[UIColor whiteColor],[UIColor whiteColor] ];
            buttonTitlesBackGroundColor = @[ DEF_COLOR_RGB(83,207,176),DEF_COLOR_RGB(171,171,171)];
        }
        
        IAlertView *alterView = [[IAlertView alloc]initWithTitle:model.Eqname titleColor:[UIColor whiteColor] titleBackgroundColor:DEF_COLOR_RGB(234,97,86)];
        // 添加子布局
        [alterView addContentView:[self addSubViewWithContent:model.Standard]];
        // 添加按钮
        alterView.buttonTitles = buttonTitles;
        alterView.buttonTitlesColor = buttonTitlesColor;
        alterView.buttonTitlesBackGroundColor = buttonTitlesBackGroundColor;
        // 添加按钮点击事件
        alterView.onButtonClickHandle = ^(IAlertView *alertView, NSInteger buttonIndex) {
            @strongify(self);
            if (buttonIndex == 0)
            {
                /*
                if (self.nfcDetectionStatus == NFC_DETECTION_JIANXIU) {
                    ApplicationForInspectionViewController *avc = [[ApplicationForInspectionViewController alloc]init];
                    avc.nfcDetectionStatus = self.nfcDetectionStatus == NFC_DETECTION_JIANXIU?NFC_DETECTION_JIANXIU:NFC_DETECTION_AFFIRNM;
                    avc.detectionModel = model;
                    avc.degreeStr = degreeStr;
                    [self.navigationController pushViewController:avc animated:YES];
                }else if (self.nfcDetectionStatus == NFC_DETECTION_AFFIRNM)
                {
                    NSString *path = [UploadingModel filePath];
                    
                    UploadingModel *uploadingModel = [[UploadingModel alloc]init];
                    uploadingModel.Degree = degreeStr;
                    uploadingModel.State = @"1";
                    uploadingModel.images = @"";
                    uploadingModel.Describe = @"";
                    uploadingModel.Actegories = @"";
                    
                    uploadingModel.Eqname = model.Eqname;
                    uploadingModel.Floorsn = model.Floorsn;
                    uploadingModel.timeT = [CMUtility currentTimestampSecond];
                    
                    NSMutableDictionary *tmpDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                    if (tmpDic == nil) {
                        tmpDic =[NSMutableDictionary dictionaryWithCapacity:10];
                    }
                    [tmpDic setObject:uploadingModel forKey:uploadingModel.Degree];
                    
                    BOOL isSave = [NSKeyedArchiver archiveRootObject:tmpDic toFile:path];
                    
                    //                    NSMutableDictionary *tmpDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                    //                    if (tmpDic == nil) {
                    //                        tmpDic = [NSMutableDictionary dictionaryWithCapacity:10];;
                    //                    }
                    //
                    //                    [tmpDic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    //                        NSLog(@"====key:%@",obj);
                    //                        UploadingModel *modelALL = [tmpDic objectForKey:obj];
                    //
                    //                        NSLog(@"====Degree:%@===State:%@===Eqname:%@",modelALL.Degree,modelALL.State,modelALL.Eqname);
                    //
                    //
                    //                    }];
                    
                    if (isSave) {
                        [CMUtility showTips:@"确认巡检成功"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else
                    {
                        [CMUtility showTips:@"确认巡检失败"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                    
                    
                    
                }
                */
            } else if (buttonIndex == 1)
            {
                /*
                if (self.nfcDetectionStatus == NFC_DETECTION_AFFIRNM)
                {
                    ApplicationForInspectionViewController *avc = [[ApplicationForInspectionViewController alloc]init];
                    avc.nfcDetectionStatus = NFC_DETECTION_JIANXIU;
                    avc.detectionModel = model;
                    avc.degreeStr = degreeStr;
                    [self.navigationController pushViewController:avc animated:YES];
                }else if (self.nfcDetectionStatus == NFC_DETECTION_JIANXIU)
                {
                    NSLog(@"点击取消");
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                */
            }else if (buttonIndex == 2)
            {
                NSLog(@"点击取消");
                [self.navigationController popViewControllerAnimated:YES];
            }
            // 关闭
            [alertView dismiss]; };
        // 显示
        [alterView show];
        
        
    }error:^(NSError *error) {
        [CMUtility showTips:@"当前巡检完成度获取失败"];
    }];
}

#pragma mark 弹窗布局
- (UIView *)addSubViewWithContent:(NSString *)content
{
    //NSString *str = @"1,水泵无损坏\n\n2,水泵无漏水\n\n3,水泵无漏油";
    NSArray *array = [content componentsSeparatedByString:@","];
    __block NSString *tmpStr = @"";
    __block NSInteger tmpStrLen = 0;
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"%ld.%@",(idx+1),obj];
        NSString *symbol = idx == (array.count - 1) ?@"\n":@",\n";
        NSString *newStr = [str stringByAppendingString:symbol];
        tmpStr =[tmpStr stringByAppendingString:newStr];
        
        tmpStrLen = tmpStr.length > tmpStrLen?tmpStr.length:tmpStrLen;
    }];
    
    

    
    if (self.nfcDetectionStatus == NFC_DETECTION_DEVICE) {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *DateStr = [formatter stringFromDate:date];
        [formatter setDateFormat:@"HH:mm:ss"];
        NSString *DateTime = [formatter stringFromDate:date];
        tmpStr = [NSString stringWithFormat:@"%@\n  %@",DateStr,DateTime];
    }
    
    CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(DEF_DEVICE_SCLE_WIDTH(190), MAXFLOAT) font:DEF_MyFont(16) string:tmpStr withSpacing:5];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH - DEF_DEVICE_SCLE_WIDTH(190), contentSize.height + DEF_DEVICE_SCLE_HEIGHT(70) + DEF_DEVICE_SCLE_HEIGHT(50))];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.width/2, DEF_DEVICE_SCLE_HEIGHT(70))];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font =DEF_MyFont(20);
    titleLab.textColor = DEF_COLOR_RGB(254,159,137);
    //    titleLab.backgroundColor = [UIColor yellowColor];
    [view addSubview:titleLab];
    
    
    
    UILabel *lab = [[UILabel alloc]init];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines = 0;
    lab.font =DEF_MyFont(16);
    lab.textColor = DEF_COLOR_RGB(27,27,27);
    //    lab.backgroundColor = [UIColor yellowColor];
    lab.frame = CGRectMake((view.width - contentSize.width)/2, DEF_DEVICE_SCLE_HEIGHT(70) + DEF_DEVICE_SCLE_HEIGHT(25), contentSize.width, contentSize.height);
    lab.attributedText = [CMUtility setLineSpacingWithString:tmpStr withFont:16 spacing:5];
    [view addSubview:lab];
    
    if (self.nfcDetectionStatus == NFC_DETECTION_WARNING) {
        titleLab.text = @"告警内容";
        
    }else if (self.nfcDetectionStatus == NFC_DETECTION_POLLING) {
        titleLab.text = @"巡检要求";
    }else if (self.nfcDetectionStatus == NFC_DETECTION_DEVICE) {
        titleLab.hidden = YES;
        
        lab.frame = CGRectMake((view.width - contentSize.width)/2,  (view.height - contentSize.height)/2, contentSize.width, contentSize.height);

    }
    
    return view;
}

/*
 -(void)handleTap:(id)sender{
 self.isPause = self.isPause;
 if (self.isPause) {
 [self pauseLayer:self.device_rotate.layer];
 }else
 {
 [self resumeLayer:self.device_rotate.layer];
 }
 }
 */

#pragma mark 动画暂停开启
//暂停layer上面的动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//继续layer上面的动画
- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


#pragma mark - DKBleNfcFunction
#pragma mark //找到最近的ble设备并连接
-(void)fineNearBle{
    //self.searchButton.titleLabel.text = @"正在搜索设备..";
    self.msgTextView.text = @"正在搜索设备..";
    self.mNearestBle = nil;
    lastRssi = -100;
    [self.bleManager startScan];
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        int searchCnt = 0;
        while ((self.mNearestBle == nil) && (searchCnt++ < 5000) && ([self.bleManager isScanning])) {
            [NSThread sleepForTimeInterval:0.001f];
        }
        [NSThread sleepForTimeInterval:1.0f];
        [self.bleManager stopScan];
        if (self.mNearestBle == nil) {
            //开始连接设备
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.msgTextView.text = @"未找到设备！";
            });
        }
        else{
            //开始连接设备
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.msgTextView.text = @"正在连接设备..";
            });
            [self.bleManager connect:self.mNearestBle callbackBlock:^(BOOL isConnectSucceed) {
                if (isConnectSucceed) {
                    //设备连接成功
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        [self.msgBuffer setString:@"设备连接成功！\r\n"];
                        self.msgTextView.text = self.msgBuffer;
                        //self.searchButton.titleLabel.text = @"断开连接";
                        //获取设备信息
                        [self getDeviceMsg];
                    });
                }
                else {
                    //设备连接失败
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        self.msgTextView.text = @"设备已断开！";
                        //self.searchButton.titleLabel.text = @"搜索设备";
                    });
                }
            }];
        }
    });
}
//- (int)convertToInt:(NSString*)strtemp//判断中英混合的的字符串长度
//{
//    int strlength = 0;
//    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
//    for (int i=0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
//
//        if (*p && *p) {
//            p++;
//            strlength++;
//        }
//        else {
//            p++;
//        }
//    }
//    return strlength;
//}
#pragma mark //获取设备信息
-(void)getDeviceMsg {
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        @try {
            //获取设备版本
            Byte versionNum = [self.bleNfcDevice getDeviceVersions];
            [self.msgBuffer appendString:@"SDK版本v2.1.0 20170612\r\n"];
            [self.msgBuffer appendString:[NSString stringWithFormat:@"设备版本：%02lx\r\n", (unsigned long)versionNum]];
            [self.msgBuffer appendString:@"蓝牙名称："];
            [self.msgBuffer appendString:[self.bleNfcDevice getDeviceName]];
            [self.msgBuffer appendString:[NSString stringWithFormat:@"\r\n信号强度：%lddB\r\n", (long)lastRssi]];
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.msgTextView.text = self.msgBuffer;
            });
            
            //获取设备电池电压
            float btVlueMv = [self.bleNfcDevice getDeviceBatteryVoltage];
            [self.msgBuffer appendString:[NSString stringWithFormat:@"设备电池电压：%.2fV\r\n", btVlueMv]];
            if (btVlueMv < 3.6) {
                [self.msgBuffer appendString:@"设备电池电量低，请及时充电！\r\n"];
            }
            else {
                [self.msgBuffer appendString:@"设备电池电量充足！\r\n"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.msgTextView.text = self.msgBuffer;
            });
            
            //开启自动寻卡
            BOOL isSuc = [self.bleNfcDevice startAutoSearchCard:20 cardType:ISO14443_P4];
            if (isSuc) {
                [self.msgBuffer appendString:@"自动寻卡已开启，正在寻卡..\r\n"];
            }
            else {
                [self.msgBuffer appendString:@"不支持自动寻卡\r\n"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.msgTextView.text = self.msgBuffer;
            });
        } @catch (NSException *exception) {
            [self.msgBuffer appendString:exception.reason];
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.msgTextView.text = self.msgBuffer;
            });
        } @finally {
        }
    });
}

#pragma mark //读写卡Demo
-(BOOL)readWriteDemo:(DKCardType)cardType{
    @weakify(self)
    switch (cardType) {
        case DKIso14443A_CPUType: {   //iso14443-a cpu卡
            CpuCard *cpuCard = [self.bleNfcDevice getCard];
            if (cpuCard != nil) {
                [self.msgBuffer setString:@"寻到iso14443A cpu卡 －>UID:"];
                [self.msgBuffer appendString:[NSString stringWithFormat:@"%@\r\n", cpuCard.uid]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                //选择交易文件
                NSData *apduRtnData = [cpuCard cpuCardTransceive:[SZTCard getSelectMainFileCmdByte]];
                Byte *apduRtnBytes = (Byte *)[apduRtnData bytes];
                if ( (apduRtnData == nil)
                    || (apduRtnData.length <= 2)
                    || (apduRtnBytes[apduRtnData.length - 2] != (Byte)0x90)
                    || (apduRtnBytes[apduRtnData.length - 1] != (Byte)0x00)) {
                    [self.msgBuffer appendString:[NSString stringWithFormat:@"未知cpu卡\r\n"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        self.msgTextView.text = self.msgBuffer;
                    });
                    
                    return NO;
                }
                
                apduRtnData = [cpuCard cpuCardTransceive:[SZTCard getBalanceCmdByte]];
                [self.msgBuffer appendString:@"余额："];
                [self.msgBuffer appendString:[SZTCard getBalance:apduRtnData]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                //读10条交易记录
                for (int i=1; i<=10; i++) {
                    apduRtnData = [cpuCard cpuCardTransceive:[SZTCard getTradeCmdByte:(Byte)i]];
                    NSString *tradeString = [SZTCard getTrade:apduRtnData];
                    if (tradeString != nil) {
                        [self.msgBuffer appendString:@"\r\n"];
                        [self.msgBuffer appendString:tradeString];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            @strongify(self)
                            self.msgTextView.text = self.msgBuffer;
                        });
                    }
                }
            }
        }
            break;
            
        case DKIso14443B_CPUType: {  //iso14443-b cpu卡
            Iso14443bCard *iso14443bcard = [self.bleNfcDevice getCard];
            if (iso14443bcard != nil) {
                [self.msgBuffer setString:@"寻到iso14443B cpu卡\r\n"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                [self.msgBuffer appendString:[NSString stringWithFormat:@"\r\n发送0084000008指令\r\n"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                Byte bytes[] = {0x00, (Byte)0x84, 0x00, 0x00, 0x08};
                NSData *sendData = [NSData dataWithBytes:bytes length:5];
                NSData *returnData = [iso14443bcard iso14443bCardTransceive:sendData];
                if (returnData != nil) {
                    [self.msgBuffer appendString:[NSString stringWithFormat:@"返回:%@\r\n", returnData]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        self.msgTextView.text = self.msgBuffer;
                    });
                }
                
                [self.msgBuffer appendString:[NSString stringWithFormat:@"\r\n发送0036000008指令\r\n"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                Byte bytes1[] = {0x00, 0x36, 0x00, 0x00, 0x08};
                sendData = [NSData dataWithBytes:bytes1 length:5];
                returnData = [iso14443bcard iso14443bCardTransceive:sendData];
                if (returnData != nil) {
                    [self.msgBuffer appendString:[NSString stringWithFormat:@"返回:%@\r\n", returnData]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        self.msgTextView.text = self.msgBuffer;
                    });
                }
            }
        }
            break;
            
        case DKFeliCa_Type:
            
            break;
            
        case DKMifare_Type: {  //M1卡
            Mifare *mifare = [self.bleNfcDevice getCard];
            if (mifare != nil) {
                [self.msgBuffer setString:@"寻到M1卡 －>UID:"];
                [self.msgBuffer appendString:[NSString stringWithFormat:@"%@\r\n", mifare.uid]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                Byte keybytes[] = {(Byte) 0xff, (Byte) 0xff,(Byte) 0xff,(Byte) 0xff,(Byte) 0xff,(Byte) 0xff};
                NSData *keyData = [[NSData alloc] initWithBytes:keybytes length:6];
                [self.msgBuffer appendString:@"使用默认密码（ffffffffffff）验证第1块密码\r\n"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                //验证密码
                BOOL isSuc = [mifare mifareAuthenticate:1 keyType:MIFARE_KEY_TYPE_A key:keyData];
                if (!isSuc) {
                    [self.msgBuffer appendString:@"密码验证失败，密码错误！\r\n"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        self.msgTextView.text = self.msgBuffer;
                    });
                    return NO;
                }
                
                [self.msgBuffer appendString:@"密码验证成功\r\n"];
                [self.msgBuffer appendString:@"开始向块1写入数据:00112233445566778899aabbccddeeff\r\n"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                Byte writeBytes[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55,
                    0x66, 0x77, (Byte)0x88, (Byte)0x99, (Byte)0xaa,
                    (Byte)0xbb, (Byte)0xcc, (Byte)0xdd, (Byte)0xee, (Byte)0xff};
                isSuc = [mifare mifareWrite:1 data:[NSData dataWithBytes:writeBytes length:16]];
                if (!isSuc) {
                    [self.msgBuffer appendString:@"写入失败\r\n"];
                }
                else {
                    [self.msgBuffer appendString:@"写入成功\r\n"];
                }
                [self.msgBuffer appendString:@"开始读块1数据\r\n"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                //读一个块
                NSData *readData = [mifare mifareRead:1];
                if ( (readData != nil) && (readData.length == 16) ) {
                    [self.msgBuffer appendString:[NSString stringWithFormat:@"读块1数据成功：%@", readData]];
                }
                else {
                    [self.msgBuffer appendString:@"读块失败\r\n"];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
            }
        }
            
            break;
            
        case DKIso15693_Type: {
            Iso15693Card *iso15693Card = [self.bleNfcDevice getCard];
            if (iso15693Card != nil) {
                [self.msgBuffer setString:@"寻到ISO15693卡 －>UID:"];
                [self.msgBuffer appendString:[NSString stringWithFormat:@"%@\r\n", iso15693Card.uid]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                
                [self.msgBuffer appendString:@"写数据01020304到块0"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                Byte writeBytes[] = {0x01, 0x02, 0x03, 0x04};
                BOOL isSuc = [iso15693Card iso15693Write:0 writeData:[NSData dataWithBytes:writeBytes length:4]];
                if (!isSuc) {
                    [self.msgBuffer appendString:@"写入失败\r\n"];
                }
                else {
                    [self.msgBuffer appendString:@"写入成功\r\n"];
                }
                [self.msgBuffer appendString:@"开始读块0\r\n"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                //读取卡片0块数据
                NSData *returnData = [iso15693Card iso15693Read:0];
                [self.msgBuffer appendString:[NSString stringWithFormat:@"返回:%@\r\n", returnData]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                //写多个块
                [self.msgBuffer appendString:@"写数据0102030405060708到块5、6"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                Byte writeBytes1[] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};
                isSuc = [iso15693Card iso15693WriteMultiple:5 number:2 writeData:[NSData dataWithBytes:writeBytes1 length:8]];
                if (!isSuc) {
                    [self.msgBuffer appendString:@"写入失败\r\n"];
                }
                else {
                    [self.msgBuffer appendString:@"写入成功\r\n"];
                }
                [self.msgBuffer appendString:@"开始读块5、6数据\r\n"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                //读多个块
                returnData = [iso15693Card iso15693ReadMultiple:5 number:2];
                [self.msgBuffer appendString:[NSString stringWithFormat:@"返回:%@\r\n", returnData]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
            }
        }
            
            break;
            
        case DKUltralight_type: {//UL卡
            Ntag21x *ntag21x = [self.bleNfcDevice getCard];
            if (ntag21x != nil) {
                //ba646d04
                [self.msgBuffer setString:@"寻到Ultralight卡 －>UID:"];
                [self.msgBuffer appendString:[NSString stringWithFormat:@"%@\r\n", ntag21x.uid]];
                NSString *originStr = [CMUtility convertDataToHexStr:ntag21x.uid];
                NSLog(@"bytes 的16进制数为:%@--%@",[CMUtility convertDataToHexStr:ntag21x.uid],originStr);
                int idx = 8;
                NSString * subString = [originStr substringToIndex:idx];
                NSLog(@"subString1:%@--",subString);

                NSString * newStr = @"";
                for (int i = 0; i < 4; i++) {
                    NSString * twoSubString = [subString substringWithRange:NSMakeRange(i*2, 2)];
                    newStr = [NSString stringWithFormat:@"%@%@",twoSubString,newStr];
                }
                NSLog(@"newStr:%@--",newStr);

                if (newStr.length > 0) {
                    //根据设备degree获取 设备信息
                    [self requestNFCDetection:newStr];
                }else
                {
                    [CMUtility showTips:@"读取设备失败"];
                }
               
                
                
                
                break;

                
                Byte *testByte1 = (Byte *)[ntag21x.uid bytes];
                for(int i=0;i<[ntag21x.uid length];i++)
                {
                    printf("testByte = %d\n",testByte1[i]);
                }
                
                NSData *data1 = [ntag21x.uid subdataWithRange:NSMakeRange(0, 8)];
                Byte *bytes = (Byte *)[data1 bytes];
                NSString *hexStr=@"";
                for(int i=0;i<[data1 length];i++)
                {
                    NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
                    if([newHexStr length]==1)
                        hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
                    else
                        hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
                }
                NSLog(@"bytes 的16进制数为:%@",hexStr);
                
                NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                
                NSString *result1 =[[ NSString alloc] initWithData:ntag21x.uid encoding:gbkEncoding];
                NSLog(@" ntag21x.uid=======%@===str%@",ntag21x.uid,result1);
                

                [self.msgBuffer appendString:@"正在写入144个字节数据0xaa到卡片...\r\n"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                //开始写200字节数据到卡片
                Byte writeBytes[144]; //ba646f04
                memset(writeBytes, 0xAA, sizeof(writeBytes));
                writeBytes[0] = 0x0062;
                writeBytes[1] = 0x0061;
                writeBytes[2] = 0x0036;
                writeBytes[3] = 0x0034;
                writeBytes[4] = 0x0036;
                writeBytes[5] = 0x0066;
                writeBytes[6] = 0x0030;
                writeBytes[7] = 0x0034;
                
                Byte *buf = (Byte *)"ba646f04";
                NSData *adata = [[NSData alloc] initWithBytes:buf length:100000];
  
                int a = sizeof(buf) / sizeof(buf[0]);
                NSLog(@"sizeof(buf)==%ld==a===%d",sizeof(buf),a);
//                BOOL isSuc = [ntag21x ntag21xLongWrite:4 writeData:[NSData dataWithBytes:buf length:sizeof(buf)]];
//                if (!isSuc) {
//                    [self.msgBuffer appendString:@"写入失败\r\n"];
//                }
//                else {
//                    [self.msgBuffer appendString:@"写入成功\r\n"];
//                }
                [self.msgBuffer appendString:@"开始读144个字数据\r\n"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
                
                [ntag21x NdefTextReadWithCallbackBlock:^(BOOL isSuc, NSString *error, NSString *returnString) {
                    @strongify(self)
                    NSLog(@"----%@",returnString);
                }];
                
                NSData *readData = [ntag21x ntag21xLongRead:1 endAddress:1];
                Byte *testByte = (Byte *)[readData bytes];
                for(int i=0;i<[readData length];i++)
                {
                    printf("testByte = %d\n",testByte[i]);
                }
                
                Byte buf1[100];
                [readData getBytes:buf1 range:NSMakeRange(0, 100)];
                // 字节长度的计算，NSData 的 length 属性是只读的
                NSUInteger length1 = readData.length;
                NSString *result =[[ NSString alloc] initWithData:readData encoding:NSUnicodeStringEncoding];
                NSLog(@"readData===%@\n length1=%ld result=======%@",readData,length1,result);
                [self.msgBuffer appendString:[NSString stringWithFormat:@"返回data:%@string:%@\r\n ", readData,result]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    self.msgTextView.text = self.msgBuffer;
                });
            }
        }
            break;
            
        case DKDESFire_type:
            
            break;
            
        default:
            break;
    }
    
    return YES;
}

//读到卡片代理回调
#pragma mark - DKBleNfcDeviceDelegate
-(void)receiveRfnSearchCard:(BOOL)isblnIsSus cardType:(DKCardType)cardType uid:(NSData *)CardSn ats:(NSData *)bytCarATS{
    [self.msgBuffer appendString:@"寻到卡片："];
    [self.msgBuffer appendString:[CardSn description]];
    [self.msgBuffer appendString:@"\r\n"];
    [self.msgTextView setText:self.msgBuffer];
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        BOOL isAutoSearchCardFlag = [self.bleNfcDevice isAutoSearchCard];
        
        @try {
            BOOL isSuc = NO;
            //如果是自动寻卡寻到的卡，寻到卡后，先关闭自动寻卡
            if (isAutoSearchCardFlag) {
                //先关掉自动寻卡
                [self.bleNfcDevice stoptAutoSearchCard];
                
                //开始读卡
                isSuc = [self readWriteDemo:cardType];
                
                //读写卡成功，蜂鸣器快响3声
                if (isSuc) {
//                    [self.bleNfcDevice openBeep:50 offDelay:50 cnt:3];
                }
                else {
//                    [self.bleNfcDevice openBeep:100 offDelay:100 cnt:2];
                }
                
                //读卡结束，重新打开自动寻卡
                int cnt = 0;
                BOOL autoSearchCardFlag;
                do {
                    autoSearchCardFlag = [self.bleNfcDevice startAutoSearchCard:20 cardType:ISO14443_P4];
                }while (!autoSearchCardFlag && (cnt++ < 3));
                
                if (!autoSearchCardFlag) {
                    [self.msgBuffer appendString:[NSString stringWithFormat:@"不支持自动寻卡！\r\n"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        self.msgTextView.text = self.msgBuffer;
                    });
                }
            }
            else {
                //开始读卡
                isSuc = [self readWriteDemo:cardType];
                
                //如果不是自动寻卡，读卡结束,关闭天线
                [self.bleNfcDevice closeRf];
                
                //读写卡成功，蜂鸣器快响3声
                if (isSuc) {
//                    [self.bleNfcDevice openBeep:50 offDelay:50 cnt:3];
                }
                else {
//                    [self.bleNfcDevice openBeep:100 offDelay:100 cnt:2];
                }
            }
        } @catch (NSException *exception) {
            [self.msgBuffer appendString:[exception reason]];
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                self.msgTextView.text = self.msgBuffer;
            });
//            [self.bleNfcDevice openBeep:100 offDelay:100 cnt:2];
            
            if (isAutoSearchCardFlag) {
                //读卡失败，重新打开自动寻卡
                int cnt = 0;
                BOOL autoSearchCardFlag;
                do {
                    @try {
                        autoSearchCardFlag = [self.bleNfcDevice startAutoSearchCard:20 cardType:ISO14443_P4];
                    }@catch (NSException *exception) {
                        autoSearchCardFlag = false;
                    }
                }while (!autoSearchCardFlag && (cnt++ < 3));
                
                if (!autoSearchCardFlag) {
                    [self.msgBuffer appendString:[NSString stringWithFormat:@"不支持自动寻卡！\r\n"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        self.msgTextView.text = self.msgBuffer;
                    });
                }
            }
        } @finally {
        }
    });
}

/*
 * 函数说明：蓝牙搜索回调
 */
#pragma mark - DKBleManagerDelegate
-(void)DKScannerCallback:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSData *facturerData = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
    Byte *facturerDataBytes = (Byte *) [facturerData bytes];
    NSLog(@"工厂信息字段：%@", facturerData);
    
    //if ([peripheral.name isEqualToString:SEARCH_BLE_NAME]) {
    //通过广播数据过滤蓝牙设备
    if ( (facturerData != nil)
        && (facturerData.length > 4)
        && (facturerDataBytes[0] == 0x01)
        && (facturerDataBytes[1] == 0x7f)
        && (facturerDataBytes[2] == 0x54)
        && (facturerDataBytes[3] == 0x50)) {
        NSLog(@"搜到设备：%@ %@", peripheral, RSSI);
        if (self.mNearestBle != nil) {
            if ([RSSI integerValue] > lastRssi) {
                self.mNearestBle = peripheral;
            }
        }
        else {
            self.mNearestBle = peripheral;
            lastRssi = [RSSI integerValue];
        }
    }
}

/*
 * 函数说明：蓝牙状态回调
 */
#pragma mark - DKBleManagerDelegate 蓝牙状态
-(void)DKCentralManagerDidUpdateState:(CBCentralManager *)central {
    NSError *error = nil;
    switch (central.state) {
        case CBCentralManagerStatePoweredOn://蓝牙打开
        {
            //开始搜索设备
            [self fineNearBle];
        }
            break;
        case CBCentralManagerStatePoweredOff://蓝牙关闭
        {
            error = [NSError errorWithDomain:@"CBCentralManagerStatePoweredOff" code:-1 userInfo:nil];
            [CMUtility showTips:@"本机蓝牙未开启，请开启蓝牙"];
        }
            break;
        case CBCentralManagerStateResetting://蓝牙重置
        {
            //pendingInit = YES;
        }
            break;
        case CBCentralManagerStateUnknown://未知状态
        {
            error = [NSError errorWithDomain:@"CBCentralManagerStateUnknown" code:-1 userInfo:nil];
            [CMUtility showTips:@"蓝牙未知"];
        }
            break;
        case CBCentralManagerStateUnsupported://设备不支持
        {
            error = [NSError errorWithDomain:@"CBCentralManagerStateUnsupported" code:-1 userInfo:nil];
            [CMUtility showTips:@"本机不支持蓝牙"];
        }
            break;
        default:
            break;
    }
}

//蓝牙连接状态回调
-(void)DKCentralManagerConnectState:(CBCentralManager *)central state:(BOOL)state{
    if (state) {
        NSLog(@"蓝牙连接成功");
    }
    else {
        NSLog(@"蓝牙连接失败");
        [CMUtility showTips:@"蓝牙连接失败"];
        @weakify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            self.msgTextView.text = @"设备已断开！";
            //self.searchButton.titleLabel.text = @"搜索设备";
        });
    }
}


#pragma mark - myControll get
- (UILabel *)nfcLab
{
    if (!_nfcLab) {
        _nfcLab = [[UILabel alloc]initWithFrame:CGRectMake((DEF_DEVICE_WIDTH - 200)/2, self.device_scan.y+self.device_scan.height +DEF_DEVICE_SCLE_HEIGHT(94), 200, DEF_DEVICE_SCLE_HEIGHT(30))];
        _nfcLab.text = @"NFC";
        _nfcLab.font = DEF_MyFont(28);
        _nfcLab.textColor = DEF_COLOR_RGB(246, 156, 153);
        _nfcLab.textAlignment = NSTextAlignmentCenter;
    }
    return _nfcLab;
}

- (UILabel *)scanLab
{
    if (!_scanLab) {
        _scanLab = [[UILabel alloc]initWithFrame:CGRectMake((DEF_DEVICE_WIDTH - 200)/2, self.nfcLab.y+self.nfcLab.height +DEF_DEVICE_SCLE_HEIGHT(30), 200, DEF_DEVICE_SCLE_HEIGHT(30))];
        _scanLab.text = @"扫  一  扫";
        _scanLab.font = DEF_MyFont(22);
        _scanLab.textColor = DEF_COLOR_RGB(246, 156, 153);
        _scanLab.textAlignment = NSTextAlignmentCenter;
    }
    return _scanLab;
}
- (UILabel *)companyLab
{
    if (!_companyLab) {
        _companyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_DEVICE_HEIGHT - DEF_DEVICE_SCLE_HEIGHT(72)-DEF_DEVICE_SCLE_HEIGHT(30), DEF_DEVICE_WIDTH, DEF_DEVICE_SCLE_HEIGHT(30))];
        _companyLab.text = @"@上海槃古科技有限公司";
        _companyLab.textColor = DEF_COLOR_RGB(246, 156, 153);
        _companyLab.textAlignment = NSTextAlignmentCenter;
    }
    return _companyLab;
}

@end

