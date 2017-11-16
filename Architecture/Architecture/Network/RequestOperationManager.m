 //
//  RequestOperationManager.m
//  MoviesStore 2.0
//
//  Created by caimiao on 15/5/21.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "RequestOperationManager.h"

@interface RequestOperationManager ()

@property (nonatomic, strong)NSMutableDictionary *parametersDic;
@property BOOL isGetConnect;

@property (nonatomic, strong) id resData;

@end

@implementation RequestOperationManager

static RequestOperationManager *operationManager;

+ (RequestOperationManager *)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        operationManager = [[RequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:DEF_IPAddress]];
        operationManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        operationManager.requestSerializer.timeoutInterval = 30;
//        operationManager.Cookie = @"";
//        operationManager.isGetConnect = YES;
    });
    
//    [operationManager.requestSerializer setValue:operationManager.Cookie forHTTPHeaderField:@"Cookie"];
    
    return operationManager;
}

//请求错误处理
+ (void)requestError:(NSError *)error operation:(AFHTTPRequestOperation *)operation failHandle:(failtureBlock)failHandle
{

    if(error.code == kCFURLErrorNotConnectedToInternet)
    {
//        iToast *itoast = [iToast makeText:@"网络不可用，请检查网络连接"];
//        [itoast setGravity:iToastGravityCenter];
//        [itoast show];
        [CMUtility showTips:@"网络不可用，请检查网络连接"];
        
        failHandle(error);
    }else if (error.code == kCFURLErrorTimedOut)
    {
//        iToast *itoast = [iToast makeText:@"网络请求超时"];
//        [itoast setGravity:iToastGravityCenter];
//        [itoast show];
         [CMUtility showTips:@"网络请求超时"];
        
        failHandle(error);
    }else if (error.code == kCFURLErrorCannotConnectToHost)
    {
//        iToast *itoast = [iToast makeText:@"网络不可用，请检查网络连接"];
//        [itoast setGravity:iToastGravityCenter];
//        [itoast show];
        [CMUtility showTips:@"网络不可用，请检查网络连接"];
        
        failHandle(error);
    }else
    {
        [CMUtility showTips:@"请求失败，请检查网络"];

        CC_LOG_VALUE(error);
        
        failHandle(error);
    }
    
    CC_LOG_VALUE(error.localizedDescription);
}

//请求成功处理
+ (void)requestSuccess:(id)responseObject operation:(AFHTTPRequestOperation *)operation
          finishHandle:(successBlock)finishHandle
          failHandle:(failtureBlock)failHandle
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // 解析
       NSData *resData = responseObject;
        NSString *string = [[NSString alloc] initWithData:resData encoding:NSUTF8StringEncoding];
        NSLog(@"请求结果==string=====%@",string);
        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"请求结果=dic======%@", dic);
        
        if (!resData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failHandle(nil);
            });
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            finishHandle(string);
        });

    });
}

//DES3解密
//+(id)decryptWithParameters:(id)responseObject
//{
//    NSString *String = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//    String = [DES3Util decrypt:String];
//    NSData *jsonData = [String dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    return dic;
//}
//
////DES3加密
//+ (NSString *)encryptWithParameters:(NSDictionary *)parameters
//{
//    return [DES3Util encrypt:[CMUtility dictionaryToJsonString:parameters]];
//}

