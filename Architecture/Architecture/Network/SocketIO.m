//
//  SocketIO.m
//  Architecture
//
//  Created by xiaofeng on 16/8/24.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//


//oc版socketio https://github.com/pkyeck/socket.IO-objc
//
#import "SocketIO.h"

@interface SocketIO()
@property (nonatomic, strong)SRWebSocket *webSocket;

@end
@implementation SocketIO



+ (SocketIO *) sharedSocket {
    static SocketIO* socket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socket = [SocketIO new];
        [socket connectSocket];
    });
    
    return socket;
}

-(id) init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)connectSocket
{
    if (_webSocket ==nil) {
        
        //监听事件回调
        [self onCallback];
        
        [self.client connect];
    }

}

- (void)onCallback
{
    /*
     http://cnodejs.org/topic/53911fd9c3ee0b5820f0b9ef
    客户端事件：
    
    connect：连接成功
    connecting：正在连接
    disconnect：断开连接
    connect_failed：连接失败
    error：错误发生，并且无法被其他事件类型所处理
    message：同服务器端message事件
    anything：同服务器端anything事件
    reconnect_failed：重连失败
    reconnect：成功重连
    reconnecting：正在重连
    在这里要提下客户端socket发起连接时的顺序。当第一次连接时，事件触发顺序为：connecting->connect；当失去连接时，事件触发顺序为：disconnect->reconnecting（可能进行多次）->connecting->reconnect->connect。
    */
    @weakify(self);
    [self.client on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        @strongify(self)
        self.isConnectSuccess = YES;
        self.connectSuccess();
        NSLog(@"*************\n\n连接成功 iOS客户端上线\n\n*************");
    }];
    
    [self.client on:@"connecting" callback:^(NSArray* data, SocketAckEmitter* ack) {
        @strongify(self)
        NSLog(@"*************\n\n正在连接\n\n*************");
    }];
    

    [self.client on:@"disconnect" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\n断开连接 iOS客户端下线\n\n*************%@",event?event[0]:@"");
        self.isConnectSuccess = NO;
    }];
    
    [self.client on:@"connect_failed" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\n连接失败 %@\n\n*************",event?event[0]:@"");
        self.isConnectSuccess = NO;
    }];
    
    
    [self.client on:@"error" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\nerror：%@\n\n*************",event?event[0]:@"");
        [CMUtility showTips:@"网络出错！"];
        self.isConnectSuccess = NO;
    }];
    
    /*
    [self.client on:@"message" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        NSLog(@"*************\n\n同服务器端message事件\n\n*************%@",event?event[0]:@"");
    }];
    
    [self.client on:@"anything" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        NSLog(@"*************\n\n同服务器端anything事件\n\n*************%@",event?event[0]:@"");
    }];
    */
    
    [self.client on:@"disconnect" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\n断开连接 iOS客户端下线\n\n*************%@",event?event[0]:@"");
    }];
    
    [self.client on:@"reconnect_failed" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\n重连失败 %@\n\n*************",event?event[0]:@"");
    }];
    
    [self.client on:@"reconnect" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\n成功重连 %@\n\n*************",event?event[0]:@"");
    }];
    
    [self.client on:@"reconnecting" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\n正在重连 %@\n\n*************",event?event[0]:@"");
    }];
    
    
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

    //[xs001]登陆
    [self.client on:XR001 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\nXR001\n\n*************%@",event?event[0]:@"");
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr001CallBackResult(dic);
        }else
        {
            self.xr001CallBackResult(@{@"errormsg":@"登录失败"});
        }
    }];
    
    //[xs002]短信
    [self.client on:XR002 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\nXR002\n\n*************%@",event?event[0]:@"");

        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr002CallBackResult(dic);
        }else
        {
            self.xr002CallBackResult(@{@"errormsg":@"获取短信验证码失败"});
        }
    }];
    
//    *   3.3	[xs003]当前区域设备
    [self.client on:XR003 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\nXR003\n\n*************%@",event?event[0]:@"");

        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr003CallBackResult(dic);
        }else
        {
            self.xr003CallBackResult(@{@"errormsg":@"获取当前区域设备失败"});
        }
    }];
//    *   3.4	[xs004]设备告警信息
    [self.client on:XR004 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        NSLog(@"*************\n\nXR004\n\n*************%@",event?event[0]:@"");

        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr004CallBackResult(dic);
        }else
        {
            self.xr004CallBackResult(@{@"errormsg":@"获取设备告警信息失败"});
        }
    }];
