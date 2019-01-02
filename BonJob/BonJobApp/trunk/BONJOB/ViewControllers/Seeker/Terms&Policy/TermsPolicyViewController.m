//
//  TermsPolicyViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 8/31/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "TermsPolicyViewController.h"

@interface TermsPolicyViewController ()

@end

@implementation TermsPolicyViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
     _viewProgressBack.hidden=YES;
    self.title=self.title;
    NSURL *websiteUrl ;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if ([self.identifier isEqualToString:@"terms"])
    {
       websiteUrl = [NSURL URLWithString:kTermsOfUse];
    }
    else
    {
        websiteUrl = [NSURL URLWithString:kPrivacyPolicy];
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [_webView loadRequest:urlRequest];
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - --------WebView Delegates---------

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    _viewProgressBack.hidden=NO;
    [_indicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    _viewProgressBack.hidden=YES;
    [_indicator stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    _viewProgressBack.hidden=YES;
    [_indicator stopAnimating];
}


@end
