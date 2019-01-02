//
//  PaymentRejectViewController.m
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import "PaymentRejectViewController.h"
#import <MessageUI/MessageUI.h>
@interface PaymentRejectViewController ()<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>

@end

@implementation PaymentRejectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SharedClass setShadowOnView:self.viewPopup];
    [SharedClass setBorderOnButton:_btnSearchCandidate];
    _btnSearchCandidate.layer.borderWidth=1.0;
    _btnSearchCandidate.layer.borderColor=InternalButtonColor.CGColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btncloseAction) name:@"Close" object:nil];
    // Do any additional setup after loading the view.
}

-(void)btncloseAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_scrollView setContentSize:CGSizeMake(_viewPopup.frame.size.width, _viewPopup.frame.origin.y+_viewPopup.frame.size.height+20)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnSearchCandidateAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate openPaymentData];
}

- (IBAction)btnOpenMailAction:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"contact@bonjob.co"]];
        [composeViewController setCcRecipients:@[@"ludonyc@gmail.com"]];
        [composeViewController setSubject:@"Donner mon opinion"];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if (result==MFMailComposeResultSent)
    {
        [controller dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    //Add an alert in case of failure
}
@end
