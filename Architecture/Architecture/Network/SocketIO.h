//
//  SocketIO.h
//  Architecture
//
//  Created by xiaofeng on 16/8/24.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRWebSocket.h"
//#import "OtherChatMessageModel.h"

typedef enum {
    Client  = 0,   //0客户
    Manage  = 1,   //1管理用户
    Teacher = 2,   //2老师
}Role_Type;//角色id (0客户，1管理用户，2老师)

typedef enum {
    Init   = 0,   //初始化链接
    Msg    = 1,   //正常聊天消息
    Notice = 2,   //通知，用于群组消息—用户入群，退群等
}Kind_Type;//消息类别（目前只定义了三种类型： init(初始化链接)， msg(正常聊天消息)， notice(通知，用于群组消息—用户入群，退群等)）

typedef enum {
    Receive_Person  = 1,
    Receive_Group   = 2,
}Receive_Type;//消息接受对象类型（1个人消息， 2群组消息）

typedef enum {
    Unaudited  = 0,
    Audit      = 1,
}Isreview_Type;//是否已审核（0未审，1已审核），目前客户端默认都传0

#define SocketIO_Singleton  [SocketIO sharedSocket]

typedef void (^ConnectSuccess) (void);

/**
 *   3.1	[xs001]登陆
 *   3.2	[xs002]短信
 *   3.3	[xs003]当前区域设备
 *   3.4	[xs004]设备告警信息
 *   3.5	[xs005] 巡检完成度(当、周、月)
 *   3.6	[xs006]查看巡检计划
 *   3.7	[xs007]上传巡检
 *   3.8	[xs008]查看巡检记录
 *   3.9	[xs009]告警历史记录
 *   3.10	[xs010]故障设备复归
 *   3.11	[xs011]设备检修记录
 *   3.12	[xs012]设备列表
 *   3.13	[xs013]监控设备列表
 *   3.14	[xs014]故障设备复归确认或申请
 *   3.15	[xs015]告警设备复归或维修
 *   3.16	[xs016]数据图
 */

typedef void (^Xr001CallBackResult) (NSDictionary *);
typedef void (^Xr002CallBackResult) (NSDictionary *);
typedef void (^Xr003CallBackResult) (NSDictionary *);
typedef void (^Xr004CallBackResult) (NSDictionary *);
typedef void (^Xr005CallBackResult) (NSDictionary *);
typedef void (^Xr006CallBackResult) (NSDictionary *);
typedef void (^Xr007CallBackResult) (NSDictionary *);
typedef void (^Xr008CallBackResult) (NSDictionary *);
typedef void (^Xr009CallBackResult) (NSDictionary *);
typedef void (^Xr010CallBackResult) (NSDictionary *);
typedef void (^Xr011CallBackResult) (NSDictionary *);
typedef void (^Xr012CallBackResult) (NSDictionary *);
typedef void (^Xr013CallBackResult) (NSDictionary *);
typedef void (^Xr014CallBackResult) (NSDictionary *);
typedef void (^Xr015CallBackResult) (NSDictionary *);
typedef void (^Xr016CallBackResult) (NSDictionary *);


@interface SocketIO : NSObject<SRWebSocketDelegate>
@property (nonatomic, copy)NSString *initializeStr;

@property (nonatomic, copy)NSString *receiveID;

@property (nonatomic, copy)NSString *videocode;
@property (nonatomic, copy)NSString *toUid;

@property (nonatomic, copy) ConnectSuccess connectSuccess;

@property (nonatomic, assign) BOOL isConnectSuccess;


@property (nonatomic, copy) Xr001CallBackResult xr001CallBackResult;
@property (nonatomic, copy) Xr002CallBackResult xr002CallBackResult;
@property (nonatomic, copy) Xr003CallBackResult xr003CallBackResult;
@property (nonatomic, copy) Xr004CallBackResult xr004CallBackResult;
@property (nonatomic, copy) Xr005CallBackResult xr005CallBackResult;
@property (nonatomic, copy) Xr006CallBackResult xr006CallBackResult;
@property (nonatomic, copy) Xr007CallBackResult xr007CallBackResult;
@property (nonatomic, copy) Xr008CallBackResult xr008CallBackResult;
@property (nonatomic, copy) Xr009CallBackResult xr009CallBackResult;
@property (nonatomic, copy) Xr010CallBackResult xr010CallBackResult;
@property (nonatomic, copy) Xr011CallBackResult xr011CallBackResult;
@property (nonatomic, copy) Xr012CallBackResult xr012CallBackResult;
@property (nonatomic, copy) Xr013CallBackResult xr013CallBackResult;
@property (nonatomic, copy) Xr014CallBackResult xr014CallBackResult;
@property (nonatomic, copy) Xr015CallBackResult xr015CallBackResult;
@property (nonatomic, copy) Xr016CallBackResult xr016CallBackResult;


//@property (nonatomic, strong) ChatMessageModel *chatMessageModel;
//
//@property (nonatomic, strong) OtherChatMessageModel *otherChatMessageModel;

@property (nonatomic, assign) BOOL isShutup;


@property (nonatomic,strong)SocketIOClient *client;

//单例对象
+(SocketIO*) sharedSocket;

/**
 *  连接成功发送初始化消息
 *
 *  @param initMessage 初始化消息
 */
//- (void)sendInitMessageWithGid:(NSString *)gid ReceiveType:(Receive_Type)receive_Type;
- (void)sendEmit:(NSString *)emit withMessage:(NSString *)message;

//- (void)sendMessage:(ChatMessageModel *)messageModel;
//- (void)quitMessage:(ChatMessageModel *)messageModel;

- (void)sendMessage;
- (void)quitMessage;


- (void)open;
- (void)close;
@end
