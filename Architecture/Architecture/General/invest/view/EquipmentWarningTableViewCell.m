//
//  EquipmentWarningTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//
#define CellHeight DEF_DEVICE_SCLE_HEIGHT(68)

#import "EquipmentWarningTableViewCell.h"
@interface EquipmentWarningTableViewCell()

@property (nonatomic, strong)UIImageView *groupIV;

@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *deviceLab;
@property (nonatomic, strong)UILabel *statusLab;
@property (nonatomic, strong)UILabel *restorationLab;
@end
@implementation EquipmentWarningTableViewCell

+ (CGFloat)equipmentWarningCellHeight
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
    
    UIImageView *groupIV = [[UIImageView alloc]init];
    groupIV.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, CellHeight);
    //groupIV.image = DEF_IMAGENAME(@"group_login_head");
    //    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    groupIV.userInteractionEnabled = YES;
    groupIV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:groupIV];
    self.groupIV = groupIV;
    
    NSArray *widthArray = @[
                            @(DEF_DEVICE_SCLE_WIDTH(134)),
                            @(DEF_DEVICE_SCLE_WIDTH(214)),
                            @(DEF_DEVICE_SCLE_WIDTH(164)),
                            @(DEF_DEVICE_SCLE_WIDTH(241))];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_SCLE_WIDTH(134), CellHeight)];
    timeLab.font = DEF_MyFont(14.0f);
    timeLab.text = @"--：--";
    timeLab.userInteractionEnabled = YES;
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;

    
    UILabel *deviceLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLab.x+timeLab.width, 0, DEF_DEVICE_SCLE_WIDTH(214), CellHeight)];
    deviceLab.font = DEF_MyFont(14.0f);
    deviceLab.text = @"设备＋地点";
    deviceLab.userInteractionEnabled = YES;
    deviceLab.backgroundColor = [UIColor clearColor];
    deviceLab.textAlignment = NSTextAlignmentCenter;
    deviceLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:deviceLab];
    self.deviceLab = deviceLab;
    
    UILabel *statusLab = [[UILabel alloc] initWithFrame:CGRectMake(deviceLab.x+deviceLab.width, 0, DEF_DEVICE_SCLE_WIDTH(164), CellHeight)];
    statusLab.font = DEF_MyFont(14.0f);
    statusLab.text = @"正常";
    statusLab.userInteractionEnabled = YES;
    statusLab.backgroundColor = [UIColor clearColor];
    statusLab.textAlignment = NSTextAlignmentCenter;
    statusLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:statusLab];
    self.statusLab = statusLab;
    
    
    UILabel *restorationLab = [[UILabel alloc] initWithFrame:CGRectMake(statusLab.x+statusLab.width, 0, DEF_DEVICE_SCLE_WIDTH(241), CellHeight)];
    restorationLab.font = DEF_MyFont(14.0f);
    restorationLab.text = @"已申请";
    restorationLab.userInteractionEnabled = YES;
    restorationLab.backgroundColor = [UIColor clearColor];
    restorationLab.textAlignment = NSTextAlignmentCenter;
    restorationLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:restorationLab];
    self.restorationLab = restorationLab;
    
    
    }

- (void)setEquipmentWarningModel:(EquipmentWarningModel *)equipmentWarningModel
{
//    self.nameLab.text = myGroupModel.gname;
//    
//    self.messageNumLab.text = myGroupModel.unreadmsgnum;
//    self.descriptionLab.text = myGroupModel.descriptionStr;
//    
//    if ([myGroupModel.unreadmsgnum intValue] >99) {
//        self.messageNumLab.text= @"99";
//    }
//    NSString *timeStr = [CMUtility getTimeWithTimestamp:myGroupModel.latestunreadmsg.pubtime WithDateFormat:@"HH:mm"];
//    self.timeLab.text = [timeStr isEqualToString:@""]?@"--:--":timeStr;
//    
//    if (!myGroupModel.unreadmsgnum || [myGroupModel.unreadmsgnum intValue] < 1) {
//        self.messageNumLab.hidden = YES;
//    }else
//    {
//        self.messageNumLab.hidden = NO;
//    }
//    if ([myGroupModel.ismember integerValue] ==1) {
//        self.backgroundColor = [UIColor clearColor];
//        self.nameLab.textColor = DEF_COLOR_333333;
//        self.descriptionLab.textColor = DEF_COLOR_999999;
//        self.groupIV.image = DEF_IMAGENAME(@"group_login_head");
//        @weakify(self)
//        [self.groupIV sd_setImageWithURL:[NSURL URLWithString:myGroupModel.headimg] placeholderImage:DEF_IMAGENAME(@"group_login_head") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            @strongify(self)
//            if (error) {
//                self.groupIV.image = [self grayImage:DEF_IMAGENAME(@"group_login_head")];
//            }else
//            {
//                self.groupIV.image = image;
//            }
//        }];
//        
//    }else
//    {
//        self.backgroundColor = DEF_UICOLORFROMRGB(0xeeeeee);
//        self.nameLab.textColor = DEF_UICOLORFROMRGB(0xb8b8b8);
//        self.descriptionLab.textColor = DEF_UICOLORFROMRGB(0xd3d3d3);
//        @weakify(self)
//        
//        [self.groupIV sd_setImageWithURL:[NSURL URLWithString:myGroupModel.headimg] placeholderImage:DEF_IMAGENAME(@"group_login_head") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            @strongify(self)
//            if (error) {
//                self.groupIV.image = [self grayImage:DEF_IMAGENAME(@"group_login_head")];
//            }else
//            {
//                self.groupIV.image = [self grayImage:image];
//                
//            }
//        }];
//    }

    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _groupIV.image = nil;
    
    _timeLab.text = @"";
    _deviceLab.text = @"";
    _statusLab.text = @"";
    _restorationLab.text = @"";
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
