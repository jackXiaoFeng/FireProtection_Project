//
//  EquipmentTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#define CellHeight DEF_DEVICE_SCLE_HEIGHT(98)

#import "EquipmentTableViewCell.h"
@interface EquipmentTableViewCell()

@property (nonatomic, strong)UIImageView *lineIV;

@property (nonatomic, strong)UILabel *equipmentLab;
@property (nonatomic, strong)UILabel *numLab;
@property (nonatomic, strong)UILabel *statusLab;
@end
@implementation EquipmentTableViewCell

+ (CGFloat)equipmentCellHeight
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
    
    UILabel *equipmentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_SCLE_WIDTH(212), CellHeight)];
    equipmentLab.font = DEF_MyFont(14.0f);
    equipmentLab.text = @"----";
    equipmentLab.userInteractionEnabled = YES;
    equipmentLab.backgroundColor = [UIColor clearColor];
    equipmentLab.textAlignment = NSTextAlignmentCenter;
    equipmentLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    equipmentLab.lineBreakMode = UILineBreakModeWordWrap;
    equipmentLab.numberOfLines = 0;
    [self.contentView addSubview:equipmentLab];
    self.equipmentLab = equipmentLab;
    
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(equipmentLab.x+equipmentLab.width, 0, DEF_DEVICE_SCLE_WIDTH(320), CellHeight)];
    numLab.font = DEF_MyFont(14.0f);
    numLab.text = @"----";
    numLab.userInteractionEnabled = YES;
    numLab.backgroundColor = [UIColor clearColor];
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:numLab];
    self.numLab = numLab;
    
    UILabel *statusLab = [[UILabel alloc] initWithFrame:CGRectMake(numLab.x+numLab.width, 0, DEF_DEVICE_SCLE_WIDTH(220), CellHeight)];
    statusLab.font = DEF_MyFont(14.0f);
    statusLab.text = @"----";
    statusLab.userInteractionEnabled = YES;
    statusLab.backgroundColor = [UIColor clearColor];
    statusLab.textAlignment = NSTextAlignmentCenter;
    statusLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:statusLab];
    self.statusLab = statusLab;
    
    
   
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

- (void)setEquipmentModel:(EquipmentModel *)equipmentModel
{
    self.equipmentLab.text = [NSString stringWithFormat:@"%@\n%@",DEF_OBJECT_TO_STIRNG(equipmentModel.Degree),DEF_OBJECT_TO_STIRNG(equipmentModel.Name)];
    
    self.numLab.text = DEF_OBJECT_TO_STIRNG(equipmentModel.xfnumericals);
    
    //0:正常
    //1:异常
    NSString *statusStr = @"";
    if ([equipmentModel.Xfstates isEqualToString:Warning_Fix_Normal]) {
        statusStr = @"正常";
    }else
    {
        statusStr = @"异常";
    }
    self.statusLab.text = statusStr;
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    //_groupIV.image = nil;
    
    _equipmentLab.text = @"";
    _numLab.text = @"";
    _statusLab.text = @"";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
