//
//  CMCMUtility.m
//  CMCMUtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "CMUtility.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "JSONKit.h"
//#import "CouponModel.h"
//#import "VouchersModel.h"

@implementation CMUtility

//!!!!: 获取字符串字数
/**
 *  获取字符串字数   汉字算两个字 英文算一个字
 *
 *  @param text 传入字符串
 *
 *  @return 返回字符串位数
 */
+ (int)calculateTextLength:(NSString *)text
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number += 1;
        }
        else
        {
            number += 0.5f;
        }
    }
    return number;
}

//!!!!: 计算字符串的宽度和高度
/**
 *  计算字符串的宽度和高度
 *
 *  @param string 入参的字符串
 *  @param font
 *  @param cSize
 *
 *  @return
 */
+ (CGSize)calculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize
{
    
    if (DEF_IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGRect rect = [string boundingRectWithSize:cSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size;
    }
    else
    {
        CGSize size = [string sizeWithFont:font constrainedToSize:cSize lineBreakMode:NSLineBreakByWordWrapping];
        return size;
    }
    return CGSizeZero;
}

/**
 *  动态算出文本大小
 *
 *  @param size   限制宽高
 *  @param font   字体的大小
 *  @param spacing 行间距
 *  @param string 内容
 *
 *  @return cgsize
 */
+(CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font string:(NSString*)string withSpacing:(CGFloat)spacing
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

/**
 *  设置文字行间距
 *
 *  @param string   字符串
 *  @param font     字体大小
 *  @param spacing  间距大小
 *
 *  @return NSAttributedString
 */
+(NSAttributedString *)setLineSpacingWithString:(NSString *)string withFont:(CGFloat)font spacing:(CGFloat)spacing{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, [string length])];
    
    return attributedString;
}

//!!!!: 计算两点经纬度之间的距离
/**
 *  计算两点经纬度之间的距离
 *
 *  @param coordinate1 经度
 *  @param coordinate2 纬度
 *
 *  @return 返回距离
 */
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2
{
    
    if (coordinate1.longitude >0  && coordinate1.longitude < 180)
    {
        if (coordinate2.longitude >0  && coordinate2.longitude < 180)
        {
            CLLocation  *currentLocation = [[CLLocation alloc]initWithLatitude:coordinate1.latitude longitude:coordinate2.longitude];
            CLLocation *otherLocation = [[CLLocation alloc]initWithLatitude:coordinate2.latitude longitude:coordinate1.longitude];
            CLLocationDistance distance = [currentLocation distanceFromLocation:otherLocation];
            return distance;
        }
    }
    else
    {
        return 0.00;
    }
    
    return 0.00;
}

//!!!!: 数字转弧度
/**
 *  数字转弧度
 *
 *  @param num num
 *
 *  @return 返回弧度
 */
+ (CGFloat)convertNumToArc:(double)num;
{
    if (num == 0)
    {
        return 0;
    }
    return num * M_PI / 180.0;
}

//!!!!: 校验手机号
/**
 *  校验手机号
 *
 *  @param mobileNum 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    NSString *strExpression = @"(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:mobileNum];
}

//!!!!: 校验姓名
/**
 *  校验姓名
 *
 *  @param name 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateName:(NSString *)name{
    NSString *strExpression = @"[\u4e00-\u9fa5]{1,15}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:name];
}

//!!!!: 校验身份证号码
/**
 *  校验身份证号码
 *
 *  @param IDCard 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validateIDCard:(NSString *)IDCard
{
    NSString *strExpression;
    if (IDCard.length == 15) {
        strExpression = @"[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    }else{
        strExpression = @"[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:IDCard];
}

//!!!!: 判断固定电话
/**
 *  判断固定电话
 *
 *  @param phoneNum 手机号码
 *
 *  @return
 */
