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

@interface DetectionViewController ()
{
    //系统蓝牙设备管理对象，可以把他理解为主设备，通过他，可以去扫描和链接外设
    CBCentralManager *manager;
    UILabel *info;
    //用于保存被发现设备
    NSMutableArray *discoverPeripherals;
}

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

@implementation DetectionViewController

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
    
    //根据设备degree获取 设备信息
    [self requestNFCDetection];
    
    
    //以下是蓝牙代码
    /*
     设置主设备的委托,CBCentralManagerDelegate
     必须实现的：
     - (void)centralManagerDidUpdateState:(CBCentralManager *)central;//主设备状态改变的委托，在初始化CBCentralManager的适合会打开设备，只有当设备正确打开后才能使用
     其他选择实现的委托中比较重要的：
     - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设的委托
     - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
     - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
     - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
     */
    
    //初始化并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
    
    
    /*
    manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    
    //持有发现的设备,如果不持有设备会导致CBPeripheralDelegate方法不能正确回调
    discoverPeripherals = [[NSMutableArray alloc]init];
    //页面样式
    [self.view setBackgroundColor:[UIColor whiteColor]];
    info = [[UILabel alloc]initWithFrame:self.view.frame];
    [info setText:@"正在执行程序，请观察NSLog信息"];
    [info setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:info];
    */
}

- (void)requestNFCDetection
{
    @weakify(self)
    NSString *degreeStr  = @"ba646f04";
    NSString *degreeStr1 = @"ba2c1704";

    [[self.viewModel nfcDetectionFromDegree:degreeStr] subscribeNext:^(id result) {
        @strongify(self);
        
        DetectionModel *model = self.viewModel.detectionList[0];
       
        NSArray *buttonTitles;
        NSArray *buttonTitlesColor;
        NSArray *buttonTitlesBackGroundColor;
        
        if (self.nfcDetectionStatus == NFC_DETECTION_AFFIRNM) {
            buttonTitles = @[ @"确认巡检", @"申请检修", @"取消" ];
            buttonTitlesColor = @[[UIColor whiteColor], [UIColor whiteColor],[UIColor whiteColor] ];
            buttonTitlesBackGroundColor = @[ DEF_COLOR_RGB(83,207,176),DEF_COLOR_RGB(233,129,113),DEF_COLOR_RGB(171,171,171)];
        }else if (self.nfcDetectionStatus == NFC_DETECTION_JIANXIU)
        {
            buttonTitles = @[ @"申请检修", @"取消" ];
            buttonTitlesColor = @[[UIColor whiteColor],[UIColor whiteColor] ];
            buttonTitlesBackGroundColor = @[ DEF_COLOR_RGB(233,129,113),DEF_COLOR_RGB(171,171,171)];
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
              
            } else if (buttonIndex == 1)
            {
                if (self.nfcDetectionStatus == NFC_DETECTION_AFFIRNM)
                {
                    ApplicationForInspectionViewController *avc = [[ApplicationForInspectionViewController alloc]init];
                    avc.nfcDetectionStatus = NFC_DETECTION_JIANXIU;
                    avc.detectionModel = model;
                    avc.degreeStr = degreeStr1;
                    [self.navigationController pushViewController:avc animated:YES];
                }else if (self.nfcDetectionStatus == NFC_DETECTION_JIANXIU)
                {
                    NSLog(@"点击取消");
                    [self.navigationController popViewControllerAnimated:YES];

                }
               
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


- (UIView *)addSubViewWithContent:(NSString *)content
{
    NSString *str = content;
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
    
     CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(DEF_DEVICE_SCLE_WIDTH(190), MAXFLOAT) font:DEF_MyFont(16) string:tmpStr withSpacing:5];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH - DEF_DEVICE_SCLE_WIDTH(190), contentSize.height + DEF_DEVICE_SCLE_HEIGHT(70) + DEF_DEVICE_SCLE_HEIGHT(50))];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.width/2, DEF_DEVICE_SCLE_HEIGHT(70))];
    titleLab.text = @"巡检要求";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font =DEF_MyFont(20);
    titleLab.textColor = DEF_COLOR_RGB(132,132,132);
//    titleLab.backgroundColor = [UIColor yellowColor];
    [view addSubview:titleLab];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((view.width - contentSize.width)/2, DEF_DEVICE_SCLE_HEIGHT(70) + DEF_DEVICE_SCLE_HEIGHT(25), contentSize.width, contentSize.height)];
    lab.attributedText = [CMUtility setLineSpacingWithString:tmpStr withFont:16 spacing:5];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.lineBreakMode = UILineBreakModeWordWrap;
    lab.numberOfLines = 0;
    lab.font =DEF_MyFont(16);
    lab.textColor = DEF_COLOR_RGB(27,27,27);
//    lab.backgroundColor = [UIColor yellowColor];
    [view addSubview:lab];
    
    return view;
}

-(void)handleTap:(id)sender{
    self.isPause = self.isPause;
    if (self.isPause) {
        [self pauseLayer:self.device_rotate.layer];
    }else
    {
        [self resumeLayer:self.device_rotate.layer];
    }
}



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

//实现代理方法
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);

    if (layer == self.layertime) {
        CGContextDrawImage(ctx, CGRectMake(0, 0, self.rotateImage.size.width, self.rotateImage.size.height), self.rotateImage.CGImage);
    }
    
    
    CGContextRestoreGState(ctx);
    
    
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            //开始扫描周围的外设
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            [central scanForPeripheralsWithServices:nil options:nil];
            
            break;
        default:
            break;
    }
    
}

//扫描到设备会进入方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSLog(@"当扫描到设备:%@",peripheral.name);
    //接下连接我们的测试设备，如果你没有设备，可以下载一个app叫lightbule的app去模拟一个设备
    //这里自己去设置下连接规则，我设置的是P开头的设备
    //    if ([peripheral.name hasPrefix:@"P"]){
    /*
     一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
     - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
     - (void)centra`lManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
     - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
     */
    
    //找到的设备必须持有它，否则CBCentralManager中也不会保存peripheral，那么CBPeripheralDelegate中的方法也不会被调用！！
    [discoverPeripherals addObject:peripheral];
    [central connectPeripheral:peripheral options:nil];
    //    }
    
    
}


//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    
}
//连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    //设置的peripheral委托CBPeripheralDelegate
    //@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
    [peripheral setDelegate:self];
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    [peripheral discoverServices:nil];
    
}


//扫描到Services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"%@",service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}

//扫描到Characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
    }
    
    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        {
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
    
    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
    
    
}

//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
    
}

//搜索到Characteristic的Descriptors
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    NSLog(@"characteristic uuid:%@",characteristic.UUID);
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor uuid:%@",d.UUID);
    }
    
}
//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}

//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{
    
    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知知道这几个基本就够用了，前连个是读写权限，后两个都是通知，两种不同的通知方式。
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast                                                = 0x01,
     CBCharacteristicPropertyRead                                                    = 0x02,
     CBCharacteristicPropertyWriteWithoutResponse                                    = 0x04,
     CBCharacteristicPropertyWrite                                                    = 0x08,
     CBCharacteristicPropertyNotify                                                    = 0x10,
     CBCharacteristicPropertyIndicate                                                = 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites                                = 0x40,
     CBCharacteristicPropertyExtendedProperties                                        = 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)        = 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)    = 0x200
     };
     
     */
    NSLog(@"%lu", (unsigned long)characteristic.properties);
    
    
    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }else{
        NSLog(@"该字段不可写！");
    }
    
    
}

//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

//停止扫描并断开连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager
                 peripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

