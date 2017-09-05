//
//  SocketIO.m
//  Architecture
//
//  Created by xiaofeng on 16/8/24.
//  Copyright © 2016年 xiaofeng. All rights reserved.
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
    [self.client on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"*************\n\niOS客户端上线\n\n*************");
        // [self.client emit:@"login" with:@[@"30342"]];
        self.connectSuccess();
        
    }];
    
    //登录
    [self.client on:XR001 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        NSLog(@"*************\n\nXR001\n\n*************%@",event?event[0]:@"");
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr001CallBackResult(dic);
        }else
        {
            //self.xr001CallBackResult(@"登录失败");
        }
    }];
    
    //获取短信验证码
    [self.client on:XR002 callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        if (event[0]) {
            NSDictionary *dic = event[0];
            self.xr002CallBackResult(dic);
        }else
        {
            //self.xr001CallBackResult(@"获取短信验证码失败");
        }
    }];
    
    [self.client on:@"chat message" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        if (event[0] && ![event[0] isEqualToString:@""]) {
        }
    }];
    [self.client on:@"privateMessage" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        if (event[0] && ![event[0] isEqualToString:@""]) {
        }
    }];
    [self.client on:@"disconnect" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        NSLog(@"*************\n\niOS客户端下线\n\n*************%@",event?event[0]:@"");
    }];
    [self.client on:@"error" callback:^(NSArray * _Nonnull event, SocketAckEmitter * _Nonnull ack) {
        NSLog(@"*************\n\n%@\n\n*************",event?event[0]:@"");
    }];
}

- (SocketIOClient *)client{
    if (!_client) {
        NSURL* url = [[NSURL alloc] initWithString:SOCKETIO_ADDRESS];
        
        _client = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @YES}];
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
