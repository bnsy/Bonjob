//
//  SettingsViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/6/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//
#import "FaqViewController.h"
#import "SettingsViewController.h"
#import "TermsPolicyViewController.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CheckSubscriptionViewController.h"
#import "RegistrationandLoginViewController.h"
#import "RecruiterLoginRegistraionViewController.h"
#import "FindajobViewController.h"
#import "RecruiterConfirmViewController.h"


@interface SettingsViewController ()<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
     [super viewDidLoad];
     _lblTerms.text=NSLocalizedString(@"Terms of Use", @"");
     _lblGiveOpinion.text=NSLocalizedString(@"Give my opinion", @"");
     _lblReceiveEmails.text=NSLocalizedString(@"Receive emails", @"");
    _lblReceiveNotification.text=NSLocalizedString(@"Receive notifications", @"");
    _lblFaq.text=NSLocalizedString(@"FAQ", @"");
    
    [SharedClass setBorderOnButton:self.btnsave];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"Settings", @"")]; //NSLocalizedString(@"Settings", @"");
    [self.btnsave setTitle:NSLocalizedString(@"Sign Out", @"") forState:UIControlStateNormal];
    [self.btnsave setBackgroundColor:InternalButtonColor];
    
    if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"email_notification"]intValue]==1)
    {
        [self.switchEmail setOn:YES];
    }
    else
    {
        [self.switchEmail setOn:NO];
    }
    if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"mobile_notification"]intValue]==1)
    {
        [self.switchNotification setOn:YES];
    }
    else
    {
        [self.switchNotification setOn:NO];
    }
    
    // FOR SUBSCRIPTION
    //[[NSUserDefaults standardUserDefaults]setObject:@"E" forKey:@"userType"];
    NSString *userType=[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"];
    
    // "E" is recruiter
    if ([userType isEqualToString:@"E"])
    {
        [_lblSubscription setHidden:NO];
        [_imgSubscription setHidden:NO];
        [_btnSubscription setHidden:NO];
    }
    else
    {
        [_lblSubscription setHidden:YES];
        [_imgSubscription setHidden:YES];
        [_btnSubscription setHidden:YES];
    }

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _btnsave.frame.size.height+_btnsave.frame.origin.y+20)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button ACtions

- (IBAction)btnGiveOpinionAction:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Donner mon opinion" message:@"Votre avis nous intéresse !\nContactez-nous par mail pour nous aider à améliorer l\'application." delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Envoyer email", @""), nil];
    alert.tag=1001;
    [alert show];
    
    
    
}



- (IBAction)switchEmailAction:(id)sender
{
    NSString *EmailOn;
    if ([self.switchEmail isOn])
    {
        EmailOn=@"1";
    }
    else
    {
        EmailOn=@"2";
    }
    
    //{"user_id":"3","email_notification"=>"1/2","mobile_notification"=>"1/2"}
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:EmailOn forKey:@"email_notification"];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"mobile_notification"] forKey:@"mobile_notification"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.delegate=self;
    webHelper.methodName=@"enableSetting";
    [webHelper webserviceHelper:params webServiceUrl:kEnableDisableEmail methodName:@"enableSetting" showHud:YES inWhichViewController:self];
}

- (IBAction)switchNotificationAction:(id)sender
{
    NSString *EmailOn;
    if ([self.switchNotification isOn])
    {
        EmailOn=@"1";
    }
    else
    {
        EmailOn=@"2";
    }
    
    //{"user_id":"3","email_notification"=>"1/2","mobile_notification"=>"1/2"}
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"email_notification"] forKey:@"email_notification"];
    [params setValue:EmailOn forKey:@"mobile_notification"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.delegate=self;
    webHelper.methodName=@"enableSetting";
    [webHelper webserviceHelper:params webServiceUrl:kEnableDisableEmail methodName:@"enableSetting" showHud:YES inWhichViewController:self];
}

-(void)openMail
{
    NSString *emailTitle = @"Donner mon opinion";
    // Email Content
    //NSString *messageBody = @"Votre avis nous intéresse !";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"contact@bonjob.co"];
    
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:@"" isHTML:NO];
        [mc setToRecipients:toRecipents];
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Veuillez configurer le courrier dans votre appareil"];
    }
    
}

