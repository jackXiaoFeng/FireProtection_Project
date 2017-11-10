//
//  ConfigDefineHeader.h
//  MoviesStore 2.0
//
//  Created by caimiao on 15/5/21.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#ifndef MoviesStore_2_0_ConfigDefineHeader_h
#define MoviesStore_2_0_ConfigDefineHeader_h

/**
 * 域名地址
 */

//#define DEF_IPAddress      @"http://121.40.82.243:9701/api3/ios" //测试环境
//#define ACT_URL      @"http://121.40.82.243:83/appwap/activity/index?agent=ios" //测试环境 活动页面地址

//#define DEBUG_SOCKETIO

#ifdef  DEBUG_SOCKETIO
#define SOCKETIO_ADDRESS          @"http://192.168.1.123:22223" //socketIO 环境
//行情@"https://yshjhqapi.yishouhuangjin.com/socket.io/socket.io.js" 
#else
//  #define SOCKETIO_ADDRESS        @"http://apit.freshcn.cn:22223" //socketIO 环境
   #define SOCKETIO_ADDRESS        @"http://wwwt.freshera.cn:22223"
#endif


#define DEF_IPAddress        @"http://apptest.tv183.net/Api" //正式环境
#define ACT_URL      @"http://piao.huo.com/appwap/activity/index?agent=ios" //正式环境 活动页面地址


 //**********************第三方*************************
//JPush 极光推送
#define APPKEY_JPush      @"5f15ee535b2c83f9738d20b8"
#define CHANNEL_JPush     @"AppStore"

//ShareSDK appKey
//cm:936a891dd67d
#define APPKEY_SHARE @"c2e5e95cf2d3"

//sina分享
//cm
//appkey:@"1050604843"
//@"ee7b631e19f1ea2bbfc78b8f310ae8c0"
//@"http://sns.whalecloud.com/sina2/callback"
#define APPKEY_SHARE_SINA @"911573264"
#define APPSECRET_SHARE_SINA @"e13daa3ca4af68fe9e7395dda6e7ccff"
#define REDIRECTURL_SHARE_SINA @"http://sns.whalecloud.com/sina2/callback"


//QQ分享
//cm
//@"1104685539"
//@"Z1p84mwfeCDp6jrg"
#define APPKEY_SHARE_QQ @"1104947680"
#define APPSECRET_SHARE_QQ @"W2b3Os0uTbbkIWUK"

//微信分享
//cm
//@"wx52199d81bd8172f3"
//@"dc2fa178dbd6ea2f1e2aefb0cafd053f"
#define APPKEY_SHARE_WX  @"wxf2610a69bd039fd9"
#define APPSECRET_SHARE_WX @"d4624c36b6795d1d99dcf0547af5443d"



/**
 *  百度地图key
 */
//cm:@"WMhzHmAHzOBqCmQAGCtUhDMG"
#define BAIDUMAP_KEY @"KffW4x7fR93KeewQDmjfPfr8"

/**
 *  友盟统计key
 */
//cm:@"561f169967e58e68c30013fb"
#define MOBCLICK_KEY @"563854b167e58e3cbc00023f"



/**
 *  微信支付key
 */
//cm:@"wx52199d81bd8172f3"
#define WEICHATKEY @"wxf2610a69bd039fd9"


//推送
//信鸽推送
#define APPID_PUSH_XG 2200147821
#define APPKEY_PUSH_XG @"IR6VW329U3II"

//极光
#define APPID_PUSH_JG 0000000
#define APPKEY_PUSH_JG @""

//*********************end**************************


//告警状态
//0:正常
//1:异常
#define Warning_Status_Normal      @"0"
#define Warning_Status_Malfunction @"1"

//申请检修状态
//0:正常
//1:故障
//2:等待维修
//3:等待复归
//4:申请复归
#define Warning_Fix_Normal      @"0"
#define Warning_Fix_Malfunction @"1"
#define Warning_Fix_Maintain    @"2"
#define Warning_Fix_Wait        @"3"
#define Warning_Fix_Apply       @"4"

#pragma mark - connect

#define SUCCESS_CODE @"0"
#define SUCCESS_MSG  @"success"


