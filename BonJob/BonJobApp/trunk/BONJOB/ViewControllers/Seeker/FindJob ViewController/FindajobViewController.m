//
//  FindajobViewController.m
//  BONJOB
//
//  Created by Infoicon Technologies on 01/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "FindajobViewController.h"
#import "RegistrationandLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "TermsPolicyViewController.h"
#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "RecruiterVerifyViewController.h"

@interface FindajobViewController ()
@property (nonatomic) XMPPManager *xmppManager;

@property (strong, nonatomic) IBOutlet UIButton *connectionviafboutlet;
@property (strong, nonatomic) IBOutlet UIButton *registrationlayout;
@property (strong, nonatomic) IBOutlet UIButton *connectionlayout;

@end

@implementation FindajobViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _prevPlaceIdentifier = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentUser"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    [SharedClass setBorderOnButton:_connectionviafboutlet];
    [SharedClass setBorderOnButton:_connectionlayout];
    [SharedClass setBorderOnButton:_registrationlayout];
    [_connectionviafboutlet setTitle:NSLocalizedString(@"Connect with Facebook", nil) forState:UIControlStateNormal];
    
    [_registrationlayout setTitle:NSLocalizedString(@"Sign Up", nil) forState:UIControlStateNormal];
    [_connectionlayout setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    
//    _conditionslabelforajob.text=NSLocalizedString(@"I have read and agree to the terms of use", @"");
    if ([self.prevPlaceIdentifier isEqualToString:@"R"])
    {
        self.imgLogin.image=[UIImage imageNamed:@"Recruiter.png"];
        _lblFindAjob.text=NSLocalizedString(@"Publish your job offer and find the right candidate in seconds", @"");
        [_lblFindAjob setAdjustsFontSizeToFitWidth:YES];
    }
    else
    {
        self.imgLogin.image=[UIImage imageNamed:@"login_img.png"];
       _lblFindAjob.text=NSLocalizedString(@"Find a job in the hospitality industry", nil);
    }
   // [self setColoredLabel];
    
    

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpToDashbaord:) name:@"OTPVERIFIED" object:nil];

}

- (void) setColoredLabel
{
    
    NSString *myString = NSLocalizedString(@"I have read and agree to the terms of use", @"");
    
    //Create mutable string from original one
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
    NSString *currentLang;
    currentLang = [[NSLocale preferredLanguages] objectAtIndex:0]; // code for get language code from device
    NSArray* foo = [currentLang componentsSeparatedByString: @"-"];
    currentLang = [foo objectAtIndex: 0];
    NSRange range;
    if (([currentLang isEqualToString:@"fr"]))
    {
        range = [myString rangeOfString:@"conditions d'utilisation"];
    }
    else
    {
        range = [myString rangeOfString:@"I have read and accept the"];
    }
    //I have read and accept the
    
    [attString addAttribute:NSForegroundColorAttributeName value:TitleColor range:range];
    
    //Add it to the label - notice its not text property but it's attributeText
    _lblTermsCondition.attributedText = attString;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -----------Button Actions------------

- (IBAction)connectionviefb:(UIButton *)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login self];
    if ([UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"fb://"]])
    {
       login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    }
    
    [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error)
        {
            
            NSLog(@"Unexpected login error: %@", error);
            NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
            NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
            [[[UIAlertView alloc] initWithTitle:alertTitle
                                        message:alertMessage
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
        else
        {
            if(result.token)   // This means if There is current access token.
            {
               
                

                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                   parameters:@{@"fields": @"picture, name, email"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id userinfo, NSError *error) {
                     if (!error)
                     {
                         
                         [self SocialLogin:userinfo];

                         /*dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                         dispatch_async(queue, ^(void) {
                             
                             dispatch_async(dispatch_get_main_queue(),
                            ^{
                                 
                                 // you are authorised and can access user data from user info object
                                 
                             });
                         });*/
                         
                     }
                     else{
                         
                         NSLog(@"%@", [error localizedDescription]);
                     }
                 }];
            }
            NSLog(@"Login Cancel");
        }
    }];
   
      [login logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
   


 }

