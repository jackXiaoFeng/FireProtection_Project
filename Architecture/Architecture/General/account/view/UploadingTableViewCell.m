//
//  UploadingTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 17/8/25.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//
#define CellHeight DEF_DEVICE_SCLE_HEIGHT(72)

#import "UploadingTableViewCell.h"
@interface UploadingTableViewCell()

@property (nonatomic, strong)UILabel *addressLab;
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UIButton *selectBtn;

@property (nonatomic, strong)UIImageView *lineIV;

@end
@implementation UploadingTableViewCell

+ (CGFloat)UploadingCellHeight
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
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_SCLE_WIDTH(448), CellHeight)];
    addressLab.font = DEF_MyFont(14.0f);
    addressLab.text = @"设备名称＋地点";
    addressLab.userInteractionEnabled = YES;
    addressLab.backgroundColor = [UIColor clearColor];
    addressLab.textAlignment = NSTextAlignmentCenter;
    addressLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:addressLab];
    self.addressLab = addressLab;
    
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(addressLab.x+addressLab.width, 0, DEF_DEVICE_SCLE_WIDTH(186), CellHeight)];
    timeLab.font = DEF_MyFont(14.0f);
    timeLab.text = @"13:00";
    timeLab.userInteractionEnabled = YES;
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.textColor = DEF_COLOR_RGB(87, 87, 87);
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    
    [self.contentView addSubview:self.selectBtn];
    
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

- (void)setUploadingMode:(UploadingModel *)UploadingMode
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
    //    self.addressLab.text = [timeStr isEqualToString:@""]?@"--:--":timeStr;
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


-(UIButton *)selectBtn
{
    if (!_selectBtn) {
        
        CGFloat selectBtnHeight = DEF_DEVICE_SCLE_HEIGHT(33);
        
        
        UIImage *selectBtnImage = DEF_IMAGENAME(@"involution_ affirm");
        
        NSString *involutionStr = @"申请复归";
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(self.timeLab.x+self.timeLab.width , (CellHeight - selectBtnHeight)/2 , selectBtnHeight, selectBtnHeight);
        selectBtn.backgroundColor = [UIColor whiteColor];
        [selectBtn setBackgroundImage:selectBtnImage forState:UIControlStateNormal];
        [selectBtn setTitle:involutionStr forState:UIControlStateNormal];
        [selectBtn setTitleColor:DEF_COLOR_RGB(254, 254, 254)forState:UIControlStateNormal];
        selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        selectBtn.titleLabel.font = DEF_MyFont(15);
        selectBtn.titleLabel.backgroundColor = [UIColor clearColor];
        
        _selectBtn = selectBtn;
        
    }
    return _selectBtn;
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