+ (BOOL)validatePhoneTel:(NSString *)phoneNum
{
    
    //先判断位数
    if (phoneNum.length == 11 || phoneNum.length == 12 || phoneNum.length == 13)
    {
        NSString *strLine = @"-";
        NSString *str1 = [[phoneNum substringFromIndex:2] substringToIndex:1];
        NSString *str2 = [[phoneNum substringFromIndex:3] substringToIndex:1];
        NSLog(@"str1 = %@\n str2 = %@",str1,str2);
        if ([str1 isEqualToString:strLine] || [str2 isEqualToString:strLine])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

//!!!!: 校验密码有效性
/**
 *  校验密码有效性
 *
 *  @param pwd 密码
 *
 *  @return
 */
+ (BOOL)validatePassword:(NSString *)pwd
{
    //同时包含字符、数字、字母（区分大小写）且6-28位
    //NSString *strExpression = @"(?=.*[a-z]|[A-Z])(?=.*\\d)(?=.*[?=[\x21-\x7e]+ ￥€£])[A-Z|a-z\\d?=[\x21-\x7e]+ ￥€£]{6,28}";
    //包含字符、数字、字母（区分大小写）且6-28位
    //NSString *strExpression = @"(?=.*[a-z]|[A-Z]|\\d|[?=[\x21-\x7e]+ ￥€£])[A-Z|a-z\\d?=[\x21-\x7e]+ ￥€£]{6,28}";
    //同时包含数字、字母（区分大小写）且6-15位
    NSString *strExpression = @"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,15}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    return [predicate evaluateWithObject:pwd];
}

//!!!!: 校验密码是否每位都相同
/**
 *  校验密码是否每位都相同
 *
 *  @param pwd 密码
 *
 *  @return
 */
+ (BOOL)passwrdSingleness :(NSString *)pwd{
    
    int strLength = 1;
    for (int i = 1; i < pwd.length; i ++) {
        NSString *temp1 = [pwd substringWithRange:NSMakeRange(i - 1, 1)];
        NSString *temp2 = [pwd substringWithRange:NSMakeRange(i, 1)];
        if ([temp1 isEqualToString:temp2]) {
            strLength ++;
        }
        if (strLength == pwd.length) {
            return YES;
        }
    }
    return 0;
}

//!!!!: 隐藏电话号码
/**
 *	@brief	隐藏电话号码
 *
 *	@param 	pNum 	电话号码
 *
 *	@return 186****1325
 */

+ (NSString *)securePhoneNumber:(NSString *)pNum
{
    if (pNum.length != 11)
    {
        return pNum;
    }
    NSString *result = [NSString stringWithFormat:@"%@****%@",[pNum substringToIndex:3],[pNum substringFromIndex:7]];
    return result;
}

//!!!!: 隐藏身份证号码
/**
 *	@brief	隐藏身份证号码
 *
 *	@param 	IdNum 	身份证号码
 *
 *	@return **************1325
 */
+ (NSString *)secureIdCard:(NSString *)IdNum
{
    NSString *result = @"";
    for (int i; i < IdNum.length - 4; i ++) {
        result = [NSString stringWithFormat:@"%@*",result];
    }
    result = [NSString stringWithFormat:@"%@%@",result,[IdNum substringFromIndex:IdNum.length - 4]];
    return result;
}

//!!!!: 银行卡每四位加空格
/**
 *  银行卡每四位加空格
 *
 *  @param bankCard 银行卡号
 *
 *  @return 1234 5678 9098 7654
 */
+ (NSString *)manageBankCard:(NSString *)bankCard{
    NSMutableString *bankCardNum = [NSMutableString stringWithString:bankCard];
    for (int i = 0; i < bankCard.length; i ++) {
        if (i > 0 && (i + 1) % 4 == 0) {
            [bankCardNum insertString:@" " atIndex:i+ (i + 1)/4];
        }
    }
    return bankCardNum;
   
}

//!!!!: 判断是否 全为空格
/**
 *	@brief	判断是否 全为空格
 *
 *	@param 	string
 *
 *	@return
 */

+ (BOOL)isAllSpaceWithString:(NSString *)string
{
    for (int i = 0; i < string.length; i++)
    {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if (![str isEqualToString:@" "])
        {
            return NO;
        }
    }
    return YES;
}

//!!!!: 反转数组
/**
 *  反转数组
 *
 *  @param targetArray 传入可变数组
 */

+ (void)reverseArray:(NSMutableArray *)targetArray
{
    for (int i = 0; i < targetArray.count / 2.0f; i++)
    {
        [targetArray exchangeObjectAtIndex:i withObjectAtIndex:(targetArray.count - 1 - i)];
    }
}

//!!!!: 时间戳转时间
/**
 *  时间戳转时间
 *
 *  @param strDate 时间戳
 *
 *  @return
 */
+ (NSString *)showDateWithStringDate:(NSString *)strDate
{
    if (strDate.length < 19)
    {
        //确保格式正确，不正确的话，返回后台给的时间
        return strDate;
    }
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *strNow = [formatter stringFromDate:dateNow];
    
    NSString *strToday = [[strNow substringFromIndex:0] substringToIndex:10];
    NSString *strDay = [[strDate substringFromIndex:0] substringToIndex:10];
    if ([strDay isEqualToString:strToday])
    {
        return [[strDate substringFromIndex:11] substringToIndex:5];
        //        return @"今天";
    }
    else
    {
        //判断是否是昨天
        NSDate *dateYesterday = [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
        NSString *strYesterday = [formatter stringFromDate:dateYesterday];
        NSString *strYes = [[strYesterday substringFromIndex:0] substringToIndex:10];
        NSString *strYesGet = [[strDate substringFromIndex:0] substringToIndex:10];
        if ([strYes isEqualToString:strYesGet])
        {
            return @"昨天";
        }
        else
        {
            return [[strDate substringFromIndex:0] substringToIndex:10];//显示年月日
            
        }
    }
}

//!!!!: 显示toast提示框 1秒后自动消失
/**
 *	@brief	显示toast提示框 1秒后自动消失
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:progressHUD];
    progressHUD.detailsLabelText = message;
    progressHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    progressHUD.yOffset = -100.0f;
    //    HUD.xOffset = 100.0f;
    
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}

//!!!!: 系统提示框
/**
 *	@brief	系统提示框
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

//!!!!: 风火轮加载信息
/**
 *  风火轮加载信息
 *
 *  @param _targetView 对象
 *  @param _msg        提示信息
 */
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg
{
    
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:_targetView];
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    [progressHUD show:YES];
    progressHUD.labelText = _msg;
    [_targetView addSubview:progressHUD];
    
}
+ (void)hideMBProgress:(UIView*)_targetView
{
    [MBProgressHUD hideAllHUDsForView:_targetView animated:YES];
//    [MBProgressHUD hideHUDForView:_targetView animated:YES];
}

+ (void)hideMBProgressNOAnimation:(UIView*)_targetView;
{
    [MBProgressHUD hideAllHUDsForView:_targetView animated:NO];

}
/**
 *提示框,Tim添加
 */
+ (void)showTips:(NSString *)tips OnView:(UIView *)view
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.labelText=tips;
    hud.removeFromSuperViewOnHide=YES;
    [hud show:YES];
    [hud hide:YES afterDelay:1.2];
}

//!!!!: 设置图片的颜色和尺寸
/**
 *  设置图片的颜色和尺寸
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  颜色画图,可通用，Tim添加
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//!!!!: 获取当前版本
/**
 *  获取当前版本
 *
 *  @return
 */
+ (NSString *)getLocalAppVersion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *version = [dict objectForKey:@"CFBundleVersion"];
    return version;
}

