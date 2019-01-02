//
//  PostajobViewController.m
//  BonjobDesign
//
//  Created by Infoicon Technologies on 20/06/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//
#import "JobPreviewCell.h"
#import "PostaJobViewController.h"
#import "JobofferCollectionViewCell.h"
#import "TypesofContractTableViewCell.h"
#import "PublishSuccessViewController.h"
#import "JobOfferedViewController.h"
#import "PostedJobData.h"
#import "RecruiterVerifyEnterMobileViewController.h"
#import "RecruiterVerifyViewController.h"
#import "PaymentDataViewController.h"
#import "PaymentDetailsViewController.h"
#import "PaymentAcceptViewController.h"
#import "PaymentRejectViewController.h"
#import "ImageCropperViewController.h"
#import "BABCropperView.h"
@implementation JobOverViewCell

@end



@interface PostajobViewController ()<PublishSuccessDelegate,JobOfferSelectedProtocol,UIAlertViewDelegate,PaymentRejectedDelegate,PaymentSuccessDelegate,PaymentAcceptedDelegate,PaymantPlanSelectedDelegate,ImageCropperDelegate,UIActionSheetDelegate>
{
    NSMutableArray *arrayjoboffercomplete,*arrTypeofContract,*arrCollectionAImages,*arrTemp,*arrJobOfferDropDown;
    int selectedIndexContract,currentCollectionSelectedIndex;
    NSString *strLanguageOfoffer;
    NSString *strLanguage,*strJobtitle,*strJobtitleId,*strLocation,*strStartDate,*strDescription,*strModeofContact,*modeofContactEmailOrPhone;
    NSString *strTypeOfContract,*strLevelOfEducation,*strExperience,*strJobLanguage,*strJobNumberOfHrs,*strJobSalary;
    NSData *imgOverViewData;
    UIDatePicker *datePicker;
    float latt,lang;
    NSDictionary *dictJobData;
    UIImageView *imageForJob;
    CGRect frameDescription,frameLocationIcon,frameLocationLabelValue;
    NSMutableArray *arrSelectedLanguages;
    NSMutableArray *arrOverViewItemsName,*arrOverViewItemsValue,*arrOverViewItemsImage;
    
    BABCropperView *cropperView;
    UIImageView *croppedImageView;
    
    NSMutableArray *arrContract,*arrEducation,*arrExperience,*arrHours,*arrLang,*arrSalary;
    NSMutableArray *arrSelContract,*arrSelEducation,*arrSelExperience,*arrSelHours,*arrSelLang,*arrSelSalary;
    NSArray *arrCollectionNames,*arrCollectionImages;
}

@end

@implementation PostajobViewController

- (void)viewDidLoad
{
    

    [super viewDidLoad];
    
    arrCollectionNames = [[NSArray alloc]initWithObjects:@"Type of contract",@"Level of education",@"Experience",@"Languages",@"Number of hours",@"Salary", nil];
    arrCollectionImages = [[NSArray alloc]initWithObjects:@"blue_doc.png",@"blue_education.png",@"blue_book.png",@"blueglobe.png",@"blue_time.png",@"blue_money.png", nil];
    arrSalary = [[NSMutableArray alloc]init];
    arrEducation = [[NSMutableArray alloc]init];
    arrExperience = [[NSMutableArray alloc]init];
    arrContract = [[NSMutableArray alloc]init];
    arrHours = [[NSMutableArray alloc]init];
    arrLang = [[NSMutableArray alloc]init];
    
    arrSelSalary = [[NSMutableArray alloc]init];
    arrSelEducation = [[NSMutableArray alloc]init];
    arrSelExperience = [[NSMutableArray alloc]init];
    arrSelContract = [[NSMutableArray alloc]init];
    arrSelHours = [[NSMutableArray alloc]init];
    arrSelLang = [[NSMutableArray alloc]init];
    
    
    [self getJobPositions];
   // frameDescription= _lblPopupDescriptionValue.frame;
   // frameLocationLabelValue =_lblPopupLocationValue.frame;
   // frameLocationIcon = _lblPopupOverViewLocation.frame;
    
    [self setup];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    
    arrCollectionAImages=[[NSMutableArray alloc]init];
    [arrCollectionAImages addObject:@"blue_doc.png"];
    [arrCollectionAImages addObject:@"blue_education.png"];
    [arrCollectionAImages addObject:@"blue_book.png"];
    [arrCollectionAImages addObject:@"blueglobe.png"];
    [arrCollectionAImages addObject:@"blue_time.png"];
    [arrCollectionAImages addObject:@"blue_money.png"];
    strDescription=@"";
    _viewModeOfContact.hidden=YES;
    selectedIndexContract=-1 ;
    
    currentCollectionSelectedIndex=-1;
    arrTemp =[[NSMutableArray alloc]init];
    arrJobOfferDropDown=[[NSMutableArray alloc]initWithArray:[SharedClass getJobOffer]];
    for (int i=0; i<6; i++)
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[NSString stringWithFormat:@"%d",-1] forKey:[NSString stringWithFormat:@"%d",-1]];
        [dict setValue:@"" forKey:@"value"];
        [arrTemp addObject:dict];
    }
    [self btnRadioBonjob:nil]; // this is beacuse client said one will be default selected.
    [[self.tabBarController.tabBar.items objectAtIndex:3] setTitle:NSLocalizedString(@"POST", @"")];
    
    
    
    //
    arrSelectedLanguages=[[NSMutableArray alloc]init];
    for (int i=0;i<10; i++)
    {
        [arrSelectedLanguages addObject:@""];
    }
    _btnValidateLanguages.layer.cornerRadius=18;
    [_viewLanguagesPopup setHidden:YES];
    _tblLanguages.dataSource=self;
    _tblLanguages.delegate=self;
    // Do any additional setup after loading the view.
    
    arrOverViewItemsName=[[NSMutableArray alloc]init];
    arrOverViewItemsValue=[[NSMutableArray alloc]init];
    arrOverViewItemsImage=[[NSMutableArray alloc]init];
    
    [arrOverViewItemsName addObject:@""];
    [arrOverViewItemsName addObject:@""];
    [arrOverViewItemsName addObject:@""];
    [arrOverViewItemsName addObject:@""];
    [arrOverViewItemsName addObject:@""];
    [arrOverViewItemsName addObject:@""];
    [arrOverViewItemsName addObject:@""];
    [arrOverViewItemsName addObject:@""];
    [arrOverViewItemsName addObject:@""];
    
    [arrOverViewItemsValue addObject:@""];
    [arrOverViewItemsValue addObject:@""];
    [arrOverViewItemsValue addObject:@""];
    [arrOverViewItemsValue addObject:@""];
    [arrOverViewItemsValue addObject:@""];
    [arrOverViewItemsValue addObject:@""];
    [arrOverViewItemsValue addObject:@""];
    [arrOverViewItemsValue addObject:@""];
    [arrOverViewItemsValue addObject:@""];
    
    [arrOverViewItemsImage addObject:@""];
    [arrOverViewItemsImage addObject:@""];
    [arrOverViewItemsImage addObject:@""];
    [arrOverViewItemsImage addObject:@""];
    [arrOverViewItemsImage addObject:@""];
    [arrOverViewItemsImage addObject:@""];
    [arrOverViewItemsImage addObject:@""];
    [arrOverViewItemsImage addObject:@""];
    [arrOverViewItemsImage addObject:@""];
    
    _textviewadditionaldescription.text=NSLocalizedString(@"Add a description (optional)", @"");
    _textviewadditionaldescription.textColor=[UIColor lightGrayColor];
    
    
    if ([self.identifier isEqualToString:@"update"])
    {
        
        dictJobData=[[NSDictionary alloc]init];
        dictJobData=[[[[PostedJobData getData]getJobData] valueForKey:@"ActiveJobs"] objectAtIndex:[self.index intValue]];
        
        dictJobData= [self recursive:[dictJobData mutableCopy]];
        
        imageForJob=[[UIImageView alloc]init];
        [imageForJob sd_setImageWithURL:[NSURL URLWithString:[dictJobData valueForKey:@"job_image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
        {
            if (!error)
            {
                imgOverViewData =  UIImageJPEGRepresentation(imageForJob.image, 0.6);
            }
            else
            {
                NSLog(@"error======%@",error.localizedDescription);
            }
        }];
        
        
       strJobtitle= [dictJobData valueForKey:@"job_title"];
       strDescription= [dictJobData valueForKey:@"job_description"];
       strLocation= [dictJobData valueForKey:@"job_location"];
        
       strTypeOfContract= [dictJobData valueForKey:@"contract_type"];
       strLevelOfEducation=  [dictJobData valueForKey:@"education_level"];
       strExperience= [dictJobData valueForKey:@"experience"];
       strLanguage= [dictJobData valueForKey:@"lang"];
       strJobNumberOfHrs= [dictJobData valueForKey:@"num_of_hours"];
        strJobSalary=  [dictJobData valueForKey:@"salarie"];
    
        strStartDate=  [dictJobData valueForKey:@"start_date"];
        
        NSArray *foo=[[dictJobData valueForKey:@"contact_mode"]componentsSeparatedByString:@":"];
        if (foo.count>1)
        {
          strModeofContact=  [foo objectAtIndex:0] ;
          //modeofContactEmailOrPhone=  [foo objectAtIndex:1] ;
            if ([strModeofContact  isEqual: @"Téléphone"]) {
                [self btnRadioPhone:nil];
                   modeofContactEmailOrPhone=  [foo objectAtIndex:1] ;
                _txtModeofContact.text = [foo objectAtIndex:1];
                
            }
            else if ([strModeofContact  isEqual: @"Email"])
            {
                [self btnRadioEmail:nil];
                modeofContactEmailOrPhone=  [foo objectAtIndex:1] ;
                _txtModeofContact.text = modeofContactEmailOrPhone;
            }
            else
            {
                [self btnRadioBonjob:nil];

            }
                
        }
        else
        {
            strModeofContact =NSLocalizedString(@"BonJob Chat", @"");
        }
        
        if (strDescription.length>0)
        {
            _textviewadditionaldescription.text=strDescription;
        }
//        if (strTypeOfContract.length>0)
//        {
////            [arrayjoboffercomplete replaceObjectAtIndex:0 withObject:strTypeOfContract];
////            [arrCollectionAImages replaceObjectAtIndex:0 withObject:@"pink_check.png"];
//            [arrSelContract addObject:strTypeOfContract];
//        }
//        if (strLevelOfEducation.length>0)
//        {
////            [arrayjoboffercomplete replaceObjectAtIndex:1 withObject:strLevelOfEducation];
////            [arrCollectionAImages replaceObjectAtIndex:1 withObject:@"pink_check.png"];
//            [arrSelEducation addObject:strLevelOfEducation];
//        }
//        if (strExperience.length>0)
//        {
////            [arrayjoboffercomplete replaceObjectAtIndex:2 withObject:strExperience];
////            [arrCollectionAImages replaceObjectAtIndex:2 withObject:@"pink_check.png"];
//             [arrSelExperience addObject:strExperience];
//        }
//        if (strLanguage.length>0)
//        {
////            [arrayjoboffercomplete replaceObjectAtIndex:3 withObject:strLanguage];
////            [arrCollectionAImages replaceObjectAtIndex:3 withObject:@"pink_check.png"];
//            [arrSelLang addObject:strLanguage];
//        }
//        if (strJobNumberOfHrs.length>0)
//        {
////            [arrayjoboffercomplete replaceObjectAtIndex:4 withObject:strJobNumberOfHrs];
////            [arrCollectionAImages replaceObjectAtIndex:4 withObject:@"pink_check.png"];
//            [arrSelHours addObject:strJobNumberOfHrs];
//        }
//        if (strJobSalary.length>0)
//        {
////            [arrayjoboffercomplete replaceObjectAtIndex:5 withObject:strJobSalary];
////            [arrCollectionAImages replaceObjectAtIndex:5 withObject:@"pink_check.png"];
//            [arrSelSalary addObject:strJobSalary];
//        }
//        [_collectionviewjoboffer reloadData];
        
        
      /*  arrayjoboffercomplete  = [[NSMutableArray alloc] initWithObjects:NSLocalizedString(@"Type of contract", @""),NSLocalizedString(@"Level of education", @""),
                                  NSLocalizedString(@"Experience", @""),
                                  NSLocalizedString(@"Languages", @"")  ,NSLocalizedString(@"Number of hours", @""),NSLocalizedString(@"Salary", @""),nil]; */
        
        _txtJobOffered.text=strJobtitle;
        _lblLocation.text=strLocation;
        _lblStartDate.text=strStartDate;
        _textviewadditionaldescription.text=strDescription;

        
    }
    else
    {
        strModeofContact =NSLocalizedString(@"BonJob Chat", @"");
    }
    
  //  _lblLocation.text=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"address"];
//    if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"address"] length]>0)
//    {
//       // strLocation=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"address"];
//    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMyOfferCount:) name:@"setrecruiteroffercount" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(postJobByVerified:) name:@"OTPVERIFIED" object:nil];
    
  //  _lblLocation.text=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"address"];

    
}

- (NSMutableDictionary *)recursive:(NSMutableDictionary *)dictionary
{
    for (NSString *key in [dictionary allKeys]) {
        id nullString = [dictionary objectForKey:key];
        if ([nullString isKindOfClass:[NSDictionary class]]) {
            [self recursive:(NSMutableDictionary*)nullString];
        } else {
            if ((NSString*)nullString == (id)[NSNull null])
                [dictionary setValue:@"" forKey:key];
        }
    }
    return dictionary;
}

-(void)setMyOfferCount:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:1]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"]];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _viewbackgroundoverview.hidden = YES;
    _viewoverviewdeatails.hidden = YES;
    _viewtypeofcontract.hidden = YES;
    
    
   
    

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.viewtypeofcontract.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0,10.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.viewtypeofcontract.layer.mask = maskLayer;
    _tableviewcontract.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:self.imageoverview.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0,10.0)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = self.view.bounds;
    maskLayer2.path  = maskPath2.CGPath;
    _imageoverview.layer.mask = maskLayer2;
    _imageoverview.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if ([[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] length]==0||[[APPDELEGATE.currentPlanDict valueForKey:@"subscription_id"] length]==0)
    {
        if (([[[APPDELEGATE.currentPlanDict valueForKey:@"currentPlan"] valueForKey:@"job_post_count"] intValue]>=1))
        {
            if (!_isEdit) {
                
                [self openPaymentData];
                
            }
          
        }
        
    }
}
-(void)viewDidLayoutSubviews
{
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.tableviewcontract.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0,10.0)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.view.bounds;
//    maskLayer.path  = maskPath.CGPath;
//    self.tableviewcontract.layer.mask = maskLayer;
//    _tableviewcontract.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//  
    
}

