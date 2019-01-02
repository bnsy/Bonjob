//
//  RegistrationSocialVC.m
//  BONJOB
//
//  Created by VISHAL SETH on 13/09/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import "RegistrationSocialVC.h"
#import "ExperienceViewController.h"
#import "SelectLocationViewController.h"
#import "TermsPolicyViewController.h"
#import "SharedClass.h"
#import "WebserviceHelper.h"

@interface RegistrationSocialVC ()<locationSelectedDelegate,ExperienceDelegate,ProcessDataDelegate,EducationLevelDelegate>
{
    BOOL termsSelected;
    float latt,lang;
    NSArray *arrExperience;
    NSString *selectedEducationId;
}
@property (nonatomic) XMPPManager *xmppManager;
@end

@implementation RegistrationSocialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self setColoredLabel];
    
    // Do any additional setup after loading the view.
}
-(void)setUp{
    [SharedClass setBorderOnButton:_btnRegister];
    _txtEmail.placeholder = NSLocalizedString(@"Email", nil);
    _txtCity.placeholder = NSLocalizedString(@"City", nil);
    _lblTitle.text = NSLocalizedString(@"Add details", nil);
    [_btnRegister setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateNormal];
    
    NSLog(@"%@",_previousData);
    _emailViewConstant.constant = 0;
    _cityViewConstant.constant = 0;
    _experienceViewConstant.constant = 0;
    _trainingViewConstant.constant = 0;
    _fieldsViewConstant.constant = 0;
     [_viewEmail setHidden:YES];
     [_viewExperience setHidden:YES];
     [_viewCity setHidden:YES];
     [_viewTraining setHidden:YES];
    [_btnTraining setHidden:YES];
    _fieldView.frame = CGRectMake(_fieldView.frame.origin.x, _fieldView.frame.origin.y, _fieldView.frame.size.width, 0);
    if ([_previousData objectForKey:@"email"] == nil ||[_previousData[@"email"]  isEqual: @""]) {
       _emailViewConstant.constant = 54;
       _fieldView.frame = CGRectMake(_fieldView.frame.origin.x, _fieldView.frame.origin.y, _fieldView.frame.size.width, 54);
         [_viewEmail setHidden:NO];
    }
    if ([_previousData[@"city"] isEqual:@""] ||
        [_previousData objectForKey:@"city"] == nil) {
        _cityViewConstant.constant = 54;
         _fieldView.frame = CGRectMake(_fieldView.frame.origin.x, _fieldView.frame.origin.y, _fieldView.frame.size.width, _fieldView.frame.size.height + 54);
         [_viewCity setHidden:NO];
        
    }
    if([[_previousData objectForKey:@"user_type"] isEqual:@"seeker"])
    {
        _txtExperience.placeholder = NSLocalizedString(@"Experience", nil);
        _txtTraining.placeholder = NSLocalizedString(@"Specify Your Training", nil);
        if ([_previousData objectForKey:@"seeker_exp_count"] == nil ||![_previousData[@"seeker_exp_count"] intValue]) {
            _experienceViewConstant.constant = 54;
            _fieldView.frame = CGRectMake(_fieldView.frame.origin.x, _fieldView.frame.origin.y, _fieldView.frame.size.width, _fieldView.frame.size.height + 54);
             [_viewExperience setHidden:NO];
        }
        if ( [_previousData objectForKey:@"education_level_name"] == nil || [_previousData[@"education_level_name"] isEqual: @""] ) {
            _trainingViewConstant.constant = 54;
            _fieldView.frame = CGRectMake(_fieldView.frame.origin.x, _fieldView.frame.origin.y, _fieldView.frame.size.width, _fieldView.frame.size.height + 54);
             [_viewTraining setHidden:NO];
             [_btnTraining setHidden:NO];
        }
    }
    else
    {
        _txtExperience.placeholder=NSLocalizedString(@"Company Name", @"");
        _btnExperience.hidden = YES;
        _txtTraining.placeholder = NSLocalizedString(@"Phone number", nil);
        _txtTraining.keyboardType = UIKeyboardTypePhonePad;
        
        if ( [_previousData objectForKey:@"enterprise_name"] == nil || [_previousData[@"enterprise_name"]isEqual:@""]) {
            _experienceViewConstant.constant = 54;
            _fieldView.frame = CGRectMake(_fieldView.frame.origin.x, _fieldView.frame.origin.y, _fieldView.frame.size.width, _fieldView.frame.size.height + 54);
              [_viewExperience setHidden:NO];
        }
        if ( [_previousData objectForKey:@"mobile_number"] == nil || [_previousData[@"mobile_number"] isEqual: @""]) {
            _trainingViewConstant.constant = 54;
            _fieldView.frame = CGRectMake(_fieldView.frame.origin.x, _fieldView.frame.origin.y, _fieldView.frame.size.width, _fieldView.frame.size.height + 54);
              [_viewTraining setHidden:NO];
              [_btnTraining setHidden:YES];
        }
        
    }
   
    _fieldsViewConstant.constant = _fieldView.frame.size.height;
}
- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnExxperienceClicked:(id)sender
{
    ExperienceViewController *exvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ExperienceViewController"];
    exvc.delegate=self;
    exvc.isFromSignUp = YES;
    [self.navigationController pushViewController:exvc animated:YES];
}
- (IBAction)btnTrainingPressed:(UIButton *)sender
{
    SelectLevelofEducationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLevelofEducationViewController"];
    slvc.delegate=self;
    slvc.titled = @"LEVEL OF EDUCATION";
    [self.navigationController pushViewController:slvc animated:YES];
    
    
}
- (IBAction)btnCityClicked:(id)sender
{
    SelectLocationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
    slvc.delegate=self;
    [self.navigationController pushViewController:slvc animated:YES];
}
- (IBAction)btnRegisterClicked:(id)sender
{
    if ([self validate])
    {
        if (termsSelected)
        {
            NSMutableDictionary *params=[NSMutableDictionary new];
            [params setValue:@"" forKey:@"user_id"];
            if ([_previousData objectForKey:@"user_id"] != nil) {
                [params setValue:_previousData[@"user_id"] forKey:@"user_id"];
            }
            
            [params setValue:_previousData[@"fb_id"] forKey:@"fb_id"];
            [params setValue:_previousData[@"full_name"] forKey:@"full_name"];
            if ([_previousData objectForKey:@"email"] == nil || [[_previousData objectForKey:@"email"]  isEqual: @""]) {
              [params setValue:_txtEmail.text forKey:@"email"];
            }
            else{
                [params setValue:[_previousData objectForKey:@"email"] forKey:@"email"];
            }
            
            [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]
                      forKey:@"device_token"];
          
            [params setValue:[_previousData objectForKey:@"user_type"] forKey:@"user_type"];
            if ([_previousData objectForKey:@"city"] == nil || [[_previousData objectForKey:@"city"]  isEqual: @""]) {
            [params setValue:_txtCity.text forKey:@"city"];
            [params setValue:[NSString stringWithFormat:@"%f",latt] forKey:@"latitude"];
            [params setValue:[NSString stringWithFormat:@"%f",lang] forKey:@"longitude"];
            }
            if([[_previousData objectForKey:@"user_type"] isEqual:@"seeker"])
            {
            
             if ([_previousData objectForKey:@"education_level_name"] == nil || [[_previousData objectForKey:@"education_level_name"]  isEqual: @""]) {
            [params setValue:selectedEducationId forKey:@"education_level"];
             }
             if ([_previousData objectForKey:@"seeker_exp_count"] == nil || ![_previousData[@"seeker_exp_count"] intValue]) {
            [params setValue:arrExperience forKey:@"experience"];
             }
            }
            else{
                if ([_previousData objectForKey:@"enterprise_name"] == nil || [[_previousData objectForKey:@"enterprise_name"]  isEqual: @""]) {
                    [params setValue:_txtExperience.text forKey:@"enterprise_name"];
                }
                if ([_previousData objectForKey:@"mobile_number"] == nil || [[_previousData objectForKey:@"mobile_number"]  isEqual: @""]) {
                    [params setValue:_txtTraining.text forKey:@"mobile_number"];
                }
            }
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.methodName=@"facebookUser";
            webHelper.delegate=self;
              [webHelper webserviceHelper:params webServiceUrl:kFacebookAddUser methodName:@"facebookUser" showHud:YES inWhichViewController:self];
            
        }
        else
        {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Bonjob"
                                                           description:NSLocalizedString(@"Select Terms & Conditions", @"Select Terms & Conditions")
                                                                  type:TWMessageBarMessageTypeInfo
                                                        statusBarStyle:UIStatusBarStyleLightContent
                                                              callback:nil];
            
        }
    }
}

