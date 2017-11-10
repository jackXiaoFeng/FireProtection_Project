//
//  LoginModel.m
//  Architecture
//
//  Created by xiaofeng on 17/9/4.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

/**
 * 获取验证码,接口
 */
- (void)fetchVericode:(NSString *)phoneNum withCompleteBlock:(CompleteBlock)complete;
{
    
    if (!SocketIO_Singleton.isConnectSuccess) {
        BLOCK_SAFE(complete)(@"服务器连接失败");
        return;
    }else
    {
        NSDictionary *datDic = @{
                                 @"Oper_flag":@1,
                                 @"Username":phoneNum,
                                 @"Sms_template":@1,
                                 };
        NSArray *arr = [NSArray arrayWithObjects:datDic, nil];
        NSDictionary *tempDic = @{
                                  @"code":XS002,
                                  @"serial_no":[NSString stringWithFormat:@"%@%@",[CMUtility currentTimestamp],XS002_serial_no],
                                  @"errorcode":@"0",
                                  @"errormsg":@"success",
                                  @"dat":arr                              };
        
        
        //@"{\"code\":\"xs001\",\"serial_no\":\"\",\"token\":\"2hACkIzVnNqCjEciwCaZ2flveBGv\",\"errorcode\":\"0\",\"errormsg\":\"success\",\"dat\":[{\"Oper_flag\":\"1\",\"Username\":\"123456\",\"Vcode\":\"123456\",\"Areas_sn\":\"12345\"}]}"
        
        NSString *jsonStr = [tempDic JSONString];
        @weakify(self)
        [SocketIO_Singleton sendEmit:XS002 withMessage:jsonStr];
        SocketIO_Singleton.xr002CallBackResult = ^(NSDictionary *resultDict){
            @strongify(self)
            NSString *errorcode = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errorcode"]);
            NSString *errormsg = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errormsg"]);
            NSLog(@"errorcode is :%@",errorcode);
            NSLog(@"errormsg is :%@",errormsg);
            
            //fixpangu: 暂定200 测试
            if ([errorcode isEqualToString:SUCCESS_CODE]) {
                
                NSArray *list = [resultDict objectForKey:@"datas"];
                NSDictionary *dic = list[0];
                BLOCK_SAFE(complete)([dic objectForKey:@"Sms_template"]);
            }else
            {
                 BLOCK_SAFE(complete)(FailToCheckNum);
            }
        };
        
        /*
        [{
            code = xs002;
            datas =     (
                         {
                             "Sms_template" = 12345;
                         }
                         );
            errorcode = 200;
            errormsg = "\U9a8c\U8bc1\U7801\U9519\U8bef";
            "serial_no" = 150468062637100002;
            token = undefined;
        }]
         */
    }
}

/**
 * 登录接口
 */
- (void)loginWithPhoneNum:(NSString *)phoneNum
                 tfVericode:(NSString *)tfVericode
                 Vericode:(NSString *)vericode
          isAgreeProtocol:(BOOL)isAgreeProtocol
                 complete:(CompleteBlock)complete
                     fail:(FailBlock)fail
{
    if (!SocketIO_Singleton.isConnectSuccess) {
        BLOCK_SAFE(complete)(@"服务器连接失败");
        return;
    }else if (phoneNum.length == 0) {
        BLOCK_SAFE(complete)(@"请输入手机号码");
        return;
    }else if(![CMUtility validateMobile:phoneNum]){
        BLOCK_SAFE(complete)(@"请输入有效的手机号码");
        return;
    }else if (tfVericode.length == 0){
        BLOCK_SAFE(complete)(@"请输入验证码");
        return;
    }
//    else if (![tfVericode isEqualToString:vericode]){
//        BLOCK_SAFE(complete)(@"验证码输入有误");
//        return;
//    }
    else if(!isAgreeProtocol){
        BLOCK_SAFE(complete)(@"请同意相关协议");
        return;
    }else{
        NSDictionary *datDic = @{
                                 @"Oper_flag":@1,
                                 @"Username":phoneNum,
                                 @"Vcode":vericode,
                                 };
        NSArray *arr = [NSArray arrayWithObjects:datDic, nil];
        NSDictionary *tempDic = @{
                                  @"code":XS001,
                                  @"serial_no":[NSString stringWithFormat:@"%@%@",[CMUtility currentTimestamp],XS001_serial_no],
                                  @"errorcode":@"0",
                                  @"errormsg":@"success",
                                  @"dat":arr
                                  };
        
        [SocketIO_Singleton sendEmit:XS001 withMessage:[tempDic JSONString]];
        SocketIO_Singleton.xr001CallBackResult = ^(NSDictionary *resultDict){
            
            NSString *errorcode = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errorcode"]);
            NSString *errormsg = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errormsg"]);
            if ([errorcode isEqualToString:SUCCESS_CODE]) {
                
                NSArray *list = [resultDict objectForKey:@"datas"];
                NSDictionary *dic = list[0];
                if (dic) {
                    CMMemberEntity.userInfo = [MTLJSONAdapter modelOfClass:[CMMemberData class] fromJSONDictionary:dic error:nil];
                    
                    NSLog(@"%@--%@--%@--%@--%@",
                          CMMemberEntity.userInfo.phone,
                          CMMemberEntity.userInfo.unitname,CMMemberEntity.userInfo.token,CMMemberEntity.userInfo.unitsn,CMMemberEntity.userInfo.username);
                    
                    CMMemberEntity.token = CMMemberEntity.userInfo.token;
                    
                    
                    //记录用户
                    [DEF_UserDefaults setObject:CMMemberEntity.userInfo.phone forKey:@"phone"];

                    [DEF_UserDefaults setObject:CMMemberEntity.userInfo.unitname forKey:@"unitname"];
                    [DEF_UserDefaults setObject:CMMemberEntity.userInfo.token forKey:@"token"];
                    [DEF_UserDefaults setObject:CMMemberEntity.userInfo.unitsn forKey:@"unitsn"];
                    [DEF_UserDefaults setObject:CMMemberEntity.userInfo.username forKey:@"username"];
                    [DEF_UserDefaults synchronize];
                    
                    CMMemberEntity.isLogined = YES;
                }
                
                
//                phone = 12345;
//                token = BOGMq9RLKyDDsFEBPEqkc;
//                unitname = "\U6d88\U9632\U5c40";
//                unitsn = 1234;
//                username = 12345;
                BLOCK_SAFE(complete)(@"登录成功");
            }else
            {
                BLOCK_SAFE(complete)(errormsg);
            }
        };

    }
}


/*
{
    code = xs001;
    datas =     (
                 {
                     phone = 12345;
                     token = BOGMq9RLKyDDsFEBPEqkc;
                     unitname = "\U6d88\U9632\U5c40";
                     unitsn = 1234;
                     username = 12345;
                 }
                 );
    errorcode = 0;
    errormsg = success;
    "serial_no" = undefined;
    token = undefined;
}
*/

@end
