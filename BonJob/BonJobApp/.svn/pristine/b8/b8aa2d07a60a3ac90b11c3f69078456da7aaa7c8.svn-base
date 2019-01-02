//
//  IntroPopupViewController.m
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import "IntroPopupViewController.h"
#import "PaymentDataViewController.h"
#import "RecruiterVerifyViewController.h"
@interface IntroPopupViewController ()

@end

@implementation IntroPopupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor clearColor];
    //[self.view setOpaque:YES];
    [SharedClass setShadowOnView:self.viewPopup];
    [SharedClass setBorderOnButton:self.btnGotoPayment];
    [SharedClass setBorderOnButton:self.btnPublishOffer];
    [SharedClass setBorderOnButton:self.btnSearchCandidate];
    self.btnGotoPayment.layer.borderColor=InternalButtonColor.CGColor;
    self.btnGotoPayment.layer.borderWidth=1.0;
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btncloseAction) name:@"Close" object:nil];
}

-(void)btncloseAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -------BUTTONS ACTIONS----------

- (IBAction)btnPublishAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate gotoPostJob];
    
}

- (IBAction)btnSearchCandidateAction:(id)sender
{
    
    [self.delegate searchCandidate];
    [self dismissViewControllerAnimated:YES completion:nil];
 
    
}

- (IBAction)btnGotoPaymentAction:(id)sender
{
    [self.delegate openPaymentDataScreen];
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)btnModifyProfileAction:(id)sender
{
    
    [self.delegate gotoMyProfile];
    
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
