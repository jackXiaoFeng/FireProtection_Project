//
//  RecordTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//
#define CellHeight DEF_DEVICE_SCLE_HEIGHT(68)

#import "RecordTableViewCell.h"
@interface RecordTableViewCell()

@property (nonatomic, strong)UILabel *addressLab;
@property (nonatomic, strong)UILabel *timeLab;

@property (nonatomic, strong)UIImageView *lineIV;

@end
@implementation RecordTableViewCell

+ (CGFloat)RecordCellHeight
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
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(DEF_DEVICE_SCLE_WIDTH(32), 0, DEF_DEVICE_SCLE_WIDTH(610)-DEF_DEVICE_SCLE_WIDTH(32), CellHeight)];
    addressLab.font = DEF_MyFont(14.0f);
    addressLab.text = @"----";
    addressLab.userInteractionEnabled = YES;
    addressLab.backgroundColor = [UIColor clearColor];
    addressLab.textAlignment = NSTextAlignmentLeft;
    addressLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:addressLab];
    self.addressLab = addressLab;
    
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(addressLab.x+addressLab.width, 0, DEF_DEVICE_SCLE_WIDTH(140), CellHeight)];
    timeLab.font = DEF_MyFont(14.0f);
    timeLab.text = @"--:--";
    timeLab.userInteractionEnabled = YES;
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    
    
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

- (void)setRecordMode:(RecordModel *)RecordMode
{
    self.addressLab.text = [NSString stringWithFormat:@"%@ ",DEF_OBJECT_TO_STIRNG(RecordMode.Name)];
    //YYYY-MM-dd HH:mm:ss
    if (RecordMode.Xtime.length < 10) {
        self.timeLab.text = @"--:--";
        
    }else
    {
        self.timeLab.text = [CMUtility getTimeWithTimestamp:RecordMode.Xtime WithDateFormat:@"HH:mm"];
    }
   
}




- (void)prepareForReuse {
    [super prepareForReuse];
    
    //_groupIV.image = nil;
    
    _addressLab.text = @"";
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
