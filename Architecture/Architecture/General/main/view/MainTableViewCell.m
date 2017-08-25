//
//  MainTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 16/8/11.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//



#import "MainTableViewCell.h"
#import "RoundnessProgressView.h"
@interface MainTableViewCell()

@property (nonatomic, strong)UIImageView *groupIV;

@property (nonatomic, strong)UIImageView *groupIV1;


@property (nonatomic, strong)UIButton *warningBtn;
@property (nonatomic, strong)UIButton *fixBtn;
@property (nonatomic, strong)UIButton *noneBtn;

@property (nonatomic, strong)UIImageView *pressIV;
@property (nonatomic, assign)CGFloat pressWidth;

@property (nonatomic, strong)UILabel *pressLab;

@property (nonatomic, assign)CGFloat cellHeight;
//圆形进度条
@property (nonatomic,strong)RoundnessProgressView *roundnessProgressView;


@end
@implementation MainTableViewCell
+ (CGFloat)mainCellHeight
{
    return DEF_DEVICE_SCLE_HEIGHT(260);
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.cellHeight = DEF_DEVICE_SCLE_HEIGHT(260);
    
    UIImageView *groupIV = [[UIImageView alloc]init];
    groupIV.frame = CGRectMake(10, 5, DEF_DEVICE_WIDTH-20, self.cellHeight - 15);
    groupIV.backgroundColor = [UIColor clearColor];
    groupIV.userInteractionEnabled = YES;
//    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:groupIV];
    self.groupIV = groupIV;
    
    //给bgView边框设置阴影 self.bgView.layer.shadowOffset = CGSizeMake(1,1);
//    self.groupIV.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.groupIV.layer.shadowOffset = CGSizeMake(0, 10);
//    self.groupIV.layer.shadowOpacity = 0.3;
//    self.groupIV.clipsToBounds = false; //这句最重要了，不然就显示不出来
    
   [self.groupIV addSubview:self.warningBtn];
    
    self.warningBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.warningBtn.layer.shadowOffset = CGSizeMake(0, 10);
    self.warningBtn.layer.shadowOpacity = 0.3;
    self.warningBtn.clipsToBounds = false; //这句最重要了，不然就显示不出来
    
    [self.groupIV addSubview:self.fixBtn];
    self.fixBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.fixBtn.layer.shadowOffset = CGSizeMake(0, 10);
    self.fixBtn.layer.shadowOpacity = 0.3;
    self.fixBtn.clipsToBounds = false; //这句最重要了，不然就显示不出来

    
    
    
    
    UIImageView *groupIV1 = [[UIImageView alloc]init];
    groupIV1.frame = CGRectMake(10, 5, DEF_DEVICE_WIDTH-20, self.cellHeight - 15);
    groupIV1.backgroundColor = [UIColor clearColor];
    groupIV1.userInteractionEnabled = YES;
    //    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:groupIV1];
    self.groupIV1 = groupIV1;
    
    //给bgView边框设置阴影 self.bgView.layer.shadowOffset = CGSizeMake(1,1);
    self.groupIV1.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.groupIV1.layer.shadowOffset = CGSizeMake(0, 10);
    self.groupIV1.layer.shadowOpacity = 0.3;
    self.groupIV1.clipsToBounds = false; //这句最重要了，不然就显示不出来
    
    
    UIImageView *pressIV = [[UIImageView alloc]init];
    pressIV.frame = CGRectMake(0, 0, self.groupIV1.width, self.groupIV1.height);
    //groupIV.image = DEF_IMAGENAME(@"group_login_head");
    pressIV.userInteractionEnabled = YES;
    //    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    pressIV.backgroundColor = [UIColor whiteColor];
    [self.groupIV1 addSubview:pressIV];
    self.pressIV = pressIV;
    
    self.pressIV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.pressIV.layer.shadowOffset = CGSizeMake(0, 10);
    self.pressIV.layer.shadowOpacity = 0.3;
    self.pressIV.clipsToBounds = false; //这句最重要了，不然就显示不出来
    
    //圆形进度条
    
    [self.pressIV addSubview:self.pressLab];


    self.groupIV.hidden = YES;
    
    self.groupIV1.hidden = YES;
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [self.pressIV addGestureRecognizer:singleRecognizer];
    
    @weakify(self);
    self.warningBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.mainTablecellclick(1);
        return [RACSignal empty];
    }];
    
    self.fixBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.mainTablecellclick(2);
        return [RACSignal empty];
    }];
    
}

- (void)setMainModel:(MainModel *)mainModel
{
    NSLog(@"index--%ld--%ld",(long)mainModel.row,(long)mainModel.progressSections);
 
    self.pressWidth = 60;

#pragma mark - 圆绘制进度
    
    if (_roundnessProgressView) {
        [self.roundnessProgressView removeFromSuperview];
    }
    
    _roundnessProgressView = [[RoundnessProgressView alloc]initWithFrame:CGRectMake((self.pressIV.width-self.pressWidth)/2 , (self.pressIV.height-self.pressWidth)/2 - 15, self.pressWidth, self.pressWidth)];
    _roundnessProgressView.thicknessWidth = 4;
    _roundnessProgressView.completedColor = [UIColor UIColorFromRGB:0xE0DBDB alpha:1];
    _roundnessProgressView.labelColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
    _roundnessProgressView.incompletedColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
    
    _roundnessProgressView.backgroundColor = [UIColor clearColor];
    [self.pressIV addSubview:_roundnessProgressView];
    
    _roundnessProgressView.progressTotal = 100;
    _roundnessProgressView.progressSections =mainModel.progressSections + 0.5;
    
    
    if (mainModel.row == 0) {
        self.groupIV.hidden = NO;
        self.groupIV1.hidden = YES;
    }else if(mainModel.row == 1)
    {
        self.groupIV.hidden = YES;
        self.groupIV1.hidden = NO;
    }else
    {
        self.groupIV.hidden = YES;
        self.groupIV1.hidden = NO;
        //self.pressIV.hidden = YES;
        self.pressLab.hidden = YES;
        _roundnessProgressView.hidden = YES;
    }
}

