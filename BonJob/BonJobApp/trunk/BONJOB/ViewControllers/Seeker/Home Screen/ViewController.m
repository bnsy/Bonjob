//
//  ViewController.m
//  BONJOB
//
//  Created by Infoicon Technologies on 29/04/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "ViewController.h"
#import "FindajobViewController.h"
#import "RecruiterConfirmViewController.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *findajob;
- (IBAction)recritacandidate:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *recruitacandidateoutlet;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    NSString *isRecLogined = [[NSUserDefaults standardUserDefaults] valueForKey:@"RecLogined"];
    NSString *isSecLogined = [[NSUserDefaults standardUserDefaults] valueForKey:@"logined"];
    /*
    if ([isSecLogined isEqualToString:@"YES"])
    {
        UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
        vc.tabBar.translucent = NO;
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([isRecLogined isEqualToString:@"YES"])
    {
        UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
        vc.tabBar.translucent = NO;
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        // user is logout
    }
     */
     
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [SharedClass setBorderOnButton:_findajob];
    [_findajob setTitle:NSLocalizedString(@"FIND A JOB", nil) forState:UIControlStateNormal];
    
    [SharedClass setBorderOnButton:_recruitacandidateoutlet];
    _recruitacandidateoutlet.backgroundColor=InternalButtonColor;
    
    _recruitacandidateoutlet.titleLabel.numberOfLines = 1;
    _recruitacandidateoutlet.titleLabel.adjustsFontSizeToFitWidth = YES;
     [_recruitacandidateoutlet sizeToFit];
     [_recruitacandidateoutlet setTitle:NSLocalizedString(@"RECRUIT A CANDIDATE", nil) forState:UIControlStateNormal];
    
    //_lblHomeDesc.text=NSLocalizedString(@"MOBILE EMPLOYMENT SOLUTION FOR THE HOSPITALITY INDUSTRY", @"");
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:_recruitacandidateoutlet.titleLabel.attributedText];
//    [attributedString.mutableString setString:NSLocalizedString(@"RECRUIT A CANDIDATE", nil)];
//
//    [_recruitacandidateoutlet setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Trouver un emploi action
- (IBAction)findajobaction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"S" forKey:@"currentUser"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    FindajobViewController *fjvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
    //fjvc.prevPlaceIdentifier=@"S";
    [self.navigationController pushViewController:fjvc animated:YES];
    
}
//Recruter un candidate method
- (IBAction)recritacandidate:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"R" forKey:@"currentUser"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    RecruiterConfirmViewController *rcvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterConfirmViewController"];
    [self.navigationController pushViewController:rcvc animated:YES];
    
}
@end
