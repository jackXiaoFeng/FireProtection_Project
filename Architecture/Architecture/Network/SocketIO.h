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

typedef void (^Xr001CallBackResult) (NSDictionary *);
typedef void (^Xr002CallBackResult) (NSDictionary *);
typedef void (^Xr003CallBackResult) (NSDictionary *);


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
