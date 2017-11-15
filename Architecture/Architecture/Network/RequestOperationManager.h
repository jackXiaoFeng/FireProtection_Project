//
//  RequestOperationManager.h
//  MoviesStore 2.0
//
//  Created by caimiao on 15/5/21.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

//网络请求status成功，即为@"1"
#define STATUSSUCCESS @200

/**
 请求数据结果block
 **/
typedef void (^successBlock) (id result);
typedef void (^failtureBlock) (id result);

@interface RequestOperationManager : AFHTTPRequestOperationManager
@property (nonatomic, strong)NSString *Cookie;
@property (nonatomic, strong)NSString *loginCookie;

+ (RequestOperationManager *)shareInstance;


/**
 *  网络请求发起GET
 *
 *  @param url           url
 *  @param parameterDic  参数
 *  @param successBlock  成功返回
 *  @param failtureBlock 失败返回
 */
+(void)apiGETRequestUrl:(NSString *)url ParametersDic:(NSMutableDictionary *)parameterDic
                success:(void (^)(NSDictionary *result))successBlock
               failture:(void (^)(id result))failtureBlock;

/**
 *  网络请求发起POST
 *
 *  @param parameterDic  post字典
 *  @param successBlock  成功返回
 *  @param failtureBlock 失败返回
 */
+(void)apiPOSTRequestParametersDic:(NSDictionary *)parameterDic
                       success:(void (^)(NSDictionary *result))successBlock
                      failture:(void (^)(id result))failtureBlock;

/**
 *  上传图片
 *
 *  @param parameterDic  post字典
 *  @param successBlock  成功返回
 *  @param failtureBlock 失败返回
 */
+(void)apiPOSTImageRequestParametersDic:(NSDictionary *)parameterDic
                           success:(void (^)(NSDictionary *result))successBlock
                          failture:(void (^)(id result))failtureBlock;
/**
 *  取消所有网络请求
 */
+(void)cancelAlloperationQueue;

+(RACSignal *)apiRacRequestParametersDic:(NSMutableDictionary *)parameterDic;



@end