-(void)setup
{
    _viewjoboffered.layer.cornerRadius = 20.0;
    _viewjoboffered.layer.borderColor = [UIColor colorWithRed:215.0/255.0 green:214.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
    _viewjoboffered.layer.borderWidth = 2.0;
    _viewModeOfContact.layer.cornerRadius = 22.0;
    _viewModeOfContact.layer.borderColor = [UIColor colorWithRed:215.0/255.0 green:214.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
    _viewModeOfContact.layer.borderWidth = 2.0;
    _btnpublishoutlet.layer.cornerRadius = 23;
    _btnoverviewoutlet.layer.cornerRadius = 23.0;
    _btnoverviewoutlet.layer.borderColor = InternalButtonColor.CGColor;//[UIColor colorWithRed:234.0/255.0 green:69.0/255.0 blue:113.0/255.0 alpha:1.0].CGColor;
    _btnoverviewoutlet.layer.borderWidth = 2.0;
    
    _textviewadditionaldescription.layer.cornerRadius = 20.0;
    _textviewadditionaldescription.layer.borderColor =  [UIColor colorWithRed:215.0/255.0 green:214.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
    _textviewadditionaldescription.layer.borderWidth = 2.0;
    
    arrTypeofContract=[[NSMutableArray alloc]init];
    
    arrayjoboffercomplete  = [[NSMutableArray alloc] initWithObjects:NSLocalizedString(@"Type of contract", @""),NSLocalizedString(@"Level of education", @""),
                            NSLocalizedString(@"Experience", @""),
                            NSLocalizedString(@"Languages", @"")  ,NSLocalizedString(@"Number of hours", @""),NSLocalizedString(@"Salary", @""),nil];
    
   // _tableviewcontract.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    // Multi language Setup
    
    _lblSpecifyJobTitile.text=NSLocalizedString(@"Specify or select a Job title", @"");
    _txtJobOffered.placeholder=NSLocalizedString(@"Job offered", @"");
    _lblPhoto.text=NSLocalizedString(@"Add Photo", @"");
    _lblLocationOfJob.text=NSLocalizedString(@"Location of the Job", @"");
    _lblClkCompleteJobOffer.text=NSLocalizedString(@"Click to complete your Job offer", @"");
    _lblStartDate.text=NSLocalizedString(@"Start date", @"");
    
    _lblAddtionalDescription.text=NSLocalizedString(@"Additional description", @"");
    _lblModeofContact.text=NSLocalizedString(@"Mode of contact", @"");
    _lblSpecifyModeofContact.text=NSLocalizedString(@"Select your preferred mode of contact", @"");
    _lblContactBonjob.text=NSLocalizedString(@"BonJob Chat", @"");
    _lblContactEmail.text=NSLocalizedString(@"E-mail", @"");
    _lblContactPhone.text=NSLocalizedString(@"Phone", @"");
    [_btnoverviewoutlet setTitle:NSLocalizedString(@"Overview", @"") forState:UIControlStateNormal];
    [_btnpublishoutlet setTitle:NSLocalizedString(@"Publish", @"") forState:UIControlStateNormal];
    _lblPopupJobTitle.text=NSLocalizedString(@"Job title:", @"");
    _lblPopupJobContract.text=NSLocalizedString(@"Contract:", @"");
    _lblPopupJobExperience.text=NSLocalizedString(@"Experience:", @"");
    _lblPopupNumberOfHours.text=NSLocalizedString(@"Number of hours:", @"");
    _lblPopupJobStartDate.text=NSLocalizedString(@"Start date:", @"");
    _lblPopupTypeofContract.text=NSLocalizedString(@"Type of contract", @"");
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"Job offer", @"")];//NSLocalizedString(@"Job offered", @"");
   
    _btnpublishoutlet.backgroundColor=InternalButtonColor;
    _lblFrench.text=NSLocalizedString(@"French", @"");
    _lblEnglish.text=NSLocalizedString(@"English", @"");
    _lblIndicateLabguageOfOffer.text=NSLocalizedString(@"Indicate the language of the offer", @"");
    _txtJobOffered.delegate=self;
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"Job offer", @"")];
    _txtJobOffered.placeholder=NSLocalizedString(@"Job offered", @"");
    
    // VIEW JOBPOST POPUP
    _btnViewMyOffer.backgroundColor=InternalButtonColor;
    [SharedClass setBorderOnButton:_btnViewMyOffer];
    _btnEditMyProfile.layer.cornerRadius=23;
    _btnEditMyProfile.layer.borderColor=InternalButtonColor.CGColor;
    _btnEditMyProfile.layer.borderWidth=1.5;
    _viewJobPostSuccessPopup.layer.cornerRadius=12;
    [_btnEditMyProfile setTitleColor:InternalButtonColor forState:UIControlStateNormal];
    _lblJobPostSuccessMsg.text=NSLocalizedString(@"Your offer has been published", @"");
    [_btnViewMyOffer setTitle:NSLocalizedString(@"View my offers", @"") forState:UIControlStateNormal];
    [_btnEditMyProfile setTitle:NSLocalizedString(@"Go to my profile", @"") forState:UIControlStateNormal];
    _viewJobPostSuccessBackground.hidden=YES;
    _viewJobPostSuccessPopup.hidden=YES;
    
    _lblLocation.text=APPDELEGATE.userAddress;
    strLocation=APPDELEGATE.userAddress;
    latt=APPDELEGATE.latitude;
    lang=APPDELEGATE.longitude;
    // [params setValue:APPDELEGATE.userAddress forKey:@"city"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - -----NI DROPDOWN DELEGATE----------
