//
//  CMCMUtility.m
//  CMCMUtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "CMUtility.h"


/**
 *  检查一个对象是否为空
 */
#define GJCFCheckObjectNull(object) [GJCFQuickCacheUitil isNullObject:object]

@implementation CMUtility

+(instancetype)sharedNet{
    static CMUtility* shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
        shareInstance.status = 3;
    });
    return shareInstance;
}

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
    if(mobileNum.length == 0 || mobileNum == nil || mobileNum.length < 11) return NO;
    
    NSString *Regex = @"^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$";//以前用的
    NSPredicate *phone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [phone evaluateWithObject:mobileNum];
}
//!!!!: 校验密码
/**
 *  校验密码    密码为6-14位字母数字下划线
 *
 *  @param password 入参string
 *
 *  @return 返回bool
 */
+ (BOOL)validatePsd:(NSString *)password
{
    if(password.length < 6 || password == nil || password.length > 14) return NO;
    NSString *Regex = @"^[0-9A-Za-z_]{6,14}$";
    NSPredicate *psd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [psd evaluateWithObject:password];
}

//!!!!: 校验优惠码
/**
 *  校验优惠码  只包含数字字母
 *
 *  @param couponCode 优惠码
 *
 *  @return 返回bool
 */
+ (BOOL)validateCouponCode:(NSString *)couponCode
{
    if(!couponCode || couponCode.length == 0) return NO;
    NSString *Regex = @"^[0-9A-Za-z]*$";
    NSPredicate *code = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [code evaluateWithObject:couponCode];
}

//!!!!: 校验支付密码
/**
 *  校验支付密码    密码为6位数字
 *
 *  @param password 入参string
 *
 *  @return 返回bool
 */
//
+ (BOOL)validatePayPsd:(NSString *)paypsd
{
    if(paypsd.length != 6) return NO;
    NSString *Regex = @"^\\d{6}$";
    NSPredicate *psd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [psd evaluateWithObject:paypsd];
}

// 判断有效url
+ (BOOL)validateHTTPUrl:(NSString *)urlStr
{
    NSString *Regex = @"(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?";
    NSPredicate *url = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [url evaluateWithObject:urlStr];
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
    if (pwd.length == 6)
    {
        NSString *strOne = [[pwd substringFromIndex:0] substringToIndex:1];
        int num = 0;
        for (int i = 0; i < 6; i++)
        {
            NSString *str = [[pwd substringFromIndex:i] substringToIndex:1];
            if ([strOne isEqualToString:str])
            {
                num++;
            }
        }
        if (num >= 6)
        {
            return NO;
        }
    }
    return YES;
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
        return [NSString stringWithFormat:@"今天 %@",[[strDate substringFromIndex:11] substringToIndex:5]];
        //        return @"今天";
    }
    else
    {
        //判断是否是昨天
        NSDate *dateYesterday = [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
        NSString *strYesterday = [formatter stringFromDate:dateYesterday];
        NSString *strYesGet = [[strDate substringFromIndex:0] substringToIndex:10];
        NSString *strYes = [[strYesterday substringFromIndex:0] substringToIndex:10];
        
        NSDate *dateYesterdayBefore = [NSDate dateWithTimeIntervalSinceNow:-(48 * 60 * 60)];
        NSString *strYesterdayBefore = [formatter stringFromDate:dateYesterdayBefore];
        NSString *strYesGetBefore = [[strDate substringFromIndex:0] substringToIndex:10];
        NSString *strYesBefore = [[strYesterdayBefore substringFromIndex:0] substringToIndex:10];


        if ([strYes isEqualToString:strYesGet])
        {
            return [NSString stringWithFormat:@"昨天 %@",[[strDate substringFromIndex:11] substringToIndex:5]];
        }else if ([strYesBefore isEqualToString:strYesGetBefore])
        {
            return [NSString stringWithFormat:@"前天 %@",[[strDate substringFromIndex:11] substringToIndex:5]];
        }
        else
        {
            return [[strDate substringFromIndex:5] substringToIndex:11];//显示年月日
            
        }
    }
}

//!!!!: 获取当前时间戳
/**
 *	@brief	获取当前时间戳
 *
 *	@return
 */