//发送请求前数据的封装
+(NSDictionary *)getParameters:(NSMutableDictionary *)parameters
{
    NSMutableDictionary *mutabledic = [[NSMutableDictionary alloc]initWithDictionary:parameters];

    if (operationManager.isGetConnect == YES) {

        [operationManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Cookie"];
        
        NSDictionary *dic = @{@"v"        : DEF_APP_VERSION ? DEF_APP_VERSION : @"",
                               @"os"      : DEF_APP_OS ? DEF_APP_OS : @"",};
        [mutabledic setObject:dic forKey:DEF_API_CONNECT];

        operationManager.isGetConnect = NO;
        [mutabledic setObject:@"" forKey:@"channelname"];
        NSLog(@"request=%@",mutabledic);

        return mutabledic;
    }

    [mutabledic setObject:@"" forKey:@"channelname"];
    NSLog(@"request=%@",mutabledic);
    
    return mutabledic;
}

//获取loginCookie
+(void)getloginRequestCookie:(AFHTTPRequestOperation *)operation
{
    RequestOperationManager *manager = [RequestOperationManager shareInstance];
    NSString *cookie = [[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
    NSArray *arry=[cookie componentsSeparatedByString:@";"];
    if(arry)
    {
        manager.loginCookie = arry[0];
        NSLog(@"loginCookie=%@",[RequestOperationManager shareInstance].loginCookie);
    }
    
}
//获取Cookie
+(void)getRequestCookie:(AFHTTPRequestOperation *)operation
{
    RequestOperationManager *manager = [RequestOperationManager shareInstance];
    NSString *cookie = [[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
    NSArray *arry=[cookie componentsSeparatedByString:@";"];
    if(arry)
    {
        manager.Cookie = arry[0];
        NSLog(@"Cookie=%@",manager.Cookie);
    }
    
}

//post请求
+ (AFHTTPRequestOperationManager *)requestPostWithParameters:(NSMutableDictionary *)parameters
                                                finishHandle:(successBlock)finishHandle
                                                  failHandle:(failtureBlock)failHandle
{
//    NSDictionary *tempDic = @{
//                              @"mobile" :@"18837736110",
//                              @"donateRentId":@"2",
//                              };
//    NSString *url = @"http://hcmuc.app.huo.com/appRandom/randomMobileCode.htm";

    RequestOperationManager *manager = [RequestOperationManager shareInstance];

//    NSDictionary *encryptStr = [RequestOperationManager getParameters:parameters];
//    NSDictionary *dic = @{@"data":encryptStr};
    
    NSString *key = [parameters allKeys][0];
    NSDictionary *newParameters = parameters;
    NSString *url = [NSString stringWithFormat:@"%@",DEF_IPAddress];
    //过滤字符串前后的空格
    url = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //过滤中间空格
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"IPAddress:%@\n%@",url,newParameters);
    [manager POST:url parameters:newParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [RequestOperationManager requestSuccess:responseObject operation:operation finishHandle:finishHandle failHandle:failHandle];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"requestError:%@ \nerroe==%@",parameters,error);
        [RequestOperationManager requestError:error operation:operation failHandle:failHandle];
    }];
    
    return manager;
}

//带图片的post请求
+ (AFHTTPRequestOperationManager *)requestPostImageWithParameters:(NSDictionary *)parameters
                                                        urlString:(NSString *)urlString
                                                     finishHandle:(successBlock)finishHandle
                                                       failHandle:(failtureBlock)failHandle
{
    AFHTTPRequestOperationManager *manager = [RequestOperationManager shareInstance];
    NSString *urlPath = urlString;
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //如果有多余参数 删除图片参数 因上传图片参数在block内部
    [para removeObjectForKey:@"imgUploader"];
    
//  manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"multipart/form-data"];
    [manager POST:urlPath parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = (UIImage *)parameters[@"imgUploader"];
        NSString *fileName = [NSString stringWithFormat:@"ios_%@.jpg", [CMUtility currentTimestampMillisecond]];
        NSLog(@"fileName----%@",fileName);
        //name字段名固定
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5f) name:@"imgUploader" fileName:fileName mimeType:@"image/jpg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [RequestOperationManager requestSuccess:responseObject operation:operation finishHandle:finishHandle failHandle:failHandle];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RequestOperationManager requestError:error operation:operation failHandle:failHandle];
    }];
    
    return manager;
}

//get请求
+ (AFHTTPRequestOperationManager *)requestGetWithParameters:(NSDictionary *)parameters
                                                  urlString:(NSString *)urlString
                                               finishHandle:(successBlock)finishHandle
                                                 failHandle:(failtureBlock)failHandle
{
    AFHTTPRequestOperationManager *manager = [RequestOperationManager shareInstance];
    NSString *urlPath = urlString;
    NSLog(@"urlPath:%@\n%@",urlPath,parameters);

    [manager GET:urlPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [RequestOperationManager requestSuccess:responseObject operation:operation finishHandle:finishHandle failHandle:failHandle];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [RequestOperationManager requestError:error operation:operation failHandle:failHandle];
    }];
    
    return manager;
}

