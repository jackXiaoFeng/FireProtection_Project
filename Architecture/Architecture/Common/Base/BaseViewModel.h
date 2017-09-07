//
//  BaseViewModel.h
//  MoviesStore 2.0
//
//  Created by caimiao on 15/5/19.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEF_PAGESIZE 20

#define DEF_PAGESIZE 20


typedef enum {
    LoadData = 1,
    LoadMore
}LoadType;

@interface BaseViewModel : NSObject

/**
 *  请求接口参数
 */
@property (nonatomic, strong)NSMutableDictionary *parametersDic;

@end

@interface BaseViewModel (optional)

- (void)feedDataWithType:(LoadType)loadType finish:(void (^)())successBlock failture:(void (^)())failtureBlock;

@end