-(void)showDropDown:(UITextField *)txt;
{
    if(dropDown == nil)
    {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:txt :&f :arrJobOfferDropDown :nil :@"down"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:txtSelect];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender index:(NSInteger)indexPath
{
    [self rel];
   // NSLog(@"%@", btnSelect.titleLabel.text);
}

-(void)rel
{
    //    [dropDown release];
    dropDown = nil;
}

#pragma mark - ------JobOffer Delegate-----
-(void)selectedJobOffer:(NSString *)jobOffer jobId:(NSString*)job_id
{
    _txtJobOffered.text=jobOffer;
    strJobtitle=jobOffer;
    strJobtitleId = job_id;
}
#pragma mark - ------------Textfield Delelegates----------
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   // [self showDropDown:textField];  open it when you want a drop down below the textfield
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==_txtJobOffered)
    {
        strJobtitle=_txtJobOffered.text;
    }
    else
    {
        modeofContactEmailOrPhone=textField.text;
    }
    
}
#pragma mark ------TextView Delegate----
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor=[UIColor blackColor];
    textView.text=@"";
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    NSString *temp=textView.text;
//
//    if (textView==_textviewadditionaldescription)
//    {
//        if ([_textviewadditionaldescription.text length]+ (text.length - range.length) >=151)
//        {
//            textView.text=[temp substringToIndex:[temp length]-1];
//        }
//        else
//            _lblTotalCharacterCount.text=[NSString stringWithFormat:@"%lu/150",(unsigned long)[_textviewadditionaldescription.text length]+ (text.length - range.length)];
//    }
//    return true;
//}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
     if (textView == _textviewadditionaldescription)
     {
    
    
    if(range.length + range.location > textView.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
         if (newLength <= 150) {
             _lblTotalCharacterCount.text = [NSString stringWithFormat:@"%lu/150",(unsigned long)newLength];
             strDescription = _textviewadditionaldescription.text;
         }
    return newLength <= 150;
    //}
    
     }
    return true;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0 || [textView.text isEqualToString:@" "])
    {
        textView.text=NSLocalizedString(@"Add a description (optional)", @"");
        textView.textColor=[UIColor lightGrayColor];
    }
    else
    {
        strDescription=textView.text;
    }
}

