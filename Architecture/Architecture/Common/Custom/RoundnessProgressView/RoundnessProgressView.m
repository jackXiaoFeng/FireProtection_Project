//
//  RoundnessProgressView.m
//  Demo
//
//  Created by WanHongQiong on 15/7/13.
//  Copyright (c) 2015年 xinyu. All rights reserved.
//

#define SMALL_CHANGE 2

#import "RoundnessProgressView.h"

@interface RoundnessProgressView ()
{
    CGFloat progress;
    
    NSTimer *timer;
    
    NSInteger num;
}

@property (nonatomic, strong)UILabel *label;

@end

@implementation RoundnessProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        
        //默认设置
        self.thicknessWidth = 5;
        self.completedColor = [UIColor blackColor];
        self.incompletedColor = [UIColor grayColor];
        
        self.progressTotal = 100;
        self.progressSections = 0;
        
        self.labelColor = [UIColor blackColor];
        self.isShowLabel = YES;
        
        self.label = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:self.label];
        num = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setProgressTotal:(NSInteger)progressTotal
{
    _progressTotal = progressTotal;
    
    [timer fire];
    
    [self setNeedsDisplay];
}

-(void)setProgressSections:(NSInteger)progressSections{
    _progressSections = progressSections;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if (self.progressTotal>=0) {
        
        UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2)
                                                                  radius:self.bounds.size.width / 2 - self.thicknessWidth / 2-SMALL_CHANGE
                                                              startAngle:(CGFloat) - M_PI_2
                                                                endAngle:(CGFloat)(1.5 * M_PI)
                                                               clockwise:YES];
        [self.completedColor setStroke];
        backCircle.lineCapStyle = kCGLineCapRound;//指定线的边缘是圆的
        backCircle.lineWidth = self.thicknessWidth;
        [backCircle stroke];
    }
    
    if (self.progressSections>=0) {
        UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2)
                                                                      radius:self.bounds.size.width / 2 -  self.thicknessWidth/ 2 - SMALL_CHANGE
                                                                  startAngle:(CGFloat) - M_PI_2
                                                                    endAngle:(CGFloat)(- M_PI_2 + progress* 2 * M_PI)
                                                                   clockwise:YES];
        [self.incompletedColor setStroke];
        progressCircle.lineCapStyle = kCGLineCapRound;//指定线的边缘是圆的
        progressCircle.lineWidth = self.thicknessWidth;
        [progressCircle stroke];
        
        if (self.isShowLabel) {
            
//            NSLog(@"[NSString stringWithForm--%@-%f---%d---",[NSString stringWithFormat:@"%.0f",progress*self.progressTotal],progress,self.progressTotal);
            NSInteger progressInt = progress*100;
             NSAttributedString * str = [CMUtility getFormatedAmountWithColor:[UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1] amount:[NSString stringWithFormat:@"%ld",progressInt] unit:@"%" amountFont:20 unitFont:10];
            
            self.label.attributedText = str;
            
            CGSize size = [self boundingRectWithSize:CGSizeMake(self.frame.size.width - self.thicknessWidth*2, self.frame.size.height - self.thicknessWidth*2) font:[UIFont systemFontOfSize:20] string:[NSString stringWithFormat:@"%ld",progressInt] withSpacing:2];
            self.label.textAlignment = NSTextAlignmentCenter;
            self.label.frame = CGRectMake(0, (self.frame.size.height - size.height)/2,self.frame.size.width,size.height);
            
        }
    }
}

- (void)updateProgressCircle{
    if (num>self.progressSections) {
        
        [timer invalidate];
        return;
    }
    
    progress = (float)num/self.progressTotal;
    
    num = num + (self.progressTotal)/100;
    //num++;
    
    [self setNeedsDisplay];
}


-(CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font string:(NSString*)string withSpacing:(CGFloat)spacing
{
    NSMutableParagraphStyle * paragraphSpaceStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphSpaceStyle setLineSpacing:spacing];
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphSpaceStyle};
    
    CGSize fitSize = [string boundingRectWithSize:size
                                          options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return fitSize;
}

@end
