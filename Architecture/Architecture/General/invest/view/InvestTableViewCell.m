//
//  MainTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 16/8/11.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//


#import "InvestTableViewCell.h"
@interface InvestTableViewCell()

@property (nonatomic, strong)UIImageView *groupIV;

@property (nonatomic, strong)UIImageView *groupIV1;


@property (nonatomic, strong)UIButton *warningBtn;
@property (nonatomic, strong)UIButton *historyBtn;

@property (nonatomic, strong)UIButton *fixBtn;
@property (nonatomic, strong)UIButton *noneBtn;

@property (nonatomic, assign)CGFloat cellHeight;

@property (nonatomic, assign)CGFloat spaceWidth;
@property (nonatomic, assign)CGFloat spaceHeight;

@end
@implementation InvestTableViewCell
+ (CGFloat)investCellHeight
{
    return DEF_DEVICE_SCLE_HEIGHT(270);
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
    
    self.cellHeight = DEF_DEVICE_SCLE_HEIGHT(270);
    self.spaceWidth = DEF_DEVICE_SCLE_WIDTH(20);
    self.spaceHeight = DEF_DEVICE_SCLE_HEIGHT(10);

    UIImageView *groupIV = [[UIImageView alloc]init];
    groupIV.frame = CGRectMake(self.spaceWidth, 0, DEF_DEVICE_WIDTH-self.spaceWidth*2, self.cellHeight - self.spaceHeight);
    groupIV.backgroundColor = [UIColor clearColor];
    groupIV.image = DEF_IMAGENAME(@"group_login_head");
    groupIV.userInteractionEnabled = YES;
    //    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:groupIV];
    self.groupIV = groupIV;
    
    //给bgView边框设置阴影 self.bgView.layer.shadowOffset = CGSizeMake(1,1);
    //    self.groupIV.layer.shadowColor = [UIColor blackColor].CGColor;
    //    self.groupIV.layer.shadowOffset = CGSizeMake(0, 10);
    //    self.groupIV.layer.shadowOpacity = 0.3;
    //    self.groupIV.clipsToBounds = false; //这句最重要了，不然就显示不出来
    
    [self.groupIV addSubview:self.warningBtn];
    [self.groupIV addSubview:self.historyBtn];
    
    
    UIImageView *groupIV1 = [[UIImageView alloc]init];
    groupIV1.frame = CGRectMake(self.spaceWidth, 0, DEF_DEVICE_WIDTH-self.spaceWidth*2, self.cellHeight - self.spaceHeight);
    groupIV1.backgroundColor = [UIColor whiteColor];
    //groupIV1.image = DEF_IMAGENAME(@"group_login_head");
    groupIV1.userInteractionEnabled = YES;
    //    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:groupIV1];
    self.groupIV1 = groupIV1;
    
    
    //[self.groupIV1 addSubview:self.fixBtn];
        
    self.groupIV.hidden = YES;
    
    self.groupIV1.hidden = YES;
    
    
    @weakify(self);
    self.warningBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.InvestTableCellclick(1);
        return [RACSignal empty];
    }];
    
    self.historyBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.InvestTableCellclick(2);
        return [RACSignal empty];
    }];
    
    self.fixBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.InvestTableCellclick(3);
        return [RACSignal empty];
    }];
}

- (void)setInvestModel:(InvestModel *)investModel
{
    NSLog(@"index--%ld--",(long)investModel.row);
    
    if (investModel.row == 0) {
        self.groupIV.hidden = NO;
        self.groupIV1.hidden = YES;
    }else if (investModel.row == 1)
    {
        self.groupIV.hidden = YES;
        self.groupIV1.hidden = NO;
    }else
    {
        self.groupIV.hidden = YES;
        self.groupIV1.hidden = NO;
        self.fixBtn.hidden = YES;
    }
}

#pragma mark - 单击双击 -

- (void)handleSingleTapFrom:(UIGestureRecognizer *)gestureRecognizer {
    self.InvestTableCellclick(3);
}


