//
//  RecruiterLoginRegistraionViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/19/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterLoginRegistraionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "SelectLocationViewController.h"
#import "TermsPolicyViewController.h"
#import "RecruiterVerifyViewController.h"
#import "ImageCropperViewController.h"
@interface RecruiterLoginRegistraionViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate,locationSelectedDelegate,UIAlertViewDelegate,ImageCropperDelegate>
{
    BOOL imageSelected,PitchVideoSelected,ImageEnterProseSelected,TermsSelected;
    NSData *videoData;
    UIImagePickerController *imagePicker;
    NSData *imgData;
    NSData *imgEnterPriseData;
    float latti,longi;
    NSData *thumbnailData;
    BOOL isEnterPrisePhoto;
}
@end

@implementation RecruiterLoginRegistraionViewController

#pragma mark - ---------View Life Cycle Methods-------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self setDualLanguage];
    //[self setColoredLabel];
    _txtLoginEmail.text=@"";
    _txtLoginPassword.text=@"";
    self.navigation.backBarButtonItem.title=@"";
    _txtLocation.delegate=self;
    _txtLoginEmail.text=@"vishal@infoicon.com";
    _txtLoginPassword.text=@"123456";
    self.viewVideoGuidePopup.layer.cornerRadius=15;
    [self.viewVideoGuidePopup setHidden:YES];
    [self.viewDimBackground setHidden:YES];
    self.navigationController.navigationBar.topItem.title = @"";
    [_btnForgotPassword setTitle:NSLocalizedString(@"Forgot your password ?", @"") forState:UIControlStateNormal];
    _txtLoginEmail.text=@"";
    _txtLoginPassword.text=@"";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(isComingFromMap) {
        
        _SegmentIndex = 0;
    }
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpToDashbaord:) name:@"OTPVERIFIED" object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[_scrollMain setContentSize:CGSizeMake(self.view.frame.size.width, _viewSIgnup.frame.size.height+_viewSIgnup.frame.origin.y+80)];
    
    
    if (_SegmentIndex == 0)
    {
        //toggle the correct view to be visible
        [_viewLogin setHidden:YES];
        [_viewSIgnup setHidden:NO];

        _viewSIgnup.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=_viewSIgnup.frame;
        frame.size.height=_btnSignup.frame.size.height+_btnSignup.frame.origin.y+40;
        _viewSIgnup.frame=frame;
       // [_scrollMain setContentSize:CGSizeMake(_scrollMain.frame.size.width, _viewSIgnup.frame.size.height+_viewSIgnup.frame.origin.y+100)];

    }
    else
    {
        //toggle the correct view to be visible
        [_viewLogin setHidden:NO];
        [_viewSIgnup setHidden:YES];

        //self.segmentControl.selectedSegmentIndex=self.SegmentIndex;
       // [self segmentSwitch:self.segmentControl];

        _viewLogin.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=_viewLogin.frame;
        frame.size.height=_btnForgotPassword.frame.size.height+_btnForgotPassword.frame.origin.y+40;
        _viewLogin.frame=frame;


        //[_scrollMain setContentSize:CGSizeMake(_scrollMain.frame.size.width, _viewLogin.frame.size.height+20)];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ----Textfield Delegate----

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_txtLocation)
    {
        [self.view endEditing:YES];
        [_txtLocation resignFirstResponder];
        SelectLocationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
        isComingFromMap = YES;
        slvc.delegate=self;
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        [self.navigationController pushViewController:slvc animated:YES];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (([textField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].location != NSNotFound && textField == _txtEmail) || ([textField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].location != NSNotFound && textField == _txtPassword)) {
        return NO;
    }
    
    if ((textField == _txtEmail) || (textField == _txtLoginEmail)  || (textField == _txtLoginPassword) || (textField == _txtPassword) || (textField == _txtName) || (textField == _txtSurName) ||(textField == _txtCompanyName)) {
        
        // do not allow the first character to be space | do not allow more than one space
        if ([string isEqualToString:@" "]) {
            if (!textField.text.length)
                return NO;
            if (range.location == 0) {
                return NO;
            }
            if ((range.length == 0 && textField == _txtEmail) || (range.length == 0 && textField == _txtPassword) || (range.length == 0 && textField == _txtLoginEmail) || (range.length == 0 && textField == _txtLoginPassword) ) {
                return NO;
            }
            
            if ([[textField.text stringByReplacingCharactersInRange:range withString:string] rangeOfString:@"  "].length)
                return NO;
            
        }
    }
    
    return YES;
}
#pragma mark - ----Location Selection Delegate----

