//
//  RecruiterVerifyViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/7/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterVerifyViewController.h"
#import "RecruiterVerifyEnterMobileViewController.h"
@interface RecruiterVerifyViewController ()

@end

@implementation RecruiterVerifyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self Setup];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 //   [_scrollView setContentSize:CGSizeMake(_viewPopup.frame.size.width, _btnVerify.frame.origin.y+_btnVerify.frame.size.height+20)];
    
   // _viewPopup.translatesAutoresizingMaskIntoConstraints=YES;
 //   CGRect frame=self.viewPopup.frame;
  //  frame.size.height=_btnVerify.frame.origin.y+_btnVerify.frame.size.height+20;
  //  [self.viewPopup setFrame:frame];
    
  //  _scrollView.translatesAutoresizingMaskIntoConstraints=YES;
//    CGRect frame1=self.scrollView.frame;
//    frame1.size.height=_viewPopup.frame.size.height+20;
//    [_scrollView setFrame:frame1];
      _scrollView.backgroundColor=[UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Setup
{
    
    [SharedClass setBorderOnButton:_btnVerify];
    _btnVerify.backgroundColor=InternalButtonColor;
    _btnCancel.layer.cornerRadius=23;
    _btnCancel.layer.borderWidth=1.5;
    _btnCancel.layer.borderColor=InternalButtonColor.CGColor;
    _viewPopup.layer.cornerRadius=13;
    _scrollView.layer.cornerRadius=13;
  
    [_btnCancel setTitleColor:InternalButtonColor forState:UIControlStateNormal];
    _lblMessage.text=NSLocalizedString(@"To publish your first offer, please verify your phone number", @"");
    _lblConfediencelNumber.text=NSLocalizedString(@"Your number is confidential and will not be shared.", @"");
    _lblClickToverifyNumber.text=NSLocalizedString(@"Click on Verify to receive your code (you will not have to verify your number for your future job offers).", @"");
    [_btnCancel setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    [_btnVerify setTitle:NSLocalizedString(@"Verify", @"") forState:UIControlStateNormal];
}

- (IBAction)btnCancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)btnVerifyAction:(id)sender
{
    RecruiterVerifyEnterMobileViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterVerifyEnterMobileViewController"];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:rvc];
    [self presentViewController:navController animated:YES completion:nil];
}
@end
