//
//  Tools.h
//  MaShangLiCai
//
//  Created by JasonLu on 14/12/3.
//  Copyright (c) 2014年 JasonLu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FYPhoneModel) {
    FYPhoneModeliPhone4,
    FYPhoneModeliPhone5,
    FYPhoneModeliPhone6,
    FYPhoneModeliPhone6p,
};

@interface Tools : NSObject

+ (FYPhoneModel)currentPhoneModel;
+ (CGFloat)fitCGFloatFive:(CGFloat)five six:(CGFloat)six sixp:(CGFloat)sixp;

+ (NSString *)pathForAttachmentFile:(NSString *)fileName;
+ (BOOL)saveAttachementFile:(NSData *)data withFileName:(NSString *)fileName;
+ (double)getAudioDuration:(NSString *)audioPath;

+ (NSString*) stringFromDate:(NSDate*) date formate:(NSString*)formate;
+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate;
+ (NSString *)formatString:(NSString *)datestring; 

+ (CGSize)sizeOfLabel:(UILabel *)label withSize:(CGSize)size;

+ (NSString *)getBankIconName:(NSString *)bankid;

+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict forClass:(Class)_class;

+ (NSString *)schemaForBankId:(NSString *)bankid directBank:(BOOL)directBank;
+ (NSString *)downloadURLForBankId:(NSString *)bankid directBank:(BOOL)directBank;

+ (NSString *)formattedDepositRate:(double)rate;

//数据存储路径
+ (NSString *)storedDataPath;


/***************************** LZR STRSR *******************************/
//限制特殊字符
+(NSString *)stringChartSpact:(NSString *)testString;

// 16进制转化为 UIColor
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(float)alpha;

/***************************** LZR END *******************************/
@end