//    *   3.5	[xs005] 巡检完成度(当、周、月)
    [self.client on:XR005 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr005CallBackResult(dic);
        }else
        {
            self.xr005CallBackResult(@{@"errormsg":@"获取巡检完成度失败"});
        }
    }];
//    *   3.6	[xs006]查看巡检计划
    [self.client on:XR006 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr006CallBackResult(dic);
        }else
        {
            self.xr006CallBackResult(@{@"errormsg":@"获取巡检计划失败"});
        }
    }];
//    *   3.7	[xs007]上传巡检
    [self.client on:XR007 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr007CallBackResult(dic);
        }else
        {
            self.xr007CallBackResult(@{@"errormsg":@"上传巡检失败"});
        }
    }];
//    *   3.8	[xs008]查看巡检记录
    [self.client on:XR008 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr008CallBackResult(dic);
        }else
        {
            self.xr008CallBackResult(@{@"errormsg":@"获取巡检记录失败"});
        }
    }];
//    *   3.9	[xs009]告警历史记录
    [self.client on:XR009 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr009CallBackResult(dic);
        }else
        {
            self.xr009CallBackResult(@{@"errormsg":@"获取告警历史记录失败"});
        }
    }];
//    *   3.10	[xs010]故障设备复归
    [self.client on:XR010 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr010CallBackResult(dic);
        }else
        {
            self.xr010CallBackResult(@{@"errormsg":@"故障设备复归失败"});
        }
    }];
//    *   3.11	[xs011]设备检修记录
    [self.client on:XR011 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr011CallBackResult(dic);
        }else
        {
            self.xr011CallBackResult(@{@"errormsg":@"故障设备复归失败"});
        }
    }];
//    *   3.12	[xs012]设备列表
    [self.client on:XR012 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr012CallBackResult(dic);
        }else
        {
            self.xr012CallBackResult(@{@"errormsg":@"获取设备列表失败"});
        }
    }];
//    *   3.13	[xs013]监控设备列表
    [self.client on:XR013 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr013CallBackResult(dic);
        }else
        {
            self.xr013CallBackResult(@{@"errormsg":@"获取监控设备列表失败"});
        }
    }];
//    *   3.14	[xs014]故障设备复归确认或申请
    [self.client on:XR014 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr014CallBackResult(dic);
        }else
        {
            self.xr014CallBackResult(@{@"errormsg":@"故障设备复归确认失败"});
        }
    }];
//    *   3.15	[xs015]告警设备复归或维修
    [self.client on:XR015 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr015CallBackResult(dic);
        }else
        {
            self.xr015CallBackResult(@{@"errormsg":@"告警设备复归失败"});
        }
    }];
//    *   3.16	[xs016]数据图
    [self.client on:XR016 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        @strongify(self)
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr016CallBackResult(dic);
        }else
        {
            self.xr016CallBackResult(@{@"errormsg":@"获取数据图失败"});
        }
    }];
 }

- (SocketIOClient *)client{
    if (!_client) {
        NSURL* url = [[NSURL alloc] initWithString:SOCKETIO_ADDRESS];
        
        _client = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @NO}];
    }
    return _client;
}

#pragma mark - webSocket -

- (void)sendEmit:(NSString *)emit withMessage:(NSString *)message
{
    [self.client emit:emit with:@[message]];
    //[self.client emit:@"xs001" with:@[@"{\"code\":\"xs001\",\"serial_no\":\"\",\"token\":\"2hACkIzVnNqCjEciwCaZ2flveBGv\",\"errorcode\":\"0\",\"errormsg\":\"success\",\"dat\":[{\"Oper_flag\":\"1\",\"Username\":\"123456\",\"Vcode\":\"123456\",\"Areas_sn\":\"12345\"}]}"]];
}

