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
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_SCLE_WIDTH((134)), CellHeight)];
        timeLab.font = DEF_MyFont(14.0f);
        timeLab.text = @"--:--";
        timeLab.userInteractionEnabled = YES;
        timeLab.backgroundColor = [UIColor clearColor];
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:timeLab];
        self.timeLab = timeLab;
        
        
        UILabel *deviceLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLab.x+timeLab.width, 0, DEF_DEVICE_SCLE_WIDTH(174), CellHeight)];
        deviceLab.font = DEF_MyFont(14.0f);
        deviceLab.text = @"----";
        deviceLab.userInteractionEnabled = YES;
        deviceLab.backgroundColor = [UIColor clearColor];
        deviceLab.textAlignment = NSTextAlignmentCenter;
        deviceLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:deviceLab];
        self.deviceLab = deviceLab;
        
        UILabel *statusLab = [[UILabel alloc] initWithFrame:CGRectMake(deviceLab.x+deviceLab.width, 0, DEF_DEVICE_SCLE_WIDTH(134), CellHeight)];
        statusLab.font = DEF_MyFont(14.0f);
        statusLab.text = @"--";
        statusLab.userInteractionEnabled = YES;
        statusLab.backgroundColor = [UIColor clearColor];
        statusLab.textAlignment = NSTextAlignmentCenter;
        statusLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:statusLab];
        self.statusLab = statusLab;
        
        UILabel *restorationTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(statusLab.x+statusLab.width, 0, DEF_DEVICE_SCLE_WIDTH(171), CellHeight)];
        restorationTimeLab.font = DEF_MyFont(14.0f);
    restorationTimeLab.text = @"--:--";
        restorationTimeLab.userInteractionEnabled = YES;
        restorationTimeLab.backgroundColor = [UIColor clearColor];
        restorationTimeLab.textAlignment = NSTextAlignmentCenter;
        restorationTimeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:restorationTimeLab];
        self.restorationTimeLab = restorationTimeLab;
        
        
        UILabel *restorationLab = [[UILabel alloc] initWithFrame:CGRectMake(restorationTimeLab.x+restorationTimeLab.width, 0, DEF_DEVICE_SCLE_WIDTH(140), CellHeight)];
        restorationLab.font = DEF_MyFont(14.0f);
        restorationLab.text = @"---";
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
        //YYYY-MM-dd HH:mm:ss
        if (WarningHistoryModel.Stime.length < 10) {
            if (WarningHistoryModel.Mtime.length < 10) {
                self.timeLab.text = @"--:--";
            }else
            {
                self.timeLab.text = [CMUtility getTimeWithTimestamp:WarningHistoryModel.Mtime WithDateFormat:@"HH:mm"];
            }
        }else
        {
            self.timeLab.text = [CMUtility getTimeWithTimestamp:WarningHistoryModel.Stime WithDateFormat:@"HH:mm"];
        }
        
        self.deviceLab.text = [NSString stringWithFormat:@"%@ ",WarningHistoryModel.Name];
        
        //1:正常 Warning_Fix_Malfunction
        NSString *statusStr = @"";
        if ([WarningHistoryModel.Xfstates isEqualToString:Warning_Fix_Malfunction]) {
            statusStr = @"正常";
        }else
        {
            statusStr = @"异常";
        }
        self.statusLab.text = statusStr;
        
        //复归时间
        if (WarningHistoryModel.Utime.length < 10) {
            self.restorationTimeLab.text = @"未处理";
        }else
        {
            self.restorationTimeLab.text = [CMUtility getTimeWithTimestamp:WarningHistoryModel.Utime WithDateFormat:@"HH:mm"];
        }
        
        
        self.restorationLab.text = DEF_OBJECT_TO_STIRNG(WarningHistoryModel.Uusername);
    }
    
- (void)prepareForReuse {
    [super prepareForReuse];
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