#pragma mark -------------TableView delegate-------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tblOverViewData)
    {
        return [arrOverViewItemsValue count] + 1;
    }
    else
    {
    if(currentCollectionSelectedIndex == 0)
    {
        return  arrContract.count;
    }
    if(currentCollectionSelectedIndex == 1)
    {
        return  arrEducation.count;
    }
    if(currentCollectionSelectedIndex == 2)
    {
        return  arrExperience.count;
    }
    if(currentCollectionSelectedIndex == 3)
    {
        return  arrLang.count;
    }
    if(currentCollectionSelectedIndex == 4)
    {
        return  arrHours.count;
    }
    
    return arrSalary.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblOverViewData)
    {
        if (indexPath.row==0)
        {
            if ([[arrOverViewItemsValue objectAtIndex:indexPath.row] length]>50)
            {
                return 80;
            }
            else if ([[arrOverViewItemsValue objectAtIndex:indexPath.row] length]>30)
            {
                return 60;
            }
            else
            return 30;
        }
        else if(indexPath.row == arrOverViewItemsValue.count)
        {
            return 170;
        }
        else
        return 30;
    }
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblOverViewData)
    {
        if (indexPath.row == arrOverViewItemsValue.count) {
            JobPreviewCell *cell = (JobPreviewCell *)[tableView dequeueReusableCellWithIdentifier:@"JobPreviewCell"];
          
            [cell.btnPublish addTarget:self action:@selector(btnPopupPublishAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.lblItemValue1.text=strLocation;
            cell.lblDesc.text = strDescription;
            [cell.btnPublish setTitle:NSLocalizedString(@"Publish", @"") forState:UIControlStateNormal];
            [cell.btnPublish setBackgroundColor:InternalButtonColor];
            [SharedClass setBorderOnButton:cell.btnPublish];
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
        JobOverViewCell *cell=(JobOverViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JobOverViewCell"];
        cell.imgItem.image=[UIImage imageNamed:[arrOverViewItemsImage objectAtIndex:indexPath.row]];
        cell.lblItemName.text=[arrOverViewItemsName objectAtIndex:indexPath.row];
        cell.lblItemValue.text=[arrOverViewItemsValue objectAtIndex:indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        }
    }
    else
    {
        TypesofContractTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"TypesofContractTableViewCell"];
        if(!Cell)
        {
            Cell = [(TypesofContractTableViewCell *)[TypesofContractTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TypesofContractTableViewCell"];
        }
        
    //    cell.showRewards addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside;
        [Cell.btnRadio addTarget:self action:@selector(btnRadioAction:) forControlEvents:UIControlEventTouchUpInside];
        Cell.btnRadio.tag = indexPath.row;
        
        if(currentCollectionSelectedIndex == 0)
        {
            JobSearchFilter *obj = [arrContract objectAtIndex:indexPath.row];
            Cell.labelofcontract.text = obj.contract_title;
             Cell.btnRadio.selected = NO;
            if(arrSelContract.count > 0 && [arrSelContract containsObject:obj])
            {
                Cell.btnRadio.selected = YES;
            }
            
        }
        if(currentCollectionSelectedIndex == 1)
        {
            JobSearchFilter *obj = [arrEducation objectAtIndex:indexPath.row];
            Cell.labelofcontract.text = obj.education_title;
            Cell.btnRadio.selected = NO;
            if(arrSelEducation.count > 0  && [arrSelEducation containsObject:obj])
            {
                Cell.btnRadio.selected = YES;
            }
            
        }
        if(currentCollectionSelectedIndex == 2)
        {
            JobSearchFilter *obj = [arrExperience objectAtIndex:indexPath.row];
            Cell.labelofcontract.text = obj.experience_title;
            Cell.btnRadio.selected = NO;
            if(arrSelExperience.count > 0 && [arrSelExperience containsObject:obj])
            {
                Cell.btnRadio.selected = YES;
            }
            
        }
        if(currentCollectionSelectedIndex == 3)
        {
            LevelOfLanguageModel *obj = [arrLang objectAtIndex:indexPath.row];
            Cell.labelofcontract.text = obj.job_language_title;
            Cell.btnRadio.selected = NO;
            if(arrSelLang.count > 0 && [arrSelLang containsObject:obj])
            {
                Cell.btnRadio.selected = YES;
            }
            
        }
        if(currentCollectionSelectedIndex == 4)
        {
            JobSearchFilter *obj = [arrHours objectAtIndex:indexPath.row];
            Cell.labelofcontract.text = obj.hours_title;
            Cell.btnRadio.selected = NO;
            if(arrSelHours.count > 0 && [arrSelHours containsObject:obj])
            {
                Cell.btnRadio.selected = YES;
            }
            
        }
        if(currentCollectionSelectedIndex == 5)
        {
            SalariesModel *obj = [arrSalary objectAtIndex:indexPath.row];
            Cell.labelofcontract.text = obj.salary_title;
            Cell.btnRadio.selected = NO;
            if(arrSelSalary.count > 0 && [arrSelSalary containsObject:obj])
            {
                Cell.btnRadio.selected = YES;
            }
            
        }
        return Cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblOverViewData)
    {
        return;
    }
  else
    {
        
        if (currentCollectionSelectedIndex==0)
        {
            [arrSelContract removeAllObjects];
           JobSearchFilter *obj = [arrContract objectAtIndex:indexPath.row];
            [arrSelContract addObject:obj];
          
        }
        else if (currentCollectionSelectedIndex==1)
        {
            [arrSelEducation removeAllObjects];
            JobSearchFilter *obj = [arrEducation objectAtIndex:indexPath.row];
            [arrSelEducation addObject:obj];
        }
        else if (currentCollectionSelectedIndex==2)
        {
           [arrSelExperience removeAllObjects];
            JobSearchFilter *obj = [arrExperience objectAtIndex:indexPath.row];
            [arrSelExperience addObject:obj];
        }
        else if (currentCollectionSelectedIndex==3)
        {
            [arrSelLang removeAllObjects];
            LevelOfLanguageModel *obj = [arrLang objectAtIndex:indexPath.row];
            [arrSelLang addObject:obj];
        }
        else if (currentCollectionSelectedIndex==4)
        {
            [arrSelHours removeAllObjects];
            JobSearchFilter *obj = [arrHours objectAtIndex:indexPath.row];
            [arrSelHours addObject:obj];
        }
        else if (currentCollectionSelectedIndex==5)
        {
            [arrSelSalary removeAllObjects];
            SalariesModel *obj = [arrSalary objectAtIndex:indexPath.row];
            [arrSelSalary addObject:obj];
        }
    
    [_collectionviewjoboffer reloadData];
        [self btncuttypeofcontract:nil];
    }
}

#pragma mark ---------------CollectionView delegate------------------
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    //UIImageView *cellimage = (UIImageView *)[self.view viewWithTag:201];
    CGFloat Width = collectionView.frame.size.width-20;
    float cellWidth =Width / 3.0;
    CGSize size = CGSizeMake(cellWidth,collectionView.frame.size.height/2 -12 );
    return size;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JobofferCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JobofferCollectionViewCell" forIndexPath:indexPath];
//    Cell.labeloffer.text = [arrayjoboffercomplete objectAtIndex:indexPath.row];
//    Cell.imageoffer.image=[UIImage imageNamed:[arrCollectionAImages objectAtIndex:indexPath.item]];
    //Cell.imageoffer.contentMode = UIViewContentModeScaleAspectFill;
    Cell.labeloffer.textColor=TitleColor;
    Cell.labeloffer.text = NSLocalizedString([arrCollectionNames objectAtIndex:indexPath.item], [arrCollectionNames objectAtIndex:indexPath.item]);
    
    Cell.imageoffer.image=[UIImage imageNamed:[arrCollectionImages objectAtIndex:indexPath.item]];
    if(arrSelContract.count > 0 && indexPath.item == 0)
    {
        JobSearchFilter * obj = [arrSelContract objectAtIndex:0];
        Cell.labeloffer.text = obj.contract_title;
        Cell.labeloffer.textColor=InternalButtonColor;
        Cell.imageoffer.image=[UIImage imageNamed:@"pink_check.png"];
    }
    
    if(arrSelEducation.count > 0 &&  indexPath.item == 1)
    {
        JobSearchFilter * obj = [arrSelEducation objectAtIndex:0];
        Cell.labeloffer.text = obj.education_title;
        Cell.labeloffer.textColor=InternalButtonColor;
        Cell.imageoffer.image=[UIImage imageNamed:@"pink_check.png"];
    }
    if(arrSelExperience.count > 0 &&  indexPath.item == 2)
    {
        JobSearchFilter * obj = [arrSelExperience objectAtIndex:0];
        Cell.labeloffer.text = obj.experience_title;
        Cell.labeloffer.textColor=InternalButtonColor;
        Cell.imageoffer.image=[UIImage imageNamed:@"pink_check.png"];
    }
    if(arrSelLang.count > 0 &&  indexPath.item == 3)
    {
        LevelOfLanguageModel * obj = [arrSelLang objectAtIndex:0];
        Cell.labeloffer.text = obj.job_language_title;
        Cell.labeloffer.textColor=InternalButtonColor;
        Cell.imageoffer.image=[UIImage imageNamed:@"pink_check.png"];
    }
    if(arrSelHours.count > 0 &&  indexPath.item == 4)
    {
        JobSearchFilter * obj = [arrSelHours objectAtIndex:0];
        Cell.labeloffer.text = obj.hours_title;
        Cell.labeloffer.textColor=InternalButtonColor;
        Cell.imageoffer.image=[UIImage imageNamed:@"pink_check.png"];
    }
    if(arrSelSalary.count > 0 &&  indexPath.item == 5)
    {
        SalariesModel * obj = [arrSelSalary objectAtIndex:0];
        Cell.labeloffer.text = obj.salary_title;
        Cell.labeloffer.textColor=InternalButtonColor;
        Cell.imageoffer.image=[UIImage imageNamed:@"pink_check.png"];
    }
    NSLog(@"%ld", (long)indexPath.row);
    return Cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    currentCollectionSelectedIndex=(int)indexPath.row;
        if(indexPath.row == 0)
    {

    _lblPopupTypeofContract.text=NSLocalizedString(@"Type of contract", @"");
     
        
        
        
    }
    else if (indexPath.row==1)
    {
        _lblPopupTypeofContract.text=NSLocalizedString(@"Level of education", @"");
        

    }
    else if (indexPath.row==2)
    {
        _lblPopupTypeofContract.text=NSLocalizedString(@"Experience", @"");
       

    }
    else if (indexPath.row==3)
    {
        
         _lblPopupTypeofContract.text=NSLocalizedString(@"Languages", @"");
        _lblLanguagesPopupTitle.text=NSLocalizedString(@"Languages", @"");
       
        
    }
    else if (indexPath.row==4)
    {
        _lblPopupTypeofContract.text=NSLocalizedString(@"Number of hours", @"");
        
        
    }
    else if (indexPath.row==5)
    {
        _lblPopupTypeofContract.text=NSLocalizedString(@"Salary", @"");
        
        
    }
    [_tableviewcontract reloadData];
    _viewtypeofcontract.layer.cornerRadius = 10.0;
    _viewbackgroundoverview.hidden = NO;
    _viewtypeofcontract.hidden = NO;
    [SharedClass showPopupView:_viewbackgroundoverview andTabbar:self.tabBarController];
    [SharedClass showPopupView:_viewtypeofcontract];
}
#pragma mark ----------- Actions on btn-------
-(void)btnRadioLanguageAction:(UIButton *)button
{
    selectedIndexContract=(int)button.tag;
    
    //[_tableviewcontract reloadData];
    NSString *stringtypeofcontract = [arrTypeofContract objectAtIndex:button.tag];
    [arrayjoboffercomplete replaceObjectAtIndex:currentCollectionSelectedIndex withObject:stringtypeofcontract];
    [arrCollectionAImages replaceObjectAtIndex:currentCollectionSelectedIndex withObject:@"pink_check.png"];
   
    if ([arrSelectedLanguages containsObject:stringtypeofcontract])
    {
        [arrSelectedLanguages replaceObjectAtIndex:selectedIndexContract withObject:@""];
    }
    else
    {
         [arrSelectedLanguages replaceObjectAtIndex:selectedIndexContract withObject:stringtypeofcontract];
    }
    [_tblLanguages reloadData];
}
-(void)btnRadioAction:(UIButton *)button
{
      selectedIndexContract=(int)button.tag;
    if (currentCollectionSelectedIndex==0)
    {
        [arrSelContract removeAllObjects];
        JobSearchFilter *obj = [arrContract objectAtIndex:selectedIndexContract];
        [arrSelContract addObject:obj];
        
    }
    else if (currentCollectionSelectedIndex==1)
    {
        [arrSelEducation removeAllObjects];
        JobSearchFilter *obj = [arrEducation objectAtIndex:selectedIndexContract];
        [arrSelEducation addObject:obj];
    }
    else if (currentCollectionSelectedIndex==2)
    {
        [arrSelExperience removeAllObjects];
        JobSearchFilter *obj = [arrExperience objectAtIndex:selectedIndexContract];
        [arrSelExperience addObject:obj];
    }
    else if (currentCollectionSelectedIndex==3)
    {
        [arrSelLang removeAllObjects];
        LevelOfLanguageModel *obj = [arrLang objectAtIndex:selectedIndexContract];
        [arrSelLang addObject:obj];
    }
    else if (currentCollectionSelectedIndex==4)
    {
        [arrSelHours removeAllObjects];
        JobSearchFilter *obj = [arrHours objectAtIndex:selectedIndexContract];
        [arrSelHours addObject:obj];
    }
    else if (currentCollectionSelectedIndex==5)
    {
        [arrSelSalary removeAllObjects];
        SalariesModel *obj = [arrSalary objectAtIndex:selectedIndexContract];
        [arrSelSalary addObject:obj];
    }
    
    
   [self btncuttypeofcontract:nil];
  
    [_collectionviewjoboffer reloadData];
}
- (IBAction)btncuttapped:(UIButton *)sender
{
    //[SharedClass hidePopupView:_viewbackgroundoverview];
    [SharedClass hidePopupViewforPreview:_viewbackgroundoverview andTabbar:self.tabBarController];
    [SharedClass hidePopupViewforPreview:self.viewoverviewdeatails];
}

- (IBAction)btncuttypeofcontract:(UIButton *)sender
{
////    _viewbackgroundoverview.hidden = YES;
////    _viewtypeofcontract.hidden = YES;
//    if (selectedIndexContract>=0 && [[[arrTemp objectAtIndex:currentCollectionSelectedIndex] valueForKey:@"value"] length]>0)
//    {
//
//        [arrCollectionAImages replaceObjectAtIndex:currentCollectionSelectedIndex withObject:@"pink_check.png"];
//        currentCollectionSelectedIndex=-1;
//        [_tableviewcontract reloadData];
//
//    }
    [SharedClass hidePopupView:_viewbackgroundoverview andTabbar:self.tabBarController];
    //[SharedClass hidePopupView:_viewbackgroundoverview];
    [SharedClass hidePopupView:_viewtypeofcontract];
}

- (IBAction)btnCameraAction:(id)sender
{
//    [QMImagePicker chooseSourceTypeInVC:self allowsEditing:NO isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL)
//    {
//
////        UIImageView *imageiconofperson;
////        imageiconofperson.image = image;
////        imageiconofperson.layer.cornerRadius = 30.0;
////        imageiconofperson.clipsToBounds = YES;
//
//        _imageoverview.image=image;
//        imgOverViewData = UIImageJPEGRepresentation(image, 0.9);
//
//        ImageCropperViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ImageCropperViewController"];
//        vc.selectedImage=image;
//        vc.delegate=self;
//        [self presentViewController:vc animated:YES completion:nil];
//        //[self.navigationController pushViewController:vc animated:YES];
//
//    }];
    
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


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
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

-(void)rectunglarImage:(UIImage *)croppedImage
{
    _imageoverview.image=croppedImage;
    imgOverViewData = UIImageJPEGRepresentation(_imageoverview.image, 0.9);
}

- (IBAction)btnLocationAction:(id)sender
{
    SelectLocationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
    slvc.delegate=self;
    [self.navigationController pushViewController:slvc animated:YES];
}

- (IBAction)btnCalenderAction:(id)sender
{
//    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:3600 * 24 * 7]; //One week from now
//    
//    NSDateComponents* dateComponents = [[NSDateComponents alloc] init];
//    dateComponents.year = -50;
//    dateComponents.month=1;
//    
//    NSDate* threeYearsAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
//    
//    LSLDatePickerDialog *dialog = [[LSLDatePickerDialog alloc] init];
//    [dialog showWithTitle:NSLocalizedString(@"Indicate your birth date", @"") doneButtonTitle:NSLocalizedString(@"Save", @"") cancelButtonTitle:@"" defaultDate:[NSDate date] minimumDate:threeYearsAgo maximumDate:currentDate datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date)
//     {
//         if(date)
//         {
//             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//             [formatter setDateFormat:@"MM/dd/yyyy"];
//             strStartDate=[formatter stringFromDate:date];
//             _lblStartDate.text=[formatter stringFromDate:date];
//             [_lblStartDate setTextColor:ButtonTitleColor];
//             //[_dateTextField setText:[formatter stringFromDate:date]];
//         }
//     }];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BONJOB" message:NSLocalizedString(@"Enter the contract start date", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Save", @""), nil];
    alertView.tag =101;
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [alertView setValue:datePicker forKey:@"accessoryView"];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1005)
    {
        if (buttonIndex==1)
        {
            [self.tabBarController setSelectedIndex:4];
        }
    }
    else
    {
        if(buttonIndex != 0)
        {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        strStartDate=[formatter stringFromDate:datePicker.date];
        _lblStartDate.text=[formatter stringFromDate:datePicker.date];
        [_lblStartDate setTextColor:ButtonTitleColor];
        }
        else
        {
            
        }
    }
    
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
        UIImageView *imageiconofperson;
                imageiconofperson.image = chosenImage;
                imageiconofperson.layer.cornerRadius = 30.0;
                imageiconofperson.clipsToBounds = YES;
        
                _imageoverview.image=chosenImage;
                imgOverViewData = UIImageJPEGRepresentation(chosenImage, 0.9);
        [self dismissViewControllerAnimated:YES completion:^{
            ImageCropperViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ImageCropperViewController"];
            vc.selectedImage=chosenImage;
            vc.delegate=self;
            [self presentViewController:vc animated:YES completion:nil];
        }];
        
        
        }
    }


- (IBAction)btnJobOfferDropDownAction:(id)sender
{
    JobOfferedViewController *jvc=[self.storyboard instantiateViewControllerWithIdentifier:@"JobOfferedViewController"];
    jvc.delegate=self;
    [self.navigationController pushViewController:jvc animated:YES];
}

- (IBAction)btnOverviewAction:(id)sender
{
//    [_viewbackgroundoverview setTranslatesAutoresizingMaskIntoConstraints:YES];
//    _viewbackgroundoverview.frame =CGRectMake(0, deviceheight, devicewidth, deviceheight);
//    _viewoverviewdeatails.frame  = CGRectMake(16*aspectratiowidth, deviceheight - 114*aspectratioheight, 288*aspectratiowidth, 404*aspectratioheight);
//    [UIView animateWithDuration:0.2
//                     animations:^{
//                         _viewbackgroundoverview.frame = CGRectMake(0, 0, devicewidth, deviceheight);
//                         //    [self.tabBarController.view addSubview:_viewbackgroundoverview];
//                         _viewbackgroundoverview.hidden = NO;
//                         _viewoverviewdeatails.hidden = NO;
//                         _viewoverviewdeatails.layer.cornerRadius = 10.0;
//
//                         _viewoverviewdeatails.frame = CGRectMake(16*aspectratiowidth,80*aspectratioheight,aspectratiowidth*292 , aspectratioheight*450);
//                         
//                         
//                         [self.view.window addSubview:_viewbackgroundoverview];
//                         [self.view.window addSubview:_viewoverviewdeatails];
//                     }
//                     completion:^(BOOL finished)
//                     {
//                         
//                     }];
//    if (strJobtitle.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"", @"")];
//    }
//    else if (strModeofContact.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"", @"")];
//    }
//    else if (strExperience.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"", @"")];
//    }
//    else if (strJobNumberOfHrs.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"", @"")];
//    }
//    else if (strStartDate.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"", @"")];
//    }
//    else if (strLocation.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"", @"")];
//    }
//    else if (strDescription.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"", @"")];
//    }
    if([self validateData])
    {
        _viewoverviewdeatails.layer.cornerRadius = 10.0;
        _viewbackgroundoverview.hidden = NO;
        _viewoverviewdeatails.hidden = NO;
        [SharedClass showPopupViewforPreview:_viewbackgroundoverview andTabbar:self.tabBarController];
        [SharedClass showPopupViewforPreview:_viewoverviewdeatails];
        [self setDataOnPreviewPopup];
        [self.tblOverViewData flashScrollIndicators];
        [self.tblOverViewData setShowsHorizontalScrollIndicator:YES];
        [self.tblOverViewData setShowsVerticalScrollIndicator:YES];
//        self.tblOverViewData.rowHeight = UITableViewAutomaticDimension;
//        self.tblOverViewData.estimatedRowHeight = 80;
    }
    else
    {
        
    }
}

-(void)setDataOnPreviewPopup
{
    if ([self.identifier isEqualToString:@"update"])
    {
        _imageoverview.image=imageForJob.image;
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        _imageoverview.translatesAutoresizingMaskIntoConstraints=NO;
//        _imageoverview.frame = CGRectMake(_imageoverview.frame.origin.x, _imageoverview.frame.origin.y, _imageoverview.frame.size.width, 500.0);
//         _imgViewConstant.constant = 500;
    }
    
//    _lblPopupJobTitleValue.text=strJobtitle;
//    _lblPopupContractValue.text=strTypeOfContract;
//    _lblPopupJobExperinceValue.text=strExperience;
//    _lblPopupNumberOfHrsValue.text=strJobNumberOfHrs;
//    _lblPopupStartDateValue.text=strStartDate;
//    _lblPopupLocationValue.text=strLocation;
//    _lblPopupDescriptionValue.text= strDescription;
    _lblOverViewTypeofContact.text=strModeofContact;
    
    
    [arrOverViewItemsImage removeAllObjects];
    [arrOverViewItemsName removeAllObjects];
    [arrOverViewItemsValue removeAllObjects];
    




    
    if (strJobtitle.length>0)
    {
        [arrOverViewItemsValue addObject:strJobtitle];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Job title", @"")];
        [arrOverViewItemsImage addObject:@"search_outline.png"];
    }
    if(arrSelContract.count > 0)
    {
        JobSearchFilter * obj = arrSelContract[0];
        [arrOverViewItemsValue addObject:obj.contract_title];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Contract", @"")];
        [arrOverViewItemsImage addObject:@"IcoFichierOutline.png"];
    }
    if (arrSelEducation.count >0)
    {
        JobSearchFilter * obj = arrSelEducation[0];
        [arrOverViewItemsValue addObject:obj.education_title];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Formation", @"")];
        [arrOverViewItemsImage addObject:@"education.png"];
    }
    
    if(arrSelExperience.count > 0)
    {
        JobSearchFilter * obj = arrSelExperience[0];
        [arrOverViewItemsValue addObject:obj.experience_title];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Experience", @"")];
        [arrOverViewItemsImage addObject:@"IcoListOutline.png"];
    }
    if(arrSelLang.count > 0)
    {
         LevelOfLanguageModel * obj = arrSelLang[0];
        [arrOverViewItemsValue addObject:obj.job_language_title];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Languages", @"")];
        [arrOverViewItemsImage addObject:@"GLOBE.png"];
    }
    if(arrSelHours.count >0)
    {
        JobSearchFilter * obj = arrSelHours[0];
        [arrOverViewItemsValue addObject:obj.hours_title];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Number of hours", @"")];
        [arrOverViewItemsImage addObject:@"IcoTimeOutline.png"];
    }
    if(arrSelSalary.count >0)
    {
         SalariesModel * obj = arrSelSalary[0];
        [arrOverViewItemsValue addObject:obj.salary_title];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Salary", @"")];
        [arrOverViewItemsImage addObject:@"salry_new.png"];
    }
    if(strStartDate.length>0)
    {
        [arrOverViewItemsValue addObject:strStartDate];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Start date", @"")];
        [arrOverViewItemsImage addObject:@"IcoCalendarOutline"];
    }
    
    if(strModeofContact.length>0)
    {
        [arrOverViewItemsValue addObject:strModeofContact];
        [arrOverViewItemsName addObject:NSLocalizedString(@"Mode of contact", @"")];
        [arrOverViewItemsImage addObject:@"mail.png"];
    }
    
  
    _tblOverViewData.delegate=self;
    _tblOverViewData.dataSource=self;
    [_tblOverViewData reloadData];
    
    _lblPopupModeofContactPlaceHolder.text=NSLocalizedString(@"Mode of contact", @"");
    _lblPopupModeofContactPlaceHolder.textColor=TitleColor;
    
//    if (strDescription.length==0)
//    {
//        _lblPopupDescriptionValue.translatesAutoresizingMaskIntoConstraints=YES;
//        _lblPopupLocationValue.translatesAutoresizingMaskIntoConstraints=YES;
//        _lblPopupOverViewLocation.translatesAutoresizingMaskIntoConstraints=YES;
//        CGRect frame=_lblPopupDescriptionValue.frame;
//        frame.size.height=0;
//        _lblPopupDescriptionValue.frame=frame;
//        [_lblPopupOverViewLocation setFrame:CGRectMake(_lblPopupOverViewLocation.frame.origin.x, _lblPopupDescriptionValue.frame.origin.y+_lblPopupDescriptionValue.frame.size.height+10, _lblPopupOverViewLocation.frame.size.width, _lblPopupOverViewLocation.frame.size.height)];
//        [_lblPopupLocationValue setFrame:CGRectMake(_lblPopupLocationValue.frame.origin.x, _lblPopupDescriptionValue.frame.origin.y+_lblPopupDescriptionValue.frame.size.height+10, _lblPopupLocationValue.frame.size.width,_lblPopupLocationValue.frame.size.height)];
//
//    }
//    else
//    {
//        _lblPopupDescriptionValue.translatesAutoresizingMaskIntoConstraints=YES;
//        _lblPopupLocationValue.translatesAutoresizingMaskIntoConstraints=YES;
//        _lblPopupOverViewLocation.translatesAutoresizingMaskIntoConstraints=YES;
//        _lblPopupDescriptionValue.frame=frameDescription;
//        _lblPopupLocationValue.frame=frameLocationLabelValue;
//        _lblPopupOverViewLocation.frame=frameLocationIcon;
//    }
    /*
     {"user_id":"1","job_title":"Urgent job","job_description":"dfdfdfdf fdf dfdfd ","job_image":"test.jpg","job_location":"noida","contract_type":"fgfggfggfg","education_level":"B.Tech","experience":"4 years","duration":"sdd f df","num_of_hours":"4 hours","salarie":"60k","start_date":"12-07-2017","contact_mode":"[name=>email,value=>pavan@mail.com]"
     }
     */
//    if (arrOverViewItemsName.count<3)
//    {
//        _viewoverviewdeatails.translatesAutoresizingMaskIntoConstraints=YES;
//        CGRect frame=_viewoverviewdeatails.frame;
//        frame.size.height=frame.size.height-150;
//        _viewoverviewdeatails.frame=frame;
//        
//        //_tblOverViewData.translatesAutoresizingMaskIntoConstraints=YES;
//        CGRect frame1=_tblOverViewData.frame;
//        frame1.size.height=frame1.size.height-120;
//        _tblOverViewData.frame=frame1;
//    }
}

-(IBAction)btnEnglishAction:(id)sender
{
    [_btnEnglish setSelected:YES];
    [_btnFrench setSelected:NO];
    strLanguageOfoffer=NSLocalizedString(@"English", @"English");
    
}

-(IBAction)btnFrenchAction:(id)sender
{
    [_btnEnglish setSelected:NO];
    [_btnFrench setSelected:YES];
    strLanguageOfoffer=NSLocalizedString(@"French", @"French");
}

- (IBAction)btnRadioBonjob:(id)sender
{
    [_btnRadioBonjob setSelected:YES];
    [_btnRadioEmail setSelected:NO];
    [_btnRadioPhone setSelected:NO];
    _viewModeOfContact.hidden=YES;
    _txtModeofContact.placeholder=@"";
    strModeofContact=NSLocalizedString(@"BonJob Chat", @"");
    modeofContactEmailOrPhone=NSLocalizedString(@"BonJob Chat", @"");
}

- (IBAction)btnRadioPhone:(id)sender
{
    [_btnRadioBonjob setSelected:NO];
    [_btnRadioEmail setSelected:NO];
    [_btnRadioPhone setSelected:YES];
    _viewModeOfContact.hidden=NO;
    _txtModeofContact.placeholder=NSLocalizedString(@"Enter a number", @"");
    [_txtModeofContact resignFirstResponder];
   _txtModeofContact.keyboardType = UIKeyboardTypeNumberPad;

    strModeofContact=NSLocalizedString(@"Phone", @"");
    modeofContactEmailOrPhone=@"";
    _txtModeofContact.text = @"";
    
}

- (IBAction)btnRadioEmail:(id)sender
{
    [_btnRadioBonjob setSelected:NO];
    [_btnRadioEmail setSelected:YES];
    [_btnRadioPhone setSelected:NO];
    _viewModeOfContact.hidden=NO;
    _txtModeofContact.placeholder=NSLocalizedString(@"Enter an email address", @"");
      [_txtModeofContact resignFirstResponder];
    _txtModeofContact.keyboardType = UIKeyboardTypeEmailAddress;
     strModeofContact=NSLocalizedString(@"E-mail", @"");
    modeofContactEmailOrPhone=@"";
     _txtModeofContact.text = @"";
}

-(void)postJobByVerified:(id)notification
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:strJobtitle forKey:@"job_title"];
    [params setValue:strDescription forKey:@"job_description"];
    [params setValue:strLocation forKey:@"job_location"];
    
    [params setValue:strTypeOfContract forKey:@"contract_type"];
    [params setValue:strLevelOfEducation forKey:@"education_level"];
    [params setValue:strExperience forKey:@"experience"];
    [params setValue:strJobLanguage forKey:@"lang"];
    [params setValue:strJobNumberOfHrs forKey:@"num_of_hours"];
    [params setValue:strJobSalary forKey:@"salarie"];
    [params setValue:strStartDate forKey:@"start_date"];
    
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:strModeofContact forKey:@"name"];
    [dict setValue:modeofContactEmailOrPhone forKey:@"value"];
    //[arr addObject:dict];
    [params setValue:dict forKey:@"contact_mode"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"publishofferByVerified";
    webHelper.delegate=self;
    
    if (imgOverViewData)
    {
        [webHelper webserviceHelper:params uploadData:imgOverViewData ImageParam:@"job_image" andVideoData:nil withVideoThumbnail:nil type:@"" webServiceUrl:kPostaJob methodName:@"publishofferByVerified" showHud:YES inWhichViewController:self];
    }
    else
    {
        [webHelper webserviceHelper:params webServiceUrl:kPostaJob methodName:@"publishofferByVerified" showHud:YES inWhichViewController:self];
    }
}