+ (NSString *)currentTimestamp
{
    NSDate *senddate = [NSDate date];
    //NSLog(@"date1时间戳 = %ld",time(NULL));
    // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)([senddate timeIntervalSince1970]*1000)];
   return dateStr;

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
    progressHUD.yOffset = 0;
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


+ (void) showAlertWithTipsTitle:(NSString *)tipsTitle  message:(NSString *) message delegate:(id)delegate leftBtnTitle:(NSString*)leftBtnTitle  rigthBtnTitle:(NSString*) rigthBtnTitle {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:tipsTitle message:message delegate:delegate cancelButtonTitle:leftBtnTitle otherButtonTitles:rigthBtnTitle, nil];
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
    if (!_targetView) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:_targetView];
        progressHUD.mode = MBProgressHUDModeIndeterminate;
        [progressHUD show:YES];
        progressHUD.labelText = _msg;
        [_targetView addSubview:progressHUD];
    });
}

//!!!!: 显示toast提示框 1秒后自动消失
/**
 *	@brief	显示toast提示框 1秒后自动消失
 *
 *	@param 	message 	提示信息
 *
 *	@return
 */
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view yOffset:(CGFloat)y
{
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:progressHUD];
    progressHUD.detailsLabelText = message;
    progressHUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    progressHUD.yOffset = y;
    
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}

+ (void)hideMBProgress:(UIView*)_targetView
{
    [MBProgressHUD hideHUDForView:_targetView animated:YES];
}

/**
 *提示框,Tim添加
 */
+ (void)showTips:(NSString *)tips
{
    if (!tips)return;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
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
/**
 *根据图像进行伸展
 */
+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
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

/**
 *  打分特殊字体
 *
 *  @param leftFount  左边字体大小
 *  @param rightFount 右边字体大小
 *  @param text       内容
 *
 *  @return 富文本
 */
+ (NSAttributedString *)ScoreLeftFount:(UIFont *)leftFount
                            rightFount:(UIFont *)rightFount
                                  text:(NSString *)text
{
    if (text == nil) {
        text = @"";
    }
    
    NSArray *arr = [text componentsSeparatedByString:@"."];
    
    NSString *leftText = arr[0];
    NSString *rightText;
    NSMutableAttributedString *attrStr;
    if ([arr count] > 1) {
        rightText = arr[1];
        attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@.%@",leftText,rightText]];
    }else{
        rightText = @"";
        attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",leftText,rightText]];
    }
    [attrStr addAttribute:NSFontAttributeName
                    value:leftFount
                    range:NSMakeRange(0, leftText.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:rightFount
                    range:NSMakeRange(leftText.length, rightText.length)];
    
    return [[NSAttributedString alloc] initWithAttributedString:attrStr];
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
 *      单个文件的大小，Tim添加
 *
 */
+ (long long)fileSizeAtPath:(NSString*)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


/**
 *
 *  遍历文件夹获得文件夹大小，返回多少M，Tim添加
 */
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
    return folderSize /1024.0;
}

/**
 *
 *  md5，Tim添加
 */
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
    if (string.length == 0) {
        string = @" ";
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, [string length])];
    
    return attributedString;
}


/**
 *  判断时间是否在一周内
 *
 *  @param dateString   时间戳
 *  @param format       时间格式
 *
 *  @return NSString    时间|星期
 */

+ (NSString*)weekDayStr:(NSString *)dateString withFormat:(NSString *)format
{
    
    if ([dateString isEqualToString:@"0"]||[dateString length]==0)
    {
        return @"";
    }
    
    NSDate *date;
    //时间戳转Date
    if (dateString.length == 10) {
        long long time;
        if (dateString.length == 10) {
            time = [dateString longLongValue];
        }
        else if (dateString.length == 13){
            time = [dateString longLongValue]/1000;
        }
        
        date = [NSDate dateWithTimeIntervalSince1970:time];
    }else{
        //string转date
        
        //去除所有非数字的字符
        dateString = [dateString stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [dateString length])];
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyyMMdd"];
        date = [inputFormatter dateFromString:dateString];
    }
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //判断两个时间是否在一个星期内
    NSInteger nowDate = [calendar ordinalityOfUnit:NSWeekCalendarUnit
                                            inUnit:NSEraCalendarUnit
                                           forDate:[NSDate date]];
    NSInteger formDate = [calendar ordinalityOfUnit:NSWeekCalendarUnit
                                             inUnit:NSEraCalendarUnit
                                            forDate:date];
    //如果时间跟当前时间不在一个星期之类，则返回年月日
    if(nowDate - formDate !=0){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        NSString *strTime = [formatter stringFromDate:date];
        return strTime;
    }
    
    NSDateComponents *comps;
    comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:date];
    NSInteger nowWeek = [comps weekday];
    NSString *weekStr = [[NSString alloc] init];
    
    switch (nowWeek) {
        case 1:
            weekStr = @"本周日";
            break;
        case 2:
            weekStr = @"本周一";
            break;
        case 3:
            weekStr = @"本周二";
            break;
        case 4:
            weekStr = @"本周三";
            break;
        case 5:
            weekStr = @"本周四";
            break;
        case 6:
            weekStr = @"本周五";
            break;
        case 7:
            weekStr = @"本周六";
            break;
            
        default:
            break;
    }
    
    return weekStr;
}

