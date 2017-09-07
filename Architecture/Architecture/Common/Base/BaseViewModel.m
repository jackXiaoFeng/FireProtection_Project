//
//  BaseViewModel.m
//  MoviesStore 2.0
//
//  Created by caimiao on 15/5/19.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (id)init
{
    self = [super init];
    if (self) {
        self.parametersDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

@end