#pragma mark - 单击双击 -

- (void)handleSingleTapFrom:(UIGestureRecognizer *)gestureRecognizer {
    self.mainTablecellclick(2);
}

-(UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}


- (UILabel *)pressLab
{
    if (!_pressLab) {
        
        NSString *pressStr = @"当前巡检完成度";
        CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) font:DEF_MyFont(15) string:pressStr withSpacing:0];
        
        _pressLab = [[UILabel alloc] initWithFrame:CGRectMake((self.pressIV.width-contentSize.width)/2 , (self.pressIV.height-contentSize.height)/2 + 33, contentSize.width, contentSize.height)];
        _pressLab.font = DEF_MyFont(15);
        _pressLab.text = pressStr;
        _pressLab.userInteractionEnabled = YES;
        _pressLab.backgroundColor = [UIColor clearColor];
        _pressLab.textAlignment = NSTextAlignmentCenter;
        _pressLab.textColor = DEF_COLOR_RGB(67, 67, 67);
    }
    return _pressLab;
}

-(UIButton *)warningBtn
{
    if (!_warningBtn) {
        UIImage *warningImage = DEF_IMAGENAME(@"device_warning_info");
        
        NSString *warningStr = @"设备告警信息";
        UIButton *warningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        warningBtn.frame = CGRectMake(0, 0, (DEF_DEVICE_WIDTH-30)/2, self.groupIV.height);
        warningBtn.backgroundColor = [UIColor whiteColor];
        [warningBtn setImage:warningImage forState:UIControlStateNormal];
        [warningBtn setTitle:warningStr forState:UIControlStateNormal];
        [warningBtn setTitleColor:DEF_COLOR_RGB(67, 67, 67)forState:UIControlStateNormal];
        warningBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        warningBtn.titleLabel.font = DEF_MyFont(15);
        warningBtn.titleLabel.backgroundColor = [UIColor clearColor];
        
        _warningBtn = warningBtn;
        
        //图片是60*60的2x的图
        CGFloat imageWidth = warningImage.size.width;
        CGFloat imageHeight = warningImage.size.height;
        
        
        CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) font:DEF_MyFont(15) string:warningStr withSpacing:0];
        CGFloat labelWidth = contentSize.width;
        
        CGFloat labelHeight= contentSize.height;
        
        CGFloat spacing = 15;
        CGFloat changeFloat = 15;
        
        //image在上，文字在下
        CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
        CGFloat imageOffsetY = imageHeight / 2 + spacing / 2 -changeFloat;//image中心移动的y距离
        //CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2 - 10;//label中心移动的x距离
        CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
        
        CGFloat labelOffsetY = labelHeight / 2 + spacing / 2 + changeFloat;//label中心移动的y距离
        _warningBtn.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
        _warningBtn.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
    }
    return _warningBtn;
}

-(UIButton *)fixBtn
{
    if (!_fixBtn) {
        UIImage *warningImage = DEF_IMAGENAME(@"device_service");

        NSString *fixStr = @"当前设备检修记录";
        UIButton *fixBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fixBtn.frame = CGRectMake((DEF_DEVICE_WIDTH-30)/2 + 10, 0, (DEF_DEVICE_WIDTH-30)/2, self.groupIV.height);
        fixBtn.backgroundColor = [UIColor whiteColor];
        [fixBtn setImage:warningImage forState:UIControlStateNormal];
        [fixBtn setTitle:fixStr forState:UIControlStateNormal];
        [fixBtn setTitleColor:DEF_COLOR_RGB(67, 67, 67)forState:UIControlStateNormal];
        fixBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        fixBtn.titleLabel.font = DEF_MyFont(15);
        fixBtn.titleLabel.backgroundColor = [UIColor clearColor];
        
        _fixBtn = fixBtn;
        
        //图片是60*60的2x的图
        CGFloat imageWidth = warningImage.size.width;
        CGFloat imageHeight = warningImage.size.height;
        
        CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) font:DEF_MyFont(15) string:fixStr withSpacing:0];
        CGFloat labelWidth = contentSize.width;
        
        CGFloat labelHeight= contentSize.height;
        
        CGFloat spacing = 15;
        CGFloat changeFloat = 15;
        
        //image在上，文字在下
        CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
        CGFloat imageOffsetY = imageHeight / 2 + spacing / 2 -changeFloat;//image中心移动的y距离
        //CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2 - 10;//label中心移动的x距离
        CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
        
        CGFloat labelOffsetY = labelHeight / 2 + spacing / 2 + changeFloat;//label中心移动的y距离
        _fixBtn.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
        _fixBtn.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
    }
    return _fixBtn;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _groupIV.image = nil;
    
    //_nameLab.text = @"";
//    _messageNumLab.text = @"";
//    _timeLab.text = @"";
//    _descriptionLab.text = @"";

}

@end