-(UIButton *)warningBtn
{
    if (!_warningBtn) {
        UIImage *warningImage = DEF_IMAGENAME(@"device_warning_info");

        NSString *warningStr = @"设备告警信息";
        UIButton *warningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        warningBtn.frame = CGRectMake(0, 0, (self.groupIV.width-self.spaceWidth/2)/2, self.groupIV.height);

        warningBtn.backgroundColor = [UIColor whiteColor];
        [warningBtn setImage:warningImage forState:UIControlStateNormal];
        [warningBtn setTitle:warningStr forState:UIControlStateNormal];
        [warningBtn setTitleColor:DEF_COLOR_RGB(67, 67, 67)forState:UIControlStateNormal];
        warningBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        warningBtn.titleLabel.font = DEF_MyFont(15);
        warningBtn.titleLabel.backgroundColor = [UIColor clearColor];
        
        _warningBtn = warningBtn;
        
        //图片是60*60的2x的图
        CGFloat imageWidth = warningImage.size.width;
        CGFloat imageHeight = warningImage.size.height;
        
        CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) font:DEF_MyFont(15) string:warningStr withSpacing:0];
        CGFloat labelWidth = contentSize.width;
        
        CGFloat labelHeight= contentSize.height;
        
        CGFloat spacing = 15;
        CGFloat changeFloat = 15;
        
        //image在上，文字在下
        CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
        CGFloat imageOffsetY = imageHeight / 2 + spacing / 2 -changeFloat;//image中心移动的y距离
        //CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2 - 10;//label中心移动的x距离
        CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
        
        CGFloat labelOffsetY = labelHeight / 2 + spacing / 2 + changeFloat;//label中心移动的y距离
        _warningBtn.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
        _warningBtn.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
    }
    return _warningBtn;
}



-(UIButton *)historyBtn
{
    if (!_historyBtn) {
        
        UIImage *warningImage = DEF_IMAGENAME(@"warning_history");

        NSString *historyStr = @"告警历史记录";
        UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        historyBtn.frame = CGRectMake((self.groupIV.width+self.spaceWidth)/2  , 0, (self.groupIV.width-self.spaceWidth/2)/2, self.groupIV.height);
        historyBtn.backgroundColor = [UIColor whiteColor];
        [historyBtn setImage:warningImage forState:UIControlStateNormal];
        [historyBtn setTitle:historyStr forState:UIControlStateNormal];
        [historyBtn setTitleColor:DEF_COLOR_RGB(67, 67, 67)forState:UIControlStateNormal];
        historyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        historyBtn.titleLabel.font = DEF_MyFont(15);
        historyBtn.titleLabel.backgroundColor = [UIColor clearColor];
        
        _historyBtn = historyBtn;
        
        //图片是60*60的2x的图
        CGFloat imageWidth = warningImage.size.width;
        CGFloat imageHeight = warningImage.size.height;
        
        
        CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) font:DEF_MyFont(15) string:historyStr withSpacing:0];
        CGFloat labelWidth = contentSize.width;
        
        CGFloat labelHeight= contentSize.height;
        
        CGFloat spacing = 15;
        CGFloat changeFloat = 15;
        
        //image在上，文字在下
        CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
        CGFloat imageOffsetY = imageHeight / 2 + spacing / 2 -changeFloat;//image中心移动的y距离
        //CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2 - 10;//label中心移动的x距离
        CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
        
        CGFloat labelOffsetY = labelHeight / 2 + spacing / 2 + changeFloat;//label中心移动的y距离
        _historyBtn.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
        _historyBtn.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
    }
    return _historyBtn;
}


-(UIButton *)fixBtn
{
    if (!_fixBtn) {
        
        UIImage *warningImage = DEF_IMAGENAME(@"device_ restoration");
        NSString *fixStr = @"故障设备复归";
        UIButton *fixBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fixBtn.frame = CGRectMake(0, 0, self.groupIV1.width, self.groupIV1.height);

        fixBtn.backgroundColor = [UIColor whiteColor];
        [fixBtn setImage:warningImage forState:UIControlStateNormal];
        [fixBtn setTitle:fixStr forState:UIControlStateNormal];
        [fixBtn setTitleColor:DEF_COLOR_RGB(67, 67, 67)forState:UIControlStateNormal];
        fixBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        fixBtn.userInteractionEnabled = YES;
        fixBtn.titleLabel.font = DEF_MyFont(15);
        fixBtn.titleLabel.backgroundColor = [UIColor clearColor];
        
        _fixBtn = fixBtn;
        
        //图片是60*60的2x的图
        CGFloat imageWidth = warningImage.size.width;
        CGFloat imageHeight = warningImage.size.height;
        
        CGSize contentSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) font:DEF_MyFont(15) string:fixStr withSpacing:0];
        CGFloat labelWidth = contentSize.width;
        
        CGFloat labelHeight= contentSize.height;
        
        CGFloat spacing = 15;
        CGFloat changeFloat = 15;
        
        //image在上，文字在下
        CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
        CGFloat imageOffsetY = imageHeight / 2 + spacing / 2 -changeFloat;//image中心移动的y距离
        //CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2 - 10;//label中心移动的x距离
        CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
        
        CGFloat labelOffsetY = labelHeight / 2 + spacing / 2 + changeFloat;//label中心移动的y距离
        _fixBtn.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
        _fixBtn.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
    }
    return _fixBtn;
}
    

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _groupIV.image = nil;
    
    //_nameLab.text = @"";
    //    _messageNumLab.text = @"";
    //    _timeLab.text = @"";
    //    _descriptionLab.text = @"";
    
}

@end