//!!!!: 图像保存路径
/**
 *  图像保存路径
 *
 *  @return
 */
+ (NSString *)savedPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return documentsDirectory;
}

/**
 *  获得屏幕图像
 *
 *  @param theView view
 *
 *  @return UIImage
 */
+ (UIImage *)imageFromView:(UIView *)theView
{
    //    UIGraphicsBeginImageContext(theView.frame.size);
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//!!!!: 获得某个范围内的屏幕图像
/**
 *  获得某个范围内的屏幕图像
 *
 *  @param theView view
 *  @param r       坐标
 *
 *  @return       UIImage
 */
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//!!!!: 将时间戳转换为指定格式时时间
/**
 *  将时间戳转换为指定格式时时间
 *
 *  @param strTimestamp  传入的时间戳
 *  @param strDateFormat 时间的格式
 *
 *  @return 返回的时间
 */
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat
{
    if ([strTimestamp isEqualToString:@"0"]||[strTimestamp length]==0)
    {
        return @"";
    }
    
    
    long long time;
    if (strTimestamp.length == 10) {
        time = [strTimestamp longLongValue];
    }
    else if (strTimestamp.length == 13){
        time = [strTimestamp longLongValue]/1000;
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:strDateFormat];
    NSString *strTime = [formatter stringFromDate:date];
    return strTime;
}

//!!!!: 通过时间获得时间戳
/**
 *  通过时间获得时间戳     传入时间格式为YYYY-MM-dd HH:mm:ss
 *
 *  @param strDate 时间戳
 *
 *  @return 时间
 */
+ (NSString *)getTimeStampWithDate:(NSString *)strDate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:strDate];
    
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    NSString * str  = [NSString stringWithFormat:@"%@000",timeStamp];
    return str;
}