/**
 *  判断时间的时间段 几分钟/几小时/几天前
 *
 *  @param format       时间格式
 *
 *  @return NSString    周几
 */
+ (NSString*)weekDayStr:(NSString *)format
{
    NSString *weekDayStr = nil;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSString *str = [self description];
    if (str.length >= 10) {
        NSString *nowString = [str substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    week ++;
    switch (week) {
        case 1:
            weekDayStr = @"周日";
            break;
        case 2:
            weekDayStr = @"周一";
            break;
        case 3:
            weekDayStr = @"周二";
            break;
        case 4:
            weekDayStr = @"周三";
            break;
        case 5:
            weekDayStr = @"周四";
            break;
        case 6:
            weekDayStr = @"周五";
            break;
        case 7:
            weekDayStr = @"周六";
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;
}


/**
 *  判断时间的时间段 几分钟/几小时/几天前
 *
 *  @param dateString   时间戳
 *  @param format       时间格式
 *
 *  @return NSString    时间|星期
 */
+ (NSString *)intervalSinceNow: (NSString *)dateString
{
    if ([dateString isEqualToString:@"0"]||[dateString length]==0)
    {
        return @"";
    }
    NSString *date1 = [CMUtility getTimeWithTimestamp:dateString WithDateFormat:@"yyyyMMdd"];
    dateString = [CMUtility getTimeWithTimestamp:dateString WithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate *theDate = [dateFormatter dateFromString:dateString];
    
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *datenow = [date dateByAddingTimeInterval:interval];
    NSString *dateNowStr = [dateFormatter stringFromDate:datenow];
    
    NSString*totalStr = [NSString stringWithFormat:@"%@ 23:59:59",[dateNowStr substringToIndex:10]];
    NSDate *dateDeadLine=[dateFormatter dateFromString:totalStr];
    long dd = fabs([theDate timeIntervalSinceDate:datenow]);
    long dd1 = fabs([theDate timeIntervalSinceDate:dateDeadLine]);

    NSString *timeString;
    if([[dateNowStr substringToIndex:10]isEqualToString:[dateString substringToIndex:10]])
    {
    if (dd/3600<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/60];
        if([timeString intValue]<10)
        {
          timeString = @"刚刚";
        }
        else
        {
         timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }
    }
    if (dd/3600>=1&&dd/86400<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/3600];
        
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    }
    else
    {
    if ((dd1>(24*60*60-1))&&(dd1<2*24*60*60))
    {
        timeString=@"昨天";
        
    }
    else if((dd1>(2*24*60*60-1))&&(dd1<3*24*60*60))
    {
       timeString=@"前天";
    }
    else {
        timeString = [CMUtility subDateWithString:date1];
    }
    }
    return timeString;
}

/* 时间转文案 */
+ (NSString *)timeAgoStringByLastMsgTime:(long long)lastDateTime lastMsgTime:(long long)lastTimeStamp
{
    NSDate *date = GJCFDateFromTimeInterval(lastDateTime);
    
    if (GJCFCheckObjectNull(date)) {
        return nil;
    }
    
    long long timeNow = lastDateTime;
    NSCalendar * calendar=[GJCFDateUitil sharedCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    NSInteger year=[component year];
    NSInteger month=[component month];
    NSInteger day=[component day];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    NSInteger t_year=[component year];
    NSInteger t_month = [component month];
    NSInteger t_day= [component day];
    
    NSString *string = nil;
    
    long long now = [today timeIntervalSince1970];
    
    long long  distance= now - timeNow;
    long long  lastMsgDistance =  lastDateTime - lastTimeStamp;
    
    if (lastMsgDistance < 60*3) {
        return nil;
    }
    
    if(distance <= 60*60*24 && day == t_day && t_month == month && t_year == year){
        
        string = [NSString stringWithFormat:@"今天  %@",GJCFDateToStringByFormat(date,@"HH:mm")];
        
    }
    else if (day == t_day - 1 && t_month == month && t_year == year){
        
        string = [NSString stringWithFormat:@"昨天  %@",GJCFDateToStringByFormat(date,@"HH:mm")];
        
    }else if (day == t_day - 2 && t_month == month && t_year == year){
        
        string = [NSString stringWithFormat:@"前天  %@",GJCFDateToStringByFormat(date,@"HH:mm")];
        
    }else if(year == t_year){
        
        NSString *detailTime = GJCFDateToStringByFormat(date,@"HH:mm");
        string=[NSString stringWithFormat:@"%ld-%ld  %@",(long)month,(long)day,detailTime];
        
    }else{
        
        NSString *detailTime = GJCFDateToStringByFormat(date,@"HH:mm");
        
        string=[NSString stringWithFormat:@"%ld-%ld-%ld  %@",(long)year,(long)month,(long)day,detailTime];
    }
    
    return string;
}

/**
 *  时间戳转换为  xx分:xx秒 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateMMssFromString:(NSString *)dateString;
{
    NSTimeInterval aTimer = fabs(dateString.doubleValue);
    int day     = (int)(aTimer/86400);
    int hour    = (int)(aTimer - day*86400)/3600;
    int minute  = (int)(aTimer -day*86400 -hour*3600)/60;
    int second  = aTimer - day*86400 - hour * 3600 - minute * 60;
    NSString *minStr  = minute < 10 ? [NSString stringWithFormat:@"0%d",minute] : [NSString stringWithFormat:@"%d",minute];
    NSString *secondStr = second < 10 ? [NSString stringWithFormat:@"0%d",second] : [NSString stringWithFormat:@"%d",second];
    return [NSString stringWithFormat:@"%@分%@秒",minStr,secondStr];
}

/**
 *  时间戳转换为  xx时:xx分 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateHHmmFromString:(NSString *)dateString
{
    NSTimeInterval aTimer = fabs(dateString.doubleValue);
    int day     = (int)(aTimer/86400);
    int hour    = (int)(aTimer - day*86400)/3600;
    int minute  = (int)(aTimer -day*86400 -hour*3600)/60;
    NSString *hourStr = hour < 10 ? [NSString stringWithFormat:@"0%d",hour] : [NSString stringWithFormat:@"%d",hour];
    NSString *minStr  = minute < 10 ? [NSString stringWithFormat:@"0%d",minute] : [NSString stringWithFormat:@"%d",minute];
    return [NSString stringWithFormat:@"%@:%@",hourStr,minStr];
}

/**
 *  时间戳转换为  xx年-xx月-xx日 xx点:xx秒  的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateYYMMDDHHMMFromString:(NSString *)dateString
{
    NSTimeInterval aTimer = fabs(dateString.doubleValue);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:aTimer];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}


/**
 *  时间戳转换为  xx年-xx月-xx日 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateYYMMDDFromString:(NSString *)dateString
{
    NSTimeInterval aTimer = fabs(dateString.doubleValue);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:aTimer];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateFormatter stringFromDate:date];
}

/**
 *  字数控制
 *
 *  @param dateString   时间戳
 *  @param label        显示字数的
 *  @param MaxNum       最大限制字数
 *  @param text         现输入字符
 *
 *  @return NSString    格式化好的日期
 */
+(BOOL)changeCharsWithText:(UITextView *)textView withTextBytes:(UILabel *)label withMax:(NSInteger)MaxNum withText:(NSString *)text{
    
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    
    //如果是中文输入法，获取高亮部分的字
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if ([text length] > MaxNum) {
                textView.text = [text substringToIndex:MaxNum];
                return NO;
            }else{
                label.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)[text length],(long)MaxNum];
                return YES;
            }
        }
    }else{
        if ([text length] > MaxNum) {
            textView.text = [text substringToIndex:MaxNum];
            return NO;
        }else{
            label.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)[text  length],(long)MaxNum];
            return YES;
        }
    }
    return YES;
}



