//
//  EquipmentTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#define CellHeight DEF_DEVICE_SCLE_HEIGHT(68)

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
    equipmentLab.text = @"消防泵1";
    equipmentLab.userInteractionEnabled = YES;
    equipmentLab.backgroundColor = [UIColor clearColor];
    equipmentLab.textAlignment = NSTextAlignmentCenter;
    equipmentLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:equipmentLab];
    self.equipmentLab = equipmentLab;
    
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(equipmentLab.x+equipmentLab.width, 0, DEF_DEVICE_SCLE_WIDTH(320), CellHeight)];
    numLab.font = DEF_MyFont(14.0f);
    numLab.text = @"3.5Mpa";
    numLab.userInteractionEnabled = YES;
    numLab.backgroundColor = [UIColor clearColor];
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:numLab];
    self.numLab = numLab;
    
    UILabel *statusLab = [[UILabel alloc] initWithFrame:CGRectMake(numLab.x+numLab.width, 0, DEF_DEVICE_SCLE_WIDTH(220), CellHeight)];
    statusLab.font = DEF_MyFont(14.0f);
    statusLab.text = @"正常";
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