/*
- (void)sendMessage:(ChatMessageModel *)messageModel;
{
//    //监听网络
//    [[RACObserve(CMUtilityNetwork, status) distinctUntilChanged]subscribeNext:^(id status){
//        int status1 = [status intValue];
//        if (status1 == 0) {
//            [CMUtility showTips:@"亲，没网啦！"];
//            
//        }else if (status1 == 1)
//        {
//            [self connectSocket];
//        }else if (status1 == 2)
//        {
//            [self connectSocket];
//        }
//    }];

    self.chatMessageModel = messageModel;
//    NSDictionary *defDic = @{@"width":@"0",
//                             @"height":@"0"};
    
    NSDictionary *dic = @{
                          @"rMsgType"   : messageModel.rMsgType,
                          @"fromUid"    : messageModel.fromUid,
                          @"fromUname"  : messageModel.fromUname,
                          @"role"       : messageModel.role,
                          @"identity"   : messageModel.identity,
                          @"headurl"    : messageModel.headurl,
                          @"kind"       : messageModel.kind,
                          @"toUid"      : messageModel.toUid,
                          @"toType"     : messageModel.toType,
                          @"content"    : messageModel.content,
                          @"time"       : messageModel.time,
                          @"isreview"   : messageModel.isreview,
                          
                          @"contentType": [NSString stringWithFormat:@"%@",messageModel.contentType],
                          @"filesize"   : @"0",
                          @"fileattr"   : @"",
                          };
    NSString *strJson = [self DataTOjsonString:dic];
    BOOL sendState =[self.webSocket sendString:strJson error:nil];
    if (!sendState) {
        Receive_Type reType =[messageModel.toType isEqualToString:@"2"]?Receive_Group:Receive_Person;
        [self sendInitMessageWithGid:messageModel.toUid ReceiveType:reType];
        [self.webSocket sendString:strJson error:nil];
    }
}
 */
- (void)sendMessage
{
    //    //监听网络
    //    [[RACObserve(CMUtilityNetwork, status) distinctUntilChanged]subscribeNext:^(id status){
    //        int status1 = [status intValue];
    //        if (status1 == 0) {
    //            [CMUtility showTips:@"亲，没网啦！"];
    //
    //        }else if (status1 == 1)
    //        {
    //            [self connectSocket];
    //        }else if (status1 == 2)
    //        {
    //            [self connectSocket];
    //        }
    //    }];
    
    //    NSDictionary *defDic = @{@"width":@"0",
    //                             @"height":@"0"};
    
    NSDictionary *dic = @{@"filesize"   : @"0",
                          @"fileattr"   : @"1"
                          };
    NSString *strJson = [self DataTOjsonString:dic];
    BOOL sendState =[self.webSocket sendString:strJson error:nil];
    if (!sendState) {
//        Receive_Type reType =[messageModel.toType isEqualToString:@"2"]?Receive_Group:Receive_Person;
        //[self sendInitMessage];
        [self.webSocket sendString:strJson error:nil];
    }
}

/*
- (void)quitMessage:(ChatMessageModel *)messageModel
{
    NSDictionary *dic = @{
                          @"rMsgType"   : messageModel.rMsgType,
                          @"fromUid"    : messageModel.fromUid,
                          @"fromUname"  : messageModel.fromUname,
                          @"role"       : messageModel.role,
                          @"identity"   : messageModel.identity,
                          @"headurl"    : messageModel.headurl,
                          @"kind"       : messageModel.kind,
                          @"toUid"      : messageModel.toUid,
                          @"toType"     : messageModel.toType,
                          @"content"    : messageModel.content,
                          @"time"       : messageModel.time,
                          @"isreview"   : messageModel.isreview,
                          };
    NSString *strJson = [self DataTOjsonString:dic];
    [self.webSocket sendString:strJson error:nil];
}
 */
- (void)quitMessage
{
    NSDictionary *dic = @{@"rMsgType"   : @"22"};
    NSString *strJson = [self DataTOjsonString:dic];
    [self.webSocket sendString:strJson error:nil];
}


- (void)open
{
    [self.webSocket open];
}

- (void)close
{
    [self.webSocket close];
}
#pragma SRWebSocketDelegate

//连接成功

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@":( Websocket 连接成功");
    if (self.connectSuccess) {
        self.connectSuccess();
    }
    
    /*
    BOOL connect = [webSocket sendString:@"" error:nil];
    if (!connect) {
        [self connectSocket];
    }
    */
}

//连接失败

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket 连接失败 Error %@=====", error);

    //NSLog(@":( Websocket 连接失败 Error %@=====%ld", error,(long)CMUtilityNetwork.status);
    
    //有网络状态下重新连接
//    if (CMUtilityNetwork.status != 0) {
        _webSocket = nil;
        [self connectSocket];
//    }
    
}

//接收到新消息的处理

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"Received接收到原始消息 \n%@", message);

    NSData* jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultDict = [jsonData objectFromJSONData];
    NSLog(@"Received接收到解析消息 \n%@", resultDict);

    NSString *rMsgType = DEF_OBJECT_TO_STIRNG(resultDict[@"rMsgType"]);
    
}

//连接关闭

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;

{
    NSLog(@"WebSocket closed----code=%ld===reason=%@===wasClean%d",(long)code,reason,wasClean);
    
    //self.title = @"Connection Closed! (see logs)";
    
    _webSocket = nil;
    
    [self connectSocket];
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