- (IBAction)btnPublishAction:(id)sender
{
    if([self validateData])
    {
        if ([self validateData])
        {
            
            if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"enterprise_name"] length]==0)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"BonJob" message:@"Remplissez votre profil avant de poster un travail." delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Ok", @""), nil];
                alert.tag=1005;
                [alert show];
            }
            else
            {
             //   if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"mobile_number"] length]>=3)
              //  {
                    if ([[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] length]==0||[[APPDELEGATE.currentPlanDict  valueForKey:@"subscription_id"] length]==0)
                    {
                        if ([[APPDELEGATE.currentPlanDict valueForKey:@"job_post_count"] intValue]>=1)
                        {
                            if (!_isEdit) {
                                
                                [self openPaymentData];
                                
                            }
                        }
                        else
                        {
                            [self publishJobOffer];
                        }
                    }
                    else
                    {
                    [self publishJobOffer];
                        
                    }
                    //[self.tabBarController setSelectedIndex:3];
               // }
               // else
              //  {
               //     RecruiterVerifyViewController *rvc=[self.storyboard /instantiateViewControllerWithIdentifier:@"RecruiterVerifyViewController"];
               //     [self presentViewController:rvc animated:YES completion:nil];
              //  }
                //[self.tabBarController setSelectedIndex:3];
               
            }
        }
    }
    else
    {
        
    }
    
}
-(void)btnPopupPublishAction:(UIButton *)button
{
    if([self validateData])
    {
        if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"enterprise_name"] length]==0)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"BonJob" message:@"Remplissez votre profil avant de poster un travail." delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Ok", @""), nil];
            alert.tag=1005;
            [alert show];
        }
        else
        {
           // if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"mobile_number"] length]>3)
          //  {
                [self publishJobOffer];
                //[self.tabBarController setSelectedIndex:3];
          //  }
//            else
//            {
//                //[self.tabBarController setSelectedIndex:3];
//                RecruiterVerifyViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterVerifyViewController"];
//                [self presentViewController:rvc animated:YES completion:nil];
//            }
        }
    }
    else
    {
        
    }
    
}

