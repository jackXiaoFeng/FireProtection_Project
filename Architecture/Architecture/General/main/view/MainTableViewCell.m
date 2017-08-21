//
//  MainTableViewCell.m
//  Architecture
//
//  Created by xiaofeng on 16/8/11.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "MainTableViewCell.h"

#define BannerHeight (DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT - DEF_TABBAR_HEIGHT)/3

#define CellHeight (DEF_DEVICE_HEIGHT-DEF_NAVIGATIONBAR_HEIGHT - DEF_TABBAR_HEIGHT - BannerHeight)/3


@interface MainTableViewCell()
@property (nonatomic, strong)UIImageView *groupIV;
@property (nonatomic, strong)UILabel *nameLab;
@property (nonatomic, strong)UILabel *messageNumLab;
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *descriptionLab;
@end
@implementation MainTableViewCell
+ (CGFloat)mainCellHeight
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
    
    CGFloat groupIVWidth = 50.0f;

    UIImageView *groupIV = [[UIImageView alloc]init];
    groupIV.frame = CGRectMake(10, 5, self.width-20, CellHeight - 15);
    groupIV.backgroundColor = [UIColor yellowColor];
    //groupIV.image = DEF_IMAGENAME(@"group_login_head");
    groupIV.userInteractionEnabled = YES;
//    groupIV.contentMode =UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:groupIV];
    self.groupIV = groupIV;
    
    //给bgView边框设置阴影 self.bgView.layer.shadowOffset = CGSizeMake(1,1);
    self.groupIV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.groupIV.layer.shadowOffset = CGSizeMake(0, 10);
    self.groupIV.layer.shadowOpacity = 0.3;
    self.groupIV.clipsToBounds = false; //这句最重要了，不然就显示不出来
    
    return;
    
    CGFloat messageNumLabWidth = 18.0f;
    UILabel *messageNumLab = [[UILabel alloc] initWithFrame:CGRectMake(groupIV.x + groupIV.width - messageNumLabWidth/2, groupIV.y - messageNumLabWidth/2 + 5, messageNumLabWidth, messageNumLabWidth)];
    messageNumLab.font = DEF_MyFont(8.0f);
    messageNumLab.text = @"";
    messageNumLab.userInteractionEnabled = YES;
    messageNumLab.backgroundColor = [UIColor redColor];
    messageNumLab.textAlignment = NSTextAlignmentCenter;
    messageNumLab.textColor = [UIColor whiteColor];
    messageNumLab.layer.cornerRadius = messageNumLabWidth/2;
    messageNumLab.clipsToBounds = YES;
    messageNumLab.hidden = YES;
    [self.contentView addSubview:messageNumLab];
    self.messageNumLab = messageNumLab;
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(DEF_DEVICE_WIDTH - 55, 0, 50, CellHeight)];
    timeLab.font = DEF_MyFont(14.0f);
    timeLab.text = @"--：--";
    timeLab.userInteractionEnabled = YES;
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.textAlignment = NSTextAlignmentLeft;
    timeLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(groupIV.x + groupIV.width + 10, 10, DEF_DEVICE_WIDTH - groupIVWidth - 60 - 40, (CellHeight-20)/2)];
    nameLab.font = [UIFont fontWithName:@"DS-Digital-Italic" size:17.0f];
    nameLab.text = @"--";
    nameLab.userInteractionEnabled = YES;
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.textColor = DEF_COLOR_333333;
    [self.contentView addSubview:nameLab];
    self.nameLab = nameLab;
    
    UILabel *descriptionLab = [[UILabel alloc] initWithFrame:CGRectMake(groupIV.x + groupIV.width + 10, 10 + (CellHeight-20)/2, DEF_DEVICE_WIDTH - groupIVWidth - 60 - 40, (CellHeight-20)/2)];
    descriptionLab.font = DEF_MyFont(14.0f);
    descriptionLab.text = @"--";
    descriptionLab.userInteractionEnabled = YES;
    descriptionLab.backgroundColor = [UIColor clearColor];
    descriptionLab.textAlignment = NSTextAlignmentLeft;
    descriptionLab.textColor = DEF_COLOR_999999;
    [self.contentView addSubview:descriptionLab];
    self.descriptionLab = descriptionLab;
}

- (void)setMainModel:(MainModel *)mainModel
{
    NSLog(@"index--%d--",mainModel.row);
    
    if (mainModel.row == 0) {
        self.groupIV.backgroundColor = [UIColor greenColor];
    }
}

-(UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _groupIV.image = nil;
    
    _nameLab.text = @"";
    _messageNumLab.text = @"";
    _timeLab.text = @"";
    _descriptionLab.text = @"";

}

@end
