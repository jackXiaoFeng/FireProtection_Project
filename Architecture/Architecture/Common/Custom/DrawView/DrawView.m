//
//  DrawView.m
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


-(void)drawRect:(CGRect)rect {
    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /**
     画实心圆
     */
    CGRect frame = CGRectMake(0,
                              
                              0,
                              rect.size.width ,
                              rect.size.height);
    
    //填充当前绘画区域内的颜色
    [[UIColor whiteColor] set];
    //填充当前矩形区域
    CGContextFillRect(ctx, rect);
    //以矩形frame为依据画一个圆
    CGContextAddEllipseInRect(ctx, frame);
    //填充当前绘画区域内的颜色
    [[UIColor orangeColor] set];
    //填充(沿着矩形内围填充出指定大小的圆)
    CGContextFillPath(ctx);
    
}

@end