-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
    _txtLocation.text=address;
    latti=lattitute;
    longi=Longitute;
}



#pragma mark - Custom methods

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
    _lblTermsConditions.attributedText = attString;
}





-(void)setup
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [SharedClass setBorderOnButton:self.btnLogin];
    [SharedClass setBorderOnButton:self.btnSignup];
    [_segmentControl setSelectedSegmentIndex:_SegmentIndex];
    [_segmentControl setTitle:NSLocalizedString(@"Sign Up", @"") forSegmentAtIndex:0];
    [_segmentControl setTitle:NSLocalizedString(@"Login", @"") forSegmentAtIndex:1];
    if (_SegmentIndex == 0)
    {
        //toggle the correct view to be visible
        [_viewLogin setHidden:YES];
        [_viewSIgnup setHidden:NO];
    }
    else
    {
        //toggle the correct view to be visible
        [_viewLogin setHidden:NO];
        [_viewSIgnup setHidden:YES];
    }
    
    _txtEmail.placeholder=NSLocalizedString(@"E-mail", @"");
    _txtPassword.placeholder=NSLocalizedString(@"Password", @"");
    [_btnLogin setTitle:NSLocalizedString(@"Login", @"") forState:UIControlStateNormal];
    [_btnSignup setTitle:NSLocalizedString(@"Sign Up", @"") forState:UIControlStateNormal];
    _txtName.placeholder=NSLocalizedString(@"First name", @"");
    _txtSurName.placeholder=NSLocalizedString(@"Name", @"");;
    _txtCompanyName.placeholder=NSLocalizedString(@"Company Name", @"");
    _txtLocation.placeholder=NSLocalizedString(@"Location", @"");;
    _txtEmail.placeholder=NSLocalizedString(@"E-mail", @"");
    _txtPassword.placeholder=NSLocalizedString(@"Password", @"");
    _lblTermsConditions.text=NSLocalizedString(@"I have read and agree to the terms of use", @"");
    _lblPhoto.text=NSLocalizedString(@"+ PHOTO", @"");
    _lblPhotoEnterprise.text=NSLocalizedString(@"+ COMPANY PHOTO", @"");
    _lblPitchVideo.text=NSLocalizedString(@"+ VIDEO PITCH", @"");
    _txtLoginEmail.placeholder=NSLocalizedString(@"E-mail", @"");
    _txtLoginPassword.placeholder=NSLocalizedString(@"Password", @"");
//    [_txtEmail setEmailField:YES];
//    [_txtPassword setPasswordField:YES];
//    [_txtName setNameField:YES];
//    [_txtSurName setNameField:YES];
//    [_txtLoginEmail setEmailField:YES];
//    [_txtLoginPassword setPasswordField:YES];
    [_btnLogin setBackgroundColor:InternalButtonColor];
    [_btnSignup setBackgroundColor:InternalButtonColor];
    self.navigationController.navigationBar.tintColor = ButtonTitleColor;
    //self.navigationController.navigationBar.topItem.title = @"";
    //self.navigationItem.backBarButtonItem.title=@"";
    _btnLogin.backgroundColor=InternalButtonColor;
    [self.navigationItem.backBarButtonItem setTitle:NSLocalizedString(@"Back", @"")];
    
}

-(void)setDualLanguage
{
    
}

-(void)resetRegisterField
{
    _txtName.text=@"";
    _txtSurName.text=@"";
    _txtCompanyName.text=@"";
    _txtLocation.text=@"";
    _txtEmail.text=@"";
    _txtPassword.text=@"";
    _txtPhonenumber.text=@"";
    [_btnAcpet setSelected:NO];
    TermsSelected =NO;
    
    
}

