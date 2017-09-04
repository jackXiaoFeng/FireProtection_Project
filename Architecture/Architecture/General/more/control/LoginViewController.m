//
//  LoginViewController.m
//  Basic
//
//  Created by xiaofeng on 16/7/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "LoginViewController.h"
#import "UserProtocolViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
//注册页面

@property (nonatomic,strong)UIView *userView;
@property (nonatomic,strong)UITextField             *userName;           //用户名
@property (nonatomic,strong)UITextField             *tfPhoneNum;           //手机号码
@property (nonatomic,strong)UITextField             *tfVericode;           //验证码
@property (nonatomic,strong)UITextField             *tfPassword;           //密码

@property (nonatomic,strong)UIButton                *btnVericode;          //获取验证码按钮

@property (nonatomic,strong)NSTimer                 *timer;                //计时器

@property (nonatomic,strong)UIButton                *btnNext;              //下一步按钮

@property (nonatomic,strong)UILabel                *companyLab;


@property (nonatomic,assign)NSInteger               timeNum;               //时间值
@property (nonatomic,strong)NSString                *sessionid;            //验证码操作Id
//@property (nonatomic,strong)CMRegAndPsdViewModel    *regViewModel;
@property (nonatomic,strong)UIButton *btnProtocol;

@property (nonatomic,assign)BOOL      isAgreeProtocol;

@property (nonatomic,assign)CGFloat               padding;               //时间值
@property (nonatomic,assign)CGFloat               textField_view_height;               //时间值

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.hidden = YES;
    
//        @weakify(self)
//        SocketIO_Singleton.connectSuccess = ^{
//            @strongify(self)
//    
//            NSLog(@"-------");
//            [SocketIO_Singleton sendInitMessage];
//        };
    
    
    UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_SCLE_HEIGHT(560))];
    headIV.image = DEF_IMAGENAME(@"login_head_bg");
    [self.view addSubview:headIV];
    
    
    UIImage *logoImage = DEF_IMAGENAME(@"login_logo");
    UIImageView *logoIV = [[UIImageView alloc]initWithFrame:CGRectMake((headIV.width-logoImage.size.width)/2, DEF_DEVICE_SCLE_HEIGHT(140), logoImage.size.width, logoImage.size.height)];
    logoIV.image = logoImage;
    [headIV addSubview:logoIV];
    
    
    CGFloat user_x =DEF_DEVICE_SCLE_WIDTH(65);
    CGFloat user_y =logoIV.y+logoIV.height+ DEF_DEVICE_SCLE_WIDTH(94);
    
    
    self.userView = [[UIView alloc]initWithFrame:CGRectMake(user_x, user_y, DEF_DEVICE_WIDTH - user_x*2, DEF_DEVICE_SCLE_HEIGHT(476))];
    self.userView.backgroundColor =[UIColor whiteColor];
    self.userView.layer.cornerRadius = 10;
    self.userView.layer.masksToBounds = YES;
    [self.view addSubview:self.userView];
    
    
    [self.userView addSubview:self.tfPhoneNum];
    
    [self.userView addSubview:self.tfVericode];
    
    [self.userView addSubview:self.btnVericode];
    
    [self.userView addSubview:self.btnNext];
    
    [self addProtocolView];
    
    [self.view addSubview:self.companyLab];
    
    //    self.regViewModel = [[CMRegAndPsdViewModel alloc]init];
    //    self.regViewModel.WeakVC = self;
    self.timeNum = 60;//倒计时时间初始化为60秒
    
    //    self.padding = 20;
    //
    //    self.textField_view_height = 60;
    
    //    // Do any additional setup after loading the view.
    //    NSArray *textFieldArray = @[self.userName,self.tfPassword];
    //    [textFieldArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 500 +DEF_NAVIGATIONBAR_HEIGHT +  (self.padding + self.textField_view_height)*idx + self.padding, DEF_DEVICE_WIDTH, self.textField_view_height)];
    //        view.backgroundColor = DEF_UICOLORFROMRGB(0xffffff);
    //        [self.view addSubview:view];
    //
    //        [view addSubview:textFieldArray[idx]];
    //
    ////        if (idx == 1) {
    ////            [view addSubview:[self createBtnGetVeriCode]];
    ////        }
    //
    //        for (int i = 0; i < 2; i ++) {
    //            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, i * (view.height - 0.5), view.width, 0.5)];
    //            lineView.backgroundColor = DEF_UICOLORFROMRGB(0xd2d2d2);
    //            lineView.alpha = 0.7;
    //            [view addSubview:lineView];
    //
    //        }
    //
    //    }];
    //
    //    self.btnNext.multipleTouchEnabled = NO;
    //
    
    //
    [self addRAC];
    
}


