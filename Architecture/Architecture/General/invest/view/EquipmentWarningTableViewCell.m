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

@property (nonatomic, strong)UIButton *involutionBtn;
@property (nonatomic,strong) NSIndexPath *indexPath;

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
    
    
    [self.contentView addSubview:self.involutionBtn];
    
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

- (void)setEquipmentWarningModel:(EquipmentWarningModel *)equipmentWarningModel indexPath:(NSIndexPath *)indexPath
{
    
    self.indexPath = indexPath;
    
    self.temEquipmentWarningModel = equipmentWarningModel;
    //YYYY-MM-dd HH:mm:ss
    if (equipmentWarningModel.Time.length < 10) {
        self.timeLab.text = @"--:--";

    }else
    {
        self.timeLab.text = [CMUtility getTimeWithTimestamp:equipmentWarningModel.Time WithDateFormat:@"HH:mm"];
    }
    
    self.deviceLab.text = [NSString stringWithFormat:@"%@ %@",DEF_OBJECT_TO_STIRNG(equipmentWarningModel.name),DEF_OBJECT_TO_STIRNG(equipmentWarningModel.Describe)];
    
    //0:正常
    //1:异常
    NSString *statusStr = @"";
    if ([equipmentWarningModel.Xfstates isEqualToString:Warning_Fix_Normal]) {
        statusStr = @"正常";
    }else
    {
        statusStr = @"告警";
    }
    self.statusLab.text = statusStr;

//    AFmaintenance 优先级1
//    //0:正常     判断Xfstates
//    //1:故障
//    //／2:申请检修 2，4 不用Xfstates
//    //3:等待复归
//    //／4:复归
//
//    Xfstates优 先级2
//    0 告警 AFmaintenance 复位
//    1 正常 AFmaintenance 正常

    NSString *fixStr = @"";
    UIImage *normalImage;
    UIImage *highlightedImage;
    
    BOOL isU = NO;
//    if([equipmentWarningModel.AFmaintenance isEqualToString:Warning_Fix_Maintain])//2 需维修
//    {
//        fixStr = @"申请检修";
//        normalImage = DEF_IMAGENAME(@"apply_involution");
//        highlightedImage = DEF_IMAGENAME(@"apply_involution");
//        isU = YES;
//        equipmentWarningModel.involutionOrRecondition = JIANXIU;
//
//    }else
    if ([equipmentWarningModel.AFmaintenance isEqualToString:Warning_Fix_Apply])//4:申请复归
    {
        fixStr = @"复归";
        normalImage = DEF_IMAGENAME(@"apply_involution");
        highlightedImage = DEF_IMAGENAME(@"apply_involution");
        isU = YES;
        equipmentWarningModel.involutionOrRecondition = FUGUI;
    }else
    {
        if ([equipmentWarningModel.Xfstates isEqualToString:Warning_Fix_Normal]) {
            fixStr = @"正常";
            normalImage = DEF_IMAGENAME(@"wait_involution");
            highlightedImage = DEF_IMAGENAME(@"wait_involution");
            isU = NO;
            
        }else
        {
            fixStr = @"复归";
            normalImage = DEF_IMAGENAME(@"apply_involution");
            highlightedImage = DEF_IMAGENAME(@"apply_involution");
            isU = YES;
            equipmentWarningModel.involutionOrRecondition = FUGUI;
        }
    }
    
    [self.involutionBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.involutionBtn setBackgroundImage:highlightedImage forState:UIControlStateSelected];

    [self.involutionBtn setTitle:fixStr forState:UIControlStateNormal];
    self.involutionBtn.userInteractionEnabled = isU;
    //self.restorationLab.text = fixStr;
}

- (void)clickEvent:(UIButton *)btn
{
    NSLog(@"clickEvent---%@---%ld",self.temEquipmentWarningModel.Describe,(long)self.indexPath.row);
    BLOCK_SAFE(self.fixBtnClickBlock)(self.indexPath);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _timeLab.text = @"";
    _deviceLab.text = @"";
    _statusLab.text = @"";
    //_restorationLab.text = @"";
}

-(UIButton *)involutionBtn
{
    if (!_involutionBtn) {
        
        CGFloat involutionX = 0;
        
        CGFloat involutionBtnWidth = DEF_DEVICE_SCLE_WIDTH(218);
        CGFloat involutionBtnHeight = DEF_DEVICE_SCLE_HEIGHT(45);
        
        UIImage *involutionBtnImage = DEF_IMAGENAME(@"apply_involution");
        
        NSString *involutionStr = @"－－";
        UIButton *involutionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        involutionBtn.frame = CGRectMake(self.statusLab.x+self.statusLab.width + involutionX, (CellHeight - involutionBtnHeight)/2 , involutionBtnWidth, involutionBtnHeight);
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
