//
//  CMCMUtility.h
//  CMCMUtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

typedef void (^FailViewBtnClickBlock) (void);


#define CMUtilityNetwork        [CMUtility sharedNet]

@interface CMUtility : NSObject

//网络状态
@property (nonatomic,assign)NSInteger  status;

//网络请求失败点击重新加载按钮调用的Block
@property (nonatomic,copy) FailViewBtnClickBlock failViewBtnClickBlock;

//网络单例方法
+(instancetype)sharedNet;

//计算字符串的字数，
+ (int)calculateTextLength:(NSString *)text;

//动态计算字符串高度
+ (CGSize)calculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;
//计算两点经纬度之间的距离
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2;

//数字转弧度
+(CGFloat)convertNumToArc:(double)num;

//校验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;

//校验登录密码
+ (BOOL)validatePsd:(NSString *)password;

//校验优惠码(只包含数字字母)
+ (BOOL)validateCouponCode:(NSString *)couponCode;

//校验支付密码
+ (BOOL)validatePayPsd:(NSString *)paypsd;

// 判断有效url
+ (BOOL)validateHTTPUrl:(NSString *)urlStr;

//判断固话
+ (BOOL)validatePhoneTel:(NSString *)phoneNum;

// 判断有效密码
+ (BOOL)validatePassword:(NSString *)pwd;

// 手机号部分隐藏
+ (NSString *)securePhoneNumber:(NSString *)pNum;

// 判断字符是否全为空格
+ (BOOL)isAllSpaceWithString:(NSString *)string;

// 反转数组
+ (void)reverseArray:(NSMutableArray *)targetArray;

// toast 提示框
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view;

// alert提示框
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate;

//风火轮加载
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;

//提示框 设置偏移量
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view yOffset:(CGFloat)y;

//隐藏风火轮
+ (void)hideMBProgress:(UIView*)_targetView;

//提示框,Tim添加
+ (void)showTips:(NSString *)tips;

//图片的颜色和尺寸
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

//颜色画图,可通用,Tim添加
+ (UIImage *)imageWithColor:(UIColor *)color;

//获取当前版本号
+ (NSString *)getLocalAppVersion;

//图像保存路径
+ (NSString *)savedPath;

//获得屏幕图像
+(UIImage *)imageFromView:(UIView *)theView;

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r;

//伸展UIImage,Tim添加
+ (UIImage *)resizeImage:(NSString *)imageName;

//将时间戳转换为时间
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat;

//将时间转换为时间戳
+ (NSString *)getTimeStampWithDate:(NSString *)strDate;

//日期显示规则   本日显示时间，昨日显示“昨日”，之前日期显示具体日期
+ (NSString *)showDateWithStringDate:(NSString *)strDate;

//千分位的格式
+ (NSString *)conversionThousandth:(NSString *)string;

//判断网络
+ (BOOL)isConnectionAvailable;

