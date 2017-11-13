//
//  PlanTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/22.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//
#define CellHeight DEF_DEVICE_SCLE_HEIGHT(68)

#import "PlanTableViewCell.h"
@interface PlanTableViewCell()

@property (nonatomic, strong)UIImageView *lineIV;

@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *addressLab;
@property (nonatomic, strong)UILabel *cycleLab;
@end
@implementation PlanTableViewCell

+ (CGFloat)PlanCellHeight
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
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_SCLE_WIDTH(272), CellHeight)];
    nameLab.font = DEF_MyFont(14.0f);
    nameLab.text = @"----";
    nameLab.userInteractionEnabled = YES;
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLab.x+nameLab.width, 0, DEF_DEVICE_SCLE_WIDTH(198), CellHeight)];
    addressLab.font = DEF_MyFont(14.0f);
    addressLab.text = @"----";
    addressLab.userInteractionEnabled = YES;
    addressLab.backgroundColor = [UIColor clearColor];
    addressLab.textAlignment = NSTextAlignmentCenter;
    addressLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:addressLab];
    self.addressLab = addressLab;
    
    UILabel *cycleLab = [[UILabel alloc] initWithFrame:CGRectMake(addressLab.x+addressLab.width, 0, DEF_DEVICE_SCLE_WIDTH(282), CellHeight)];
    cycleLab.font = DEF_MyFont(14.0f);
    cycleLab.text = @"----";
    cycleLab.userInteractionEnabled = YES;
    cycleLab.backgroundColor = [UIColor clearColor];
    cycleLab.textAlignment = NSTextAlignmentCenter;
    cycleLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:cycleLab];
    self.cycleLab = cycleLab;
    
    
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

- (void)setPlanModel:(PlanModel *)PlanModel
{
//    self.nameLab.text = PlanModel.Name;
//    self.addressLab.text  = PlanModel.Describe;
//    self.cycleLab.text  = PlanModel.Cycle;
    
    self.nameLab.text = PlanModel.Eqname;
    self.addressLab.text  = PlanModel.Floorsn;
    self.cycleLab.text  = [NSString stringWithFormat:@"%@天",PlanModel.Number];
    
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
    _addressLab.text = @"";
    _cycleLab.text = @"";    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