/**
 *  取消网络请求
 */
+(void)cancelAlloperationQueue
{
    AFHTTPRequestOperationManager *manager = [RequestOperationManager shareInstance];
    [manager.operationQueue cancelAllOperations];
}

//取消request请求
+ (void)cancelRequestWithPath:(NSString *)path
{
    AFHTTPRequestOperationManager *manager = [RequestOperationManager shareInstance];
    
    NSString *twoPath = path;
    twoPath = [twoPath substringToIndex:[twoPath rangeOfString:@"&"].location];
    NSString *onePath;
    
    for (NSOperation *operation in [manager.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        
        onePath = [[[(AFHTTPRequestOperation *)operation request] URL] absoluteString];
        onePath = [onePath substringToIndex:[onePath rangeOfString:@"&"].location];
        
        if ([onePath isEqual:twoPath]) {
            [operation cancel];
        }
    }
}


+(void)apiGETRequestUrl:(NSString *)url ParametersDic:(NSMutableDictionary *)parameterDic
                       success:(void (^)(NSDictionary *result))successBlock
                      failture:(void (^)(id result))failtureBlock
{
    NSString *newUrl = [NSString stringWithFormat:@"%@%@",DEF_IPAddress,url];
    [RequestOperationManager requestGetWithParameters:parameterDic urlString:newUrl finishHandle:^(id result) {
        BLOCK_SAFE (successBlock)(result);
    } failHandle:^(id result) {
        BLOCK_SAFE (failtureBlock)(result);
    }];
 }


+(void)apiPOSTRequestParametersDic:(NSMutableDictionary *)parameterDic
                       success:(void (^)(NSDictionary *result))successBlock
                      failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                          finishHandle:^(id result) {
                                             BLOCK_SAFE (successBlock)(result);
                                          } failHandle:^(id result) {
                                              BLOCK_SAFE (failtureBlock)(result);
                                          }];
}

+(void)apiPOSTImageRequestParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock
{
    //NSString *key = [parameterDic allKeys][0];
    NSDictionary *newParameters = parameterDic;
    NSString *url = [NSString stringWithFormat:@"%@",DEF_IP_POSTIMAGE];
    //过滤字符串前后的空格
    url = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //过滤中间空格
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [RequestOperationManager requestPostImageWithParameters:newParameters urlString:url finishHandle:^(id result) {
        BLOCK_SAFE (successBlock)(result);
    } failHandle:^(id result) {
        BLOCK_SAFE (failtureBlock)(result);
    }];
}

+(RACSignal *)racPostRequestWithParameters:(NSDictionary *)parameterDic
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RequestOperationManager *manager = [RequestOperationManager shareInstance];
        
        NSString *key = [parameterDic allKeys][0];
        NSDictionary *newParameters = [parameterDic objectForKey:key];
        NSString *url = [NSString stringWithFormat:@"%@%@",DEF_IPAddress,key];
        //过滤字符串前后的空格
        url = [url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //过滤中间空格
        url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"IPAddress:%@\n%@",url,newParameters);

        [manager POST:url parameters:newParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [RequestOperationManager getRequestCookie:operation];

//            for (NSString *str in [parameterDic allKeys]) {
//                //当为获取自动登陆接口时不获取上一层请求参数
//                if ([str isEqualToString:DEF_API_RELOGIN] || [str isEqualToString:DEF_API_LOGIN] || [str isEqualToString:DEF_API_USERTHIRDLOGIN]) {
//                }
//                else if([str isEqualToString:DEF_API_LOGOUT])
//                {
//                    operationManager.Cookie = @"";
//                }
//            }
            
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];

        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

