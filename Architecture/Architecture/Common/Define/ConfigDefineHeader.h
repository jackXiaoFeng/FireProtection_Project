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

#define DEF_IPAddress        @"http://apptest.tv183.net/Api" //正式环境
#define ACT_URL      @"http://piao.huo.com/appwap/activity/index?agent=ios" //正式环境 活动页面地址



 //**********************第三方*************************
//JPush 极光推送
#define APPKEY_JPush      @"e59ef0a17b43c6b890127537"
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



#pragma mark - connect

/**
 *  获取最新版本
 */
#define DEF_API_version               @"/Customer/version"

/**
 *  在线直播接口
 */
#define DEF_API_liveVideo              @"/Live/liveVideo"


/**
 *  登陆
 */
#define DEF_API_loginIn                @"/Login/loginIn"

/**
 *  获取验证码
 */
#define DEF_API_phoneVerify            @"/Register/phoneVerify"

/**
 *  注册
 */
#define DEF_API_register               @"/Register/register"

/**
 *  验证验证码是否正确
 */
#define DEF_API_checkVerify            @"/Customer/checkVerify"

/**
 *  忘记密码->重置密码
 */
#define DEF_API_getBackPass            @"/Customer/getBackPass"

/**
 *  重置密码
 */
#define DEF_API_modefyPass             @"/Customer/modefyPass"

/**
 *  用户反馈信息
 */
#define DEF_API_feedback               @"/Customer/feedback"

/**
 *  更新头像
 */
#define DEF_API_modefyHeadUrl          @"/Customer/modefyHeadUrl"

/**
 *  更新用户名
 */
#define DEF_API_modefyNickname         @"/Customer/modefyNickname"

/**
 *  获取用户信息
 */
#define DEF_API_getUserInfo            @"/Customer/getUserInfo"


/**
 *  我参与的群组
 */
#define DEF_API_groupEntry             @"/Group/groupEntry"

/**
 * 退出群组
 */
#define DEF_API_groupQuit              @"/Group/groupQuit"

/**
 *  群组
 */
#define DEF_API_myGroup                @"/Group/myGroup"

/**
 *  登录 历史聊天记录接口
 */
#define DEF_API_history                @"/Message/history"

/**
 *  未登录 历史聊天记录接口
 */
#define DEF_API_hallHistory             @"/Message/hallHistory"





/**
 *  获取直播室信息
 */
#define DEF_API_getRoompath                 @"/api/getRoompath"

/**
 *  插入聊天信息
 */
#define DEF_API_chating                     @"/app/chating"






/**
 *  获取sessionid3
 */
#define DEF_API_CONNECT           @"connect"

#pragma mark - LoginAndRegister

/**
 *  验证手机号码是否已经注册过（重置密码和设置支付密码时用，修改用户手机号码时不用）
 */
#define DEF_API_CHECKPHONE              @"checkPhone"


/**
 *  验证验证码是否正确
 */
#define DEF_API_CHECKCAPTCHA            @"checkCaptcha"

/**
 *  重置密码
 */
#define DEF_API_RESETPASSWORD           @"resetPassword"

/**
 *  重置手机号码
 */
#define DEF_API_RESETPHONE              @"resetPhone"



/**
 *  支付密码
 */
#define DEF_API_PAYPASSWORD             @"payPassword"

/**
 *  修改用户信息
 */
#define DEF_API_SETUSERINFO             @"setUserInfo"

/**
 *  用户反馈信息
 */
#define DEF_API_FEEDBACK                @"feedback"

/**
 *  app版本信息
 */
#define DEF_API_VERSION                 @"version"



/**
 *  第三方登录
 */
#define DEF_API_USERTHIRDLOGIN          @"userthirdlogin"

/**
 *  退出登录
 */
#define DEF_API_LOGOUT                  @"logout"


/**
 *  自动登录
 */
#define DEF_API_RELOGIN                 @"relogin"

/**
 *  获取用户信息
 */
