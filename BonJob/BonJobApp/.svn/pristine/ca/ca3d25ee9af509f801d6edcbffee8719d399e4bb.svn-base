//
//  EnterCodeViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/10/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//


#import "RecruiterVerifyViewController.h"
#import "RecruiterVerifyEnterMobileViewController.h"
#import "EnterCodeViewController.h"

@interface EnterCodeViewController ()<ProcessDataDelegate>

@end

@implementation EnterCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetup];
    _viewBackGround.hidden=YES;
    _viewPopup.hidden=YES;
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.txtEnterCodeHere.inputAccessoryView = keyboardToolbar;
    // Do any additional setup after loading the view.
}

-(void)yourTextViewDoneButtonPressed
{
    [self.txtEnterCodeHere resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initialSetup
{
    _lblMsg.text=NSLocalizedString(@"Enter your code", @"");
    [_btnConfirm setTitle:NSLocalizedString(@"Confirm", @"") forState:UIControlStateNormal];
    [_btnResendCode setTitle:NSLocalizedString(@"Resend the code", @"") forState:UIControlStateNormal];
    _txtEnterCodeHere.placeholder=NSLocalizedString(@"Enter the code", @"");
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"Verification code", @"")];//NSLocalizedString(@"Verification code", @"");
    _viewTxtFieldHolder.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _viewTxtFieldHolder.layer.borderWidth=0.8;
    _viewTxtFieldHolder.layer.cornerRadius=23;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    [_btnCancel setTitleColor:ButtonTitleColor forState:UIControlStateNormal];
    [_btnCancel setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    [_btnConfirm setBackgroundColor:InternalButtonColor];
    [_btnResendCode setTitleColor:InternalButtonColor forState:UIControlStateNormal];
    [SharedClass setBorderOnButton:_btnConfirm];
    _viewPopup.layer.cornerRadius=15;
    _lblPopupMsg.text=NSLocalizedString(@"Your business account has been verified successfully!", @"");
    _lblPopupSuccess.text=NSLocalizedString(@"Your offer has been published", @"");
    _lblPopupMsg.textColor=InternalButtonColor;
    [_btnViewMyOffer setTitle:NSLocalizedString(@"View my offers", @"") forState:UIControlStateNormal];
    [_btnViewMyProfile setTitle:NSLocalizedString(@"Go to my profile", @"") forState:UIControlStateNormal];
    [_btnViewMyProfile setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnViewMyProfile.layer.borderWidth=1.5;
    _btnViewMyProfile.layer.borderColor=InternalButtonColor.CGColor;
    [SharedClass setBorderOnButton:_btnViewMyOffer];
    _btnViewMyOffer.backgroundColor=InternalButtonColor;
    _btnViewMyProfile.layer.cornerRadius=23;
    [_btnViewMyProfile setTitleColor:InternalButtonColor forState:UIControlStateNormal];
    [_lblPopupMsg adjustsFontSizeToFitWidth];
    [_lblPopupSuccess adjustsFontSizeToFitWidth];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(JOBPOSTED:) name:@"JOBPOSTEDBYVERIFIED" object:nil];
    
}

-(IBAction)btnResentCode:(id)sender
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:self.strNumber forKey:@"mobile_number"];
    
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"sendotp";
    [webhelper webserviceHelper:params webServiceUrl:kSendOtp methodName:@"sendotp" showHud:YES inWhichViewController:self];
}

- (IBAction)btnConfirmAction:(id)sender
{
    if (_txtEnterCodeHere.text.length==0 || [_txtEnterCodeHere.text isEqualToString:@""])
    {
        [SharedClass showToast:self toastMsg:@"Enter OTP"];
    }
    else
    {
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:_txtEnterCodeHere.text forKey:@"otp"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"verifyotp";
    [webhelper webserviceHelper:params webServiceUrl:kVerifyOtp methodName:@"verifyotp" showHud:YES inWhichViewController:self];
   }
    
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
    if ([methodNameIs isEqualToString:@"verifyotp"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
//                _viewPopup.hidden=NO;
//                _viewBackGround.hidden=NO;
//                [SharedClass showPopupView:_viewBackGround];
//                [SharedClass showPopupView:_viewPopup];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OTPVERIFIED" object:nil];
            NSMutableDictionary *dict=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] mutableCopy];
            [dict setValue:@"123456" forKey:@"mobile_number"];
            [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"sendotp"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    
}

-(void)JOBPOSTED:(id)sender
{
                    _viewPopup.hidden=NO;
                    _viewBackGround.hidden=NO;
                    [SharedClass showPopupView:_viewBackGround];
                    [SharedClass showPopupView:_viewPopup];
}

- (IBAction)btnViewMyOfferAction:(id)sender
{
    [SharedClass hidePopupView:_viewBackGround];
    [SharedClass hidePopupView:_viewPopup];
    UIViewController *vc = self.presentingViewController;
    while (vc.presentingViewController)
    {
        if ([vc isKindOfClass:[RecruiterTabarViewController class]])
        {

            break;
        }
        else
        {
          vc = vc.presentingViewController;
        }
    }

    [vc dismissViewControllerAnimated:YES completion:^{

    }];


//    [[NSNotificationCenter defaultCenter]postNotificationName:@"switchtomyoffer" object:nil];
//
    
//    NSArray *views=self.navigationController.viewControllers;
//    for (int i=0; i<[views count]; i++)
//    {
//        UIViewController *vc=[views objectAtIndex:i];
//        if ([vc isKindOfClass:[EnterCodeViewController class]] || [vc isKindOfClass:[RecruiterVerifyViewController class]] || [vc isKindOfClass:[RecruiterVerifyEnterMobileViewController class]] )
//        {
//            [self.navigationController dismissViewControllerAnimated:vc completion:nil];
//        }
//
//    }
    [self performSelector:@selector(nowFire) withObject:nil afterDelay:0.5];
}

-(void)nowFire
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"switchtomyoffer" object:nil];
    
    
}

-(void)switchToMyOffer:(id)sender
{
    
    
}

- (IBAction)btnViewMYProfile:(id)sender
{
    [SharedClass hidePopupView:_viewBackGround];
    [SharedClass hidePopupView:_viewPopup];
    
    
    UIViewController *vc = self.presentingViewController;
    while (vc.presentingViewController)
    {
        if ([vc isKindOfClass:[RecruiterTabarViewController class]])
        {
            break;
        }
        else
        {
            vc = vc.presentingViewController;
        }
    }

    [vc dismissViewControllerAnimated:YES completion:^{

    }];
    [self performSelector:@selector(nowFire2) withObject:nil afterDelay:1.0];
    
    
    
}

-(void)nowFire2
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"switchtomyprofile" object:nil];
}

- (IBAction)btnCancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