+ (UIButton *)createHttpRequestFailViewWithView:(UIView *)view{
    
    
    BOOL isHave = NO;
    for (UIView *tempView in view.subviews) {
        if (tempView.tag == 1624) {
            isHave = YES;
        }
    }
    
    if (isHave) {
        [CMUtility removeFailViewWith:view];
    }
    
    UIView *failView = [[UIView alloc] init];
    failView.backgroundColor = [UIColor whiteColor];
    failView.tag = 1624;
//    if([view isKindOfClass:[UITableView class]]||[view isKindOfClass:[UICollectionView class]])
//    {
//        failView.frame = view.frame;
//        [view.superview addSubview:failView];
//    }
//    else
//    {
        failView.frame = CGRectMake(0, 0, view.width, view.height);
      [view addSubview:failView];
//    }

    
    UIImageView *failImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (view.height-DEF_RESIZE_UI(175))/2-25, DEF_RESIZE_UI(70), DEF_RESIZE_UI(70))];
    failImageView.image = DEF_IMAGENAME(@"icon_fail_to_load");
    failImageView.center = CGPointMake(DEF_DEVICE_WIDTH/2, failImageView.centerY);
    [failView addSubview:failImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, failImageView.frame.origin.y + failImageView.frame.size.height + 10, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(30))];
    label.text = @"数据加载失败";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = DEF_MyBoldFont(15);
    label.textColor = [UIColor lightGrayColor];
    [failView addSubview:label];
    
    UILabel *msgLb = [[UILabel alloc] initWithFrame:CGRectMake(0, label.frame.origin.y + label.frame.size.height, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(30))];
    msgLb.text = @"确认您的手机是否联网";
    msgLb.textAlignment = NSTextAlignmentCenter;
    msgLb.font = DEF_MyBoldFont(13);
    msgLb.textColor = DEF_COLOR_RGB(220, 220, 220);
    [failView addSubview:msgLb];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, msgLb.frame.origin.y + msgLb.frame.size.height + 15, DEF_RESIZE_UI(100), DEF_RESIZE_UI(35));
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    button.center = CGPointMake(DEF_DEVICE_WIDTH/2, button.centerY);
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 2;
    button.layer.borderWidth = 1;
    button.layer.borderColor = DEF_COLOR_RGB(220, 220, 220).CGColor;
    [failView addSubview:button];
    
    return button;
    return nil;
}

