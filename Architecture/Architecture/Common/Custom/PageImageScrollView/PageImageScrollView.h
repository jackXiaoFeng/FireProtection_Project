//
//  PageImageScrollView.h
//  Uzai
//
//  Created by UZAI on 14-8-1.
//
//

#import <UIKit/UIKit.h>
#import "DDPageControl.h"
@interface PageImageScrollView : UIView
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) DDPageControl *pageControll;
- (void)reloadUzaiPageScrollView :(NSArray *)imageArray;
@end
