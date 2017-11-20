//
//  UploadingModel.h
//  Architecture
//
//  Created by xiaofeng on 17/8/28.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadingModel : NSObject <NSCoding>
@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,strong)NSString *Eqname;
@property (nonatomic,strong)NSString *Floorsn;
@property (nonatomic,strong)NSString *timeT;
@property (nonatomic,strong)NSString *Degree;
@property (nonatomic,strong)NSString *State;
@property (nonatomic,strong)NSString *images;
@property (nonatomic,strong)NSString *Describe;
@property (nonatomic,strong)NSString *Actegories;


- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)encodeWithCoder:(NSCoder *)aCoder;

+ (NSString *)filePath;

@end