-(BOOL)validate
{
     if(([_previousData objectForKey:@"email"] == nil ||[_previousData[@"email"]  isEqual: @""]) && _txtEmail.text.length==0)
    {
        [SharedClass MakeAlert:_txtEmail];
        
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter email"];
        return NO;
    }
    else if(([_previousData objectForKey:@"email"] == nil ||[_previousData[@"email"]  isEqual: @""]) && _txtEmail.text.length != 0 && [self validateEmailWithString:_txtEmail.text]==NO)
    {
        [SharedClass MakeAlert:_txtEmail];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter valid email"];
        return NO;
    }
    
    else if(([_previousData objectForKey:@"city"] == nil ||[_previousData[@"city"]  isEqual: @""]) && _txtCity.text.length==0)
    {
        [SharedClass MakeAlert:_txtCity];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter city"];
        return NO;
    }
    
    if([[_previousData objectForKey:@"user_type"] isEqual:@"seeker"])
    {
     if(([_previousData objectForKey:@"seeker_exp_count"] == nil ||![_previousData[@"seeker_exp_count"] intValue]) && _txtExperience.text.length==0)
    {
        [SharedClass MakeAlert:_txtExperience];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter experience"];
        return NO;
    }
    else if(([_previousData objectForKey:@"education_level_name"] == nil ||[_previousData[@"education_level_name"]  isEqual: @""]) && _txtTraining.text.length==0)
    {
        [SharedClass MakeAlert:_txtTraining];
        [Alerter.sharedInstance showWarningWithMsg:@"Please specify your training"];
        return NO;
    }
    }
    else{
        if(([_previousData objectForKey:@"enterprise_name"] == nil ||[_previousData[@"enterprise_name"]  isEqual: @""]) && _txtExperience.text.length==0)
        {
            [SharedClass MakeAlert:_txtExperience];
            [Alerter.sharedInstance showWarningWithMsg:@"Please enter company name"];
            return NO;
        }
        else if(([_previousData objectForKey:@"mobile_number"] == nil ||[_previousData[@"mobile_number"]  isEqual: @""]) && _txtTraining.text.length==0)
        {
            [SharedClass MakeAlert:_txtTraining];
            [Alerter.sharedInstance showWarningWithMsg:@"Please enter phone number"];
            return NO;
        }
    }
    return YES;
    
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (IBAction)btnTermsLinkClicked:(id)sender
{
    TermsPolicyViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsPolicyViewController"];
    tvc.identifier=@"terms";
    tvc.title=NSLocalizedString(@"Terms of Use", @"");
    [self.navigationController pushViewController:tvc animated:YES];
}

- (IBAction)btnTC_Clicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (btn.isSelected)
    {
        [btn setSelected:NO];
        termsSelected=NO;
    }
    else
    {
        [btn setSelected:YES];
        termsSelected=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _lblterms.attributedText = attString;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Delegates

-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
    _txtCity.text = address;
    latt = lattitute;
    lang = Longitute;
}
-(void)ExperienceSelected:(NSArray *)arr
{
    arrExperience = [[NSArray alloc]initWithArray:arr];
    NSString *str = [NSString stringWithFormat:@"%@-%@",[[arr objectAtIndex:0] valueForKey:@"position_held_name"],[[arr objectAtIndex:0] valueForKey:@"company_name"]];
    if([str isEqualToString:@"-"])
    {
        str = @"No Company added";
    }
    _txtExperience.text = NSLocalizedString(str,@"");
    
}

-(void)levelofEducationSelected:(NSString *)education title:(NSString*)educationTitle screenTitle:(NSString*)titled
{
    if ([titled isEqualToString:@"LEVEL OF EDUCATION"]) {
        _txtTraining.text=educationTitle;
        selectedEducationId = education;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Webservice Process Delegate
-(void)inProgress:(float)value
{
    NSLog(@"UploadingValue=%f",value);
}

-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([methodNameIs isEqualToString:@"forgotpass"])
        {
            if ([[responseDict valueForKey:@"success"] boolValue]==1)
            {
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Bonjob"
                                                               description:[responseDict valueForKey:@"msg"]
                                                                      type:TWMessageBarMessageTypeSuccess
                                                            statusBarStyle:UIStatusBarStyleLightContent
                                                                  callback:nil];
            }
            else
            {
                [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            }
        }
    }
    else if ([methodNameIs isEqualToString:@"facebookUser"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
           // [self loginUserForChat];
            [self directHome:responseDict];
            
           
          
        }
        else
        {
            [Alerter.sharedInstance showWarningWithMsg:[responseDict valueForKey:@"msg"]];
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
