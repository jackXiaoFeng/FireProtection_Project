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

@property (nonatomic, strong)UIImageView *lineIV;

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
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_SCLE_WIDTH(134), CellHeight)];
    timeLab.font = DEF_MyFont(13.0f);
    timeLab.text = @"--：--";
    timeLab.userInteractionEnabled = YES;
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;

    
    UILabel *deviceLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLab.x+timeLab.width, 0, DEF_DEVICE_SCLE_WIDTH(214), CellHeight)];
    deviceLab.font = DEF_MyFont(14.0f);
    deviceLab.text = @"--";
    deviceLab.userInteractionEnabled = YES;
    deviceLab.backgroundColor = [UIColor clearColor];
    deviceLab.textAlignment = NSTextAlignmentCenter;
    deviceLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:deviceLab];
    self.deviceLab = deviceLab;
    
    UILabel *statusLab = [[UILabel alloc] initWithFrame:CGRectMake(deviceLab.x+deviceLab.width, 0, DEF_DEVICE_SCLE_WIDTH(164), CellHeight)];
    statusLab.font = DEF_MyFont(14.0f);
    statusLab.text = @"--";
    statusLab.userInteractionEnabled = YES;
    statusLab.backgroundColor = [UIColor clearColor];
    statusLab.textAlignment = NSTextAlignmentCenter;
    statusLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:statusLab];
    self.statusLab = statusLab;
    
    
    UILabel *restorationLab = [[UILabel alloc] initWithFrame:CGRectMake(statusLab.x+statusLab.width, 0, DEF_DEVICE_SCLE_WIDTH(241), CellHeight)];
    restorationLab.font = DEF_MyFont(14.0f);
    restorationLab.text = @"--";
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

- (void)setEquipmentWarningModel:(EquipmentWarningModel *)equipmentWarningModel
{
    
    self.timeLab.text = equipmentWarningModel.Time;
    
    //YYYY-MM-dd HH:mm:ss
    self.timeLab.text = [CMUtility getTimeWithTimestamp:@"1504772308" WithDateFormat:@"MM/dd HH:mm"];
    
    self.deviceLab.text = [NSString stringWithFormat:@"%@ %@",equipmentWarningModel.name,equipmentWarningModel.Describe];
    
    self.statusLab.text = equipmentWarningModel.Xfstates;

    self.restorationLab.text = equipmentWarningModel.Xfnumericals;

    
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
