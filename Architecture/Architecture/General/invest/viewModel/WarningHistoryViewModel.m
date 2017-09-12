//
//  WarningHistoryViewModel.m
//  Architecture
//
//  Created by xiaofeng on 17/9/6.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "WarningHistoryViewModel.h"

@interface WarningHistoryViewModel()
/**
 *  分页
 */
@property int Page;


@end


@implementation WarningHistoryViewModel

-(id)init
{
    self = [super init];
    if (self) {
        
        self.warningHistoryList = [[NSMutableArray alloc]init];
        
        self.WarningHistoryModel = [[WarningHistoryModel alloc]init];
        
        self.Page = 1;
    }
    return self;
}


/**
 *  获取用户下拉刷新或者上提加载更多函数
 *
 *  @param loadType LoadData 下拉刷新 LoadMore 上提加载更多
 *  @param urlType  接口类型
 *  @param filmId   影片ID
 *
 *  @return RACSignal
 */

-(RACSignal *)feedDataWithType:(LoadType)loadType
{
    @weakify(self);
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        
        int page = 1;
        int pageSize = DEF_PAGESIZE;
        
        if (loadType == LoadData) {
            page = 1;
        }
        //预告
        if (loadType == LoadMore) {
            //下拉刷新
            self.Page ++;
            
            page = self.Page;
        }
        NSDictionary *datDic = @{
                                 @"unitsn":CMMemberEntity.userInfo.unitsn,
                                 @"Oper_flag":@1,
                                 @"Nrow":[NSNumber numberWithInt:pageSize],
                                 @"Page":[NSNumber numberWithInt:page],
                                 };
        NSArray *arr = [NSArray arrayWithObjects:datDic, nil];
        NSDictionary *tempDic = @{
                                  @"code":XS009,
                                  @"serial_no":[NSString stringWithFormat:@"%@%@",[CMUtility currentTimestamp],XS009_serial_no],
                                  @"errorcode":@"0",
                                  @"errormsg":@"success",
                                  @"token":CMMemberEntity.token,
                                  @"dat":arr
                                  };
        
        
        NSString *jsonStr = [tempDic JSONString];
        @weakify(self)
        [SocketIO_Singleton sendEmit:XS009 withMessage:jsonStr];
        SocketIO_Singleton.xr009CallBackResult = ^(NSDictionary *resultDict){
            @strongify(self)
            NSString *errorcode = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errorcode"]);
            NSString *errormsg = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errormsg"]);
            NSLog(@"errorcode is :%@",errorcode);
            NSLog(@"errormsg is :%@",errormsg);
            
            //fixpangu: 暂定200 测试
            if ([errorcode isEqualToString:SUCCESS_CODE]) {
                
                if (loadType == LoadData) {
                    [self.warningHistoryList removeAllObjects];
                }
                
                [self.warningHistoryList addObjectsFromArray:(NSMutableArray *)[MTLJSONAdapter modelsOfClass:[WarningHistoryModel class] fromJSONArray:resultDict[@"datas"] error:nil]];
                
                [subscriber sendNext: self.warningHistoryList];
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