-(BOOL)validateRegister
{
    if (_txtName.text.length==0)
    {
        [SharedClass MakeAlert:_txtName];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter name"];
        return NO;
    }
    else if(_txtName.text.length==0)
    {
        [SharedClass MakeAlert:_txtName];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter name"];
        return NO;
    }
    else if(_txtSurName.text.length==0)
    {
        [SharedClass MakeAlert:_txtSurName];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter last name"];
        return NO;
    }
    else if(_txtCompanyName.text.length==0)
    {
        [SharedClass MakeAlert:_txtCompanyName];
         [Alerter.sharedInstance showWarningWithMsg:@"Please enter company name"];
        return NO;
    }
    else if(_txtLocation.text.length==0)
    {
        [SharedClass MakeAlert:_txtLocation];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter location"];
        return NO;
    }
    else if(_txtEmail.text.length==0)
    {
        [SharedClass MakeAlert:_txtEmail];
      
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter email"];
        return NO;
    }
    else if(_txtPhonenumber.text.length==0)
    {
        [SharedClass MakeAlert:_txtPhonenumber];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter phone number"];
        return NO;
    }
    else if([self validateEmailWithString:_txtEmail.text]==NO)
    {
        [SharedClass MakeAlert:_txtEmail];
         [Alerter.sharedInstance showWarningWithMsg:@"Please enter valid email"];
        return NO;
    }
    else if(_txtPassword.text.length<6)
    {
        [SharedClass MakeAlert:_txtPassword];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter password"];
        return NO;
    }
    else
    {
        return YES;
    }
    return NO;
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(BOOL)validateLogin
{
    if ([self validateEmailWithString:_txtLoginEmail.text]==NO)
    {
        [SharedClass MakeAlert:_txtLoginEmail];
        [Alerter.sharedInstance showInfoWithMsg:@"Please enter valid email"];
        return NO;
    }
    else if ([_txtLoginEmail.text length]==0)
    {
        [SharedClass MakeAlert:_txtLoginEmail];
       
        [Alerter.sharedInstance showInfoWithMsg:@"Please enter email"];
        return NO;
    }
    else if (_txtLoginPassword.text.length==0)
    {
        [SharedClass MakeAlert:_txtLoginPassword];
         [Alerter.sharedInstance showInfoWithMsg:@"Please enter password"];
        return NO;
    }
    return YES;
}

#pragma mark - ---------Button Actions-------------

- (IBAction)btnForgotPasswordAction:(id)sender
{
    
    UIAlertView *myView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Forgot your password ?", @"") message:NSLocalizedString(@"Enter your email address", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Ok", @""), nil];
    myView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [myView textFieldAtIndex:0].delegate = self;
    [myView show];
    
}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Make sure the button they clicked wasn't Cancel
    if (buttonIndex == alertView.firstOtherButtonIndex)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if (textField.text.length>0 && [self NSStringIsValidEmail:textField.text])
        {
            NSMutableDictionary *params=[NSMutableDictionary new];
            [params setValue:textField.text forKey:@"email"];
            
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.methodName=@"forgotpass";
            webHelper.delegate=self;
            NSString *url=[NSString stringWithFormat:@"%@",kEmpForgotPassword];
            [webHelper webserviceHelper:params webServiceUrl:url methodName:@"forgotpass" showHud:YES inWhichViewController:self];
        }
        else
        {
            [self btnForgotPasswordAction:nil];
        }
        NSLog(@"%@", textField.text);
    }
}

- (IBAction)segmentSwitch:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0)
    {
        //toggle the correct view to be visible
        [_viewLogin setHidden:YES];
        [_viewSIgnup setHidden:NO];
        //[_scrollMain setContentSize:CGSizeMake(_scrollMain.frame.size.width, _viewSIgnup.frame.size.height)];
    }
    else
    {
        //toggle the correct view to be visible
        [_viewLogin setHidden:NO];
        [_viewSIgnup setHidden:YES];
       // [_scrollMain setContentSize:CGSizeMake(_scrollMain.frame.size.width, _viewLogin.frame.size.height)];
    }
}



- (IBAction)btnSinupAction:(id)sender
{
    [self signup];
}

- (IBAction)btnLoginAction:(id)sender
{
    [self signIn];
    /*UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
     vc.tabBar.translucent = NO;
     [self presentViewController:vc animated:YES completion:nil];
     */
    
}

