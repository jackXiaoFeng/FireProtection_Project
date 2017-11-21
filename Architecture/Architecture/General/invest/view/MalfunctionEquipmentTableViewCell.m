//
//  MalfunctionEquipmentTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//
#define CellHeight DEF_DEVICE_SCLE_HEIGHT(92)

#import "MalfunctionEquipmentTableViewCell.h"
@interface MalfunctionEquipmentTableViewCell()
    
    @property (nonatomic, strong)UILabel *timeLab;
    @property (nonatomic, strong)UILabel *deviceLab;
    @property (nonatomic, strong)UIButton *involutionBtn;

    @property (nonatomic, strong)UIImageView *lineIV;
    @property (nonatomic,strong) NSIndexPath *indexPath;
@end

@implementation MalfunctionEquipmentTableViewCell

+ (CGFloat)malfunctionEquipmentCellHeight
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
        timeLab.font = DEF_MyFont(14.0f);
        timeLab.text = @"--：--";
        timeLab.userInteractionEnabled = YES;
        timeLab.backgroundColor = [UIColor clearColor];
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:timeLab];
        self.timeLab = timeLab;
        
        
        UILabel *deviceLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLab.x+timeLab.width, 0, DEF_DEVICE_SCLE_WIDTH(258), CellHeight)];
        deviceLab.font = DEF_MyFont(14.0f);
        deviceLab.text = @"----";
        deviceLab.userInteractionEnabled = YES;
        deviceLab.backgroundColor = [UIColor clearColor];
        deviceLab.textAlignment = NSTextAlignmentCenter;
        deviceLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:deviceLab];
        self.deviceLab = deviceLab;
        
        //复归btn
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
    
- (void)malfunctionEquipmentMode:(MalfunctionEquipmentModel *)malfunctionEquipmentMode indexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    
    self.temmalfunctionEquipmentMode = malfunctionEquipmentMode;
    //YYYY-MM-dd HH:mm:ss
    if (malfunctionEquipmentMode.Time.length < 10) {
        self.timeLab.text = @"--:--";
        
    }else
    {
        self.timeLab.text = [CMUtility getTimeWithTimestamp:malfunctionEquipmentMode.Time WithDateFormat:@"HH:mm"];
    }
    
    self.deviceLab.text = [NSString stringWithFormat:@"%@ %@",malfunctionEquipmentMode.name,malfunctionEquipmentMode.Describe];
    
    
    //0:正常
    //1:故障
    //2:需维修
    //3:等待复归
    //4:申请复归
    NSString *fixStr = @"";
    UIImage *normalImage;
    UIImage *highlightedImage;
    BOOL isU;
    if ([malfunctionEquipmentMode.AFmaintenance isEqualToString:Warning_Fix_Apply])
    {
        fixStr = @"申请复归";
        normalImage = DEF_IMAGENAME(@"apply_involution");
        highlightedImage = DEF_IMAGENAME(@"apply_involution");
        isU = YES;
    }else if ([malfunctionEquipmentMode.AFmaintenance isEqualToString:Warning_Fix_Wait])
    {
        fixStr = @"等待复归";
        normalImage = DEF_IMAGENAME(@"wait_involution");
        highlightedImage = DEF_IMAGENAME(@"wait_involution");
        isU = NO;
    }
    [self.involutionBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.involutionBtn setBackgroundImage:highlightedImage forState:UIControlStateSelected];
    
    [self.involutionBtn setTitle:fixStr forState:UIControlStateNormal];
    self.involutionBtn.userInteractionEnabled = isU;
    //self.restorationLab.text = fixStr;
}

- (void)clickEvent:(UIButton *)btn
{
    NSLog(@"clickEvent---%@---%ld",self.temmalfunctionEquipmentMode.Describe,(long)self.indexPath.row);
    BLOCK_SAFE(self.fixBtnClickBlock)(self.indexPath);
}
    

-(UIButton *)involutionBtn
{
    if (!_involutionBtn) {
        
        CGFloat involutionX = DEF_DEVICE_SCLE_WIDTH(70);
        
        CGFloat involutionBtnWidth = DEF_DEVICE_SCLE_WIDTH(218);
        CGFloat involutionBtnHeight = DEF_DEVICE_SCLE_HEIGHT(50);

        
        UIImage *involutionBtnImage = DEF_IMAGENAME(@"involution_affirm");
        
        NSString *involutionStr = @"申请复归";
        UIButton *involutionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        involutionBtn.frame = CGRectMake(self.deviceLab.x+self.deviceLab.width + involutionX, (CellHeight - involutionBtnHeight)/2 , involutionBtnWidth, involutionBtnHeight);
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
    

- (void)prepareForReuse {
    [super prepareForReuse];
    
    //_groupIV.image = nil;
    
    _timeLab.text = @"";
    _deviceLab.text = @"";
}
    
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
