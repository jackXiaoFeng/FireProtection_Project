//
//  Tools.m
//  MaShangLiCai
//
//  Created by JasonLu on 14/12/3.
//  Copyright (c) 2014年 JasonLu. All rights reserved.
//

#import "Tools.h"
#import <AVFoundation/AVFoundation.h>

#define specialCharacterStr     @"@／     …：；（）¥「」＂、[]{}-*+=_\\|＜＞$€^•'@#$%^&;*()_+'\",，;/.?<>？。！!【】❴❵——·~£》'｛｝|^ _ ““｝'‘:～《""“”″˝"

@implementation Tools

+ (FYPhoneModel)currentPhoneModel {
    if (DEF_DEVICE_WIDTH>375.0) {
        return FYPhoneModeliPhone6p;
    } else if (DEF_DEVICE_WIDTH>320.0 && DEF_DEVICE_WIDTH <= 375.0) {
        return FYPhoneModeliPhone6;
    } else {
        if (DEF_DEVICE_HEIGHT > 480) {
            return FYPhoneModeliPhone5;
        } else {
            return FYPhoneModeliPhone4;
        }
    }
}

+ (CGFloat)fitCGFloatFive:(CGFloat)five six:(CGFloat)six sixp:(CGFloat)sixp{
    if ([self currentPhoneModel] == FYPhoneModeliPhone6) {
        return six;
    }else if ([self currentPhoneModel] == FYPhoneModeliPhone6p){
        return sixp;
    }else{
        return five;
    }
}

+ (NSString *)attachmentFilePath  {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingPathComponent:@"data/attachment"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
        NSError *error = nil;
        BOOL success = [url setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error:&error];
        if(!success) {
            NSLog(@"excluding %@ from backup, error:%@", [url lastPathComponent], error);
        }
    }
    
    return path;
}

+ (NSString *)pathForAttachmentFile:(NSString *)fileName {
    NSString *path = [Tools attachmentFilePath];
    path = [path stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (BOOL)saveAttachementFile:(NSData *)data withFileName:(NSString *)fileName {
    NSString *path = [Tools attachmentFilePath];
    path = [path stringByAppendingPathComponent:fileName];
    
    BOOL succes = [data writeToFile:path atomically:YES];
    
    return succes;
}

+ (double)getAudioDuration:(NSString *)audioPath {
    AVAudioPlayer *play = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audioPath] error:nil];
    return play.duration;
}

//时间处理
+ (NSString*) stringFromDate:(NSDate*) date formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)formatString:(NSString *)datestring {
//    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSString *formate = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [Tools dateFromFomate:datestring formate:formate];
    NSString *text = [Tools stringFromDate:createDate formate:@"yyyy-MM-dd"];
    return text;
}

