//
//  RecruiterConfirmViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/1/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterConfirmViewController.h"

@interface RecruiterConfirmViewController ()

@end

@implementation RecruiterConfirmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.viewPopup.translatesAutoresizingMaskIntoConstraints=YES;
    CGRect frame=self.viewPopup.frame;
    frame.size.height=_btnCancel.frame.size.height+_btnCancel.frame.origin.y+8;
    frame.origin.x=20;
    frame.origin.y=self.view.frame.size.height/2-_viewPopup.frame.size.height/2.8;
    frame.size.width=self.view.frame.size.width-40;
    self.viewPopup.frame=frame;
    [self setup];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    _lblMsg.text=NSLocalizedString(@"You are about to create a recruiter account", @"");
    _lblConfirm.text=NSLocalizedString(@"Please confirm by clicking on the button.", @"");
   [_btnImRecruiter setTitle:NSLocalizedString(@"I am a recruiter", @"") forState:UIControlStateNormal];
    [_btnCancel setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    //[_lblConfirm setAdjustsFontSizeToFitWidth:YES];
    //[_lblMsg setAdjustsFontSizeToFitWidth:YES];
    
    [_btnRecruiteCandidate setTitle:NSLocalizedString(@"RECRUIT A CANDIDATE",@"") forState:UIControlStateNormal];
    _btnRecruiteCandidate.titleLabel.numberOfLines = 1;
    _btnRecruiteCandidate.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_btnRecruiteCandidate sizeToFit];
    [_btnRecruiteCandidate setTitle:NSLocalizedString(@"RECRUIT A CANDIDATE", nil) forState:UIControlStateNormal];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_btnRecruiteCandidate.titleLabel.attributedText];
    [attributedString.mutableString setString:NSLocalizedString(@"RECRUIT A CANDIDATE", nil)];
    
    [_btnRecruiteCandidate setAttributedTitle:attributedString forState:UIControlStateNormal];
    [SharedClass setBorderOnButton:self.btnImRecruiter];
    self.viewPopup.layer.cornerRadius=20;
    
}
- (IBAction)btnImRecruiterAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"R" forKey:@"currentUser"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    FindajobViewController *fjvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
  //  fjvc.prevPlaceIdentifier=@"R";
    [self.navigationController pushViewController:fjvc animated:YES];
}

- (IBAction)btnCancelAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnRecruitaCandidate:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"R" forKey:@"currentUser"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    FindajobViewController *fjvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
   // fjvc.prevPlaceIdentifier=@"R";
    [self.navigationController pushViewController:fjvc animated:YES];
}
@end
