//
//  MainTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 16/8/11.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#define BannerHeight (DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT - DEF_TABBAR_HEIGHT)/3

#define CellHeight (DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT - DEF_TABBAR_HEIGHT - BannerHeight)/3


#import "MainTableViewCell.h"
#import "RoundnessProgressView.h"
@interface MainTableViewCell()

@property (nonatomic, strong)UIImageView *groupIV;

@property (nonatomic, strong)UIButton *warningBtn;
@property (nonatomic, strong)UIButton *fixBtn;
@property (nonatomic, strong)UIButton *noneBtn;

@property (nonatomic, strong)UIImageView *pressIV;


@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *messageNumLab;
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *descriptionLab;

//圆形进度条
@property (nonatomic,strong)RoundnessProgressView *roundnessProgressView;


@end
@implementation MainTableViewCell
+ (CGFloat)mainCellHeight
{
    return CellHeight;
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
    
    CGFloat groupIVWidth = 50.0f;

    UIImageView *groupIV = [[UIImageView alloc]init];
    groupIV.frame = CGRectMake(10, 5, self.width-20, CellHeight - 15);
    groupIV.backgroundColor = [UIColor clearColor];
    //groupIV.image = DEF_IMAGENAME(@"group_login_head");
    groupIV.userInteractionEnabled = YES;
//    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:groupIV];
    self.groupIV = groupIV;
    
    //给bgView边框设置阴影 self.bgView.layer.shadowOffset = CGSizeMake(1,1);
    self.groupIV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.groupIV.layer.shadowOffset = CGSizeMake(0, 10);
    self.groupIV.layer.shadowOpacity = 0.3;
    self.groupIV.clipsToBounds = false; //这句最重要了，不然就显示不出来
    
    
    
    
    
    UIButton *warningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    warningBtn.frame = CGRectMake(0, 0, (self.width-30)/2, self.groupIV.height);
    warningBtn.backgroundColor = [UIColor whiteColor];
    [warningBtn setImage:DEF_IMAGENAME(@"deviceWarning") forState:UIControlStateNormal];
    [warningBtn setTitle:@"设备告警信息" forState:UIControlStateNormal];
    [warningBtn setTitleColor:DEF_COLOR_RGB(67, 67, 67)forState:UIControlStateNormal];
    warningBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    warningBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    //warningBtn.titleLabel.backgroundColor = [UIColor redColor];

    //warningBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //warningBtn.titleLabel.textColor = DEF_COLOR_RGB(67, 67, 67);
    //    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    [self.groupIV addSubview:warningBtn];
    self.warningBtn = warningBtn;

    //图片是60*60的2x的图
    CGFloat imageWidth = 50;
    CGFloat imageHeight = 50;
    CGFloat labelWidth = [self.warningBtn.titleLabel.text sizeWithFont:self.warningBtn.titleLabel.font].width;
    CGFloat labelHeight = [self.warningBtn.titleLabel.text sizeWithFont:self.warningBtn.titleLabel.font].height;
    
    CGFloat spacing = 0;
    
    //image在上，文字在下
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2 - 15;//image中心移动的y距离
    //CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2 - 10;//label中心移动的x距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2 - 10;//label中心移动的x距离

    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2 +15;//label中心移动的y距离
    self.warningBtn.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
    self.warningBtn.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
    
    
    UIImageView *pressIV = [[UIImageView alloc]init];
    pressIV.frame = CGRectMake((self.width-30)/2 + 10, 0, (self.width-30)/2, self.groupIV.height);
    pressIV.backgroundColor = [UIColor yellowColor];
    //groupIV.image = DEF_IMAGENAME(@"group_login_head");
    pressIV.userInteractionEnabled = YES;
    //    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    pressIV.backgroundColor = [UIColor redColor];
    [self.groupIV addSubview:pressIV];
    self.pressIV = pressIV;
    
    [self.pressIV addSubview:self.roundnessProgressView];

    
    return;
    
    CGFloat messageNumLabWidth = 18.0f;
    UILabel *messageNumLab = [[UILabel alloc] initWithFrame:CGRectMake(groupIV.x + groupIV.width - messageNumLabWidth/2, groupIV.y - messageNumLabWidth/2 + 5, messageNumLabWidth, messageNumLabWidth)];
    messageNumLab.font = DEF_MyFont(8.0f);
    messageNumLab.text = @"";
    messageNumLab.userInteractionEnabled = YES;
    messageNumLab.backgroundColor = [UIColor redColor];
    messageNumLab.textAlignment = NSTextAlignmentCenter;
    messageNumLab.textColor = [UIColor whiteColor];
    messageNumLab.layer.cornerRadius = messageNumLabWidth/2;
    messageNumLab.clipsToBounds = YES;
    messageNumLab.hidden = YES;
    [self.contentView addSubview:messageNumLab];
    self.messageNumLab = messageNumLab;
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(DEF_DEVICE_WIDTH - 55, 0, 50, CellHeight)];
    timeLab.font = DEF_MyFont(14.0f);
    timeLab.text = @"--：--";
    timeLab.userInteractionEnabled = YES;
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(groupIV.x + groupIV.width + 10, 10, DEF_DEVICE_WIDTH - groupIVWidth - 60 - 40, (CellHeight-20)/2)];
    nameLab.font = [UIFont fontWithName:@"DS-Digital-Italic" size:17.0f];
    nameLab.text = @"--";
    nameLab.userInteractionEnabled = YES;
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.textColor = DEF_COLOR_333333;
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UILabel *descriptionLab = [[UILabel alloc] initWithFrame:CGRectMake(groupIV.x + groupIV.width + 10, 10 + (CellHeight-20)/2, DEF_DEVICE_WIDTH - groupIVWidth - 60 - 40, (CellHeight-20)/2)];
    descriptionLab.font = DEF_MyFont(14.0f);
    descriptionLab.text = @"--";
    descriptionLab.userInteractionEnabled = YES;
    descriptionLab.backgroundColor = [UIColor clearColor];
    descriptionLab.textAlignment = NSTextAlignmentLeft;
    descriptionLab.textColor = DEF_COLOR_999999;
    [self.contentView addSubview:descriptionLab];
    self.descriptionLab = descriptionLab;
}

- (void)setMainModel:(MainModel *)mainModel
{
    NSLog(@"index--%d--",mainModel.row);
    self.roundnessProgressView.progressSections =98.0;
    if (mainModel.row == 0) {
    }
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

- (RoundnessProgressView *)roundnessProgressView
{
    if (!_roundnessProgressView) {
        _roundnessProgressView = [[RoundnessProgressView alloc]initWithFrame:CGRectMake((self.pressIV.width)/2 -50, (self.pressIV.height)/2 -50, 50, 50)];
        _roundnessProgressView.thicknessWidth = 4;
        _roundnessProgressView.completedColor = [UIColor UIColorFromRGB:0xE0DBDB alpha:1];
        _roundnessProgressView.labelColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
        _roundnessProgressView.incompletedColor = [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1];
        
        _roundnessProgressView.backgroundColor = [UIColor yellowColor];
        _roundnessProgressView.progressTotal = 100;
    }
    return _roundnessProgressView;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    _groupIV.image = nil;
    
    _nameLab.text = @"";
    _messageNumLab.text = @"";
    _timeLab.text = @"";
    _descriptionLab.text = @"";

}

@end