-(void)inProgress:(float)value
{
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
        {
            NSString *whichsegment = @"Inscription";
            RegistrationandLoginViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationandLoginViewController"];
            rvc.whichsegmentisshow = whichsegment;
            rvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
 
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:rvc];
            
            APPDELEGATE.window.rootViewController=nav;
            
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
            
            RecruiterLoginRegistraionViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterLoginRegistraionViewController"];
            [rvc setSegmentIndex:0];
            //APPDELEGATE.window.rootViewController=rvc;
            
            //FindajobViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:rvc];
            //            rvc.whichsegmentisshow = whichsegment;
            //            rvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
            APPDELEGATE.window.rootViewController=nav;
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        //[self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    
    if ([methodNameIs isEqualToString:@"enableSetting"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            dict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] mutableCopy];
            [dict setValue:[dict valueForKey:@"user_id"] forKey:@"user_id"];
            [dict setValue:[dict valueForKey:@"username"] forKey:@"username"];
            [dict setValue:[dict valueForKey:@"last_name"] forKey:@"last_name"];
            [dict setValue:[dict valueForKey:@"email"] forKey:@"email"];
            [dict setValue:[dict valueForKey:@"first_name"] forKey:@"first_name"];
            [dict setValue:[dict valueForKey:@"authKey"] forKey:@"authKey"];
            [dict setValue:[dict valueForKey:@"mobile_number"] forKey:@"mobile_number"];
            [dict setValue:[[responseDict valueForKey:@"data"]valueForKey:@"email_notification"] forKey:@"email_notification"];
            [dict setValue:[[responseDict valueForKey:@"data"]valueForKey:@"mobile_notification"] forKey:@"mobile_notification"];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
//            [[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]setValue:[responseDict valueForKey:@"email_notification"] forKey:@"email_notification"];
//            [[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]setValue:[responseDict valueForKey:@"mobile_notification"] forKey:@"mobile_notification"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else
        {
            [Alerter.sharedInstance showWarningWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"logout"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
             
                ViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            
         NSArray *viewControllerArray = @[rvc];
                
                UINavigationController *nav=[[UINavigationController alloc]init];
                
                [nav setViewControllers:viewControllerArray animated:YES];
              
                APPDELEGATE.window.rootViewController=nav;
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
                
                
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
            {
                
                ViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
               // [rvc setSegmentIndex:0];
                //APPDELEGATE.window.rootViewController=rvc;
                
                //FindajobViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
               // FindajobViewController *fvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
                NSArray *viewControllerArray = @[rvc];
                UINavigationController *nav=[[UINavigationController alloc]init];
                
                [nav setViewControllers:viewControllerArray animated:YES];

                //            rvc.whichsegmentisshow = whichsegment;
                //            rvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
                APPDELEGATE.window.rootViewController=nav;
                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
            }
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"logined"];
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"SeekerLogined"];
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"RecLogined"];
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"AUTOLOGIN"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            //[Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            ViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            // [rvc setSegmentIndex:0];
            //APPDELEGATE.window.rootViewController=rvc;
            
            //FindajobViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
            // FindajobViewController *fvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
            NSArray *viewControllerArray = @[rvc];
            UINavigationController *nav=[[UINavigationController alloc]init];
            
            [nav setViewControllers:viewControllerArray animated:YES];
            
            //            rvc.whichsegmentisshow = whichsegment;
            //            rvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
            APPDELEGATE.window.rootViewController=nav;
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"logined"];
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"SeekerLogined"];
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"RecLogined"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"AUTOLOGIN"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
        
    }
}


- (IBAction)btnSaveAction:(id)sender
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"BonJob" message:NSLocalizedString(@"Are you Sure to Logout ?", @"") delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001)
    {
        if (buttonIndex==1)
        {
             [self openMail];
        }
       
    }
    else
    {
        if (buttonIndex==1)
        {
            
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.delegate=self;
            webHelper.methodName=@"logout";
            [webHelper webserviceHelper:params webServiceUrl:kLogoutUser methodName:@"logout" showHud:YES inWhichViewController:self];
        }
    }
    
}
- (IBAction)btnFaqAction:(id)sender
{
    FaqViewController *fvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FaqViewController"];
    [self.navigationController pushViewController:fvc animated:YES];
}

- (IBAction)btnLegalTermsAction:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Terms of Use", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Terms of Use", @""),NSLocalizedString(@"Privacy Policy", @""),
                            nil];
    
    popup.tag = 1;
    [popup showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TermsPolicyViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsPolicyViewController"];
    switch (buttonIndex)
    {
        case 0:
            //  [self termsofuse];
            tvc.identifier=@"terms";
            tvc.title=NSLocalizedString(@"Terms of Use", @"");
            [self.navigationController pushViewController:tvc animated:YES];
            break;
        case 1:
            //  [self privacypolicy];
            tvc.identifier=@"policy";
            tvc.title=NSLocalizedString(@"Privacy Policy", @"");
            [self.navigationController pushViewController:tvc animated:YES];
            break;
        default:
            break;
    }
}

- (IBAction)btnSubscriptionAction:(id)sender
{
    CheckSubscriptionViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CheckSubscriptionViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
