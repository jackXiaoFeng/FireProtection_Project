//
//  UploadingViewModel.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/16.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "UploadingViewModel.h"
@interface UploadingViewModel()
/**
 *  分页
 */
@property int Page;


@end
@implementation UploadingViewModel

-(id)init
{
    self = [super init];
    if (self) {
        
        self.uploadingList = [[NSMutableArray alloc]init];
        
        self.uploadingModel = [[UploadingModel alloc]init];
        
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
        NSString *utf8Str = [NSString utf8ToUnicode:CMMemberEntity.userInfo.unitsn];
        
        NSDictionary *datDic = @{
                                 @"Unitsn":utf8Str,
                                 @"Oper_flag":@1,
                                 @"Nrow":[NSNumber numberWithInt:pageSize],
                                 @"Page":[NSNumber numberWithInt:page],
                                 };
        NSArray *arr = [NSArray arrayWithObjects:datDic, nil];
        NSDictionary *tempDic = @{
                                  @"code":XS032,
                                  @"serial_no":[NSString stringWithFormat:@"%@%@",[CMUtility currentTimestampMillisecond],XS032_serial_no],
                                  @"errorcode":@"0",
                                  @"errormsg":@"success",
                                  @"token":CMMemberEntity.token,
                                  @"dat":arr
                                  };
        
        NSString *jsonStr = [NSString deleteCharactersInJsonStr:[tempDic JSONString]];
        @weakify(self)
        [SocketIO_Singleton sendEmit:XS032 withMessage:jsonStr];
        SocketIO_Singleton.xr032CallBackResult = ^(NSDictionary *resultDict){
            @strongify(self)
            NSString *errorcode = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errorcode"]);
            NSString *errormsg = DEF_OBJECT_TO_STIRNG([resultDict objectForKey:@"errormsg"]);
            NSLog(@"errorcode is :%@",errorcode);
            NSLog(@"errormsg is :%@",errormsg);
            
            //fixpangu: 暂定200 测试
            if ([errorcode isEqualToString:SUCCESS_CODE]) {
                
                if (loadType == LoadData) {
                    [self.uploadingList removeAllObjects];
                }
                
                //[self.uploadingList addObjectsFromArray:(NSMutableArray *)[MTLJSONAdapter modelsOfClass:[UploadingModel class] fromJSONArray:resultDict[@"datas"] error:nil]];
                for (int i = 0; i< 30; i++) {
                    UploadingModel *model =[[UploadingModel alloc]init];
                    model.name = [NSString stringWithFormat:@"name:%d",i];
                    model.isSelect = NO;
                    [self.uploadingList addObject:model];
                }
                
                [subscriber sendNext: self.uploadingList];
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
