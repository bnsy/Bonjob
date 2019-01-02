//
//  HomeViewController.m
//  BONJOB
//
//  Created by Infoicon Technologies on 29/04/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "LookForJobViewController.h"

@interface HomeViewController ()
{
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"prevLogined"] isEqualToString:@"1"])
    {
        LookForJobViewController *lvc=[self.storyboard instantiateViewControllerWithIdentifier:@"LookForJobViewController"];
        [self.navigationController pushViewController:lvc animated:YES];
    }
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"prevLogined"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self setup];
    _secondviewforshow.translatesAutoresizingMaskIntoConstraints=YES;
    CGRect frame=_secondviewforshow.frame;
    frame.size.height=_lookingforajoboutlet.frame.size.height+_lookingforajoboutlet.frame.origin.y+5;
    frame.size.width=self.view.frame.size.width-20;
    frame.origin.x=10;
    frame.origin.y=_imgHeaderLogo.frame.origin.y+_imgHeaderLogo.frame.size.height+5;
    
    
    double screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        NSLog(@"All iPads");
    } else if (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPhone)
    {
        if(screenHeight == 480)
        {
            //NSLog(@"iPhone 4/4S");
            //smallFonts = true;
        } else if (screenHeight == 568) {
            NSLog(@"iPhone 5/5S/SE");
            //smallFonts = true;
           frame.size.height=_lookingforajoboutlet.frame.size.height+_lookingforajoboutlet.frame.origin.y+15; frame.origin.y=_imgHeaderLogo.frame.origin.y+_imgHeaderLogo.frame.size.height+30;
        } else if (screenHeight == 667) {
            //NSLog(@"iPhone 6/6S");
           frame.size.height=_lookingforajoboutlet.frame.size.height+_lookingforajoboutlet.frame.origin.y+15;
            frame.origin.y=_imgHeaderLogo.frame.origin.y+_imgHeaderLogo.frame.size.height+40;
        } else if (screenHeight == 736) {
            //NSLog(@"iPhone 6+, 6S+");
            
           frame.size.height=_lookingforajoboutlet.frame.size.height+_lookingforajoboutlet.frame.origin.y+15; frame.origin.y=_imgHeaderLogo.frame.origin.y+_imgHeaderLogo.frame.size.height+40;
        } else {
            //NSLog(@"Others");
        }
    }
    
  //  _secondviewforshow.frame=frame;
    //_secondviewforshow.center = _secondviewforshow.superview.center;
//    CGSize size = _secondviewforshow.superview.frame.size;
//    [_secondviewforshow setCenter:CGPointMake(size.width, size.height/2)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ------------Button Actions Here----------
- (IBAction)editmyprofileaction:(UIButton *)sender
{
    [self.tabBarController setSelectedIndex:4];
}

- (IBAction)addonebuttonaction:(UIButton *)sender
{
    
}

- (IBAction)indicateyourexpbuttonaction:(UIButton *)sender
{
    
}
- (IBAction)registeapitchvideoaction:(UIButton *)sender
{
    
}


- (IBAction)btnLookForJobAction:(id)sender
{
    
//    UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
    LookForJobViewController *lvc=[self.storyboard instantiateViewControllerWithIdentifier:@"LookForJobViewController"];
    [self.navigationController pushViewController:lvc animated:YES];
    //[self presentViewController:lvc animated:YES completion:nil];

}

#pragma mark - ----------Initial Setup------------
-(void)setup
{
    _secondviewforshow.center = self.view.center;
    _secondviewforshow.layer.cornerRadius = 10.0;
    
    _editmyprofileoutlet.layer.cornerRadius = 24.0;
    _lookingforajoboutlet.layer.cornerRadius = 24.0;
    _lookingforajoboutlet.layer.borderColor = InternalButtonColor.CGColor;
    _lookingforajoboutlet.layer.borderWidth = 2.0;
    
    UILabel *label1 = (UILabel *)[self.view viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Welcome", nil),[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"first_name"]];
    UILabel *label2 = (UILabel *)[self.view viewWithTag:2];
    label2.text = NSLocalizedString(@"BonJob is a free mobile service to connect with recruiters", nil);
    UILabel *label3 = (UILabel *)[self.view viewWithTag:3];
    label3.text = NSLocalizedString(@"To optimize your chances:", nil);
    UILabel *label4 = (UILabel *)[self.view viewWithTag:4];
    label4.text = NSLocalizedString(@"Add a Photo", nil);
    UILabel *label5 = (UILabel *)[self.view viewWithTag:5];
    label5.text = NSLocalizedString(@"Photo", nil);
    UILabel *label6 = (UILabel *)[self.view viewWithTag:6];
    label6.text = NSLocalizedString(@"Indicate your Experience", nil);
    UILabel *label7 = (UILabel *)[self.view viewWithTag:7];
    label7.text = NSLocalizedString(@"Experience", nil);
    UILabel *label8 = (UILabel *)[self.view viewWithTag:8];
    label8.text = NSLocalizedString(@"Record a Video Pitch", nil);
    UILabel *label9 = (UILabel *)[self.view viewWithTag:9];
    label9.text = NSLocalizedString(@"Pitch", nil);
    
    [_editmyprofileoutlet setTitle:NSLocalizedString(@"Edit my profile", nil) forState:UIControlStateNormal];
    [_lookingforajoboutlet setTitle:NSLocalizedString(@"Search jobs", nil) forState:UIControlStateNormal];
    
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:NSLocalizedString(@"SEARCH", @"")];
    
    [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:NSLocalizedString(@"MY OFFERS", @"")];
    
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:NSLocalizedString(@"CHAT", @"")];
    
    [[self.tabBarController.tabBar.items objectAtIndex:3] setTitle:NSLocalizedString(@"ACTIVITY", @"")];
    
    [[self.tabBarController.tabBar.items objectAtIndex:4] setTitle:NSLocalizedString(@"PROFILE", @"")];
    _editmyprofileoutlet.backgroundColor=InternalButtonColor;
    
}
@end