+(RACSignal *)racGetParameters:(NSMutableDictionary *)parameterDic
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RequestOperationManager *manager = [RequestOperationManager shareInstance];
        if (manager.isGetConnect == YES) {
            [operationManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Cookie"];
            NSDictionary *dic = @{@"v"       : DEF_APP_VERSION ? DEF_APP_VERSION : @"",
                                  @"os"      : DEF_APP_OS ? DEF_APP_OS : @"",};
            [parameterDic setObject:dic forKey:DEF_API_CONNECT];
            
            manager.isGetConnect = NO;
        }
        
//        [parameterDic setObject:@"" forKey:@"channelname"];
        NSLog(@"request=%@",parameterDic);
        
        [subscriber sendNext:parameterDic];
        [subscriber sendCompleted];
        return nil;
    }];
}

+(RACSignal *)racEncryptWithParameters:(NSMutableDictionary *)parameterDic
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:parameterDic];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

+(RACSignal *)requestError:(NSError *)error
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if(error.code == kCFURLErrorNotConnectedToInternet)
        {
//            iToast *itoast = [iToast makeText:@"网络不可用，请检查网络连接"];
//            [itoast setGravity:iToastGravityCenter];
//            [itoast show];
            [CMUtility showTips:@"网络不可用，请检查网络连接"];
            
            [subscriber sendError:error];
        }else if (error.code == kCFURLErrorTimedOut)
        {
//            iToast *itoast = [iToast makeText:@"网络请求超时"];
//            [itoast setGravity:iToastGravityCenter];
//            [itoast show];
            [CMUtility showTips:@"网络请求超时"];
            
            [subscriber sendError:error];
        }else if (error.code == kCFURLErrorCannotConnectToHost)
        {
//            iToast *itoast = [iToast makeText:@"网络不可用，请检查网络连接"];
//            [itoast setGravity:iToastGravityCenter];
//            [itoast show];
            [CMUtility showTips:@"网络不可用，请检查网络连接"];
            
            [subscriber sendError:error];
        }else
        {
            CC_LOG_VALUE(error);
            
            [subscriber sendError:error];
        }
        [subscriber sendCompleted];
        
        CC_LOG_VALUE(error.localizedDescription);

        return nil;
    }];
}

+(RACSignal *)restartRequest
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        if ([[RequestOperationManager shareInstance].resData[@"status"] intValue] == 1001) {
            RequestOperationManager *manager = [RequestOperationManager shareInstance];
            manager.isGetConnect = YES;
            [[RequestOperationManager racRequestPostWithParameters:manager.parametersDic] subscribeNext:^(id x) {
                [subscriber sendNext:x];
                [subscriber sendCompleted];
            } error:^(NSError *error) {
                [subscriber sendError:error];
            }];
        }
        return nil;
    }];
}

+(RACSignal *)requestSuccess:(id)responseObject
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        id resData = responseObject;
        NSLog(@"resData======%@",resData);
        
        [RequestOperationManager shareInstance].resData = resData;
        if (!resData) {
            [subscriber sendError:nil];
            [subscriber sendCompleted];
        }
        
        [subscriber sendNext:resData];
        [subscriber sendCompleted];
        
        return nil;
    }] concat:[RequestOperationManager restartRequest]];
}

+(RACSignal *)racRequestPostWithParameters:(NSMutableDictionary *)parameterDic
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

        RequestOperationManager *manager = [RequestOperationManager shareInstance];
        manager.parametersDic = parameterDic;
        
        [[[[RequestOperationManager racGetParameters:parameterDic] flattenMap:^RACStream *(NSMutableDictionary * dic) {
            return [RequestOperationManager racEncryptWithParameters:dic];
        }]  flattenMap:^RACStream *(NSDictionary *dic) {
            return [RequestOperationManager racPostRequestWithParameters:dic];
        }] subscribeNext:^(id responseObject) {
            [[RequestOperationManager requestSuccess:responseObject] subscribeNext:^(id x) {
                [subscriber sendNext:x];
                [subscriber sendCompleted];
            } error:^(NSError *error) {
                [subscriber sendError:error];
            }];
        } error:^(NSError *error) {
            [[RequestOperationManager requestError:error] subscribeError:^(NSError *error) {
                [subscriber sendError:error];
            }];
        }];
        
        return nil;
    }];
}

+(RACSignal *)apiRacRequestParametersDic:(NSMutableDictionary *)parameterDic
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RequestOperationManager racRequestPostWithParameters:parameterDic] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
}

@end
