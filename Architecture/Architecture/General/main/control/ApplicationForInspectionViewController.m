//
//  ApplicationForInspectionViewController.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/14.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "ApplicationForInspectionViewController.h"

@interface ApplicationForInspectionViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIPickerView *myPickerView;
@property (nonatomic,strong)NSArray *proTimeList;
@property (nonatomic,strong)NSString *actegoriesStr;
@property (nonatomic,assign)NSInteger selectRow;
@property (nonatomic,assign)NSInteger currentTag;

@property (nonatomic,strong)UIView *whiteView;

@property (nonatomic,strong)NSMutableDictionary *imageDic;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UIAlertController      *imgActionSheet;        //头像选择弹出框

@property (nonatomic,strong)CMTakePhoto *photoPicker;           //照片选择器

@end

@implementation ApplicationForInspectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.titleLb.text = self.detectionModel.Eqname;
    
    self.imageDic = [NSMutableDictionary dictionaryWithCapacity:10];
    
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, DEF_DEVICE_SCLE_HEIGHT(78))];
    contentLab.font = DEF_MyFont(15);
    contentLab.textColor =DEF_COLOR_RGB(87,87,87);
    contentLab.text = @"     申请检修内容";
    contentLab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentLab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT + contentLab.height -2, DEF_DEVICE_WIDTH,2)];
    lineView.backgroundColor = DEF_COLOR_RGB(247,247,247);
    [self.view addSubview:lineView];
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT + contentLab.height, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - DEF_NAVIGATIONBAR_HEIGHT - contentLab.height)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.whiteView];
    
    
    
        // 选择框
        self.myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake((DEF_DEVICE_WIDTH - 200)/2, DEF_DEVICE_SCLE_HEIGHT(172), 200, 216)];
        // 显示选中框
        self.myPickerView.showsSelectionIndicator=YES;
        self.myPickerView.dataSource = self;
        self.myPickerView.delegate = self;
        [self.whiteView addSubview:self.myPickerView];
        
        
        _proTimeList = [self.detectionModel.Faulttypes componentsSeparatedByString:@","];
        self.actegoriesStr = _proTimeList[0];
        
        UILabel *fixLab = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_DEVICE_SCLE_HEIGHT(172), DEF_DEVICE_WIDTH, DEF_DEVICE_SCLE_HEIGHT(20))];
        fixLab.font = DEF_MyFont(19);
        fixLab.textColor =DEF_COLOR_RGB(244,205,203);
        fixLab.text = @"请选择检修类型";
        fixLab.textAlignment = NSTextAlignmentCenter;
        [self.whiteView addSubview:fixLab];    
    
    
    
    NSArray *nameArray = @[
                           @"提 交",
                           @"取 消"
                           ];
    NSArray *normalArray = @[
                             @"submit_bottom_normal",
                             @"cancel_bottom_normal"
                             ];
    
    NSArray *selectedArray = @[
                               @"submit_bottom_selected",
                               @"ucancel_bottom_selected"
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
        btn.frame = CGRectMake(btnX, self.whiteView.height - DEF_DEVICE_SCLE_HEIGHT(57) - btnHeight , btnWidth, btnHeight);
        
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
        
        [self.whiteView addSubview:btn];
    }];
    
    //描述
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_SCLE_WIDTH(52), self.whiteView.height - DEF_DEVICE_SCLE_HEIGHT(218) - btnHeight, 50, 50)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines = 0;
    lab.textColor = DEF_COLOR_RGB(27,27,27);
//    lab.backgroundColor = [UIColor yellowColor];
    
    NSString *str = @"描述\n (必填)";
    NSArray *tempArr = [str componentsSeparatedByString:@" "];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:18.0]
                          range:NSMakeRange(0, ((NSString *)tempArr[0]).length)];
    
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:13.0]
                          range:NSMakeRange(((NSString *)tempArr[0]).length, ((NSString *)tempArr[1]).length+1)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor lightGrayColor]
                          range:NSMakeRange(((NSString *)tempArr[0]).length, ((NSString *)tempArr[1]).length+1)];
   
    lab.attributedText = AttributedStr;
    [self.whiteView addSubview:lab];
    
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(DEF_DEVICE_SCLE_WIDTH(52) + 50, lab.y + 5, DEF_DEVICE_WIDTH - DEF_DEVICE_SCLE_WIDTH(110) - 50, DEF_DEVICE_SCLE_HEIGHT(108))];
    // 设置文本框背景颜色
    self.textView.backgroundColor = DEF_COLOR_RGB(238,238,238);
    //外框