//生成指定大小的图片 图片中心为指定显示的图片
+(UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName;

//限制输入框只能输入数字
+ (BOOL)printInNumber:(NSString*)number;

//限制输入框只能输入字母和数字组合
+ (BOOL)printInLettersOrNumber:(NSString*)str;

//限制输入框只能输入字母
+ (BOOL)printInLetters:(NSString*)str;

//单个文件的大小,Tim添加
+ (long long)fileSizeAtPath:(NSString*)filePath;

//遍历文件夹获得文件夹大小，返回多少M，Tim添加
+ (float)folderSizeAtPath:(NSString*) folderPath;

//md5，Tim添加
+ (NSString *) md5: (NSString *) inPutText;

//字典转字符串
+ (NSString*)dictionaryToJsonString:(NSDictionary *)dic;

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
                                  text:(NSString *)text;

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
+(CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font string:(NSString*)string withSpacing:(CGFloat)spacing;


/**
 *  设置文字行间距
 *
 *  @param string   字符串
 *  @param font     字体大小
 *  @param spacing  间距大小
 *
 *  @return NSAttributedString
 */

+(NSAttributedString *)setLineSpacingWithString:(NSString *)string withFont:(CGFloat)font spacing:(CGFloat)spacing;

/**
 *  判断时间是否在一周内
 *
 *  @param dateString   时间戳
 *  @param format       时间格式
 *
 *  @return NSString    时间|星期
 */
+ (NSString*)weekDayStr:(NSString *)dateString withFormat:(NSString *)format;


/**
 *  判断时间的时间段 几分钟/几小时/几天前
 *
 *  @param dateString   时间戳
 *  @param format       时间格式
 *
 *  @return NSString    时间|星期
 */
+ (NSString *)intervalSinceNow: (NSString *)dateString;

/**
 *  时间戳转换为  xx分:xx秒 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateMMssFromString:(NSString *)dateString;


/**
 *  时间戳转换为  xx时:xx分 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateHHmmFromString:(NSString *)dateString;

/**
 *  时间戳转换为  xx年-xx月-xx日 xx点:xx秒  的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateYYMMDDHHMMFromString:(NSString *)dateString;

/**
 *  时间戳转换为  xx年-xx月-xx日 的格式
 *
 *  @param dateString   时间戳
 *
 *  @return NSString    格式化好的日期
 */
+ (NSString *)dateYYMMDDFromString:(NSString *)dateString;

/**
 *  判断时间的时间段 几分钟/几小时/几天前
 *
 *  @param format       时间格式
 *
 *  @return NSString    周几
 */
+ (NSString*)weekDayStr:(NSString *)format;

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
+(BOOL)changeCharsWithText:(UITextView *)textView withTextBytes:(UILabel *)label withMax:(NSInteger)MaxNum withText:(NSString *)text;

/**
 *  获取当前时间戳 秒 毫秒
 *  @return NSString    时间戳字符串
 */

+ (NSString *)currentTimestampSecond;
+ (NSString *)currentTimestampMillisecond;


/**
 *  网络请求失败加载的View
 *
 *  @param view         要加载的View
 *
 *  @return UIButton    重新加载按钮
 */
+ (UIButton *)createHttpRequestFailViewWithView:(UIView *)view;


/**
 *  移除网络请求失败加载的View
 *
 *  @param view         要移除的View
 *
 *  @return
 */
+ (void)removeFailViewWith:(UIView *)superView;

/**
 *  网络请求时播放的动画
 *
 *  @param view         当前的View
 *
 *  @return
 */
+(void)showGifProgressViewInView:(UIView *)view;

/**
 *  网络请求时播放的动画   自定义位置
 *
 *  @param view         当前的View 有偏移量
 *
 *  @return
 */
+(void)showGifProgressViewInView:(UIView *)view andOffsetValue:(CGFloat)value;


/**
 *  结束动画
 *
 *  @param view         当前的View
 *
 *  @return
 */
+(void)hiddenGifProgressViewInView:(UIView *)view;


//将20150717 转化为 今天7月12日
+(NSString*)dateWithString:(NSString*)date;

//将20150717 转化为 7月12日
+(NSString*)subDateWithString:(NSString*)date;


/*
    自定义提示view
    [mxf 2015/11/13]
 */
+ (void) showAlertWithTipsTitle:(NSString *)tipsTitle  message:(NSString *) message delegate:(id)delegate leftBtnTitle:(NSString*)leftBtnTitle  rigthBtnTitle:(NSString*) rigthBtnTitle;


/**
 *  改变搜索词的颜色
 *
 *  @param string      需处理的字符串
 *  @param searchStr   关键词
 *  @param searchColor 改变关键词的颜色
 *
 *  @return 处理后的字符串
 */
+ (NSMutableAttributedString *)needtoProcessString:(NSString *)string searchString:(NSString *)searchStr searchColor:(UIColor *)searchColor;

+ (NSString *)timeAgoStringByLastMsgTime:(long long)lastDateTime lastMsgTime:(long long)lastTimeStamp;

/**
 * 本地版本号的
 *
 * @result 本地版本号的
 */
+ (NSString *)checkVersion;
/**
 * 比较版本号，判断线上版本和本地版本号的大小，根据字符串的大小比较，Tim添加
 * @param str1表示当前版本号，str2表示app store版本号
 *
 * @result 返回YES表示需要更新版本，NO表示不需要更新
 */
+ (BOOL)compareString:(NSString *)str1 WithString:(NSString *)str2;



+ (NSAttributedString *)getFormatedAmountWithColor:(UIColor *)textColor
                                            amount:(NSString *)amount
                                              unit:(NSString *)unit amountFont:(NSInteger) font unitFont:(NSInteger) unfont;

+ (NSAttributedString *)getFormatedAmountAmount:(NSString *)amount
                                           unit:(NSString *)unit
                                          other:(NSString *) other
                                    amountColor:(UIColor *) anColor
                                      unitColor:(UIColor *) unColor
                                            one:(NSInteger) oneFont
                                            two:(NSInteger) twoFont
                                          three:(NSInteger) threeFont;
+ (NSAttributedString *)getFormatedAmountAprs:(NSString *)aprs
                                         unit:(NSString *)unit
                                          qix:(NSString *) qx
                                     minMoney:(NSString *) money
                                    unitColor:(UIColor *) unColor;


//其中将十六进制字符串转换成NSData的代码如下:
+ (NSData *)convertHexStrToData:(NSString *)str;
//将NSData转换成十六进制的字符串则可使用如下方式:
+ (NSString *)convertDataToHexStr:(NSData *)data;

@end
