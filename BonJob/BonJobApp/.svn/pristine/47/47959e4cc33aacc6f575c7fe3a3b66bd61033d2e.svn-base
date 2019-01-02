//
//  RecruiterVerifyEnterMobileViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/7/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterVerifyEnterMobileViewController.h"
#import "EnterCodeViewController.h"
@implementation countryCell
@end

@interface RecruiterVerifyEnterMobileViewController ()<UITextFieldDelegate>
{
    NSMutableArray *arrCountry,*arrCountryCode;
    int CurrentIndex;

}
@end

@implementation RecruiterVerifyEnterMobileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     _viewPopupBackground.hidden = YES;
    _viewPopup.hidden=YES;
    arrCountry=[[NSMutableArray alloc]initWithArray:[SharedClass getCountryList]];
    arrCountryCode=[[NSMutableArray alloc]initWithArray:[SharedClass getCountryCode]];
    [_tblPopup reloadData];
    _txtMobileNumber.delegate=self;
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    _txtMobileNumber.inputAccessoryView = keyboardToolbar;
    // Do any additional setup after loading the view.
}

-(void)yourTextViewDoneButtonPressed
{
    [self.txtMobileNumber resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    [SharedClass setBorderOnButton:_btnVerify];
    [_btnVerify setBackgroundColor:InternalButtonColor];
    [_btnDropDown setTitleColor:InternalButtonColor forState:UIControlStateNormal];
    _viewTxtFieldHolder.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _viewTxtFieldHolder.layer.borderWidth=0.8;
    _viewTxtFieldHolder.layer.cornerRadius=23;
    self.lblMsg.text=NSLocalizedString(@"Enter your phone number to receive your code by sms", @"");
    [_btnCancel setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    [_btnCancel setTitleColor:ButtonTitleColor forState:UIControlStateNormal];
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"Phone number", @"")]; // NSLocalizedString(@"Phone number", @"");
    _txtMobileNumber.placeholder=NSLocalizedString(@"Enter a number", @"");
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    [self.btnVerify setTitle:NSLocalizedString(@"Verify", @"") forState:UIControlStateNormal];
    _lblPopupTitle.text=NSLocalizedString(@"Country code", @"");
    _viewPopup.layer.cornerRadius=17;
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_viewPopup.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(20.0, 20.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    _viewPopup.layer.mask = maskLayer;
    for (int i=0; i<[arrCountry count]; i++)
    {
        if ([[arrCountry objectAtIndex:i] isEqualToString:@"France"])
        {
            CurrentIndex=i;
            _lblCountryCode.text=[arrCountryCode objectAtIndex:CurrentIndex];
            [_tblPopup reloadData];
            [_btnDropDown setTitle:[arrCountry objectAtIndex:CurrentIndex]forState:UIControlStateNormal];
            break;
        }
    }
}

#pragma mark - ---------ACTIONS HERE-----------

- (IBAction)btnCancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==self.txtMobileNumber && range.location==0)
    {
        if ([string hasPrefix:@"0"])
        {
            [SharedClass showToast:self toastMsg:NSLocalizedString(@"Don't Enter 0 at First digit", @"")];
            return NO;
        }
        
    }
    return YES;
}

- (IBAction)btnVerifyAction:(id)sender
{
    if (_txtMobileNumber.text.length==0 || [_txtMobileNumber.text isEqualToString:@""])
    {
        [SharedClass showToast:self toastMsg:@"Please enter Mobile number"];
    }
    else
    {
        NSArray *foo=[_lblCountryCode.text componentsSeparatedByString:@"+"];
        NSString *number=[NSString stringWithFormat:@"%@%@",[foo objectAtIndex:1],_txtMobileNumber.text];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
        [params setValue:number forKey:@"mobile_number"];

        WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
        webhelper.delegate=self;
        webhelper.methodName=@"sendotp";
        [webhelper webserviceHelper:params webServiceUrl:kSendOtp methodName:@"sendotp" showHud:YES inWhichViewController:self];
    }
    //{"user_id":"1","mobile_number":"9687542857"}
    
//    EnterCodeViewController *evc=[self.storyboard instantiateViewControllerWithIdentifier:@"EnterCodeViewController"];
//    UINavigationController *navcontrol=[[UINavigationController alloc]initWithRootViewController:evc];
//    [self presentViewController:navcontrol animated:YES completion:nil];

    
}

-(void)inProgress:(float)value
{
    
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
    if ([methodNameIs isEqualToString:@"sendotp"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            EnterCodeViewController *evc=[self.storyboard instantiateViewControllerWithIdentifier:@"EnterCodeViewController"];
            NSArray *foo=[_lblCountryCode.text componentsSeparatedByString:@"+"];
            NSString *number=[NSString stringWithFormat:@"%@%@",[foo objectAtIndex:1],_txtMobileNumber.text];
            evc.strNumber=number;
            UINavigationController *navcontrol=[[UINavigationController alloc]initWithRootViewController:evc];
            [self presentViewController:navcontrol animated:YES completion:nil];
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}

- (IBAction)btnClosePopupAction:(id)sender
{
    [SharedClass hidePopupView:_viewPopupBackground];
    [SharedClass hidePopupView:_viewPopup];
}

-(IBAction)btnSelectCountry:(id)sender
{
    _viewPopupBackground.hidden = NO;
    _viewPopup.hidden=NO;
    [SharedClass showPopupView:_viewPopupBackground];
    [SharedClass showPopupView:_viewPopup];
}

-(void)btnRadioSelected:(UIButton *)btn
{
    CurrentIndex=(int)btn.tag;
    _lblCountryCode.text=[arrCountryCode objectAtIndex:CurrentIndex];
    [_tblPopup reloadData];
    [_btnDropDown setTitle:[arrCountry objectAtIndex:CurrentIndex]forState:UIControlStateNormal];
    [SharedClass hidePopupView:_viewPopupBackground];
    [SharedClass hidePopupView:_viewPopup];
}

#pragma mark - --------TABLEVIEW DELEGATES & DATA SOURCES----------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrCountry count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    countryCell *cell=(countryCell*)[tableView dequeueReusableCellWithIdentifier:@"countryCell"];
    if (!cell)
    {
        cell=[[countryCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"countryCell"];
    }
    cell.lblCountryName.text=[arrCountry objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.btnRadio setTag:indexPath.row];
    [cell.btnRadio addTarget:self action:@selector(btnRadioSelected:) forControlEvents:UIControlEventTouchUpInside];
    //cell.lblCountryName.text=@"Frence";
    if (indexPath.row==CurrentIndex)
    {
        [cell.btnRadio setSelected:YES];
    }
    else
        
    {
        [cell.btnRadio setSelected:NO];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CurrentIndex=(int)indexPath.row;
    _lblCountryCode.text=[arrCountryCode objectAtIndex:CurrentIndex];
    [_tblPopup reloadData];
    [_btnDropDown setTitle:[arrCountry objectAtIndex:CurrentIndex]forState:UIControlStateNormal];
    [SharedClass hidePopupView:_viewPopupBackground];
    [SharedClass hidePopupView:_viewPopup];
}

@end