//    self.textView.layer.borderColor = [UIColor redColor].CGColor;
//    self.textView.layer.borderWidth = 1;
//    self.textView.layer.cornerRadius =5;
    
    [self.whiteView addSubview:self.textView];
    
    
    CGFloat cameraWidth = DEF_DEVICE_SCLE_WIDTH(100);
    CGFloat cameraHeight = DEF_DEVICE_SCLE_HEIGHT(100);
    CGFloat cameraX = DEF_DEVICE_SCLE_WIDTH(42);
    CGFloat cameraSpace = DEF_DEVICE_SCLE_WIDTH(6);

    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(cameraX + (cameraSpace+cameraWidth)*i, lab.y - DEF_DEVICE_SCLE_HEIGHT(160), cameraWidth, cameraHeight)];
        imageView.backgroundColor = DEF_COLOR_RGB(238,238,238);
        if (i == 0) {
            imageView.image = DEF_IMAGENAME(@"camera");
        }
        imageView.tag = 200+i;
        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [imageView addGestureRecognizer:tap];
        
        //初始化一个长按手势
        UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
        //长按等待时间
        //longPressGest.minimumPressDuration = 3;
        //长按时候,手指头可以移动的距离
        //longPressGest.allowableMovement = 30;
        [imageView addGestureRecognizer:longPressGest];
        
        [self.whiteView addSubview: imageView];
        
        
    }
}

- (void)leftBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)handleTap:(UITapGestureRecognizer *)sender{
    
    UIView *view = sender.view;
    if (view.tag == 200) {
        NSLog(@"调用相机");
//        if (self.imageArray.count < 4) {
//
//            [self presentViewController:self.imgActionSheet animated:YES completion:nil];
//        }else
//        {
//            [CMUtility showTips:@"最多只能上传3张图片"];
//        }
    }else
    {
        self.currentTag = view.tag;
        [self presentViewController:self.imgActionSheet animated:YES completion:nil];
    }
    
}

-(void)longPressView:(UILongPressGestureRecognizer *)longPressGest
{
    UIImageView *view = (UIImageView *)longPressGest.view;

    if (view.image) {
        //NSString *title = NSLocalizedString(@"A Short Title Is Best", nil);
        NSString *message = NSLocalizedString(@"是否要删除照片？", nil);
        NSString *cancelButtonTitle = NSLocalizedString(@"否", nil);
        NSString *otherButtonTitle = NSLocalizedString(@"是", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NULL message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"The \"Cancel\" alert's cancel action occured.");
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"删除照片");
            view.image = NULL;
            
            [self.imageDic removeObjectForKey:[NSString stringWithFormat:@"%ld",view.tag]];
            [self.imageDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSLog(@"imageDic==%@", obj);
                
            }];
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)xunjianBtnclick:(UIButton *)btn
{
    NSUInteger BtnTag = btn.tag;
    if (BtnTag == 100) {
        
        __block NSString *imagesStr = @"";
        NSArray *imageArray = (NSArray *)self.imageDic.allKeys;
        if (imageArray.count > 0) {
            [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *str = [NSString stringWithFormat:@"%@",obj];
                NSString *symbol = idx == (imageArray.count - 1) ?@"":@",";
                NSString *newStr = [str stringByAppendingString:symbol];
                imagesStr =[imagesStr stringByAppendingString:newStr];
            }];
        }
        if ([DEF_OBJECT_TO_STIRNG(self.textView.text) isEqualToString:@""]) {
            [CMUtility showTips:@"请输入异常描述"];
            return;
        }
        if ([DEF_OBJECT_TO_STIRNG(self.actegoriesStr)  isEqualToString:@""]) {
            [CMUtility showTips:@"请选择检修类型"];
            return;
        }
        
        NSString *path = [UploadingModel filePath];

        UploadingModel *uploadingModel = [[UploadingModel alloc]init];
        uploadingModel.Degree = self.degreeStr;
        uploadingModel.State = @"4";
        uploadingModel.images = imagesStr;
        uploadingModel.Describe = self.textView.text;
        uploadingModel.Actegories = self.actegoriesStr;
        
        uploadingModel.Eqname = self.detectionModel.Eqname;
        uploadingModel.Floorsn = self.detectionModel.Floorsn;
        uploadingModel.timeT = [CMUtility currentTimestampSecond];
        
        NSMutableDictionary *tmpDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (tmpDic == nil) {
            tmpDic =[NSMutableDictionary dictionaryWithCapacity:10];
        }
        [tmpDic setObject:uploadingModel forKey:uploadingModel.Degree];
        
        BOOL isSave = [NSKeyedArchiver archiveRootObject:tmpDic toFile:path];
        if (isSave) {
            [CMUtility showTips:@"提交检修成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [CMUtility showTips:@"提交检修失败"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_proTimeList count];
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 180;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSString  *_proTimeStr = [_proTimeList objectAtIndex:row];
    self.actegoriesStr = _proTimeStr;
    NSLog(@"_proTimeStr=%@",_proTimeStr);
    self.selectRow = row;
    [self.myPickerView reloadAllComponents];
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [_proTimeList objectAtIndex:row];

}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.font = DEF_MyFont(20);
    
    if (row == self.selectRow)
    {
        pickerLabel.textColor = DEF_COLOR_RGB(230,84,80);
    }
    else
    {
        pickerLabel.textColor = DEF_COLOR_RGB(178,178,178);
    }
    return pickerLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CMTakePhoto *)photoPicker
{
    if (!_photoPicker) {
        _photoPicker = [[CMTakePhoto alloc]init];
    }
    return _photoPicker;
}

- (UIAlertController *)imgActionSheet
{
    if (!_imgActionSheet) {
        _imgActionSheet = [UIAlertController alertControllerWithTitle:nil message:@"选取照片" preferredStyle:UIAlertControllerStyleActionSheet];
        @weakify(self)
        [self addActionTarget:_imgActionSheet title:@"拍照" color: DEF_APP_MAIN_COLOR action:^(UIAlertAction *action) {
            @strongify(self)
            [self.photoPicker toTakePhotoWithViewController:self andComplete:^(UIImage *img){
                @strongify(self)
                if (img) {
                    [self uploadingImage:img];
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        self.headImageView.image = img;
//                        self.headImg = [self imageCompressForWidth:img targetWidth:600];
//                        NSData *imageData = UIImageJPEGRepresentation(self.headImg,0.001);
//                        UIImage *m_selectImage = [UIImage imageWithData:imageData];
//                        self.headImg = m_selectImage;
//
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self updateHeadImage];
//                        });
//                    });
                }
            }];
        }];
        [self addActionTarget:_imgActionSheet title:@"从相册中选取" color: DEF_APP_MAIN_COLOR action:^(UIAlertAction *action) {
            @strongify(self)
            [self.photoPicker toSelectPhotoWithViewController:self andComplete:^(UIImage *img){
                if (img) {
                    [self uploadingImage:img];
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        self.headImageView.image = img;
//                        //                        NSData *imgData = UIImageJPEGRepresentation(img, 0.5);
//                        //                        self.headImg = [UIImage imageWithData:imgData];
//                        self.headImg = [self imageCompressForWidth:img targetWidth:600];
//                        NSData *imageData = UIImageJPEGRepresentation(self.headImg,0.001);
//                        UIImage *m_selectImage = [UIImage imageWithData:imageData];
//                        self.headImg = m_selectImage;
//                        NSLog(@"m_selectImage:%@",m_selectImage);
//
//                        dispatch_async(dispatch_get_main_queue(), ^{
//
//                            [self updateHeadImage];
//                        });
//                    });
                }
            }];
            
        }];
        [self addCancelActionTarget:_imgActionSheet title:@"取消"];
        
    }
    return _imgActionSheet;
}

