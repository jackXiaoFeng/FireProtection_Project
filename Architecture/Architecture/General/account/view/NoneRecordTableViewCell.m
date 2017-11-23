//
//  NoneRecordTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/17.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#define CellHeight DEF_DEVICE_SCLE_HEIGHT(68)

#import "NoneRecordTableViewCell.h"
@interface NoneRecordTableViewCell()

@property (nonatomic, strong)UIImageView *lineIV;

@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *timeLab;
@end
@implementation NoneRecordTableViewCell

+ (CGFloat)NoneRecordHeight
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
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_SCLE_WIDTH(448), CellHeight)];
    nameLab.font = DEF_MyFont(14.0f);
    nameLab.text = @"----";
    nameLab.userInteractionEnabled = YES;
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLab.x+nameLab.width, 0, DEF_DEVICE_SCLE_WIDTH(303), CellHeight)];
    timeLab.font = DEF_MyFont(14.0f);
    timeLab.text = @"--天";
    timeLab.userInteractionEnabled = YES;
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textAlignment = NSTextAlignmentCenter;
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

- (void)setNoneRecordModel:(NoneRecordModel *)noneRecordModel
{
    self.nameLab.text = DEF_OBJECT_TO_STIRNG(noneRecordModel.Eqname);
    self.timeLab.text = [NSString stringWithFormat:@"%@天",noneRecordModel.Number];
    //    self.addressLab.text  = PlanModel.Describe;
    //    self.cycleLab.text  = PlanModel.Cycle;
    
//    self.nameLab.text = PlanModel.Eqname;
//    self.addressLab.text  = PlanModel.Floorsn;
//    self.cycleLab.text  = [NSString stringWithFormat:@"%@天",PlanModel.Number];
    
    //Count = 27;
    //Eqname = "\U5de1\U68c0\U70b94F";
    //Floorsn = 4F;
    //Number = 2;
    //"Oper_flag" = 1;
    //page = 1;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    //_groupIV.image = nil;
    
    _nameLab.text = @"";
    _timeLab.text = @"";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
