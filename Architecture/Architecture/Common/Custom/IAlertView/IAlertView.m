//
//  IAlertView.m
//  Architecture
//
//  Created by xiaofeng on 2017/11/14.
//  Copyright © 2017年 xiaofeng. All rights reserved.
//

#import "IAlertView.h"
#import <QuartzCore/QuartzCore.h>


// title高度
#define kAlertViewDefaultTitleHeight DEF_DEVICE_SCLE_HEIGHT(107)
// 按钮高度
#define kAlertViewDefaultButtonHeight DEF_DEVICE_SCLE_HEIGHT(114)

#define kAlertViewDefaultButtonSpacerHeight 0.5// 分隔线宽度

#define kAlertViewCornerRadius 7// 圆角半径


CGFloat buttonHeight = 0;
CGFloat buttonSpacerHeight = 0;

@interface IAlertView ()

@property (nonatomic, strong) UILabel *titleView; // 标题View

@end

@implementation IAlertView

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleBackgroundColor:(UIColor *)titleBackgroundColor
{
    _title = title;
    _titleColor = titleColor;
    _titleBackgroundColor = titleBackgroundColor;
    return [self init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        // 默认只有一个取消按钮
        _buttonTitles = @[@"取消"];
        // 必须调用此方法监听设备旋转才有效
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        // 监听设备旋转
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        // 监听键盘出现
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        // 监听键盘消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

// 设置子布局
- (void)addContentView: (UIView *)contentView
{
    _containerView = contentView;
}

// 创建并显示提示AlertView
- (void)show
{
    // 创建提示视图
    _dialogView = [self createContainerView];
    
    // layer光栅化，提高性能
    _dialogView.layer.shouldRasterize = YES;
    _dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:_dialogView];
    
    // iOS7, 旋转方向调整
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        switch (interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                self.transform = CGAffineTransformMakeRotation(M_PI * 270.0 / 180.0);
                break;
                
            case UIInterfaceOrientationLandscapeRight:
                self.transform = CGAffineTransformMakeRotation(M_PI * 90.0 / 180.0);
                break;
                
            case UIInterfaceOrientationPortraitUpsideDown:
                self.transform = CGAffineTransformMakeRotation(M_PI * 180.0 / 180.0);
                break;
                
            default:
                break;
        }
        
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
    } else {
        // iOS8, 仅把提示视图居中即可
        CGSize screenSize = [self countScreenSize];
        CGSize dialogSize = [self countDialogSize];
        CGSize keyboardSize = CGSizeMake(0, 0);
        
        _dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
    }
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    _dialogView.layer.opacity = 0.5f;
    //    _dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0); // 由大变小的动画
    
    [UIView animateWithDuration:0.1f delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
                         _dialogView.layer.opacity = 1.0f;
                         //                         _dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:nil
     ];
    
}

// 创建提示视图
- (UIView *)createContainerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    }
    
    // 如果有标题则containerView的y坐标往下移
    if (_title.length) {
        CGRect containerViewFrame = _containerView.frame;
        containerViewFrame.origin.y += kAlertViewDefaultTitleHeight;
        containerViewFrame.size.height += kAlertViewDefaultTitleHeight;
        _containerView.frame = containerViewFrame;
    }
    
    
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
    [self setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    // 提示视图
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height)];
    
    dialogContainer.layer.cornerRadius = kAlertViewCornerRadius;
    dialogContainer.layer.masksToBounds = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = dialogContainer.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f] CGColor],
                       nil];
    
    CGFloat cornerRadius = kAlertViewCornerRadius;
    gradient.cornerRadius = cornerRadius;
    [dialogContainer.layer insertSublayer:gradient atIndex:0];
    
    dialogContainer.layer.cornerRadius = cornerRadius;
    dialogContainer.layer.shadowRadius = cornerRadius + 5;
    dialogContainer.layer.shadowOpacity = 0.1f;
    dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius + 5) / 2, 0 - (cornerRadius + 5) / 2);
    dialogContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
    // 分隔线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, dialogContainer.bounds.size.height - buttonHeight - buttonSpacerHeight, dialogContainer.bounds.size.width, buttonSpacerHeight)];
    lineView.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f];
    [dialogContainer addSubview:lineView];
    
    // 添加标题View
    if (_title.length) {
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dialogContainer.bounds.size.width, kAlertViewDefaultTitleHeight)];
        _titleView.backgroundColor = _titleBackgroundColor;
        _titleView.text = _title;
        _titleView.font = DEF_MyFont(19);
        _titleView.textColor = _titleColor ? : [UIColor blackColor];
        _titleView.textAlignment = NSTextAlignmentCenter;
        [dialogContainer addSubview:_titleView];
        
        //设置单独几个角为圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_titleView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _titleView.bounds;
        maskLayer.path = maskPath.CGPath;
        _titleView.layer.mask = maskLayer;
    }
    
    // 添加子布局
    [dialogContainer addSubview:_containerView];
    // 添加按钮
    [self addButtonsToView:dialogContainer];
    
    return dialogContainer;
}