-(void)SocialLogin:(id)userDict
{
    //{"full_name":"Pavan Pandey","user_type":"employer","email":"pkp@mail.com","fb_id":"12312wsadsadasd23"}
    NSDictionary *uDict=(NSDictionary *)userDict;
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    if ([self.prevPlaceIdentifier isEqualToString:@"S"])
    {
       [params setValue:@"seeker" forKey:@"user_type"];
    }
    else
    {
        [params setValue:@"employer" forKey:@"user_type"];
    }
    [params setValue:[uDict valueForKey:@"name"] forKey:@"full_name"];
    [params setValue:[uDict valueForKey:@"email"] forKey:@"email"];
    [params setValue:[uDict valueForKey:@"id"] forKey:@"fb_id"];
//      [params setValue:@"dgfdgsd243df@gmail.com" forKey:@"email"];
//     [params setValue:@"54fghfgs343hfghdf" forKey:@"fb_id"];
    [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"] forKey:@"device_token"];
    
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"socialLogin";
    webHelper.delegate=self;
    [webHelper webserviceHelper:params webServiceUrl:kFacebookLogin methodName:@"socialLogin" showHud:YES inWhichViewController:self];

}


- (IBAction)registrationaction:(UIButton *)sender
{
    if ([self.prevPlaceIdentifier isEqualToString:@"S"])
    {
        whichsegment = @"Inscription";
        RegistrationandLoginViewController *ralvc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationandLoginViewController"];
        ralvc.whichsegmentisshow = whichsegment;
        ralvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
        [self.navigationController pushViewController:ralvc animated:YES];
    }
    else
    {
        RecruiterLoginRegistraionViewController *rlvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterLoginRegistraionViewController"];
        [rlvc setSegmentIndex:0];
        [self.navigationController pushViewController:rlvc animated:YES];
    }
}

- (IBAction)coneectionaction:(UIButton *)sender
{
    if ([self.prevPlaceIdentifier isEqualToString:@"S"])
    {
        whichsegment = @"Connexion";
        RegistrationandLoginViewController *ralvc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationandLoginViewController"];
        ralvc.whichsegmentisshow = whichsegment;
        ralvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
        [self.navigationController pushViewController:ralvc animated:YES];
    }
    else
    {
        RecruiterLoginRegistraionViewController *rlvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterLoginRegistraionViewController"];
        [rlvc setSegmentIndex:1];
        [self.navigationController pushViewController:rlvc animated:YES];
    }
}

#pragma mark - ---------Webservice response------------
-(void)jumpToDashbaord:(id)notification
{
    UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
    vc.tabBar.translucent = NO;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //[self presentViewController:vc animated:YES completion:nil];
    
    APPDELEGATE.window.rootViewController=vc;
}
-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
        {
           // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
            //[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
          //  [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
          //  [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([methodNameIs isEqualToString:@"socialLogin"])
    {
        
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            
            if ([[responseDict valueForKey:@"register"]  isEqual: @"2"]) {
                [self directHome:responseDict];
                
            }
            else
            {
                RegistrationSocialVC *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationSocialVC"];
            
                tvc.previousData =  [[[responseDict valueForKey:@"data"] objectAtIndex:0] mutableCopy];
                tvc.prevPlaceIdentifier = _prevPlaceIdentifier;
                [self.navigationController pushViewController:tvc animated:YES];
            }
        }
        else
        {
           [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}

-(void)directHome:(NSDictionary*)responseDict
{
    [[NSUserDefaults standardUserDefaults]setValue:[[responseDict valueForKey:@"data"] objectAtIndex:0] forKey:@"userData"];
                 [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"prevLogined"] forKey:@"prevLogined"];
             [self loginUserForChat];
                [[NSUserDefaults standardUserDefaults]synchronize];
                if ([self.prevPlaceIdentifier isEqualToString:@"R"])
                {
    
    
                      [[NSUserDefaults standardUserDefaults]setObject:@"E" forKey:@"userType"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"R" forKey:@"AUTOLOGIN"];
    
                    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
                        UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
                        vc.tabBar.translucent = NO;
    
                        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
    
    
                        APPDELEGATE.window.rootViewController=vc;
    
    
                }
                else
                {
                    UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
                      [[NSUserDefaults standardUserDefaults]setObject:@"S" forKey:@"userType"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"S" forKey:@"AUTOLOGIN"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    vc.tabBar.translucent = NO;
                    APPDELEGATE.window.rootViewController=vc;
    
                }
}

-(void)inProgress:(float)value
{
    
}
- (IBAction)btnTermsAction:(id)sender
{
    TermsPolicyViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsPolicyViewController"];
    tvc.identifier=@"terms";
    tvc.title=NSLocalizedString(@"Terms of Use", @"");
    [self.navigationController pushViewController:tvc animated:YES];
}

#pragma mark- Chat Login

-(void)loginUserForChat
{
    
    NSString *userName=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"];
    
    NSString *strUserName=[NSString stringWithFormat:@"bonjob_%@@%@",userName,kDefaultChatServer];
    
    //NSString *strPassword=[NSString stringWithFormat:@"bonjob_%@",userName];
    NSString *strPassword=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"chat_password"];
    
    NSString* chatUser=strUserName;//@"bonjob_54@172.104.8.51";
    //NSString* chatUser=@"bonjob_2";
    NSString* password=strPassword;//@"bonjob_54";
    NSLog(@"Password=%@",password);
    
    //    NSString* chatUser=@"bonjob_42@172.104.8.51";
    //    //NSString* chatUser=@"bonjob_1";
    //    NSString* password=@"bonjob_42";
    [self setChatUserWithName:chatUser pass:password];
    
    BOOL connected = NO;
    
    if([chatUser isEqualToString:@""])
    {
        
    }
    else
    {
        self.xmppManager =[XMPPManager sharedManager];
        [self.xmppManager connect];
    }
    //[[self appDelegate] disconnect];
    
    //connected = [[self appDelegate] connect];
    NSLog(@"*** %@ = connected = %i",chatUser, connected);
    
}

-(void)setChatUserWithName:(NSString*)name pass:(NSString*)pass
{
    
    name=!name ? @"": name;
    pass=!pass ? @"": pass;
    
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setObject:pass forKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
@end