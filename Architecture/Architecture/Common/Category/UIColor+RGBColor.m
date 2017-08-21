//
//  UIColor+RGBColor.m
//  Uzai
//
//  Created by UZAI on 14-7-11.
//
//

#import "UIColor+RGBColor.h"

@implementation UIColor (RGBColor)
+ (UIColor *) UIColorFromRGB:(int) rgbValue alpha:(float) alphaValue {
    float r = ((float)((rgbValue & 0xFF0000) >> 16))/255.0f;
    float g = ((float)((rgbValue & 0xFF00) >> 8))/255.0f;
    float b = ((float)(rgbValue & 0xFF))/255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:alphaValue];
}

- (UIImage *)colorTransformToImage
{
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  根据color创建Image
 *
 *  @param color color参数
 *
 *  @return 返回值Image
 */
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




@end