- (IBAction)btnViewMyOfferAction:(id)sender
{
    if ([self.identifier isEqualToString:@"update"])
    {
        [SharedClass hidePopupView:_viewJobPostSuccessBackground andTabbar:self.tabBarController];
        [SharedClass hidePopupView:_viewJobPostSuccessPopup];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PublishSuccess" object:self];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.tabBarController setSelectedIndex:1];
        [self performSelector:@selector(nowFire) withObject:nil afterDelay:0.1];
        [SharedClass hidePopupView:_viewJobPostSuccessBackground andTabbar:self.tabBarController];
        [SharedClass hidePopupView:_viewJobPostSuccessPopup];
        
        
    }
}
-(void)nowFire
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PublishSuccess" object:self];
}

- (IBAction)btnEditMyProfileAction:(id)sender
{
    [SharedClass hidePopupView:_viewJobPostSuccessBackground andTabbar:self.tabBarController];
    [SharedClass hidePopupView:_viewJobPostSuccessPopup];
    [self.tabBarController setSelectedIndex:4];
}

#pragma mark - ---------Validate Data Before Submit-------------
-(void)paymentPopupClose
{
    if ([[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] length]==0||[[APPDELEGATE.currentPlanDict  valueForKey:@"subscription_id"] length]==0)
    {
        if ([[APPDELEGATE.currentPlanDict valueForKey:@"job_post_count"] intValue]>=1)
        {
            [self.tabBarController setSelectedIndex:1];
        }
    }
}
-(void)openPaymentData
{
    
    // By Cs Rai....
    // Dismiss overview popup first if it is already appearing
    
    [SharedClass hidePopupViewforPreview:_viewbackgroundoverview andTabbar:self.tabBarController];
    [SharedClass hidePopupViewforPreview:self.viewoverviewdeatails];
    
    // Show Payment data Popup
    PaymentDataViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDataViewController"];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

-(BOOL)validateData
{
    [self.txtModeofContact resignFirstResponder];
    if ([strLanguageOfoffer isEqualToString:@""]||strLanguageOfoffer.length==0)
    {
        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please select a language", @"")];
        return NO;
    }
    else if ([ _txtJobOffered.text isEqualToString:@""]|| _txtJobOffered.text.length==0)
    {
        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please enter a job title", @"")];
        return NO;
    }

    else if ([strLocation isEqualToString:@""]||strLocation.length==0)
    {
        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please select a location", @"")];
        return NO;
    }

    else if ([strModeofContact isEqualToString:@""]||strModeofContact.length==0)
    {
        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please select mode of contact", @"")];
        return NO;
    }
    
    else if (strModeofContact.length>0 && modeofContactEmailOrPhone.length==0)
    {
        if ([strModeofContact isEqualToString:NSLocalizedString(@"BonJob Chat", @"")])
        {
            return YES;
        }
        else
        {
            //strModeofContact=NSLocalizedString(@"E-mail", @"");
            //strModeofContact=NSLocalizedString(@"Phone", @"");
            if ([strModeofContact isEqualToString:NSLocalizedString(@"Phone", @"")])
            {
                [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please enter a phone number", @"")];
                return NO;
            }
            else if ([strModeofContact isEqualToString:NSLocalizedString(@"E-mail", @"")])
            {
                [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please enter a valid email", @"")];
                return NO;
            }
            else
                return YES;
        }
    }
    else if([strModeofContact isEqualToString:NSLocalizedString(@"E-mail", @"")] && [self isNotValidEmail])
    {
        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please enter a valid email", @"")];
        return NO;
    }
    else
    return YES;
}

-(BOOL)isNotValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL B = [emailTest evaluateWithObject:_txtModeofContact.text];
    if (!B)
    {
        return YES;
    }
    else
    
        return NO;
}

#pragma mark - ----------Publish Job Offer webservice Delegates------------

-(void)getJobPositions
{
   // http://172.104.8.51/bonjob_new/services2/jobPostDropdowns
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"JobPositions";
    [webhelper webserviceHelper:kGetJobPositionsDropDowns showHud:YES];
}

-(void)publishJobOffer
{
    if(strJobtitleId == nil || [strJobtitleId isEqualToString:@""])
    {
        strJobtitleId = @"0";
        strJobtitle = _txtJobOffered.text;
    }
    /*
     strLanguageOfoffer
    strJobtitle
    imgOverViewData
    strLocation
     strTypeOfContract
      strLevelOfEducation
      strExperience
      strJobLanguage
      strJobNumberOfHrs
      strJobSalary
      strStartDate
      strDescription
      strModeofContact
      strModeofContact
      modeofContactEmailOrPhone
     */
    
    /*{{"user_id":"1","job_title":"Urgent job","job_description":"dfdfdfdf fdf dfdfd ","job_image":"test.jpg","job_location":"noida","contract_type":"fgfggfggfg","education_level":"B.Tech","experience":"4 years","lang":"sdd f df","num_of_hours":"4 hours","salarie":"60k","start_date":"12-07-2017","contact_mode":"[name=>email,value=>pavan@mail.com]"}} */
    
    NSDictionary *dicCurrentPlan = APPDELEGATE.currentPlanDict;
    NSLog(@"%@", dicCurrentPlan);
    
    if (([[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] length]==0||[[APPDELEGATE.currentPlanDict  valueForKey:@"subscription_id"] length]==0) && !([self.identifier isEqualToString:@"update"]))
    {
        
        if ([[APPDELEGATE.currentPlanDict valueForKey:@"job_post_count"] intValue]>=1)
        {
            
            
            if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"email"] isEqualToString:@"bonjobcontact@gmail.com"])
            {
                if ([[APPDELEGATE.currentPlanDict valueForKey:@"job_post_count"] intValue]>3)
                {
                    [self openPaymentData];
                }
                else
                {
                    NSLog(@"Else added By CS Rai");
                    
                    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
                    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
                    [params setValue:strJobtitle forKey:@"job_title"];
                     [params setValue:strJobtitleId forKey:@"job_title_id"];
                    
                    [params setValue:strDescription forKey:@"job_description"];
                    [params setValue:strLocation forKey:@"job_location"];
                    
                    [params setValue:@"" forKey:@"contract_type"];
                     [params setValue:@"" forKey:@"education_level"];
                    [params setValue:@"" forKey:@"experience"];
                     [params setValue:@"" forKey:@"lang"];
                    [params setValue:@"" forKey:@"num_of_hours"];
                     [params setValue:@"" forKey:@"salarie"];
                    
                    if (arrSelContract.count > 0) {
                        JobSearchFilter * obj = arrSelContract[0];
                       [params setValue:obj.contract_id forKey:@"contract_type"];
                    }
                    if (arrSelEducation.count > 0) {
                        JobSearchFilter * obj = arrSelEducation[0];
                        [params setValue:obj.education_id forKey:@"education_level"];
                    }
                    if (arrSelExperience.count > 0) {
                        JobSearchFilter * obj = arrSelExperience[0];
                        [params setValue:obj.experience_id forKey:@"experience"];
                    }
                    if (arrSelLang.count > 0) {
                        LevelOfLanguageModel * obj = arrSelLang[0];
                        [params setValue:obj.job_language_id forKey:@"lang"];
                    }
                    if (arrSelHours.count > 0) {
                        JobSearchFilter * obj = arrSelHours[0];
                        [params setValue:obj.hours_id forKey:@"num_of_hours"];
                    }
                    if (arrSelSalary.count > 0) {
                        SalariesModel * obj = arrSelSalary[0];
                        [params setValue:obj.salary_id forKey:@"salarie"];
                    }
                    
                    [params setValue:strStartDate forKey:@"start_date"];
                    
                    
                    
                    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                    
                    [dict setValue:strModeofContact forKey:@"name"];
                    [dict setValue:modeofContactEmailOrPhone forKey:@"value"];
                    //[arr addObject:dict];
                    [params setValue:dict forKey:@"contact_mode"];
                    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
                    webHelper.methodName=@"publishoffer";
                    webHelper.delegate=self;
                    
                    if (imgOverViewData)
                    {
                        [webHelper webserviceHelper:params uploadData:imgOverViewData ImageParam:@"job_image" andVideoData:nil withVideoThumbnail:nil type:@"" webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
                    }
                    else
                    {
                        [webHelper webserviceHelper:params webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
                    }
                }
            }
            else
            {
                if (!_isEdit) {
                    [self openPaymentData];
                }
               
            }
            
            
            
            
        } else {
            
            NSLog(@"Else added By CS Rai");
            
                NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
                [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
            [params setValue:strJobtitle forKey:@"job_title"];
            [params setValue:strJobtitleId forKey:@"job_title_id"];
                [params setValue:strDescription forKey:@"job_description"];
                [params setValue:strLocation forKey:@"job_location"];
                
            
            [params setValue:@"" forKey:@"contract_type"];
            [params setValue:@"" forKey:@"education_level"];
            [params setValue:@"" forKey:@"experience"];
            [params setValue:@"" forKey:@"lang"];
            [params setValue:@"" forKey:@"num_of_hours"];
            [params setValue:@"" forKey:@"salarie"];
            
            if (arrSelContract.count > 0) {
                JobSearchFilter * obj = arrSelContract[0];
                [params setValue:obj.contract_id forKey:@"contract_type"];
            }
            if (arrSelEducation.count > 0) {
                JobSearchFilter * obj = arrSelEducation[0];
                [params setValue:obj.education_id forKey:@"education_level"];
            }
            if (arrSelExperience.count > 0) {
                JobSearchFilter * obj = arrSelExperience[0];
                [params setValue:obj.experience_id forKey:@"experience"];
            }
            if (arrSelLang.count > 0) {
                LevelOfLanguageModel * obj = arrSelLang[0];
                [params setValue:obj.job_language_id forKey:@"lang"];
            }
            if (arrSelHours.count > 0) {
                JobSearchFilter * obj = arrSelHours[0];
                [params setValue:obj.hours_id forKey:@"num_of_hours"];
            }
            if (arrSelSalary.count > 0) {
                SalariesModel * obj = arrSelSalary[0];
                [params setValue:obj.salary_id forKey:@"salarie"];
            }
            
                [params setValue:strStartDate forKey:@"start_date"];
                
                
                
                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                
                [dict setValue:strModeofContact forKey:@"name"];
                [dict setValue:modeofContactEmailOrPhone forKey:@"value"];
                //[arr addObject:dict];
                [params setValue:dict forKey:@"contact_mode"];
                WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
                webHelper.methodName=@"publishoffer";
                webHelper.delegate=self;
                
                if (imgOverViewData)
                {
                    [webHelper webserviceHelper:params uploadData:imgOverViewData ImageParam:@"job_image" andVideoData:nil withVideoThumbnail:nil type:@"" webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
                }
                else
                {
                    [webHelper webserviceHelper:params webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
                }
                
        }
    }
    else
    {
        if ([self.identifier isEqualToString:@"update"])
        {
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
            //        [params setValue:[dictJobData valueForKey:@"job_title"] forKey:@"job_title"];
            //        [params setValue:[dictJobData valueForKey:@"job_description"] forKey:@"job_description"];
            //        [params setValue:[dictJobData valueForKey:@"job_location"] forKey:@"job_location"];
            //
            //        [params setValue:[dictJobData valueForKey:@"contract_type"] forKey:@"contract_type"];
            //        [params setValue:[dictJobData valueForKey:@"education_level"] forKey:@"education_level"];
            //        [params setValue:[dictJobData valueForKey:@"experience"] forKey:@"experience"];
            //        [params setValue:[dictJobData valueForKey:@"lang"] forKey:@"lang"];
            //        [params setValue:[dictJobData valueForKey:@"num_of_hours"] forKey:@"num_of_hours"];
            //        [params setValue:[dictJobData valueForKey:@"salarie"] forKey:@"salarie"];
            //        [params setValue:[dictJobData valueForKey:@"start_date"] forKey:@"start_date"];
            
            [params setValue:strJobtitle forKey:@"job_title"];
            [params setValue:strJobtitleId forKey:@"job_title_id"];
            [params setValue:strDescription forKey:@"job_description"];
            [params setValue:strLocation forKey:@"job_location"];
            
            [params setValue:@"" forKey:@"contract_type"];
            [params setValue:@"" forKey:@"education_level"];
            [params setValue:@"" forKey:@"experience"];
            [params setValue:@"" forKey:@"lang"];
            [params setValue:@"" forKey:@"num_of_hours"];
            [params setValue:@"" forKey:@"salarie"];
            
            if (arrSelContract.count > 0) {
                JobSearchFilter * obj = arrSelContract[0];
                [params setValue:obj.contract_id forKey:@"contract_type"];
            }
            if (arrSelEducation.count > 0) {
                JobSearchFilter * obj = arrSelEducation[0];
                [params setValue:obj.education_id forKey:@"education_level"];
            }
            if (arrSelExperience.count > 0) {
                JobSearchFilter * obj = arrSelExperience[0];
                [params setValue:obj.experience_id forKey:@"experience"];
            }
            if (arrSelLang.count > 0) {
                LevelOfLanguageModel * obj = arrSelLang[0];
                [params setValue:obj.job_language_id forKey:@"lang"];
            }
            if (arrSelHours.count > 0) {
                JobSearchFilter * obj = arrSelHours[0];
                [params setValue:obj.hours_id forKey:@"num_of_hours"];
            }
            if (arrSelSalary.count > 0) {
                SalariesModel * obj = arrSelSalary[0];
                [params setValue:obj.salary_id forKey:@"salarie"];
            }
            
            [params setValue:strStartDate forKey:@"start_date"];
            
            [params setValue:[dictJobData valueForKey:@"job_id"] forKey:@"job_id"];
            
            
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            
            //NSArray *foo=[[dictJobData valueForKey:@"contact_mode"]componentsSeparatedByString:@":"];
            //        NSArray *foo=[strModeofContact componentsSeparatedByString:@":"];
            //        if (foo.count>1)
            //        {
            //            [dict setValue:[foo objectAtIndex:0] forKey:@"name"];
            //            [dict setValue:[foo objectAtIndex:1] forKey:@"value"];
            //        }
            
            [dict setValue:strModeofContact forKey:@"name"];
            [dict setValue:modeofContactEmailOrPhone forKey:@"value"];
            
            [params setValue:dict forKey:@"contact_mode"];
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.methodName=@"jobupdated";
            webHelper.delegate=self;
            
            if (imgOverViewData)
            {
                [webHelper webserviceHelper:params uploadData:imgOverViewData ImageParam:@"job_image" andVideoData:nil withVideoThumbnail:nil type:@"" webServiceUrl:kUpdateJob methodName:@"jobupdated" showHud:YES inWhichViewController:self];
            }
            else
            {
                [webHelper webserviceHelper:params webServiceUrl:kUpdateJob methodName:@"jobupdated" showHud:YES inWhichViewController:self];
            }
            
            
            //{"job_id":"1","job_title":"Urgent job","job_description":"dfdfdfdf fdf dfdfd ","job_image":"test.jpg","job_location":"noida","contract_type":"fgfggfggfg","education_level":"B.Tech","experience":"4 years","lang":"sdd f df","num_of_hours":"4 hours","salarie":"60k","start_date":"12-07-2017","contact_mode":"[name=>email,value=>pavan@mail.com]"}
        }
        else
        {
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
            [params setValue:strJobtitle forKey:@"job_title"];
            [params setValue:strJobtitleId forKey:@"job_title_id"];
            [params setValue:strDescription forKey:@"job_description"];
            [params setValue:strLocation forKey:@"job_location"];
            
           
            [params setValue:@"" forKey:@"contract_type"];
            [params setValue:@"" forKey:@"education_level"];
            [params setValue:@"" forKey:@"experience"];
            [params setValue:@"" forKey:@"lang"];
            [params setValue:@"" forKey:@"num_of_hours"];
            [params setValue:@"" forKey:@"salarie"];
            
            if (arrSelContract.count > 0) {
                JobSearchFilter * obj = arrSelContract[0];
                [params setValue:obj.contract_id forKey:@"contract_type"];
            }
            if (arrSelEducation.count > 0) {
                JobSearchFilter * obj = arrSelEducation[0];
                [params setValue:obj.education_id forKey:@"education_level"];
            }
            if (arrSelExperience.count > 0) {
                JobSearchFilter * obj = arrSelExperience[0];
                [params setValue:obj.experience_id forKey:@"experience"];
            }
            if (arrSelLang.count > 0) {
                LevelOfLanguageModel * obj = arrSelLang[0];
                [params setValue:obj.job_language_id forKey:@"lang"];
            }
            if (arrSelHours.count > 0) {
                JobSearchFilter * obj = arrSelHours[0];
                [params setValue:obj.hours_id forKey:@"num_of_hours"];
            }
            if (arrSelSalary.count > 0) {
                SalariesModel * obj = arrSelSalary[0];
                [params setValue:obj.salary_id forKey:@"salarie"];
            }
            
            [params setValue:strStartDate forKey:@"start_date"];
            
            
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            
            [dict setValue:strModeofContact forKey:@"name"];
            [dict setValue:modeofContactEmailOrPhone forKey:@"value"];
            //[arr addObject:dict];
            [params setValue:dict forKey:@"contact_mode"];
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.methodName=@"publishoffer";
            webHelper.delegate=self;
            
            if (imgOverViewData)
            {
                [webHelper webserviceHelper:params uploadData:imgOverViewData ImageParam:@"job_image" andVideoData:nil withVideoThumbnail:nil type:@"" webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
            }
            else
            {
                [webHelper webserviceHelper:params webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
            }
            
        }
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
    if ([methodNameIs isEqualToString:@"publishoffer"])
    {
        if ([[responseDict valueForKey:@"success"] intValue]==1)
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            dict=[APPDELEGATE.currentPlanDict mutableCopy];
            [dict setValue:@"1" forKey:@"job_post_count"];
            APPDELEGATE.currentPlanDict=dict;
//            PublishSuccessViewController *pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PublishSuccessViewController"];
//            pvc.delegate=self;
//            [self presentViewController:pvc animated:YES completion:nil];
//            [SharedClass hidePopupView:_viewbackgroundoverview andTabbar:self.tabBarController];
            //_viewbackgroundoverview.hidden = YES;
            
            _viewoverviewdeatails.hidden = YES;
            [SharedClass hidePopupViewforPreview:_viewbackgroundoverview andTabbar:self.tabBarController];
            [SharedClass hidePopupViewforPreview:self.viewoverviewdeatails];
            _viewJobPostSuccessBackground.hidden=NO;
            _viewJobPostSuccessPopup.hidden=NO;
            [SharedClass showPopupView:_viewJobPostSuccessBackground andTabbar:self.tabBarController];
            [SharedClass showPopupView:_viewJobPostSuccessPopup];
            
            
            strJobtitle =@"";
            strDescription=@"";
            //strLocation=@"";
            strTypeOfContract=@"";
            strLevelOfEducation=@"";
            strExperience=@"";
            strJobLanguage=@"";
            strJobNumberOfHrs=@"";
            
            strJobSalary=@"";
            strStartDate=@"";
            modeofContactEmailOrPhone=@"";
            _txtJobOffered.text=@"";
            _txtModeofContact.text = @"";
            
            [arrCollectionAImages removeAllObjects];
            [arrayjoboffercomplete removeAllObjects];
            
            _textviewadditionaldescription.text=@"";
            _lblStartDate.text=@"";
            
            imgOverViewData=nil;
            
            [arrSelContract removeAllObjects];
            [arrSelExperience removeAllObjects];
            [arrSelEducation removeAllObjects];
            [arrSelHours removeAllObjects];
            [arrSelSalary removeAllObjects];
            [arrSelLang removeAllObjects];
            strJobtitleId = @"";
            
            
            
            [_collectionviewjoboffer reloadData];
        }
        else
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"jobupdated"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            _viewoverviewdeatails.hidden = YES;
            [SharedClass hidePopupViewforPreview:_viewbackgroundoverview andTabbar:self.tabBarController];
            [SharedClass hidePopupViewforPreview:self.viewoverviewdeatails];
            _viewJobPostSuccessBackground.hidden=NO;
            _viewJobPostSuccessPopup.hidden=NO;
            [SharedClass showPopupView:_viewJobPostSuccessBackground andTabbar:self.tabBarController];
            [SharedClass showPopupView:_viewJobPostSuccessPopup];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jobofferupdated" object:self];
        }
        else
        {
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"publishofferByVerified"])
    {
        if ([[responseDict valueForKey:@"success"] intValue]==1)
        {
        _viewoverviewdeatails.hidden = YES;
        [SharedClass hidePopupViewforPreview:_viewbackgroundoverview andTabbar:self.tabBarController];
        [SharedClass hidePopupViewforPreview:self.viewoverviewdeatails];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            dict=[APPDELEGATE.currentPlanDict mutableCopy];
            [dict setValue:@"1" forKey:@"job_post_count"];
            APPDELEGATE.currentPlanDict=dict;
//        _viewJobPostSuccessBackground.hidden=NO;
//        _viewJobPostSuccessPopup.hidden=NO;
//        [SharedClass showPopupView:_viewJobPostSuccessBackground andTabbar:self.tabBarController];
//        [SharedClass showPopupView:_viewJobPostSuccessPopup];
        
        strJobtitle =@"";
        strDescription=@"";
        //strLocation=@"";
        strTypeOfContract=@"";
        strLevelOfEducation=@"";
        strExperience=@"";
        strJobLanguage=@"";
        strJobNumberOfHrs=@"";
        
        strJobSalary=@"";
        strStartDate=@"";
        modeofContactEmailOrPhone=@"";
        _txtJobOffered.text=@"";
        [arrCollectionAImages removeAllObjects];
        [arrayjoboffercomplete removeAllObjects];
        
        _textviewadditionaldescription.text=@"";
        _lblStartDate.text=@"";
        
        imgOverViewData=nil;
        
        arrCollectionAImages=[[NSMutableArray alloc]init];
        [arrCollectionAImages addObject:@"blue_doc.png"];
        [arrCollectionAImages addObject:@"blue_education.png"];
        [arrCollectionAImages addObject:@"blue_book.png"];
        [arrCollectionAImages addObject:@"blueglobe.png"];
        [arrCollectionAImages addObject:@"blue_time.png"];
        [arrCollectionAImages addObject:@"blue_money.png"];
        
        
        arrayjoboffercomplete  = [[NSMutableArray alloc] initWithObjects:NSLocalizedString(@"Type of contract", @""),NSLocalizedString(@"Level of education", @""),
                                  NSLocalizedString(@"Experience", @""),
                                  NSLocalizedString(@"Languages", @"")  ,NSLocalizedString(@"Number of hours", @""),NSLocalizedString(@"Salary", @""),nil];
        
        [_collectionviewjoboffer reloadData];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"JOBPOSTEDBYVERIFIED" object:nil];
    }
    else
    {
        [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
        //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
    }
    }
    else if([methodNameIs isEqualToString:@"JobPositions"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==1)
        {
            for (NSDictionary *dict in [responseDict valueForKey:@"contractTypes"]) {
                
                JobSearchFilter *obj = [[JobSearchFilter alloc]init];
                [arrContract addObject:[obj initWithDictContract:dict type:@"contract"]];
            }
            
            for (NSDictionary *dict in [responseDict valueForKey:@"educationLevels"]) {
                
                JobSearchFilter *obj = [[JobSearchFilter alloc]init];
                [arrEducation addObject:[obj initWithDictContract:dict type:@"education"]];
            }
            for (NSDictionary *dict in [responseDict valueForKey:@"experiences"]) {
                
                JobSearchFilter *obj = [[JobSearchFilter alloc]init];
                [arrExperience addObject:[obj initWithDictContract:dict type:@"experience"]];
            }
            for (NSDictionary *dict in [responseDict valueForKey:@"jobLanguages"]) {
                
                LevelOfLanguageModel *obj = [[LevelOfLanguageModel alloc]init];
                [arrLang addObject:[obj initWithDict:dict]];
            }
            for (NSDictionary *dict in [responseDict valueForKey:@"numberOfHours"]) {
                
                JobSearchFilter *obj = [[JobSearchFilter alloc]init];
                [arrHours addObject:[obj initWithDictContract:dict type:@"hours"]];
            }
            for (NSDictionary *dict in [responseDict valueForKey:@"salaries"]) {
                
                SalariesModel *obj = [[SalariesModel alloc]init];
                [arrSalary addObject:[obj initWithDict:dict]];
            }
            
            if([self.identifier isEqualToString:@"update"])
            {
                if (strTypeOfContract.length>0 && ![strTypeOfContract isEqualToString:@"0"])
                {
                  
         [arrSelContract addObject:[arrContract objectAtIndex:strTypeOfContract.intValue - 1]];
                }
                if (strLevelOfEducation.length>0 && ![strLevelOfEducation isEqualToString:@"0"])
                {
                     [arrSelEducation addObject:[arrEducation objectAtIndex:strLevelOfEducation.intValue - 1]];
                }
                if (strExperience.length>0 && ![strExperience isEqualToString:@"0"])
                {
                    [arrSelExperience addObject:[arrExperience objectAtIndex:strExperience.intValue - 1]];
                }
                if (strLanguage.length>0 && ![strLanguage isEqualToString:@"0"])
                {
                    [arrSelLang addObject:[arrLang objectAtIndex:strLanguage.intValue - 1]];
                }
                if (strJobNumberOfHrs.length>0 && ![strJobNumberOfHrs isEqualToString:@"0"])
                {
                   [arrSelHours addObject:[arrHours objectAtIndex:strJobNumberOfHrs.intValue - 1]];
                    
                }
                if (strJobSalary.length>0 && ![strJobSalary isEqualToString:@"0"])
                {
                    [arrSelSalary addObject:[arrSalary objectAtIndex:strJobSalary.intValue - 1]];
                }
            }
            
            [_collectionviewjoboffer reloadData];
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    
}

-(void)inProgress:(float)value
{
    
}

#pragma mark - ---------PublishSuccess Delegate----------

-(void)gotoMyProfileTapped
{
    [self.tabBarController setSelectedIndex:4];
}
-(void)viewMyOfferTapped
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PublishSuccess" object:self];
    [self.tabBarController setSelectedIndex:1];
}

#pragma mark - LocationData delegate
-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
    _lblLocation.text=address;
    strLocation=address;
    latt=lattitute;
    lang=Longitute;
}

- (void)toggleTabBar:(BOOL)hiddenTabBar
{
    
    self.tabBarController.tabBar.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        if (hiddenTabBar)
        {
            self.tabBarController.tabBar.center = CGPointMake(self.tabBarController.tabBar.center.x, self.view.window.bounds.size.height-self.tabBarController.tabBar.bounds.size.height/2);
        }
        else
        {
            self.tabBarController.tabBar.center = CGPointMake(self.tabBarController.tabBar.center.x, self.view.window.bounds.size.height+self.tabBarController.tabBar.bounds.size.height);
        }
        
    }
     completion:^(BOOL finished)
     {
        
    }];
}



- (IBAction)btnValidateLanguagesAction:(id)sender
{
    [arrCollectionAImages replaceObjectAtIndex:currentCollectionSelectedIndex withObject:@"pink_check.png"];
    currentCollectionSelectedIndex=-1;
    [_tblLanguages reloadData];
    [SharedClass hidePopupView:_viewbackgroundoverview andTabbar:self.tabBarController];
    [SharedClass hidePopupView:_viewLanguagesPopup];
}

- (IBAction)btnCloseLanguagesPopupAction:(id)sender
{
    [SharedClass hidePopupView:_viewbackgroundoverview andTabbar:self.tabBarController];
    [SharedClass hidePopupView:_viewLanguagesPopup];
}
#pragma mark - ---------PAYMENT MODULE CALLBACKS-------

- (void)paymentDone:(BOOL)value
{
    if (!value)
    {
        PaymentRejectViewController *pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentRejectViewController"];
        pvc.delegate=self;
        [pvc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        [pvc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self presentViewController:pvc animated:YES completion:nil];
    }
    else
    {
        PaymentAcceptViewController *pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentAcceptViewController"];
        pvc.delegate=self;
        [pvc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        [pvc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self presentViewController:pvc animated:YES completion:nil];
    }
}

-(void)paymentPlanSelected:(long)index
{
    PaymentDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDetailsViewController"];
    vc.planDict=[APPDELEGATE.arrPlanData objectAtIndex:index];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)openEditProfile
{
    [self.tabBarController setSelectedIndex:4];
}

- (void)openPostJobController {
    [self.tabBarController setSelectedIndex:3];
}

- (void)openSearchCandidateController
{
    [self.tabBarController setSelectedIndex:0];
}




@end