+(CGSize)sizeOfLabel:(UILabel *)label withSize:(CGSize)size;
{
    NSDictionary *attribute = @{NSFontAttributeName: label.font};
    
//    NSLog(@"label:%@",label);
//    NSLog(@"%@",size);
    
    CGSize retSize = [label.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

+ (NSString *)getBankIconName:(NSString *)bankid {
    NSString *name = nil;
    switch ([bankid integerValue]) {
        case 1:
            name = @"BankIcon_ICBC";
            break;
            
        case 2:
            name = @"BankIcon_ABC";
            break;
            
        case 3:
            name = @"BankIcon_BC";
            break;
            
        case 4:
            name = @"BankIcon_CBC";
            break;
            
        case 5:
            name = @"BankIcon_BCM";
            break;
            
        case 6:
            name = @"BankIcon_CMB";
            break;
            
        case 7:
            name = @"BankIcon_SPDB";
            break;
            
        case 8:
            name = @"BankIcon_CMBC";
            break;
        case 9:
            name = @"BankIcon_CITIC";
            break;
            
        case 10:
            name = @"BankIcon_CIB";
            break;
            
        case 11:
            name = @"BankIcon_CEB";
            break;
            
        case 12:
            name = @"BankIcon_HXB";
            break;
        case 13:
            name = @"BankIcon_PAB";
            break;
            
        case 14:
            name = @"BankIcon_CGB";
            break;
            
        case 15:
            name = @"BankIcon_PSBC";
            break;
            
        case 16:
            name = @"BankIcon_BOS";
            break;
        case 17:
            name = @"BankIcon_BOB";
            break;
        case 18:
            name = @"BankIcon_JSBK";
            break;
            
        case 19:
            name = @"BankIcon_BON";
            break;
            
        case 20:
            name = @"BankIcon_BONB";
            break;
        case 21:
            name = @"BankIcon_HangZhou";
            break;
        case 22:
            name = @"BankIcon_ShengJin";
            break;
        case 23:
            name = @"BankIcon_TianJin";
            break;
        case 24:
            name = @"BankIcon_DaLian";
            break;
        case 25:
            name = @"BankIcon_XiaMenGuoJi";
            break;
        case 26:
            name = @"BankIcon_HuiFeng";
            break;
        case 27:
            name = @"BankIcon_ZhaDa";
            break;
        case 28:
            name = @"BankIcon_HuaQi";
            break;
        case 29:
            name = @"BankIcon_DongYa";
            break;
        case 30:
            name = @"BankIcon_HengSheng";
            break;
        case 31:
            name = @"BankIcon_XingZhan";
            break;
        case 32:
            name = @"BankIcon_HuaQiao";
            break;
        case 33:
            name = @"BankIcon_NanYangShangYe";
            break;
        case 34:
            name = @"BankIcon_DaHua";
            break;
        case 35:
            name = @"BankIcon_SanJinZhuYou";
            break;
        case 36:
            name = @"BankIcon_AoXin";
            break;
        case 37:
            name = @"BankIcon_FuBangHuaYi";
            break;
        default:
            name = @"不存在";
            NSLog(@"银行图片不存在");
            break;
    }
    return name;
}

+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict forClass:(Class)class {
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:class]) {
        if ([obj isKindOfClass:[NSString class]] && [obj isEqual:@""]) {
            return nil;
        } else {
            return obj;
        }
    } else {
        if ([obj isKindOfClass:[NSNumber class]] && class == [NSString class]) {
            return [(NSNumber *)obj stringValue];
        }
    }
    return nil;
}

+ (NSString *)schemaForBankId:(NSString *)bankid directBank:(BOOL)directBank {
    NSString *schema = nil;
    if (!directBank) {
        switch ([bankid integerValue]) {
            case 1:  //工行
                schema = @"com.icbc.iphoneclient://";
                break;
            case 3:  //中行
                schema = @"BOCMBCIZF://";
                break;
            case 4:  //建行
                schema = @"wx2654d9155d70a468://";
                break;
            case 6:  //招行
                schema = @"cmbmobilebank://";
                break;
            case 7:  //浦发
                schema = @"wx1cb534bb13ba3dbd://";
                break;
            case 8:  //民生
                schema = @"wx42840ed4e9347932://";
                break;
            case 9:  //中信银行
                schema = @"rm226427com.citic.mobile://";
                break;
            case 11: //光大
                schema = @"wxf505f9da589b9506://";
                break;
            case 13: //平安
                schema = @"wx95415c456652ce73://";
                break;
            case 14: //广发
                schema = @"CGB://";
                break;
            case 16: //上海银行
                schema = @"BankOfShangHai://";
                break;
            case 17: //北京银行
                schema = @"wxb57101c34cb7773e://";
                break;
            case 18: //江苏银行
                schema = @"wx4868b35061f87885://";
                break;
            case 19: //南京银行
                schema = @"QQ0606C670://";
                break;
            case 20: //宁波银行
                schema = @"nbcbmobilebank://";
                break;
            case 21: //杭州银行
                schema = @"hzbank://";
                break;
            case 23: //天津银行
                schema = @"wxbd4aaf12f5b9bf4d://";
                break;
            case 26: //汇丰银行
                schema = @"comhtsuhsbcpersonalbanking://";
                break;
            default:
                break;
        }

    } else {
        switch ([bankid integerValue]) {
            case 1:  //工行
                break;
            case 3:  //中行
                break;
            case 4:  //建行
                break;
            case 6:  //招行
                break;
            case 7:  //浦发
                break;
            case 8:  //民生
                break;
            case 9:  //中信银行
                break;
            case 11: //光大
                break;
            case 13: //平安
                break;
            case 14: //广发
                break;
            case 16: //上海银行
                break;
            case 17: //北京银行
                break;
            case 18: //江苏银行
                break;
            case 19: //南京银行
                schema = @"QQ2FC6AD84://";
                break;
            case 20: //宁波银行
                break;
            case 21: //杭州银行
                break;
            case 23: //天津银行
                break;
            case 26: //汇丰银行
                break;
            default:
                break;
        }

    }
    
    return schema;
}