// 添加按钮
- (void)addButtonsToView: (UIView *)container
{
    if (!_buttonTitles) {
        return;
    }
    if (!_buttonTitlesColor) {
        return;
    }
    if (!_buttonTitlesBackGroundColor) {
        return;
    }
    
    NSInteger buttonCount = [_buttonTitles count];
    CGFloat buttonWidth = container.bounds.size.width / buttonCount;
    
    for (int i = 0; i < buttonCount; i++) {
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        [closeButton addTarget:self action:@selector(buttonClickHandle:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTag:i];
        
        [closeButton setTitle:[_buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        // 设置按钮颜色
        UIColor *titleColor = _buttonTitlesColor[i];
        UIColor *titlesBackGroundColor = _buttonTitlesBackGroundColor[i];

        [closeButton setTitleColor:titleColor forState:UIControlStateNormal];
        [closeButton setTitleColor:titleColor forState:UIControlStateHighlighted]; 
        [closeButton setBackgroundColor:titlesBackGroundColor];
        closeButton.titleLabel.font = DEF_MyFont(18);
        
        
        //[closeButton.layer setCornerRadius:kAlertViewCornerRadius];
        
        [container addSubview:closeButton];
//        if (i > 0)
//        {
//            // 按钮分隔线
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, kAlertViewDefaultButtonSpacerHeight, buttonHeight)];
//            lineView.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f];
//            [container addSubview:lineView];
//        }
    }
}

// 按钮点击
- (void)buttonClickHandle:(id)sender
{
    if (_onButtonClickHandle) {
        _onButtonClickHandle(self, [sender tag]);
    }
}

- (void)setOnClickListerner:(OnButtonClickHandle)onButtonClickHandle
{
    _onButtonClickHandle = onButtonClickHandle;
}

// 关闭AlertView并移除
- (void)dismiss
{
    CATransform3D currentTransform = _dialogView.layer.transform;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        CGFloat startRotation = [[_dialogView valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
        CATransform3D rotation = CATransform3DMakeRotation(-startRotation + M_PI * 270.0 / 180.0, 0.0f, 0.0f, 0.0f);
        
        _dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1));
    }
    
    _dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         _dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         _dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

// 得到提示视图的size
- (CGSize)countDialogSize
{
    CGFloat dialogWidth = _containerView.frame.size.width;
    CGFloat dialogHeight = _containerView.frame.size.height + buttonHeight + buttonSpacerHeight;
    
    return CGSizeMake(dialogWidth, dialogHeight);
}

// 得到屏幕的size
- (CGSize)countScreenSize
{
    if (_buttonTitles && [_buttonTitles count] > 0) {
        buttonHeight       = kAlertViewDefaultButtonHeight;
        buttonSpacerHeight = kAlertViewDefaultButtonSpacerHeight;
    } else {
        buttonHeight = 0;
        buttonSpacerHeight = 0;
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // iOS7, 屏幕的宽高不会随着方向自动调整
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
        }
    }
    
    return CGSizeMake(screenWidth, screenHeight);
}

// 设备旋转
- (void)deviceOrientationDidChange: (NSNotification *)notification
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        [self changeOrientationForIOS7];
    } else {
        [self changeOrientationForIOS8:notification];
    }
}

// 设备旋转（iOS7）
- (void)changeOrientationForIOS7 {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat startRotation = [[self valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    CGAffineTransform rotation;
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 180.0 / 180.0);
            break;
            
        default:
            rotation = CGAffineTransformMakeRotation(-startRotation + 0.0);
            break;
    }
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         _dialogView.transform = rotation;
                         
                     }
                     completion:nil
     ];
    
}

// 设备旋转（iOS8）
- (void)changeOrientationForIOS8: (NSNotification *)notification {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGSize dialogSize = [self countDialogSize];
                         CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
                         self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                         _dialogView.frame = CGRectMake((screenWidth - dialogSize.width) / 2, (screenHeight - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
    
    
}

// 键盘出现
- (void)keyboardWillShow: (NSNotification *)notification
{
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation) && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) {
        CGFloat tmp = keyboardSize.height;
        keyboardSize.height = keyboardSize.width;
        keyboardSize.width = tmp;
    }
    
    [UIView animateWithDuration:0.1f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         _dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

// 键盘消失
- (void)keyboardWillHide: (NSNotification *)notification
{
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
    [UIView animateWithDuration:0.1f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         _dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

- (void)dealloc
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}




@end
