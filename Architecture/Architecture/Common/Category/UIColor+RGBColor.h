//
//  UIColor+RGBColor.h
//  Uzai
//
//  Created by UZAI on 14-7-11.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (RGBColor)
+ (UIColor *) UIColorFromRGB:(int) rgbValue alpha:(float) alphaValue;
- (UIImage *)colorTransformToImage;



+ (UIImage*) createImageWithColor: (UIColor*) color;
@end