- (void)addRAC
{
    @weakify(self)
    [[[self.btnNext rac_signalForControlEvents:UIControlEventTouchUpInside]
      flattenMap:^id(id value) {
          @strongify(self);
          //self.btnNext.enabled = YES;
          self.completion();
          return [self regSignal];
      }]
     subscribeNext:^(NSString *str) {
         @strongify(self)
         if ([str isEqualToString:@"注册成功"]) {
             //[CMUtility showTips:@"注册成功"];
             [self.navigationController popViewControllerAnimated:YES];
             
         }else{
             //[CMUtility showTips:str];
         }
     }];
    
    [RACObserve(self,isAgreeProtocol) subscribeNext:^(NSNumber *isAgreeProtocol) {
        @strongify(self);
        NSString *imageName = [isAgreeProtocol integerValue] == 0?@"protocol_Unselect":@"protocol_select";
        [self.btnProtocol setImage:DEF_IMAGENAME(imageName) forState:UIControlStateNormal];
    }];
}
/**
 *  注册
 */
-(void)rightBtnClick
{
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
}

- (UIButton *)btnNext
{
    if (!_btnNext) {
        
        //登录按钮
        _btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnNext.frame = CGRectMake(self.tfVericode.x, self.tfVericode.y + self.tfVericode.height + DEF_DEVICE_SCLE_HEIGHT(74), self.tfPhoneNum.width, self.tfPhoneNum.height);
        [_btnNext setTitle:@"登  录" forState:UIControlStateNormal];
        [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnNext setBackgroundImage:DEF_IMAGENAME(@"login_btn_normal") forState:UIControlStateNormal];
        [_btnNext setBackgroundImage:DEF_IMAGENAME(@"login_btn_selected") forState:UIControlStateSelected];
    }
    return _btnNext;
}

//创建获取验证码按钮
- (UIButton *)btnVericode
{
    if (!_btnVericode) {
        
        CGFloat width = DEF_DEVICE_SCLE_WIDTH(225);
        CGFloat height = DEF_DEVICE_SCLE_HEIGHT(72);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.tfVericode.x+self.tfVericode.width + DEF_DEVICE_SCLE_WIDTH(13), self.tfVericode.y, width, height);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:@"验证码" forState:UIControlStateNormal];
        [btn setBackgroundImage:DEF_IMAGENAME(@"login_codeBtn_normal") forState:UIControlStateNormal];
        [btn setBackgroundImage:DEF_IMAGENAME(@"login_codeBtn_selected") forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(sendRequestAndstartTimer) forControlEvents:UIControlEventTouchUpInside];
        
        _btnVericode = btn;
    }
    return _btnVericode;
}

#pragma mark - 计时器
#pragma mark - Timer
/**
 * 发送获取验证码请求，并且开启计时器
 */
- (void)sendRequestAndstartTimer
{
    //检查出不符合要求的手机号
    @weakify(self);
    if(self.tfPhoneNum.text.length == 0){
        //[CMUtility showTips:@"请输入手机号码"];
        return;
    }else if(![CMUtility validateMobile:self.tfPhoneNum.text]) {
        //[CMUtility showTips:@"请输入有效的手机号码"];
        return;
    }else{
        self.btnVericode.enabled = NO;
        [self.btnVericode setTitle:@"获取中..." forState:UIControlStateDisabled];
        
        //        [self.regViewModel fetchVericode:self.tfPhoneNum.text Type:GetPhoneVerify_Login  withCompleteBlock:^(NSString *str) {
        //            @strongify(self);
        //            if (![str isEqualToString:FailToCheckNum]) {
        //                self.sessionid = str;
        //                [self startTimer];
        //                self.tfPhoneNum.userInteractionEnabled = NO;
        //            }else{
        //                //暂停计时器
        //                [_timer setFireDate:[NSDate distantFuture]];
        //                [_timer invalidate];
        //                _timer = nil;
        //                self.btnVericode.enabled = YES;
        //                self.tfPhoneNum.userInteractionEnabled = YES;
        //                self.timeNum = 60;
        //
        //            }
        //        }];
    }
}