+ (void)removeFailViewWith:(UIView *)superView{
    if([superView isKindOfClass:[UITableView class]]||[superView isKindOfClass:[UICollectionView class]])
    {
        UIView *view = [superView.superview viewWithTag:1624];
        [view removeFromSuperview];
    }
    else
    {
        UIView *view = [superView viewWithTag:1624];
        [view removeFromSuperview];
    }
}

+(void)showGifProgressViewInView:(UIView *)view
{
    [CMUtility hiddenGifProgressViewInView:view];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:view];
    progressHUD.mode = MBProgressHUDModeCustomView;
    progressHUD.color = [UIColor clearColor];
    
    CGSize gifImageSize = [UIImage imageNamed:@"loading_anim_01"].size;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 8; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_anim_0%d",i]]];
    }
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, gifImageSize.width, gifImageSize.height)];
    imgV.animationImages = arr;
    imgV.animationDuration = 0.7;
    imgV.tag = 10000;
    [imgV startAnimating];
    if([view isKindOfClass:[UITableView class]]||[view isKindOfClass:[UICollectionView class]])
    {
        progressHUD.yOffset = -(DEF_NAVIGATIONBAR_HEIGHT + 49)/2;
    }
    progressHUD.customView = imgV;
    [progressHUD show:YES];
    [view addSubview:progressHUD];
}

+(void)showGifProgressViewInView:(UIView *)view andOffsetValue:(CGFloat)value{
    
    [CMUtility hiddenGifProgressViewInView:view];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:view];
    progressHUD.mode = MBProgressHUDModeCustomView;
    progressHUD.color = [UIColor clearColor];
    
    CGFloat offsetValue = value > 0 ? value :value *-1;
    CGSize gifImageSize = [UIImage imageNamed:@"loading_anim_01"].size;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, gifImageSize.width, gifImageSize.height + offsetValue)];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 8; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_anim_0%d",i]]];
    }
    CGRect frame = value > 0
    ? CGRectMake(0, 0, gifImageSize.width, gifImageSize.height)
    : CGRectMake(0,value * -1, gifImageSize.width, gifImageSize.height);

    UIImageView *imgV = [[UIImageView alloc]initWithFrame:frame];
    imgV.animationImages = arr;
    imgV.animationDuration = 0.7;
    imgV.tag = 10000;
    [imgV startAnimating];
    [bgView addSubview:imgV];
    
    progressHUD.customView = bgView;
    [progressHUD show:YES];
    [view addSubview:progressHUD];
}