//!!!!: 千分位格式
/**
 *  千分位格式
 *
 *  @param string 入参
 *
 *  @return
 */
+ (NSString *)conversionThousandth:(NSString *)string
{
    double value = [string doubleValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return formattedNumberString;
}

//!!!!: 判断网络
/**
 *  判断网络
 *
 *  @return
 */
+ (BOOL)isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
            
        default:
            break;
    }
    
    return isExistenceNetwork;
}
 


//!!!!: 生成指定大小的图片 图片中心为指定显示的图片
/**
 *  生成指定大小的图片 图片中心为指定显示的图片
 *
 *  @param size      尺寸
 *  @param imageName 图片名字
 *
 *  @return
 */
+ (UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName
{
    if(size.height < 0 || size.width < 0)
    {
        return nil;
    }
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = [UIColor blackColor];
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.center = CGPointMake(CGRectGetWidth(view.frame) / 2.0, CGRectGetHeight(view.frame) / 2.0);
    [view addSubview:imageView];
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

+ (BOOL)printInNumber:(NSString*)number
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+ (BOOL)printInLettersOrNumber:(NSString*)str
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"];
    int i = 0;
    while (i < str.length) {
        NSString * string = [str substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
+ (BOOL)printInLetters:(NSString*)str
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ"];
    int i = 0;
    while (i < str.length) {
        NSString * string = [str substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
+ (NSString*)dictionaryToJsonString:(NSDictionary *)dic
{
    return [dic JSONString];
}
#pragma  tableview
+ (void)setExtraCellLineHidde:(UITableView *)tableView tabHeader:(BOOL) header tabFooter:(BOOL) footer
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    if (!header) {
        [tableView setTableHeaderView:view];
    }
    if (!footer) {
        [tableView setTableFooterView:view];
    }
}
//限制特殊字符不能输入@
+(int) XZInputText:(NSString *) stringText{
    NSCharacterSet *nameCharacters = [NSCharacterSet
                                      characterSetWithCharactersInString:@"`~!@#$%^&*()+=|{}':;',\\[\\].<>?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？"];
    NSRange userNameRange = [stringText rangeOfCharacterFromSet:nameCharacters];
    
    if (userNameRange.location != NSNotFound) {
        return 0;//包含特殊字符
    }else{
        return 1;
    }
    return 1;
}
+ (NSAttributedString *)getFormatedAmountWithColor:(UIColor *)textColor
                                            amount:(NSString *)amount
                                              unit:(NSString *)unit amountFont:(NSInteger) font unitFont:(NSInteger) unfont{
    if (amount == nil) {
        amount = @"";
    }
    if (unit == nil) {
        unit = @"";
    }
    //    amount=[NSString stringWithFormat:@"%.2lf",[amount floatValue]/100];
    NSString *str = [NSString stringWithFormat:@"%@%@",amount,unit];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:font]
                    range:NSMakeRange(0, amount.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:unfont]
                    range:NSMakeRange(amount.length, unit.length)];
    
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:textColor
                    range:NSMakeRange(0, str.length)];
    
    return [[NSAttributedString alloc] initWithAttributedString:attrStr];
}

+ (NSAttributedString *)getFormatedAmountAmount:(NSString *)amount
                                           unit:(NSString *)unit
                                          other:(NSString *) other
                                    amountColor:(UIColor *) anColor
                                      unitColor:(UIColor *) unColor
                                            one:(NSInteger) oneFont
                                            two:(NSInteger) twoFont
                                            three:(NSInteger) threeFont
{
    if (amount == nil) {
        amount = @"0";
    }
    if (unit == nil) {
        unit = @"";
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@",amount,unit,other];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:oneFont]
                    range:NSMakeRange(0, amount.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:twoFont]
                    range:NSMakeRange(amount.length, unit.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:threeFont]
                    range:NSMakeRange(unit.length,other.length)];
    
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:anColor
                    range:NSMakeRange(0, amount.length)];
    
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:unColor
                    range:NSMakeRange(amount.length, unit.length)];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:attrStr];
}


