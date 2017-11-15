//
//  CMTakePhoto.h
//  CMmovies
//
//  Created by hongren on 15/6/15.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ImagePickerBlock)(UIImage *);
@interface CMTakePhoto : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
}
@property (nonatomic,copy)ImagePickerBlock imgBlock;

/**
 *  拍摄照片
 */
- (void)toTakePhotoWithViewController:(UIViewController *)viewController andComplete:(ImagePickerBlock)complete;

/**
 *  本地选取照片
 */
- (void)toSelectPhotoWithViewController:(UIViewController *)viewController andComplete:(ImagePickerBlock)complete;

@end
