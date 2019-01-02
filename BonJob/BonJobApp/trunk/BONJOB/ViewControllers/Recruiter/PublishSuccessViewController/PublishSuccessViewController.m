//
//  PublishSuccessViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/7/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "PublishSuccessViewController.h"

@interface PublishSuccessViewController ()

@end

@implementation PublishSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    _btnSeeMyOffer.backgroundColor=InternalButtonColor;
    [SharedClass setBorderOnButton:_btnSeeMyOffer];
    _btnGotoMyProfile.layer.cornerRadius=23;
    _btnGotoMyProfile.layer.borderColor=InternalButtonColor.CGColor;
    _btnGotoMyProfile.layer.borderWidth=1.5;
    _viewPopup.layer.cornerRadius=12;
    [_btnGotoMyProfile setTitleColor:InternalButtonColor forState:UIControlStateNormal];
    _lblMsg.text=NSLocalizedString(@"Your offer has been published", @"");
    [_btnSeeMyOffer setTitle:NSLocalizedString(@"View my offers", @"") forState:UIControlStateNormal];
    [_btnGotoMyProfile setTitle:NSLocalizedString(@"Go to my profile", @"") forState:UIControlStateNormal];
    [_btnGotoMyProfile addTarget:self action:@selector(gotoMyProfile:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSeeMyOffer addTarget:self action:@selector(lookMyOffer:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)gotoMyProfile:(UIButton *)btn
{
    [self.delegate gotoMyProfileTapped];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)lookMyOffer:(UIButton *)btn
{
    [self.delegate viewMyOfferTapped];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