/**
 *   3.1	[xs001]登陆
 *   3.1.1	请求报文体
 */
#define XS001 @"xs001"
#define XS001_serial_no @"00001"

/**
 *   3.1.2	响应报文体
 */
#define XR001 @"xr001"


/**
 *   3.2	[xs002]短信
 ＊  3.2.1	请求报文体
 */
#define XS002 @"xs002"
#define XS002_serial_no @"00002"

/**
 *   3.1.2	响应报文体
 */
#define XR002 @"xr002"


/**
 *   3.3	[xs003]当前区域设备
 ＊  3.3.1
 */
#define XS003 @"xs003"
#define XS003_serial_no @"00003"

/**
 *   3.3.2	响应报文体
 */
#define XR003 @"xr003"


/**
 *   3.4	[xs004]设备告警信息
 ＊  3.4.1
 */
#define XS004 @"xs004"
#define XS004_serial_no @"00004"

/**
 *   3.4.2	响应报文体
 */
#define XR004 @"xr004"


/**
 *   3.5	[xs005] 巡检完成度(当、周、月)
 ＊  3.5.1
 */
#define XS005 @"xs005"
#define XS005_serial_no @"00005"

/**
 *   3.5.2	响应报文体
 */
#define XR005 @"xr005"


/**
 *   3.6	[xs006]查看巡检计划
 ＊  3.6.1
 */
#define XS006 @"xs006"
#define XS006_serial_no @"00006"

/**
 *   3.6.2	响应报文体
 */
#define XR006 @"xr006"


/**
 *   3.7	[xs007]上传巡检
 ＊  3.7.1
 */
#define XS007 @"xs007"
#define XS007_serial_no @"00007"

/**
 *   3.7.2	响应报文体
 */
#define XR007 @"xr007"


/**
 *   3.8	[xs008]查看巡检记录
 ＊  3.8.1
 */
#define XS008 @"xs008"
#define XS008_serial_no @"00008"

/**
 *   3.8.2	响应报文体
 */
#define XR008 @"xr008"


/**
 *   3.9	[xs009]告警历史记录
 ＊  3.9.1
 */
#define XS009 @"xs009"
#define XS009_serial_no @"00009"

/**
 *   3.9.2	响应报文体
 */
#define XR009 @"xr009"


/**
 *   3.10	[xs010]故障设备复归
 ＊  3.10.1
 */
#define XS010 @"xs010"
#define XS010_serial_no @"00010"

/**
 *   3.10.2	响应报文体
 */
#define XR010 @"xr010"


/**
 *   3.11	[xs011]设备检修记录
 
 ＊  3.11.1
 */
#define XS011 @"xs011"
#define XS011_serial_no @"00011"

/**
 *   3.11.2	响应报文体
 */
#define XR011 @"xr011"


/**
 *   3.12	[xs012]设备列表
 
 ＊  3.12.1
 */
#define XS012 @"xs012"
#define XS012_serial_no @"00012"

/**
 *   3.12.2	响应报文体
 */
#define XR012 @"xr012"


/**
 *   3.13	[xs013]监控设备列表
 
 ＊  3.13.1
 */
#define XS013 @"xs013"
#define XS013_serial_no @"00013"

/**
 *   3.13.2	响应报文体
 */
#define XR013 @"xr013"



/**
 *   3.14	[xs014]故障设备复归确认或申请
 
 ＊  3.14.1
 */
#define XS014 @"xs014"
#define XS014_serial_no @"00014"

/**
 *   3.14.2	响应报文体
 */
#define XR014 @"xr014"


/**
 *   3.15	[xs015]告警设备复归或维修
 
 ＊  3.15.1
 */
#define XS015 @"xs015"
#define XS015_serial_no @"00015"

/**
 *   3.15.2	响应报文体
 */
#define XR015 @"xr015"


/**
 *   3.16	[xs016]数据图
 
 ＊  3.16.1
 */
#define XS016 @"xs016"
#define XS016_serial_no @"00016"

/**
 *   3.16.2	响应报文体
 */
#define XR016 @"xr016"


#endif
