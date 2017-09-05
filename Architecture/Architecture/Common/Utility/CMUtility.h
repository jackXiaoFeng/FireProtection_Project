//
//  CMUtility.h
//  CaiMiaoFinance
//
//  Created by caimiao on 15/5/29.
//  Copyright (c) 2015年 Caimiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>


#define COUPONS_SELECTED @"selected_coupons"
#define VOUCHERS_SELECTED @"selected_vouchers"

#define USERDEFAULT_BUY_TICKETS_STATUS_SUCCESS @"buyTicketsStatus"
#define USERDEFAULT_BUY_TICKETS_STATUS_SUCCESS_COPUONES @"buyTicketsStatusCoupus"


#define USERDEFAULT_COUPON_ISSHOW_LFETBTNS @"showLeftBtnsCoupon"
#define USERDEFAULT_VERHOUS_ISSHOW_LFETBTNS @"showLeftBtnsVerhous"


@interface CMUtility : NSObject


//计算字符串的字数，
+ (int)calculateTextLength:(NSString *)text;

//动态计算字符串高度
+ (CGSize)calculateStringSize:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;

//动态算出文本大小
+(CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font string:(NSString*)string withSpacing:(CGFloat)spacing;

//设置文字行间距
+(NSAttributedString *)setLineSpacingWithString:(NSString *)string withFont:(CGFloat)font spacing:(CGFloat)spacing;

//计算两点经纬度之间的距离
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2;

//数字转弧度
+(CGFloat)convertNumToArc:(double)num;

//校验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;

//校验姓名
+ (BOOL)validateName:(NSString *)name;

//校验身份证号码
+ (BOOL)validateIDCard:(NSString *)IDCard;

//判断固话
+ (BOOL)validatePhoneTel:(NSString *)phoneNum;

// 判断有效密码
+ (BOOL)validatePassword:(NSString *)pwd;

// 校验密码是否每位都相同
+ (BOOL)passwrdSingleness :(NSString *)pwd;

// 手机号部分隐藏
+ (NSString *)securePhoneNumber:(NSString *)pNum;

// 身份证号部分隐藏
+ (NSString *)secureIdCard:(NSString *)IdNum;

// 银行卡每四位加空格
+ (NSString *)manageBankCard:(NSString *)bankCard;

// 判断字符是否全为空格
+ (BOOL)isAllSpaceWithString:(NSString *)string;

// 反转数组
+ (void)reverseArray:(NSMutableArray *)targetArray;

//创建navigation title
+ (UIView *)navTitleView:(NSString *)_title;
+ (UIView *)navButtonTitleViewWithTarget:(id)target title:(NSString *)title action:(SEL)selector;

/**
 *	@brief	通用navigation 右边按钮 有图片
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    响应方法
 *	@param 	imageStr 	图片名称
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem *)navRightBackBtn:(id)_target action:(SEL)selector imageStr:(NSString *)imageStr;

/**
 *	@brief	通用navigation 右边按钮 文字
 *
 *	@param 	_target 	接收对象
 *	@param 	selector    响应方法
 *	@param 	title 	    按钮名称
 *
 *	@return	BarButtonItem
 */
+ (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector;

// toast 提示框
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view;

// alert提示框
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate;

//风火轮加载
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;

//隐藏风火轮
+ (void)hideMBProgress:(UIView*)_targetView;
//隐藏风火轮没动画
+ (void)hideMBProgressNOAnimation:(UIView*)_targetView;

//提示框,Tim添加
+ (void)showTips:(NSString *)tips;

//图片的颜色和尺寸
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

//获取当前版本号
+ (NSString *)getLocalAppVersion;

//图像保存路径
+ (NSString *)savedPath;

//获得屏幕图像
+(UIImage *)imageFromView:(UIView *)theView;

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r;

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

//字典转字符串
+ (NSString*)dictionaryToJsonString:(NSDictionary *)dic;

//去掉tableview的空白处横线
+ (void)setExtraCellLineHidde:(UITableView *)tableView tabHeader:(BOOL) header tabFooter:(BOOL) footer;

//判断不能输入特殊字符
+(int) XZInputText:(NSString *) stringText;

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

//单个文件的大小
+ (long long)fileSizeAtPath:(NSString*)filePath;

//遍历文件夹获得文件夹大小
+ (float ) folderSizeAtPath:(NSString*) folderPath;

//md5加密
+(NSString *) md5: (NSString *) inPutText;


//是否购票成功
//-1未成功 1成功
+(void) setBuyTicketsStatus:(NSInteger) buyTicketsStatus;
+ (NSInteger) buyTicketsStatus;


//是否购票成功
//-1未成功 1成功
+(void) setBuyTicketsStatusWithCoupon:(NSInteger) buyTicketsStatus;
+ (NSInteger) buyTicketsStatusWithCoupon;



+(void) setIsShowLeftBtnsCoupon:(NSInteger) buyTicketsStatus;
+ (NSInteger) isShowLeftBtnsCoupon;


+(void) setIsShowLeftBtnsVouvhers:(NSInteger) buyTicketsStatus;
+ (NSInteger) isShowLeftBtnsVouvhers;
/**
 *  获取客服电话号码
 */
//+(NSString *)getKefuNumber;

@end
