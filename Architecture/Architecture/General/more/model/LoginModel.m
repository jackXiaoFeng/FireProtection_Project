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
    NSDictionary *datDic = @{
                              @"Oper_flag":@1,
                              @"Username":@"12345",
                              @"Sms_template":@1,
                              };
    NSArray *arr = [NSArray arrayWithObjects:datDic, nil];
    NSDictionary *tempDic = @{
                              @"code":XS002,
                              @"serial_no":@"",
                              @"errorcode":@"0",
                              @"errormsg":@"success",
                              @"dat":arr                              };
 
    
    //@"{\"code\":\"xs001\",\"serial_no\":\"\",\"token\":\"2hACkIzVnNqCjEciwCaZ2flveBGv\",\"errorcode\":\"0\",\"errormsg\":\"success\",\"dat\":[{\"Oper_flag\":\"1\",\"Username\":\"123456\",\"Vcode\":\"123456\",\"Areas_sn\":\"12345\"}]}"
    
    
    NSString *jsonStr = [tempDic JSONString];
    NSLog(@"jsonStr---%@",jsonStr);
    
    @weakify(self)
    [SocketIO_Singleton sendEmit:XS002 withMessage:jsonStr];
    SocketIO_Singleton.xr002CallBackResult = ^(NSDictionary *dic){
        NSLog(@"--------%@",dic);
        //BLOCK_SAFE(complete)(str);
    };
    
//    
//    SocketIO_Singleton.connectSuccess = ^{
//        @strongify(self)
//        [SocketIO_Singleton sendEmit:XS002 withMessage:jsonStr];
//        
//        //@"{\"code\":\"xs001\",\"serial_no\":\"\",\"token\":\"2hACkIzVnNqCjEciwCaZ2flveBGv\",\"errorcode\":\"0\",\"errormsg\":\"success\",\"dat\":[{\"Oper_flag\":\"1\",\"Username\":\"123456\",\"Vcode\":\"123456\",\"Areas_sn\":\"12345\"}]}"
//        
//    };

    
    //获取验证码
    /*
    [RequestOperationManager apiPOSTRequestParametersDic:dic success:^(NSDictionary *result) {
        NSLog(@"%@",result[@"describe"]);
        if ([result[@"status"] isEqualToNumber:STATUSSUCCESS]) {
            [CMUtility showTips:@"验证码已发送"];
            NSLog(@"%@",result[@"data"][@"sessionid"]);
            
            BLOCK_SAFE(complete)(result[@"data"][@"sessionid"]);
        }else{
            [CMUtility showTips:result[@"describe"]];
            BLOCK_SAFE(complete)(FailToCheckNum);
        }
    } failture:^(id result) {
        [CMUtility showTips:FailToGetVericode];
        BLOCK_SAFE(complete)(FailToGetVericode);
    }];
    */
}

/**
 * 登录接口
 */
- (void)loginWithPhoneNum:(NSString *)phoneNum
                 Vericode:(NSString *)vericode
          isAgreeProtocol:(BOOL)isAgreeProtocol
                 complete:(CompleteBlock)complete
                     fail:(FailBlock)fail
{
    
    if (phoneNum.length == 0) {
        BLOCK_SAFE(complete)(@"请输入手机号码");
        return;
    }else if(![CMUtility validateMobile:phoneNum]){
        BLOCK_SAFE(complete)(@"请输入有效的手机号码");
        return;
    }else if (vericode.length == 0){
        BLOCK_SAFE(complete)(@"请输入验证码");
        return;
    }else if(!isAgreeProtocol){
        BLOCK_SAFE(complete)(@"请同意相关协议");
        return;
    }else{
        NSDictionary *datDic = @{
                                 @"Oper_flag":@1,
                                 @"Username":@"12345",
                                 @"Vcode":@"12345",
                                 };
        NSArray *arr = [NSArray arrayWithObjects:datDic, nil];
        NSDictionary *tempDic = @{
                                  @"code":XS001,
                                  @"serial_no":@"",
                                  @"errorcode":@"0",
                                  @"errormsg":@"success",
                                  @"dat":arr
                                  };
        
        //@"{\"code\":\"xs001\",\"serial_no\":\"\",\"token\":\"2hACkIzVnNqCjEciwCaZ2flveBGv\",\"errorcode\":\"0\",\"errormsg\":\"success\",\"dat\":[{\"Oper_flag\":\"1\",\"Username\":\"123456\",\"Vcode\":\"123456\",\"Areas_sn\":\"12345\"}]}"
        
        
        NSString *jsonStr = [tempDic JSONString];
        
        [SocketIO_Singleton sendEmit:XS001 withMessage:jsonStr];
        SocketIO_Singleton.xr001CallBackResult = ^(NSDictionary *resultDict){
                        
            NSLog(@"code is :%@",[resultDict objectForKey:@"code"]);
            NSLog(@"errormsg is :%@",[resultDict objectForKey:@"errormsg"]);

            NSString *errormsg =[resultDict objectForKey:@"errormsg"];
            NSArray *list = [resultDict objectForKey:@"datas"];
            for (NSDictionary *dic in list) {
                NSLog(@"tokentokentoken :%@",[dic objectForKey:@"token"]);
            }
            //NSLog(@"XS001--------%@",str);
            BLOCK_SAFE(complete)(errormsg);
        };

    }
}

/*
{
    code = xs001;
    datas =     (
                 {
                     token = "";
                 }
                 );
    errorcode = 200;
    errormsg = "\U9a8c\U8bc1\U7801\U9519\U8bef";
    "serial_no" = "";
    token = undefined;
}
*/

@end