- (IBAction)btnPhotoAction:(id)sender
{
//    [QMImagePicker chooseSourceTypeInVC:self allowsEditing:YES isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL)
//     {
//         imageSelected=YES;
//         _imgUser.image = image;
//         imgData= UIImageJPEGRepresentation(_imgUser.image, 0.6);
//         self.imgUser.layer.cornerRadius = self.imgPitchVideo.frame.size.width / 2;
//         self.imgUser.clipsToBounds = YES;
//     }];
    isEnterPrisePhoto = NO;
    NSString *other2=NSLocalizedString(@"Take a picture", nil);
    
    NSString *other1 = NSLocalizedString(@"Choose from gallery", nil);
    
    NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1,other2, nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (IBAction)btnPhotoEnterPriseAction:(id)sender
{
     isEnterPrisePhoto = YES;
    NSString *other2=NSLocalizedString(@"Take a picture", nil);
    
    NSString *other1 = NSLocalizedString(@"Choose from gallery", nil);
    
    NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1,other2, nil];
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
    
//    [QMImagePicker chooseSourceTypeInVC:self allowsEditing:NO isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL)
//     {
//
//
//         ImageCropperViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ImageCropperViewController"];
//         vc.selectedImage=image;
//         vc.delegate=self;
//         [self presentViewController:vc animated:YES completion:nil];
//
//
//     }];
    
}

-(void)rectunglarImage:(UIImage *)croppedImage
{
    ImageEnterProseSelected=YES;
    _imgPhotoEnterPrise.image = croppedImage;
    imgEnterPriseData= UIImageJPEGRepresentation(_imgPhotoEnterPrise.image, 0.8);
    self.imgPhotoEnterPrise.layer.cornerRadius = self.imgPitchVideo.frame.size.width / 2;
    self.imgPhotoEnterPrise.clipsToBounds = YES;
}

- (IBAction)btnVideoAction:(id)sender
{
    //    NSString *alreadyShowed=[[NSUserDefaults standardUserDefaults] valueForKey:@"videopopup"];
    //    if ([alreadyShowed isEqualToString:@"yes"])
    // {
    [self openActionSheet:YES isPhoto:NO];
    //    }
    //    else
    //    {
    //        [self.viewVideoGuidePopup setHidden:NO];
    //        [self.viewDimBackground setHidden:NO];
    //        [SharedClass showPopupView:self.viewDimBackground andTabbar:nil];
    //        [SharedClass showPopupView:self.viewVideoGuidePopup];
    //    }
    //[self openActionSheet:YES isPhoto:NO];
}

- (IBAction)btnTermsConditionsAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if ([btn isSelected])
    {
        [btn setSelected:NO];
        TermsSelected =NO;
    }
    else
    {
        [btn setSelected:YES];
        TermsSelected=YES;
    }
}

- (IBAction)btnTermsAction:(id)sender
{
    
    TermsPolicyViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsPolicyViewController"];
    tvc.identifier=@"terms";
    tvc.title=NSLocalizedString(@"Terms of Use", @"");
    [self.navigationController pushViewController:tvc animated:YES];
    
}

