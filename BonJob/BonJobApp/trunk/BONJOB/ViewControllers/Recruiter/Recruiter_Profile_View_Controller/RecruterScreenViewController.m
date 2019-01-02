//
//  RecruterScreenViewController.m
//  Recurterscreen
//
//  Created by Infoicon Technologies on 10/07/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruterScreenViewController.h"
#import "EditRecruterScreenViewController.h"
@interface RecruterScreenViewController ()<RecruiterProfileUpdatedDelegate,UIAlertViewDelegate>
{
    NSMutableDictionary *responseDictt;
}
@property (strong, nonatomic) IBOutlet UIButton *btnmodifymyprofile;
@end

@implementation RecruterScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SharedClass setBorderOnButton:_btnmodifymyprofile];
    _btnmodifymyprofile.backgroundColor=InternalButtonColor;
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"PROFILE", @"")];//NSLocalizedString(@"PROFILE", @"");
    [[self.tabBarController.tabBar.items objectAtIndex:4] setTitle:NSLocalizedString(@"PROFILE", @"")];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    self.lblCompanyName.textColor=InternalButtonColor;
    _lblRecruiterName.textColor=TitleColor;
    
    [_btnmodifymyprofile setTitle:NSLocalizedString(@"Edit my profile", @"") forState:UIControlStateNormal];
    
    [self getRecruiterProfile];
    [_viewImageBackground setHidden:YES];
    [_viewImageHolder setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMyOfferCount:) name:@"setrecruiteroffercount" object:nil];
    
    NSString *isAdmin =[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"is_admin"];
    
    if ([isAdmin intValue]==1)
    {
        [_btnmodifymyprofile setTitle:NSLocalizedString(@"Logout", @"Logout") forState:UIControlStateNormal];
    
    }
    else
    {
        UIButton *btnSettings=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btnSettings setImage:[UIImage imageNamed:@"SettingsFilled.png"] forState:UIControlStateNormal];
        [btnSettings addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *btnBarSettings=[[UIBarButtonItem alloc]initWithCustomView:btnSettings];
        self.navigationItem.rightBarButtonItem=btnBarSettings;
        [btnBarSettings setTintColor:InternalButtonColor];
    }

    
    // Do any additional setup after loading the view.
}

-(void)setMyOfferCount:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:1]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"]];
    }
}



