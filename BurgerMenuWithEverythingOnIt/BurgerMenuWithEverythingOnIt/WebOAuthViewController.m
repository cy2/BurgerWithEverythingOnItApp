//
//  WebOAuthViewController.m
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/16/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import "WebOAuthViewController.h"
#import <WebKit/WebKit.h>

@interface WebOAuthViewController () <WKNavigationDelegate>

@end

@implementation WebOAuthViewController

- (void)viewDidLoad {
    NSLog(@" WebOAuthViewController > viewDidLoad fired");
    
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:webView];
    
    webView.navigationDelegate = self;
    
    NSString *urlString = @"https://stackexchange.com/oauth/dialog?client_id=4278&scope=no_expiry&redirect_uri=https://stackexchange.com/oauth/login_success";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@" WebOAuthViewController > webView fired");
    
    NSURLRequest *request = navigationAction.request;
    NSURL *url = request.URL;
    NSLog(@"returned url %@",url.description);
    
    if ([url.description containsString:@"access_token"]) {
        
        NSArray *components = [[url description] componentsSeparatedByString:@"="];
        NSString *token = components.lastObject;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSLog(@"we have access token %@",token);
        
        [userDefaults setObject:token forKey:@"token"];
        [userDefaults synchronize];
        
        [self dismissViewControllerAnimated:true completion:nil];
        
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
    
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