- (void)startTimer
{
    [self.btnVericode setTitle:[NSString stringWithFormat:@"%ld S",(long)self.timeNum] forState:UIControlStateDisabled];
    [self.timer setFireDate:[NSDate distantPast]];
}

/**
 * 倒计时
 */
- (void)timerAction
{
    self.timeNum--;
    [self.btnVericode setTitle:[NSString stringWithFormat:@"%ld S",(long)self.timeNum] forState:UIControlStateDisabled];
    if (self.timeNum == 0) {
        //暂停计时器
        [_timer setFireDate:[NSDate distantFuture]];
        [_timer invalidate];
        _timer = nil;
        self.btnVericode.enabled = YES;
        self.tfPhoneNum.userInteractionEnabled = YES;
        self.timeNum = 60;
    }
}

#pragma mark - private singal
/**
 *  创建注册信号
 */
- (RACSignal *)regSignal
{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        if (!self.sessionid) {
            self.sessionid = @"";//1469166550
        }
        //        [self.regViewModel regWithUserName:self.userName.text
        //                                  PhoneNum:self.tfPhoneNum.text Vericode:self.tfVericode.text Password:self.tfPassword.text
        //                                 sessionid:self.sessionid
        //                           isAgreeProtocol:self.isAgreeProtocol
        //                                  complete:^(NSString *str) {
        //                                      [subscriber sendNext:str];
        //                                      [subscriber sendCompleted];
        //                                  } fail:^(NSError *err) {
        //                                      @strongify(self);
        //                                      self.btnNext.enabled = YES;
        //                                  }];
        return nil;
    }];
}

- (void)addProtocolView
{
    self.isAgreeProtocol = YES;
    
    UIFont *font = DEF_MyFont(13);
    NSString * protocolString = @"槃古科技相关协议";
    CGSize protocolSize = [CMUtility boundingRectWithSize:CGSizeMake(MAXFLOAT, 25) font:font string:protocolString withSpacing:0];
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(self.userView.width - protocolSize.width - 10, self.userView.height - 25, protocolSize.width,25);
    
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:protocolString];
    [aAttributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 7)];
    lab.attributedText = aAttributedString;
    lab.font = font;
    lab.userInteractionEnabled = YES;
    [self.userView addSubview:lab];
    
    //协议按钮
    UIButton *btnProtocol = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnProtocol setTitleColor:DEF_COLOR_RGB(141, 141, 142) forState:UIControlStateNormal];
    btnProtocol.titleLabel.font = font;
    btnProtocol.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnProtocol.frame = CGRectMake(lab.x - 80, self.userView.height - 25, 80,25);
    [btnProtocol setImage:DEF_IMAGENAME(@"protocol_select") forState:UIControlStateNormal];
    [btnProtocol setTitle:@"您已经同意" forState:UIControlStateNormal];
    [self.userView addSubview:btnProtocol];
    self.btnProtocol = btnProtocol;
    
    @weakify(self);
    [[btnProtocol rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        self.isAgreeProtocol = !self.isAgreeProtocol;
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(protocolLabTap:)];
    [lab addGestureRecognizer:tap];
    
}

- (void)protocolLabTap:(UITapGestureRecognizer *)tap
{
    UserProtocolViewController *userProtocolVC = [[UserProtocolViewController alloc]init];
    [self presentViewController:userProtocolVC animated:YES completion:nil];
}

#pragma mark - getter
- (UITextField *)userName
{
    if (!_userName) {
        NSString *placeHolder = @"昵称";
        UITextField *field = [self createTF:placeHolder withFrame:CGRectMake(20,0,DEF_DEVICE_WIDTH - 40,self.textField_view_height)];
        [field setValue:DEF_COLOR_RGB(141, 141, 142) forKeyPath:@"_placeholderLabel.textColor"];
        field.leftView = [self createLeftViewWithName:@"Login_Username"];
        field.leftViewMode = UITextFieldViewModeAlways;
        field.delegate = self;
        
        _userName = field;
    }
    return _userName;
}

