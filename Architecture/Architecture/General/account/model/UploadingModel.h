//
//  UploadingModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadingModel : MTLModel <MTLJSONSerializing>
@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,strong)NSString *name;

@end
