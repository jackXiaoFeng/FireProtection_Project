//
//  WarningHistoryTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//
#define CellHeight DEF_DEVICE_SCLE_HEIGHT(86)

#import "WarningHistoryTableViewCell.h"

@interface WarningHistoryTableViewCell()

    @property (nonatomic, strong)UILabel *timeLab;
    @property (nonatomic, strong)UILabel *deviceLab;
    @property (nonatomic, strong)UILabel *statusLab;
    @property (nonatomic, strong)UILabel *restorationTimeLab;
    @property (nonatomic, strong)UILabel *restorationLab;
    @property (nonatomic, strong)UIImageView *lineIV;

@end

@implementation WarningHistoryTableViewCell

+ (CGFloat)warningHistoryCellHeight
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
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_SCLE_WIDTH(112), CellHeight)];
        timeLab.font = DEF_MyFont(14.0f);
        timeLab.text = @"--：--";
        timeLab.userInteractionEnabled = YES;
        timeLab.backgroundColor = [UIColor clearColor];
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:timeLab];
        self.timeLab = timeLab;
        
        
        UILabel *deviceLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLab.x+timeLab.width, 0, DEF_DEVICE_SCLE_WIDTH(192), CellHeight)];
        deviceLab.font = DEF_MyFont(14.0f);
        deviceLab.text = @"设备＋地点";
        deviceLab.userInteractionEnabled = YES;
        deviceLab.backgroundColor = [UIColor clearColor];
        deviceLab.textAlignment = NSTextAlignmentCenter;
        deviceLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:deviceLab];
        self.deviceLab = deviceLab;
        
        UILabel *statusLab = [[UILabel alloc] initWithFrame:CGRectMake(deviceLab.x+deviceLab.width, 0, DEF_DEVICE_SCLE_WIDTH(112), CellHeight)];
        statusLab.font = DEF_MyFont(14.0f);
        statusLab.text = @"正常";
        statusLab.userInteractionEnabled = YES;
        statusLab.backgroundColor = [UIColor clearColor];
        statusLab.textAlignment = NSTextAlignmentCenter;
        statusLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:statusLab];
        self.statusLab = statusLab;
        
        UILabel *restorationTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(statusLab.x+statusLab.width, 0, DEF_DEVICE_SCLE_WIDTH(128), CellHeight)];
        restorationTimeLab.font = DEF_MyFont(14.0f);
        restorationTimeLab.text = @"12:00";
        restorationTimeLab.userInteractionEnabled = YES;
        restorationTimeLab.backgroundColor = [UIColor clearColor];
        restorationTimeLab.textAlignment = NSTextAlignmentCenter;
        restorationTimeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:restorationTimeLab];
        self.restorationTimeLab = restorationTimeLab;
        
        
        UILabel *restorationLab = [[UILabel alloc] initWithFrame:CGRectMake(restorationTimeLab.x+restorationTimeLab.width, 0, DEF_DEVICE_SCLE_WIDTH(210), CellHeight)];
        restorationLab.font = DEF_MyFont(14.0f);
        restorationLab.text = @"已申请";
        restorationLab.userInteractionEnabled = YES;
        restorationLab.backgroundColor = [UIColor clearColor];
        restorationLab.textAlignment = NSTextAlignmentCenter;
        restorationLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:restorationLab];
        self.restorationLab = restorationLab;
        
        UIImageView *lineIV = [[UIImageView alloc]init];
        lineIV.frame = CGRectMake(0, CellHeight -1, DEF_DEVICE_WIDTH, 1);
        lineIV.backgroundColor = COLOR_APP_CELL_LINE;
        [self.contentView addSubview:lineIV];
        self.lineIV = lineIV;
        
        
    }
    
- (void)setHidenLine:(BOOL)hidenLine{
    
    _hidenLine= hidenLine;
    
    self.lineIV.hidden= hidenLine;
    
}
    
- (void)setWarningHistoryModel:(WarningHistoryModel *)WarningHistoryModel
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
    
    //_groupIV.image = nil;
    
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