+ (NSString *)downloadURLForBankId:(NSString *)bankid directBank:(BOOL)directBank {
    NSString *url = nil;
    
    if (!directBank) {
        switch ([bankid integerValue]) {  //手机银行
            case 1:  //工行
                break;
            case 3:  //中行
                break;
            case 4:  //建行
                break;
            case 6:  //招行
                break;
            case 7:  //浦发
                break;
            case 8:  //民生
                break;
            case 9:  //中信银行
                break;
            case 11: //光大
                break;
            case 13: //平安
                break;
            case 14: //广发
                break;
            case 16: //上海银行
                break;
            case 17: //北京银行
                break;
            case 18: //江苏银行
                break;
            case 19: //南京银行
                url = @"https://itunes.apple.com/cn/app/id435060143?mt=8";
                break;
            case 20: //宁波银行
                break;
            case 21: //杭州银行
                break;
            case 23: //天津银行
                break;
            case 26: //汇丰银行
                break;
            default:
                break;
        }
    } else { //直销银行
        switch ([bankid integerValue]) {
            case 1:  //工行
                break;
            case 3:  //中行
                break;
            case 4:  //建行
                break;
            case 6:  //招行
                break;
            case 7:  //浦发
                break;
            case 8:  //民生
                break;
            case 9:  //中信银行
                break;
            case 11: //光大
                break;
            case 13: //平安
                break;
            case 14: //广发
                break;
            case 16: //上海银行
                break;
            case 17: //北京银行
                break;
            case 18: //江苏银行
                break;
            case 19: //南京银行
                url = @"https://itunes.apple.com/cn/app/id930396328?&mt=8";  //你好银行
                break;
            case 20: //宁波银行
                break;
            case 21: //杭州银行
                break;
            case 23: //天津银行
                break;
            case 26: //汇丰银行
                break;
            default:
                break;
        }

    }
    
    return url;
}

+ (NSString *)formattedDepositRate:(double)rate
{
    NSString *t = [NSString stringWithFormat:@"%.4f",rate];
    if ([t hasSuffix:@"0"]) {
        t = [t substringToIndex:(t.length-1)];
    }
    if ([t hasSuffix:@"000"]) {
        t = [t substringToIndex:(t.length-1)];
    }
    return [NSString stringWithFormat:@"%@%%",t];
}

+ (NSString *)storedDataPath  {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingPathComponent:@"data"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
        NSError *error = nil;
        BOOL success = [url setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error:&error];
        if(!success) {
            NSLog(@"excluding %@ from backup, error:%@", [url lastPathComponent], error);
        }
    }
    
    return path;
}


+(NSString *)stringChartSpact:(NSString *)testString
{
    testString = [[testString stringByReplacingOccurrencesOfString:@" " withString:@""]
                  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:specialCharacterStr];
    return [testString stringByTrimmingCharactersInSet:doNotWant];
}


+ (UIColor *)colorWithHexValue:(uint)hexValue alpha:(float)alpha
{
    return [UIColor
            colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
            green:((float)((hexValue & 0xFF00) >> 8))/255.0
            blue:((float)(hexValue & 0xFF))/255.0
            alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(float)alpha
{
    if (hexStr == nil || (id)hexStr == [NSNull null]) {
        return nil;
    }
    else{
        UIColor *color;
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
        
        uint hexValue;
        if ([[NSScanner scannerWithString:hexStr] scanHexInt:&hexValue]) {
            color = [self colorWithHexValue:hexValue alpha:alpha];
        }
        else {
            // invalid hex string
            color = [UIColor clearColor];
        }
        return color;
    }
}


@end