+ (NSAttributedString *)getFormatedAmountAprs:(NSString *)aprs
                                         unit:(NSString *)unit
                                          qix:(NSString *) qx
                                     minMoney:(NSString *) money
                                    unitColor:(UIColor *) unColor
{
    if (aprs == nil) {
        aprs = @"";
    }if (unit == nil) {
        unit = @"";
    }if (qx == nil) {
        qx = @"";
    }if (money == nil) {
        money = @"";
    }
    
    NSString *str = [NSString stringWithFormat:@"%@ %@  %@  %@",aprs,unit,qx,money];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(0, aprs.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(aprs.length, unit.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(unit.length,qx.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14.0f]
                    range:NSMakeRange(qx.length,money.length)];
    
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:unColor
                    range:NSMakeRange(aprs.length, unit.length)];
    
    return [[NSAttributedString alloc] initWithAttributedString:attrStr];
}

+ (long long)fileSizeAtPath:(NSString*)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [CMUtility fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

+(NSString *) md5: (NSString *) inPutText
{
    if (!inPutText) {
        return inPutText;
    }
    const char *cStr = [inPutText UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    NSString *md5Result = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5Result;
}


+ (void) setBuyTicketsStatus:(NSInteger) buyTicketsStatus {
    
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:buyTicketsStatus  forKey:USERDEFAULT_BUY_TICKETS_STATUS_SUCCESS];
    [NSUserDefaults resetStandardUserDefaults];
    
}

+ (NSInteger) buyTicketsStatus {
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:USERDEFAULT_BUY_TICKETS_STATUS_SUCCESS];
}


+(void) setBuyTicketsStatusWithCoupon:(NSInteger) buyTicketsStatus {
    
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:buyTicketsStatus  forKey:USERDEFAULT_BUY_TICKETS_STATUS_SUCCESS_COPUONES];
    [NSUserDefaults resetStandardUserDefaults];
    
}

+ (NSInteger) buyTicketsStatusWithCoupon {
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:USERDEFAULT_BUY_TICKETS_STATUS_SUCCESS_COPUONES];
}




//优惠券
+ (void) setIsShowLeftBtnsCoupon:(NSInteger) buyTicketsStatus {
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:buyTicketsStatus  forKey:USERDEFAULT_COUPON_ISSHOW_LFETBTNS];
    [NSUserDefaults resetStandardUserDefaults];
}
+ (NSInteger) isShowLeftBtnsCoupon {
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:USERDEFAULT_COUPON_ISSHOW_LFETBTNS];
}


//抵用券
+ (void) setIsShowLeftBtnsVouvhers:(NSInteger) buyTicketsStatus{
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:buyTicketsStatus  forKey:USERDEFAULT_VERHOUS_ISSHOW_LFETBTNS];
    [NSUserDefaults resetStandardUserDefaults];
}
+ (NSInteger) isShowLeftBtnsVouvhers{
    NSUserDefaults *defaults  = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:USERDEFAULT_VERHOUS_ISSHOW_LFETBTNS];
}
/**
 *  获取客服电话号码
 */
//+(NSString *)getKefuNumber{
//    
//    return [CMUserInformation standardUserInformation].kefuPhone;
//}

@end
