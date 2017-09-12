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
        deviceLab.text = @"设备＋地点";
        deviceLab.userInteractionEnabled = YES;
        deviceLab.backgroundColor = [UIColor clearColor];
        deviceLab.textAlignment = NSTextAlignmentCenter;
        deviceLab.textColor = DEF_COLOR_RGB(87, 87, 87);
        [self.contentView addSubview:deviceLab];
        self.deviceLab = deviceLab;
        
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
        //    self.nameLab.text = myGroupModel.gname;
        //
        //    self.messageNumLab.text = myGroupModel.unreadmsgnum;
        //    self.descriptionLab.text = myGroupModel.descriptionStr;
        //
        //    if ([myGroupModel.unreadmsgnum intValue] >99) {
        //        self.messageNumLab.text= @"99";
        //    }
        //    NSString *timeStr = [CMUtility getTimeWithTimestamp:myGroupModel.latestunreadmsg.pubtime WithDateFormat:@"HH:mm"];
        //    self.timeLab.text = [timeStr isEqualToString:@""]?@"--:--":timeStr;
        //
        //    if (!myGroupModel.unreadmsgnum || [myGroupModel.unreadmsgnum intValue] < 1) {
        //        self.messageNumLab.hidden = YES;
        //    }else
        //    {
        //        self.messageNumLab.hidden = NO;
        //    }
        //    if ([myGroupModel.ismember integerValue] ==1) {
        //        self.backgroundColor = [UIColor clearColor];
        //        self.nameLab.textColor = DEF_COLOR_333333;
        //        self.descriptionLab.textColor = DEF_COLOR_999999;
        //        self.groupIV.image = DEF_IMAGENAME(@"group_login_head");
        //        @weakify(self)
        //        [self.groupIV sd_setImageWithURL:[NSURL URLWithString:myGroupModel.headimg] placeholderImage:DEF_IMAGENAME(@"group_login_head") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //            @strongify(self)
        //            if (error) {
        //                self.groupIV.image = [self grayImage:DEF_IMAGENAME(@"group_login_head")];
        //            }else
        //            {
        //                self.groupIV.image = image;
        //            }
        //        }];
        //
        //    }else
        //    {
        //        self.backgroundColor = DEF_UICOLORFROMRGB(0xeeeeee);
        //        self.nameLab.textColor = DEF_UICOLORFROMRGB(0xb8b8b8);
        //        self.descriptionLab.textColor = DEF_UICOLORFROMRGB(0xd3d3d3);
        //        @weakify(self)
        //
        //        [self.groupIV sd_setImageWithURL:[NSURL URLWithString:myGroupModel.headimg] placeholderImage:DEF_IMAGENAME(@"group_login_head") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //            @strongify(self)
        //            if (error) {
        //                self.groupIV.image = [self grayImage:DEF_IMAGENAME(@"group_login_head")];
        //            }else
        //            {
        //                self.groupIV.image = [self grayImage:image];
        //
        //            }
        //        }];
        //    }
        
        
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
        
        _involutionBtn = involutionBtn;
        
    }
    return _involutionBtn;
}
    

- (void)prepareForReuse {
    [super prepareForReuse];
    
    //_groupIV.image = nil;
    
    _timeLab.text = @"";
    
}
    
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