- (UITextField *)tfPhoneNum
{
    if (!_tfPhoneNum) {
        CGFloat space = DEF_DEVICE_SCLE_WIDTH(50);
        CGFloat Y = DEF_DEVICE_SCLE_WIDTH(78);
        CGFloat height = DEF_DEVICE_SCLE_HEIGHT(72);
        
        NSString *placeHolder = @"手机号";
        UITextField *field = [self createTF:placeHolder withFrame:CGRectMake(space,Y,self.userView.width - space*2,height)];
        [field setValue:DEF_COLOR_RGB(141, 141, 142) forKeyPath:@"_placeholderLabel.textColor"];
        field.keyboardType = UIKeyboardTypeNumberPad;
        field.leftView = [self createLeftViewWithName:@"login_user"];
        field.leftViewMode = UITextFieldViewModeAlways;
        field.delegate = self;
        field.layer.borderColor= [UIColor lightGrayColor].CGColor;
        field.layer.borderWidth= 1.0f;
        field.layer.cornerRadius = 5;
        field.layer.masksToBounds = YES;
        _tfPhoneNum = field;
    }
    return _tfPhoneNum;
}

- (UITextField *)tfVericode
{
    if (!_tfVericode) {
        CGFloat space = DEF_DEVICE_SCLE_WIDTH(50);
        CGFloat Y = DEF_DEVICE_SCLE_WIDTH(78);
        CGFloat height = DEF_DEVICE_SCLE_HEIGHT(72);
        
        UITextField *tf = [self createTF:@"输入验证码" withFrame:CGRectMake(space,Y + height + DEF_DEVICE_SCLE_WIDTH(40),DEF_DEVICE_SCLE_WIDTH(280),height)];
        [tf setValue:DEF_COLOR_RGB(141, 141, 142) forKeyPath:@"_placeholderLabel.textColor"];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = [self createLeftViewWithName:@"login_code"];
        tf.delegate = self;
        tf.layer.borderColor= [UIColor lightGrayColor].CGColor;
        tf.layer.borderWidth= 1.0f;
        tf.layer.cornerRadius = 5;
        tf.layer.masksToBounds = YES;
        _tfVericode = tf;
    }
    return _tfVericode;
}

- (UITextField *)tfPassword
{
    if (!_tfPassword) {
        UITextField *tf = [self createTF:@"密码（至少6位）" withFrame:CGRectMake(20,0,DEF_DEVICE_WIDTH - 40,self.textField_view_height)];
        tf.secureTextEntry = YES;
        [tf setValue:DEF_COLOR_RGB(141, 141, 142) forKeyPath:@"_placeholderLabel.textColor"];
        tf.leftView = [self createLeftViewWithName:@"Login_Password"];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.delegate = self;
        
        _tfPassword = tf;
    }
    return _tfPassword;
}


//计时器
- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}


- (UILabel *)companyLab
{
    if (!_companyLab) {
        _companyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_DEVICE_HEIGHT - DEF_DEVICE_SCLE_HEIGHT(72)-DEF_DEVICE_SCLE_HEIGHT(30), DEF_DEVICE_WIDTH, DEF_DEVICE_SCLE_HEIGHT(30))];
        _companyLab.text = @"@上海槃古科技有限公司";
        _companyLab.textColor = DEF_COLOR_RGB(204, 204, 204);
        _companyLab.textAlignment = NSTextAlignmentCenter;
    }
    return _companyLab;
}

//创建textfield
- (UITextField *)createTF:(NSString *)str withFrame:(CGRect)rect
{
    UITextField *tf = [[UITextField alloc]initWithFrame:rect];
    tf.font = [UIFont systemFontOfSize:17];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.placeholder = str;
    tf.textColor = [UIColor grayColor];
    
    return tf;
}

//创建textfield的leftView
- (UIView *)createLeftViewWithName:(NSString *)str
{
    UIImage *image = [UIImage imageNamed:str];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, image.size.width + DEF_DEVICE_SCLE_WIDTH(40), image.size.height)];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_DEVICE_SCLE_WIDTH(24), 0, image.size.width, image.size.height)];
    imv.image = [UIImage imageNamed:str];
    imv.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imv];
    
    return view;
}

#pragma mark - other
//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)keyBoardHide
{
    [self.view endEditing:YES];
}

@end
