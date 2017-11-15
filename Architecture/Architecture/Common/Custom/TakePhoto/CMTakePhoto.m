//
//  CMTakePhoto.m
//  CMmovies
//
//  Created by hongren on 15/6/15.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "CMTakePhoto.h"

@implementation CMTakePhoto
- (void)dealloc
{
    
}

/**
 *  拍摄照片
 */
- (void)toTakePhotoWithViewController:(UIViewController *)viewController andComplete:(void(^)(UIImage *img))complete
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = sourceType;
        picker.allowsEditing = YES;
        self.imgBlock = complete;
        [viewController.navigationController presentViewController:picker animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前设备不支持摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

/**
 *  本地选取照片
 */
- (void)toSelectPhotoWithViewController:(UIViewController *)viewController andComplete:(void(^)(UIImage *img))complete
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = sourceType;
        picker.allowsEditing = YES;
        self.imgBlock = complete;
        [viewController.navigationController presentViewController:picker animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请允许访问本地相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //如果是拍照的，就把照片保存一份在本地
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        //如果是 来自照相机的image，那么先保存
        UIImage* editImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIImageWriteToSavedPhotosAlbum(editImage, self,
                                       NULL,
                                       nil);
    }
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        //获得编辑后的图片
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        BLOCK_SAFE(self.imgBlock)(image);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

}

@end
