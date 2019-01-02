//
//  PaymentAcceptViewController.m
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import "PaymentAcceptViewController.h"

@interface PaymentAcceptViewController ()

@end

@implementation PaymentAcceptViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SharedClass setShadowOnView:self.viewPopup];
    [SharedClass setBorderOnButton:self.btnPublish];
    [SharedClass setBorderOnButton:self.btnSearchCandidate];
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
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _viewPopup.frame.origin.y+_viewPopup.frame.size.height+20)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPublishJobAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate openPostJobController];
}

- (IBAction)btnSearchCandidateAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate openSearchCandidateController];
}

- (IBAction)btnEditProfileAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate openEditProfile];
}
@end