#pragma mark - -------WebService for Signup & Signin-------
-(void)signup
{
    
    if ([self validateRegister])
    {
        if (TermsSelected)
        {
            NSMutableDictionary *params=[NSMutableDictionary new];
            [params setValue:_txtName.text forKey:@"first_name"];
            [params setValue:_txtSurName.text forKey:@"last_name"];
            [params setValue:_txtEmail.text forKey:@"email"];
            [params setValue:_txtCompanyName.text forKey:@"enterprise_name"];
            [params setValue:_txtLocation.text forKey:@"address"];
            [params setValue:_txtPassword.text forKey:@"password"];
            [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]
                      forKey:@"device_token"];
            [params setValue:@"employer" forKey:@"user_type"];
            [params setValue:[NSString stringWithFormat:@"%f",latti] forKey:@"company_lat"];
            [params setValue:[NSString stringWithFormat:@"%f",longi] forKey:@"company_long"];
            [params setValue:_txtPhonenumber.text forKey:@"mobile"];
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.methodName=@"signup";
            webHelper.delegate=self;
            if (PitchVideoSelected && imageSelected && ImageEnterProseSelected)
            {
                [webHelper webserviceHelper:params uploadData:imgData ImageParam:@"user_pic" EnterPriseImage:imgEnterPriseData andVideoData:videoData withVideoThumbnail:thumbnailData  type:@".mp4" webServiceUrl:kRecruiterRegister methodName:@"signup" showHud:YES inWhichViewController:self];
            }
            else if (PitchVideoSelected && imageSelected)
            {
                [webHelper webserviceHelper:params uploadData:imgData ImageParam:@"user_pic" EnterPriseImage:nil andVideoData:videoData withVideoThumbnail:thumbnailData  type:@".mp4" webServiceUrl:kRecruiterRegister methodName:@"signup" showHud:YES inWhichViewController:self];
            }
            else if (PitchVideoSelected && ImageEnterProseSelected)
            {
                [webHelper webserviceHelper:params uploadData:nil ImageParam:@"user_pic" EnterPriseImage:imgEnterPriseData andVideoData:videoData withVideoThumbnail:thumbnailData  type:@".mp4" webServiceUrl:kRecruiterRegister methodName:@"signup" showHud:YES inWhichViewController:self];
            }
            else if (imageSelected && ImageEnterProseSelected)
            {
                [webHelper webserviceHelper:params uploadData:imgData ImageParam:@"user_pic" EnterPriseImage:imgEnterPriseData andVideoData:nil withVideoThumbnail:nil  type:@".mp4" webServiceUrl:kRecruiterRegister methodName:@"signup" showHud:YES inWhichViewController:self];
            }
            else
            {
                [webHelper webserviceHelper:params webServiceUrl:kRecruiterRegister methodName:@"signup" showHud:YES inWhichViewController:self];
            }
            
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
-(void)signIn
{
    if ([self validateLogin])
    {
        NSMutableDictionary *params=[NSMutableDictionary new];
        [params setValue:_txtLoginEmail.text forKey:@"email"];
        [params setValue:_txtLoginPassword.text forKey:@"password"];
        [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"] forKey:@"device_token"];
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.methodName=@"login";
        webHelper.delegate=self;
        NSString *url=[NSString stringWithFormat:@"%@",kRecruiterLogin];
        [webHelper webserviceHelper:params webServiceUrl:url methodName:@"login" showHud:YES inWhichViewController:self];
        
    }
}



#pragma mark - -------WebService Response for Signup & Signin-------

-(void)jumpToDashbaord:(id)notification
{
    UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
    vc.tabBar.translucent = NO;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    APPDELEGATE.window.rootViewController=vc;
}

-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
        {
            //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
            //[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
            //[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
            //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
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
    else if ([methodNameIs isEqualToString:@"login"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            NSString *msg=[NSString stringWithFormat:@"%@ %@ %@",NSLocalizedString(@"Welcome", @""),[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"first_name"],[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"last_name"]];
            [Alerter.sharedInstance ShowSuccessWithMsg:msg];
            [[NSUserDefaults standardUserDefaults]setObject:[[responseDict valueForKey:@"data"] objectAtIndex:0] forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults]setObject:@"E" forKey:@"userType"];
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];

             [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"prevLogined"] forKey:@"prevLogined"];
            [[NSUserDefaults standardUserDefaults]setObject:@"R" forKey:@"AUTOLOGIN"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
          //  if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"mobile_number"] length]>=3)
         //   {
                
                UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
                vc.tabBar.translucent = NO;
                
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                APPDELEGATE.window.rootViewController=vc;
                if ([[NSString stringWithFormat:@"%@",[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"is_admin"]]isEqualToString:@"1"])
                {
                    [vc setSelectedIndex:2];
                    
                     [[NSUserDefaults standardUserDefaults]setObject:@"A" forKey:@"AUTOLOGIN"];
                     [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    
                    [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
                    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
                    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
                    
                    
                    
                }
                
            //}
//            else
//            {
//                RecruiterVerifyViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterVerifyViewController"];
//                [self presentViewController:rvc animated:YES completion:nil];
//            }
            
            
            
            
            
            
            
            //[self presentViewController:vc animated:YES completion:nil];
            
            
            [self loginUserForChat];
            _txtLoginEmail.text=@"";
            _txtLoginPassword.text=@"";
            
            
            
            
        }
        else
        {
            [Alerter.sharedInstance showWarningWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"signup"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            [self resetRegisterField];
            [self.segmentControl setSelectedSegmentIndex:1];
            _imgUser.image = [UIImage imageNamed:@"blue_user.png"];
            _imgPhotoEnterPrise.image = [UIImage imageNamed:@"blue_home.png"];
            _imgPitchVideo.image = [UIImage imageNamed:@"blue_play.png"];
            [_viewLogin setHidden:NO];
            [_viewSIgnup setHidden:YES];
            /*
            if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"mobile_number"] length]>=3)
            {
                [self.segmentControl setSelectedSegmentIndex:1];
                [_viewLogin setHidden:NO];
                [_viewSIgnup setHidden:YES];
                [self resetRegisterField];
                
                UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
                vc.tabBar.translucent = NO;
                
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                APPDELEGATE.window.rootViewController=vc;
                
            }
            else
            {
             */
//                [self resetRegisterField];
//                RecruiterVerifyViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterVerifyViewController"];
//            //By CS Rai
//            [[NSUserDefaults standardUserDefaults]setObject:[[responseDict valueForKey:@"data"] objectAtIndex:0] forKey:@"userData"];
//
//            // Set User type as E (Recruiter) in NSUserDefault
//            [[NSUserDefaults standardUserDefaults]setObject:@"E" forKey:@"userType"];
//            [[NSUserDefaults standardUserDefaults]setObject:@"R" forKey:@"AUTOLOGIN"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//
//                [self presentViewController:rvc animated:YES completion:nil];
            //}
            
            
        }
        else
        {
            [Alerter.sharedInstance showWarningWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        
    }
}
-(void)inProgress:(float)value
{
    
}


//-----------

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

//-----------



#pragma mark - -------Camera Control-------
-(void)openActionSheet:(BOOL)isVideo isPhoto:(BOOL)isPhoto
{
    /* "Choose from gallery"   =   "Choose from gallery";
     "Take a picture"        =   "Take a picture";
     "Take a video"          =   "Take a video"; */
    NSString *other1;
    NSString *other2;
    
    if (isVideo)
    {
        other2=NSLocalizedString(@"Take a video", nil);
    }
    else
    {
        other2=NSLocalizedString(@"Take a picture", nil);
    }
    other1 = NSLocalizedString(@"Choose from gallery", nil);
    //other2 = isPhoto ? NSLocalizedString(@"Take a picture", nil):nil;
    //other3 = isVideo ? NSLocalizedString(@"Take a video", nil):nil;
    NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1,other2, nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1 ||  actionSheet.tag == 2) {
        switch (buttonIndex)
        {
            case 0:
                [self openGalleryforPic];
                break;
            case 1:
                [self openCameraforPic];
                break;
                
            default:
                break;
        }
    }
    else
    {
    switch (buttonIndex)
    {
        case 0:
            [self openGallery];
            break;
        case 1:
            [self openFrontCamera];
            break;
            
        default:
            break;
    }
    }
}
-(void)openCameraforPic
{
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *deviceNotFoundAlert = [[UIAlertView alloc] initWithTitle:@"No Device" message:@"Camera is not available"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Okay"
                                                            otherButtonTitles:nil];
        [deviceNotFoundAlert show];
        
    } else {
        
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
       
            cameraPicker.allowsEditing = YES;
      
        cameraPicker.delegate =self;
        // Show image picker
        [self presentViewController:cameraPicker animated:YES completion:nil];
    }
      }];
}

-(void)openGalleryforPic
{
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIAlertView *deviceNotFoundAlert = [[UIAlertView alloc] initWithTitle:@"No Device" message:@"Gallery is not available"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Okay"
                                                            otherButtonTitles:nil];
        [deviceNotFoundAlert show];
        
    } else {
        
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
       
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            cameraPicker.allowsEditing = NO;
        }
        else{
            cameraPicker.allowsEditing = YES;
        }
    
        cameraPicker.delegate =self;
        // Show image picker
        [self presentViewController:cameraPicker animated:YES completion:nil];
    }
      }];
}
-(void)openGallery
{
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc]init];
    videoPicker.delegate = self;
  //  videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    videoPicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    videoPicker.videoMaximumDuration = 60.0f;
         
              videoPicker.allowsEditing = YES;
      
   // [self dismissViewControllerAnimated:YES completion:^{
         [self presentViewController:videoPicker animated:YES completion:nil];
    }];
   
}

