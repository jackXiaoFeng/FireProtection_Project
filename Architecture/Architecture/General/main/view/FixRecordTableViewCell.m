//
//  FixRecordTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//
#define CellHeight DEF_DEVICE_SCLE_HEIGHT(86)

#import "FixRecordTableViewCell.h"

@interface FixRecordTableViewCell()

@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *deviceLab;
@property (nonatomic, strong)UILabel *statusLab;
@property (nonatomic, strong)UILabel *restorationTimeLab;
@property (nonatomic, strong)UILabel *restorationLab;
@property (nonatomic, strong)UIImageView *lineIV;

@end

@implementation FixRecordTableViewCell

+ (CGFloat)fixRecordCellHeight
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

- (void)setFixRecordModel:(FixRecordModel *)FixRecordModel
{
    //YYYY-MM-dd HH:mm:ss
    if (FixRecordModel.Stime.length < 10) {
        self.timeLab.text = @"--:--";
        
    }else
    {
        self.timeLab.text = [CMUtility getTimeWithTimestamp:FixRecordModel.Stime WithDateFormat:@"HH:mm"];
    }
    
    self.deviceLab.text = [NSString stringWithFormat:@"%@ %@",FixRecordModel.Name,FixRecordModel.Describe];
    
    //0:正常
    //1:异常
    NSString *statusStr = @"";
    //        if ([WarningHistoryModel.Xfstates isEqualToString:Warning_Fix_Normal]) {
    //            statusStr = @"正常";
    //        }else
    //        {
    //            statusStr = @"异常";
    //        }
    self.statusLab.text = statusStr;
    
    //复归时间
    if (FixRecordModel.Utime.length < 10) {
        self.restorationTimeLab.text = @"--:--";
        
    }else
    {
        self.restorationTimeLab.text = [CMUtility getTimeWithTimestamp:FixRecordModel.Utime WithDateFormat:@"HH:mm"];
    }
    
    
    self.restorationLab.text = DEF_OBJECT_TO_STIRNG(FixRecordModel.Uname);
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
