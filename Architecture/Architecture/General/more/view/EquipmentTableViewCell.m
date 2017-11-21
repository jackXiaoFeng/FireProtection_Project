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

//@property (nonatomic, strong)UIButton *involutionBtn;
@property (nonatomic,strong) NSIndexPath *indexPath;

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
    equipmentLab.lineBreakMode = NSLineBreakByWordWrapping;
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
    
    
    //[self.contentView addSubview:self.involutionBtn];
   
    UIImageView *lineIV = [[UIImageView alloc]init];
    lineIV.frame = CGRectMake(0, CellHeight -1, DEF_DEVICE_WIDTH, 1);
    lineIV.backgroundColor = COLOR_APP_CELL_LINE;
    [self.contentView addSubview:lineIV];
    self.lineIV = lineIV;
    
//    self.statusLab.hidden = YES;
    //self.involutionBtn.hidden = YES;
}

- (void)setHidenLine:(BOOL)hidenLine{
    
    _hidenLine= hidenLine;
    
    self.lineIV.hidden= hidenLine;
    
}

- (void)setEquipmentModel:(EquipmentModel *)equipmentModel indexPath:(NSIndexPath *)indexPath

{
    
    self.indexPath = indexPath;
    
    self.tmpEquipmentModel = equipmentModel;
    
    self.equipmentLab.text = [NSString stringWithFormat:@"%@\n%@",DEF_OBJECT_TO_STIRNG(equipmentModel.Degree),DEF_OBJECT_TO_STIRNG(equipmentModel.Name)];
    
    self.numLab.text = DEF_OBJECT_TO_STIRNG(equipmentModel.xfnumericals);
    
    NSString *statusStr = @"";
    UIColor *color = DEF_COLOR_RGB(87, 87, 87);;
    if ([equipmentModel.AFmaintenance isEqualToString:Warning_Fix_Apply])//4:申请复归
    {
        statusStr = @"正在维修"; //fix： 加btn 调014复归api
        color = DEF_COLOR_RGB(230,84,80);

//        UIImage *normalImage = DEF_IMAGENAME(@"apply_involution");
//        UIImage *highlightedImage = DEF_IMAGENAME(@"apply_involution");
//        [self.involutionBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
//        [self.involutionBtn setBackgroundImage:highlightedImage forState:UIControlStateSelected];
//
//        [self.involutionBtn setTitle:statusStr forState:UIControlStateNormal];
//        self.involutionBtn.userInteractionEnabled = YES;
//
//        self.involutionBtn.hidden = NO;
//        self.statusLab.hidden = YES;
    }else
    {
        statusStr = @"正常";
        color = DEF_COLOR_RGB(87, 87, 87);

//        self.statusLab.hidden = NO;
//        self.involutionBtn.hidden = YES;
    }
    self.statusLab.textColor = color;
    self.statusLab.text = statusStr;

}

- (void)clickEvent:(UIButton *)btn
{
    NSLog(@"clickEvent---%@---%ld",self.tmpEquipmentModel.Describe,(long)self.indexPath.row);
    BLOCK_SAFE(self.fixBtnClickBlock)(self.indexPath);
}

/*
-(UIButton *)involutionBtn
{
    if (!_involutionBtn) {
        
//        CGFloat involutionX = 0;
        
        CGFloat involutionBtnWidth = DEF_DEVICE_SCLE_WIDTH(218);
        CGFloat involutionBtnHeight = DEF_DEVICE_SCLE_HEIGHT(45);
        
        UIImage *involutionBtnImage = DEF_IMAGENAME(@"");
        
        NSString *involutionStr = @"apply_involution";
        UIButton *involutionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        involutionBtn.frame = CGRectMake(self.numLab.x+self.numLab.width + 10/2,(CellHeight - involutionBtnHeight - 10)/2 , involutionBtnWidth-10, involutionBtnHeight + 10);
        involutionBtn.backgroundColor = [UIColor whiteColor];
        [involutionBtn setBackgroundImage:involutionBtnImage forState:UIControlStateNormal];
        [involutionBtn setTitle:involutionStr forState:UIControlStateNormal];
        [involutionBtn setTitleColor:DEF_COLOR_RGB(254, 254, 254)forState:UIControlStateNormal];
        involutionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        involutionBtn.titleLabel.font = DEF_MyFont(15);
        involutionBtn.titleLabel.backgroundColor = [UIColor clearColor];
        [involutionBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        _involutionBtn = involutionBtn;
    }
    return _involutionBtn;
}
*/
- (void)prepareForReuse {
    [super prepareForReuse];
    
    //_groupIV.image = nil;
    
    _equipmentLab.text = @"";
    _numLab.text = @"";
    _statusLab.text = @"";
    //[_involutionBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
