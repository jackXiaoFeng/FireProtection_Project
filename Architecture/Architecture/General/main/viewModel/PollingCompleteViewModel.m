//
//  PollingCompleteViewModel.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/15.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "PollingCompleteViewModel.h"

@implementation PollingCompleteViewModel

-(id)init
{
    self = [super init];
    if (self) {
        
        self.pollingCompleteList = [[NSMutableArray alloc]init];
        
        self.pollingCompleteModel = [[PollingCompleteModel alloc]init];
    }
    return self;
}

/**
 *  巡检完成度
 *
 *  @return RACSignal
 */

-(RACSignal *)feedData
{
    @weakify(self);
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        int nowInt = [[CMUtility currentTimestampSecond] intValue];
        int Zero = nowInt - (nowInt + 28800)%86400;
        
        NSString *utf8Str = [NSString utf8ToUnicode:CMMemberEntity.userInfo.unitsn];
        NSDictionary *datDic = @{
                                 @"Unitsn":utf8Str,
                                 @"Stime":[NSString stringWithFormat:@"%d",Zero],
                                 @"Otime":[NSString stringWithFormat:@"%d",nowInt],
                                 };
        NSArray *arr = [NSArray arrayWithObjects:datDic, nil];
        NSDictionary *tempDic = @{
                                  @"code":XS005,
                                  @"serial_no":[NSString stringWithFormat:@"%@%@",[CMUtility currentTimestampMillisecond],XS005_serial_no],
                                  @"errorcode":@"0",
                                  @"errormsg":@"success",
                                  @"token":CMMemberEntity.token,
                                  @"dat":arr
                                  };
        
        
        NSString *jsonStr = [NSString deleteCharactersInJsonStr:[tempDic JSONString]];
        
        @weakify(self)
        [SocketIO_Singleton sendEmit:XS005 withMessage:jsonStr];
        SocketIO_Singleton.xr005CallBackResult = ^(NSDictionary *resultDict){
            @strongify(self)
            NSString *errorcode = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errorcode"]);
            NSString *errormsg = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errormsg"]);
            NSLog(@"errorcode is :%@",errorcode);
            NSLog(@"errormsg is :%@",errormsg);
            
            //fixpangu: 暂定200 测试
            if ([errorcode isEqualToString:SUCCESS_CODE]) {
                
                [self.pollingCompleteList addObjectsFromArray:(NSMutableArray *)[MTLJSONAdapter modelsOfClass:[PollingCompleteModel class] fromJSONArray:resultDict[@"datas"] error:nil]];
                
                [subscriber sendNext: self.pollingCompleteList];
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