// 取消按钮
-(void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                             {
                             }];
    [action setValue:DEF_APP_MAIN_COLOR forKey:@"_titleTextColor"]; [alertController addAction:action];
}
//添加对应的title    这个方法也可以传进一个数组的titles  我只传一个是为了方便实现每个title的对应的响应事件不同的需求不同的方法
- (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(UIColor *)color action:(void(^)(UIAlertAction *action))actionTarget {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { actionTarget(action); }];
    [action setValue:color forKey:@"_titleTextColor"];
    [alertController addAction:action];
}



- (void)uploadingImage:(UIImage *)img
{
    NSLog(@"=======%@",img);
    @weakify(self)
    [CMUtility showMBProgress:self.view message:@"上传中..."];
    [[self RACUploadingImage:img] subscribeNext:^(id result) {
        @strongify(self)
        [CMUtility hideMBProgress:self.view];
        NSString *str = result;
        if ([str containsString:@"ios_"]) {
            UIImageView *iV = [self.view viewWithTag:self.currentTag];
            iV.image =img;
            //放入字典
            [self.imageDic setObject:str forKey:[NSString stringWithFormat:@"%ld",self.currentTag]];
            
            [self.imageDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSLog(@"imageDic==%@", obj);
                
            }];
            [CMUtility hideMBProgress:self.view];
        } else {
            [CMUtility hideMBProgress:self.view];
            [CMUtility showTips:@"上传失败"];
        }
        
    }];
}

- (RACSignal *)RACUploadingImage:(UIImage *)headImage
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //[CMUtility showMBProgress:self.view message:@"发送中..."];
        //参数
        NSDictionary *tempDic = @{
                                  @"imgUploader" :headImage,
                                  };
        [RequestOperationManager apiPOSTImageRequestParametersDic:tempDic success:^(NSDictionary *result) {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failture:^(id result) {
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        }];
        return nil;
    }] doError:^(NSError *error) {
        
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)keyBoardHide
{
    [self.view endEditing:YES];
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
