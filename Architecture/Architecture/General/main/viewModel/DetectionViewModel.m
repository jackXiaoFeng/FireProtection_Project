//
//  DetectionViewModel.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/17.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "DetectionViewModel.h"

@implementation DetectionViewModel
-(id)init
{
    self = [super init];
    if (self) {
        
        self.detectionList = [[NSMutableArray alloc]init];
        
        self.detectionModel = [[DetectionModel alloc]init];
        
    }
    return self;
}

/**
 *  巡检完成度
 *
 *  @return RACSignal
 */

-(RACSignal *)nfcDetectionFromDegree:(NSString *)Degree{
    @weakify(self);
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        NSString *utf8Str = [NSString utf8ToUnicode:CMMemberEntity.userInfo.unitsn];
        //NSString *utf8Degree = [NSString allUtf8ToUnicode:degree];
        NSDictionary *datDic = @{
                                 //@"Unitsn":utf8Str,
                                 @"Oper_flag":@1,
                                 @"Degree":Degree
                                 };
        NSArray *arr = [NSArray arrayWithObjects:datDic, nil];
        NSDictionary *tempDic = @{
                                  @"code":XS020,
                                  @"serial_no":[NSString stringWithFormat:@"%@%@",[CMUtility currentTimestampMillisecond],XS020_serial_no],
                                  @"errorcode":@"0",
                                  @"errormsg":@"success",
                                  @"token":CMMemberEntity.token,
                                  @"dat":arr                              };
        
        NSString *jsonStrTmp = [tempDic JSONString];
        NSString *jsonStr = [NSString deleteCharactersInJsonStr:jsonStrTmp];
        
        @weakify(self)
        [SocketIO_Singleton sendEmit:XS020 withMessage:jsonStr];
        SocketIO_Singleton.xr020CallBackResult = ^(NSDictionary *resultDict){
            @strongify(self)
            NSString *errorcode = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errorcode"]);
            NSString *errormsg = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errormsg"]);
            NSLog(@"errorcode is :%@",errorcode);
            NSLog(@"errormsg is :%@",errormsg);
            
            //fixpangu: 暂定200 测试
            if ([errorcode isEqualToString:SUCCESS_CODE]) {
                
                [self.detectionList addObjectsFromArray:(NSMutableArray *)[MTLJSONAdapter modelsOfClass:[DetectionModel class] fromJSONArray:resultDict[@"datas"] error:nil]];
                
                [subscriber sendNext: SUCCESS_MSG];
                [subscriber sendCompleted];
            }else
            {
                id obj =resultDict;
                [subscriber sendError:obj];
            }
        };
        return nil;
    }];
}
@end