#define DEF_API_USERINFO                @"userinfo"

/**********************Tim  修改***********************/
#pragma mark - 我的
/**
 *  获取消息
 */
#define DEF_API_MYMESSAGE                @"myMessage"

/**
 *  获取我的订单
 */
#define DEF_API_ORDER                    @"order"

/**
 *  取消订单
 */
#define DEF_API_ORDERUNDO                @"orderUndo"



/**
 *  获取用户的卡券
 */
#define DEF_API_MYCOUPON                 @"myCoupon"

/**
 *  获取用户未领取的卡券
 */
#define DEF_API_GETCANGETCOUPON          @"getCanGetCoupon"

/**
 *  绑定卡券
 */
#define DEF_API_BINGINGCOUPON            @"bindingCoupon"

/**
 *  通过优惠卷组编号领取优惠卷并绑定到个人
 */
#define DEF_API_USERBINDCOUPON           @"userBindCoupon"

/**
 *  获取预购票
 */
#define DEF_API_ORDERPERVIOUS            @"orderPrevious"


/**
 *  获取我参加的活动
 */
#define DEF_API_MYACTIVITY               @"myActivity"

/**
 *  我关注的电影
 */
#define DEF_API_ATTENTION                @"attention"

/**
 *  取消电影关注
 */
#define DEF_API_CANCELATTENTION          @"cancelAttention"

/**
 *  取消电影院的收藏
 */
#define DEF_API_CANCELFAVORITE           @"cancelFavorite"


/**
 *  我收藏的影院
 */
#define DEF_API_FAVORITE                 @"favorite"



#pragma mark - Home

/**
 *  首页正在上映
 */
#define DEF_API_HOME_SHOW                  @"showing"

/**
 *  首页收藏或附近
 */
#define DEF_API_HOME_FAVORITE              @"favoriteHome"

/**
 *  首页即将上映
 */
#define DEF_API_HOME_TOSHOW                @"toShow"
/**
 *  首页精彩活动
 */
#define DEF_API_HOME_BANNER                @"bannerIndex"

#define DEF_API_HOME_HOTNEWS               @"cinecism"

#define DEF_API_HOME_PROMOTION             @"promotion"

/**
 *  首页接口
 */
#define DEF_API_HOME                       @"homePage"

/**
 *预告
 */
#define DEF_API_FIND_ANNOUNCE    @"announce"

/**
 *关注影片
 */
#define DEF_API_FIND_ATTENTIONFILM @"attentionFilm"

/**
 *取消关注
 */
#define DEF_API_FIND_CANCELATTENTION @"cancelAttention"

/**
 * 影片资讯
 */
#define DEF_API_FIND_NEWS @"news"

/**
 * 资讯详情
 */
#define DEF_API_FIND_NEWSDETAIL @"newsDetail"

/**
 * 影片影评
 */
#define DEF_API_FIND_CINECISM @"cinecism"

/**
 * 发现界面H5接口
 */
#define DEF_API_FIND_h5Url @"h5Url"

/**
 * 演员详情
 */
#define DEF_API_ACTOR @"actor"

/**
 * 演员影片
 */
#define DEF_API_ACTORFILM @"actorFilm"

/**
 *评论列表
 */
#define DEF_API_FIND_COMMENT @"comment"

/**
 *我的评论列表
 */
#define DEF_API_FIND_MYCOMMENT @"myComment"

/**
 *我的评论列表
 */
#define DEF_API_MYCOMMENT @"myComment"


/**
 *我的最新评论
 */
#define DEF_API_MYLASTCOMMENT @"myLastComment"

/**
 *提交评论
 */
#define DEF_API_FIND_COMMENTCOMMON @"commentCommon"

/**
 * 用户顶
 */
#define DEF_API_FIND_UPDOWN @"upDown"


/**
 * 用户取消顶
 */
#define DEF_API_FIND_CANCELUPDOWN @"cancelUpDown"



#pragma mark - CINAMA