- (IBAction)btnmodifymyprofileaction:(UIButton *)sender
{
    NSString *isAdmin=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"is_admin"];
    if ([isAdmin intValue]==1)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"BonJob" message:NSLocalizedString(@"Are you Sure to Logout ?", @"") delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alertView show];
    }
    else
    {
        EditRecruterScreenViewController *editVc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditRecruterScreenViewController"];
        editVc.hidesBottomBarWhenPushed=YES;
        editVc.DictProfile=responseDictt;
        editVc.delegate=self;
        [self.navigationController pushViewController:editVc animated:YES];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001)
    {
        if (buttonIndex==1)
        {
            //[self openMail];
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

-(void)recruiterProfileUpdated
{
    [self getRecruiterProfile];
}

- (IBAction)btnCloseImagePreview:(id)sender
{
    [_viewImageBackground setHidden:YES];
    [_viewImageHolder setHidden:YES];
    [SharedClass hidePopupView:_viewImageBackground andTabbar:self.tabBarController];
    [SharedClass hidePopupView:self.viewImageHolder];
}

- (IBAction)btnViewProfileImage:(id)sender
{
    [_viewImageBackground setHidden:NO];
    [_viewImageHolder setHidden:NO];
    [SharedClass showPopupView:_viewImageBackground andTabbar:self.tabBarController];
    [SharedClass showPopupView:self.viewImageHolder];
    _viewImageHolder.layer.cornerRadius=10;
    _imgViewProfilePic.layer.cornerRadius=10;
    _imgViewProfilePic.clipsToBounds=YES;
    NSString *userpicurl= [responseDictt valueForKey:@"user_pic"];
    [_imgViewProfilePic sd_setImageWithURL:[NSURL URLWithString:userpicurl] placeholderImage:kDefaultPlaceHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if(error)
         {
             [_imgViewProfilePic setImage:kDefaultPlaceHolder];
         }
    }];
    
}

- (void)settingButtonAction:(id)sender
{
    SettingsViewController *svc=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - ------Set Profile Data----------

-(void)setProfileData:(NSMutableDictionary *)response
{
    _lblCompanyName.text=[response valueForKey:@"enterprise_name"];
    _lblCompanyLocation.text=[response valueForKey:@"city"];
    _lblRecruiterName.text=[NSString stringWithFormat:@"%@ %@",[response valueForKey:@"first_name"],[response valueForKey:@"last_name"]];
    self.imgRecruiterPic.layer.borderColor=[UIColor lightGrayColor].CGColor;

    _imgRecruiterPic.layer.cornerRadius = _imgRecruiterPic.frame.size.width / 2;
 //   _imgRecruiterPic.clipsToBounds = YES;
    _imgRecruiterPic.layer.borderWidth=1.0;
    //_imgViewProfilePic.layer.borderColor=[UIColor colorWithRed:214/255.0 green:214/255.0 blue:217/255.0 alpha:1.0].CGColor;
  //  [_imgViewProfilePic.layer setBorderColor: [[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:0.5] CGColor]];


   // _imgViewProfilePic.layer.borderColor =  [UIColor lightGrayColor].cg;
    // [SharedClass colorWithHexString:@"#d6d6d9"].CGColor;
    __weak UIImageView *weakImageView = _imgRecruiterPic;
    NSString *userpicurl= [response valueForKey:@"user_pic"];
    if (userpicurl.length>0 && ([userpicurl.lastPathComponent containsString:@".png"] || [userpicurl.lastPathComponent containsString:@".jpg"]))
    {
        [_imgRecruiterPic sd_setImageWithURL:[NSURL URLWithString:userpicurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if (!error)
             {
                 weakImageView.alpha = 0.0;
                 weakImageView.image = image;
                 [UIView animateWithDuration:0.3
                                  animations:^
                  {
                      weakImageView.alpha = 1.0;
                      _imgRecruiterPic.layer.cornerRadius = _imgRecruiterPic.frame.size.width / 2;
                      _imgRecruiterPic.clipsToBounds = YES;
                      
                  }];
             }
             else
             {
                 [SharedClass showToast:self toastMsg:error.localizedDescription];
                 _imgRecruiterPic.image= [UIImage imageNamed:@"defaultPic.png"];
             }
             
             
         }];
    }
    else
    {
        _imgRecruiterPic.image=[UIImage imageNamed:@"defaultPic.png"];
    }
    __weak UIImageView *weakImageView2 = _imgEnterprisePic;
    NSString *enterpriseurl= [response valueForKey:@"enterprise_pic"];
    if (enterpriseurl.length>0 && ([enterpriseurl.lastPathComponent containsString:@".png"] || [enterpriseurl.lastPathComponent containsString:@".jpg"]))
    {
        [_imgEnterprisePic sd_setImageWithURL:[NSURL URLWithString:enterpriseurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if (!error)
             {
                 weakImageView2.alpha = 0.0;
                 weakImageView2.image = image;
                 [UIView animateWithDuration:0.3
                                  animations:^
                  {
                      weakImageView2.alpha = 1.0;
                  }];
             }
             else
             {
                 [SharedClass showToast:self toastMsg:error.localizedDescription];
                 _imgEnterprisePic.image=kDefaultPlaceHolder;
             }
         }];
    }
    else
    {
        _imgEnterprisePic.image=[UIImage imageNamed:@"defaultPic.png"];
    }

    
}

#pragma mark - ------Webservice Method for get Profile----------
-(void)getRecruiterProfile
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"getProfile";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:kRecruiterGetProfile methodName:@"getProfile" showHud:YES inWhichViewController:self];
}
-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([methodNameIs isEqualToString:@"getProfile"])
    {
        if ([[responseDict valueForKey:@"success"] intValue]==1)
        {
            [_viewBackground setHidden:YES];
            responseDictt=[[NSMutableDictionary alloc]init];
            responseDictt=[responseDict valueForKey:@"data"];
            responseDictt=[self validateDict:responseDictt];
            [self setProfileData:responseDictt];
            
        }
        else
        {
            [_viewBackground setHidden:NO];
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"logout"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
            {
                NSString *whichsegment = @"Inscription";
                ViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
              //  rvc.whichsegmentisshow = whichsegment;
                //rvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
                //APPDELEGATE.window.rootViewController=rvc;
                
                
                //FindajobViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:rvc];
                //            rvc.whichsegmentisshow = whichsegment;
                //            rvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
                APPDELEGATE.window.rootViewController=nav;
                
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
            {
                
                ViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
             //   [rvc setSegmentIndex:1];
                //APPDELEGATE.window.rootViewController=rvc;
                
                //FindajobViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FindajobViewController"];
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:rvc];
                //            rvc.whichsegmentisshow = whichsegment;
                //            rvc.segmentviewcontrolleroutlet.selectedSegmentIndex = -1;
                APPDELEGATE.window.rootViewController=nav;
                
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
            }
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"logined"];
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"SeekerLogined"];
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"RecLogined"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}
-(void)inProgress:(float)value
{
    
}

-(NSMutableDictionary *)validateDict:(NSMutableDictionary *)dict
{
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[dict mutableCopy];
    for (NSString *key in dict)
    {
        if ([[tempDict valueForKey:key]isKindOfClass:[NSNull class]])
        {
            [tempDict setValue:@"" forKey:key];
        }
    }
    return tempDict;
}
@end