+(void)hiddenGifProgressViewInView:(UIView *)view
{
    UIImageView *imgV = (UIImageView *)[view viewWithTag:10000];
    if (imgV) {
        imgV.alpha = 0;
        [imgV removeFromSuperview];
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}

//将20150717 转化为 今天7月12日
+(NSString*)dateWithString:(NSString*)date
{
    NSString *converStr;
    if(date.length==8)
    {
        NSString *dateTrailStr = @"";
        NSString *dateLeadStr = @"";
        NSString *month = [date substringWithRange:NSMakeRange(4, 2)];
        NSString *day = [date substringWithRange:NSMakeRange(6, 2)];
        if([month integerValue]<10)
        {
            month = [NSString stringWithFormat:@"%@",[month substringFromIndex:1]];
        }
        if([day integerValue]<10)
        {
            day = [NSString stringWithFormat:@"%@",[day substringFromIndex:1]];
        }
        dateTrailStr = [NSString stringWithFormat:@"%@月%@日",month,day];
        
        long dayInt = 24*60*60;
        NSString*totalStr = [NSString stringWithFormat:@"%@235959",date];
        // NSTimeZone* localzone = [NSTimeZone localTimeZone];
        NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:8];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYYMMddHHmmss"];
        [formatter setTimeZone:GTMzone];
        
        NSDate* inputDate = [formatter dateFromString:totalStr];
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: date];
        NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
        
        long distanceInt = [inputDate timeIntervalSinceDate:localeDate];
        if((distanceInt/dayInt)==0)
        {
            dateLeadStr = @"今天";
        }
        else if((distanceInt/dayInt)==1)
        {
            dateLeadStr = @"明天";
        }
        else if((distanceInt/dayInt)==2)
        {
            dateLeadStr = @"后天";
        }
        else
        {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            [calendar setTimeZone:GTMzone];
            NSDateComponents *comps;
            comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)fromDate:inputDate];
            NSInteger week = [comps weekday];
            if(week==1)
            {
                dateLeadStr=@"周日";
            }else if(week==2){
                dateLeadStr=@"周一";
                
            }else if(week==3){
                dateLeadStr=@"周二";
                
            }else if(week==4){
                dateLeadStr=@"周三";
                
            }else if(week==5){
                dateLeadStr=@"周四";
                
            }else if(week==6){
                dateLeadStr=@"周五";
                
            }else if(week==7){
                dateLeadStr=@"周六";
                
            }
        }
        converStr = [NSString stringWithFormat:@"%@%@",dateLeadStr,dateTrailStr];
    }
    else
    {
        converStr = date;
    }
    return converStr;
}

//改变搜索词的颜色
+ (NSMutableAttributedString *)needtoProcessString:(NSString *)string searchString:(NSString *)searchStr searchColor:(UIColor *)searchColor{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange rang;
    NSUInteger searchStrLength = searchStr.length;
    if (searchStrLength > 0) {
        for (int i = 0; i < string.length - searchStrLength + 1; i ++) {
            rang = NSMakeRange(i, searchStrLength);
            if ([[string substringWithRange:rang] isEqualToString:searchStr]) {
                [str addAttribute:NSForegroundColorAttributeName value:searchColor range:rang];
            }
        }
    }
    return str;
}


//将20150717 转化为 7月12日
+(NSString*)subDateWithString:(NSString*)date
{
    NSString *converStr;
    if(date.length==8)
    {
        NSString *month = [date substringWithRange:NSMakeRange(4, 2)];
        NSString *day = [date substringWithRange:NSMakeRange(6, 2)];
        if([month integerValue]<10)
        {
            month = [NSString stringWithFormat:@"%@",[month substringFromIndex:1]];
        }
        if([day integerValue]<10)
        {
            day = [NSString stringWithFormat:@"%@",[day substringFromIndex:1]];
        }
        converStr = [NSString stringWithFormat:@"%@月%@日",month,day];
    }
    else
    {
        converStr = date;
    }
    return converStr;
}

+ (NSString *)checkVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *nowVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@",nowVersion];
}

/**
 * 比较版本号，判断线上版本和本地版本号的大小，根据字符串的大小比较，Tim添加
 * @param str1表示当前版本号，str2表示app store版本号
 *
 * @result 返回YES表示需要更新版本，NO表示不需要更新
 */
+ (BOOL)compareString:(NSString *)str1 WithString:(NSString *)str2{
    const char* s1 = [str1 cStringUsingEncoding:NSASCIIStringEncoding];
    const char* s2 = [str2 cStringUsingEncoding:NSASCIIStringEncoding];
    return strcmp(s1, s2) < 0 ;
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


@end