/**
 *  城市选择
 */
#define DEF_API_REGION @"regionIOS"

/**
 *  地铁查询
 */
#define DEF_API_TRAIN @"train"

/**
 *  商圈查询
 */
#define DEF_API_SHOPAREA @"shopArea"

/**
 *  地区查询
 */
#define DEF_API_DISTRICT @"district"

/**
 *  影院搜索
 */
#define DEF_API_CINEMASEARCH @"cinemaSearch"

/**
 *  影院详情
 */
#define DEF_API_CINEMADETAIL @"cinemaDetail"

/**
 *  收藏影院
 */
#define DEF_API_FAVORITECINEMA @"favoriteCinema"

/**
 *  取消收藏影院
 */
#define DEF_API_CANCELFAVORITE @"cancelFavorite"
/**
 

 *  影院影片
 */
#define DEF_API_CINEMAFILM @"cinemaFilm"
/**
 *  影院排期
 */
#define DEF_API_CINEMASCHEDULE @"filmCinemaSchedule"//@"cinemaSchedule"

/**
 *  快速购票
 */
#define DEF_API_FASTTICKET @"fastTicket"
/**
 *  快速购票影片列表
 */
#define DEF_API_FASTTICKETFILM @"fastTicketFilm"
/**
 *  快速购票排期
 */
#define DEF_API_FASTTICKETSCHEDULE @"fastTicketSchedule"

/**
 *  影院座位接口
 */
#define DEF_API_SEATSCHEDULE @"orderSeat"
/**
 *  订单提交接口
 */
#define DEF_API_ORDERADD @"orderAdd"
/**
 *  订单支付接口
 */
#define DEF_API_ORDERPAY @"orderPay"
/**
 *  活动列表接口
 */
#define DEF_API_GETUSABLEACTIVITYS @"getUsableActivitys"
/**
 *  卡券列表接口
 */
#define DEF_API_GETCOUPONLIST @"getCouponList"
/**
 *  支付信息接口
 */
#define DEF_API_GETPAYINFO @"getPayInfo"
/**
 *  根据订单code获取详情接口
 */
#define DEF_API_ORDERDETAILBYCODE @"orderDetailByCode"
/**
 *  重发取票码接口
 */
#define DEF_API_RESENDTICKETCODE @"resendTicketcode"
/**
 *  影片搜索
 */
#define DEF_API_FILMSEARCH @"filmSearch"
/**
 *  影片关键字搜索
 */
#define DEF_API_FILMSEARCH_NEW @"filmSearch_new"
/**
 *  影片详情
 */
#define DEF_API_FILMDETAIL @"filmDetail"

/**
 *  分享
 */
#define DEF_API_SHARE @"share"

/**
 *  影片演员
 */
#define DEF_API_FILMACTOR @"filmActor"

/**
 *  影片详情  评分
 */
#define DEF_API_SCOREFILM @"scoreFilm"

/**
 *  影片评分
 */
#define DEF_API_SCORECINEMA @"scoreCinema"

/**
 *  影片搜索影院
 */
#define DEF_API_FILMCINEMA @"filmCinemaByConditions"//@"filmCinemaTrain"//

/**
 *  分享接口 获取分享信息
 */
#define DEF_API_SHARE @"share"

/**
 *   新增优惠劵根据code
 */
#define DEF_API_BINDINGORDER @"bindingCouponByOrder"


/**
 *   活动购票列表
 */
#define DEF_API_ACTIVITYSCHEDULE @"activitySchedule"

/**
 *   活动首页列表
 */
#define DEF_API_ACTIVITYLIST @"activityList"

/**
 *   活动是否上线
 */
#define DEF_API_VERSIONISOPEN @"versionIsOpen"

/**
 *   活动详情
 */
#define DEF_API_ACTIVITYDETAIL @"activityDetail"

/**
 *   当前用户是否可以参加该活动
 */
#define DEF_API_ISJOINACTIVITY @"isJoinActivity"

#endif