-(void)openFrontCamera
{
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *videoRecorder = [[UIImagePickerController alloc]init];
        videoRecorder.delegate = self;
        NSArray *sourceTypes = [UIImagePickerController availableMediaTypesForSourceType:videoRecorder.sourceType];
        NSLog(@"Available types for source as camera = %@", sourceTypes);
        if (![sourceTypes containsObject:(NSString*)kUTTypeMovie] ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Device Not Supported for video Recording."                                                                       delegate:self
                                                  cancelButtonTitle:@"Yes"
                                                  otherButtonTitles:@"No",nil];
            [alert show];
            
            return;
        }
        // videoRecorder.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        videoRecorder.sourceType = UIImagePickerControllerSourceTypeCamera;
        videoRecorder.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeMovie];
        videoRecorder.videoQuality = UIImagePickerControllerQualityTypeMedium;
        videoRecorder.videoMaximumDuration = 60;
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
        {
            videoRecorder.cameraDevice =  UIImagePickerControllerCameraDeviceFront;
        }
        else
        {
            videoRecorder.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        imagePicker = videoRecorder;
        [imagePicker setShowsCameraControls:YES];
        //[self presentModalViewController:imagePicker animated:YES];
        //[self dismissViewControllerAnimated:YES completion:^{
            [self presentViewController:imagePicker animated:YES completion:nil];
     //   }];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Camera Not Available"                                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
      }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if([info[UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)(kUTTypeImage)])
    {
        //image
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad  && chosenImage == nil)
        {
            chosenImage = info[UIImagePickerControllerOriginalImage];
        }
        if (isEnterPrisePhoto == NO) {
            imageSelected=YES;
            _imgUser.image = chosenImage;
            imgData= UIImageJPEGRepresentation(_imgUser.image, 0.6);
            self.imgUser.layer.cornerRadius = self.imgPitchVideo.frame.size.width / 2;
            self.imgUser.clipsToBounds = YES;
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
        else{
            [self dismissViewControllerAnimated:YES completion:^{
                ImageCropperViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ImageCropperViewController"];
                vc.selectedImage=chosenImage;
                vc.delegate=self;
                [self presentViewController:vc animated:YES completion:nil];
            }];
            
        }
        
    }
    
    else
    {
    
    // This is the NSURL of the video object
    [self.navigationController.navigationBar setHidden:NO];
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSURL* videoUrl = videoURL;
    NSURL  *newVideoUrl = [[NSURL alloc] initWithString:[videoUrl absoluteString]];
    videoData = [NSData dataWithContentsOfFile:[newVideoUrl path]];
    long videoSize = videoData.length/1024.0f/1024.0f;
    
    if (videoSize<8)
    {
        PitchVideoSelected=YES;
    }
    else
    {
        PitchVideoSelected=NO;
        [SharedClass showToast:self toastMsg:@"Select a video less then 8 Mb in size"];
    }
    //    NSDictionary * properties = [[NSFileManager defaultManager] attributesOfItemAtPath:newVideoUrl.path error:nil];
    //    NSNumber * size = [properties objectForKey: NSFileSize];
    //    NSLog(@"Vide info :- %@",properties);
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:newVideoUrl options:nil];
    NSTimeInterval durationInSeconds = 0.0;
    if (asset)
        durationInSeconds = CMTimeGetSeconds(asset.duration);
    if (durationInSeconds>60)
    {
        NSString *msg=[NSString stringWithFormat:@"Video Length is %f",durationInSeconds];
        [SharedClass showToast:self toastMsg:msg];
    }
    _imgPitchVideo.image = [[SharedClass sharedInstance]thumbnailFromVideoAtURL:newVideoUrl];
    thumbnailData = UIImagePNGRepresentation(_imgPitchVideo.image);
    self.imgPitchVideo.layer.cornerRadius = self.imgPitchVideo.frame.size.width / 2;
    self.imgPitchVideo.clipsToBounds = YES;
    NSLog(@"VideoURL = %@", videoURL);
    [picker dismissViewControllerAnimated:YES completion:^{}];
    }
}
- (IBAction)btnCloseVideoGuidePopupAction:(id)sender
{
    //[[NSUserDefaults standardUserDefaults] valueForKey:@"videopopup"]
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"videopopup"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [SharedClass hidePopupView:self.viewDimBackground andTabbar:nil];
    [SharedClass hidePopupView:self.viewVideoGuidePopup];
}

@end

