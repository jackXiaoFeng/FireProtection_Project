//
//  UserProtocolViewController.m
//  Basic
//
//  Created by xiaofeng on 16/7/20.
//  Copyright © 2016年 xiaofeng. All rights reserved.
//

#import "UserProtocolViewController.h"

@interface UserProtocolViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;


@end

@implementation UserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"用户服务协议";
    [self loadHtmlWithUrl];
    [self.activityIndicatorView startAnimating];
    
    self.leftBtn.hidden = NO;

    // Do any additional setup after loading the view.
}

- (void)leftBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)loadHtmlWithUrl
{
    NSURL *protocolUrl = [[NSBundle mainBundle] URLForResource:@"agreement.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:protocolUrl];
    [self.webView loadRequest:request];
}


#pragma mark - delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    //[CMUtility showTips:@"( ⊙ o ⊙ )啊！出错了!"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *requestURL = [request URL];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL:requestURL ];
    }
    return YES;
}

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.navBar.height, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - self.navBar.height)];
        _webView.delegate = self;
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.view addSubview:_activityIndicatorView];
    }
    
    return _activityIndicatorView;
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
