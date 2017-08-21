//
//  MainViewController.m
//  Architecture
//
//  Created by xiaofeng on 16/6/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "MainViewController.h"
#import "DYMRollingBannerVC.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    DYMRollingBannerVC *vc = [[DYMRollingBannerVC alloc]init];
    
    vc.view.frame = CGRectMake(0, 100, DEF_DEVICE_WIDTH, 400);
    // 1. Set the inteval for rolling (optional, the default value is 1 sec)
    vc.rollingInterval = 5;
    
    // 2. set the placeholder image (optional, the default place holder is nil)
    vc.placeHolderImage = [UIImage imageNamed:@"default"];
    
    // 3. define the way how you load the image from a remote url
    [vc setRemoteImageLoadingBlock:^(UIImageView *imageView, NSString *imageUrlStr, UIImage *placeHolderImage) {
        [imageView sd_cancelCurrentImageLoad];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:placeHolderImage options:SDWebImageProgressiveDownload];
    }];
    
    // 4. setup the rolling images
    vc.rollingImages = @[@"http://easyread.ph.126.net/G8GtEi-zmPQzvS5w7ScxmQ==/7806606224489671909.jpg"
                         , @"http://www.qqpk.cn/Article/UploadFiles/201312/20131212154331984.jpg"
                         , @"http://epaper.syd.com.cn/sywb/res/1/20080108/42241199752656275.jpg"
//                         , [UIImage imageNamed:@"001"]
//                         , [UIImage imageNamed:@"002"]
                         ];
    
    // 5. add a handler when a tap event occours (optional, default do noting)
    [vc addBannerTapHandler:^(NSInteger whichIndex) {
        NSLog(@"banner tapped, index = %@", @(whichIndex));
    }];
    
    // 6. If 'YES', the auto scrolling will scroll to the right
    vc.isAutoScrollingBackward = YES;
    
    // 7. start auto rolling (optional, default does not auto roll)
    [vc startRolling];

    
    [self.view addSubview:vc.view];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
