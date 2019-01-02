//
//  JobOfferDetailViewController.m
//  BonjobScreen9
//
//  Created by Infoicon Technologies on 14/06/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "JobOfferDetailViewController.h"
#import "GetJobModel.h"
#import "CompanyPageDetailsViewController.h"
#import <Social/Social.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerSharer.h>
#import "AppliedJobViewController.h"
#define METERS_PER_MILE 1609.344

@interface JobOfferDetailViewController ()<MFMailComposeViewControllerDelegate,AppiledControllerDissmissedDelegate>
{
    NSMutableArray *arrResponse;
    NSDictionary *dataDict;
    NSString *ReportUniqueID;
}
@end
@implementation JobOfferDetailViewController
@synthesize mapView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self initialSetup];
    self.title=self.jobTitle;
    [_viewNoData setHidden:NO];
    
//    arrResponse=[[NSMutableArray alloc]initWithArray:[[[GetJobModel getModel]getResponse] mutableCopy]];
//    dataDict = [[NSDictionary alloc]init];
//    dataDict=[arrResponse objectAtIndex:[self.index intValue]];
//    
//    [self setData];
    
    [self getJobDetails];
    
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
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    
    //[_viewMain setFrame:CGRectMake(_viewMain.frame.origin.x, _viewMain.frame.origin.y,_viewMain.frame.size.width,_viewMain.frame.size.height-300)];
    NSString *appyOn=[dataDict valueForKey:@"apply_on"];
    if (appyOn.length>0)
    {
        [self.btnApplyJob setTitle:NSLocalizedString(@"Applied", @"") forState:UIControlStateNormal];
        _btnApplyJob.backgroundColor=InternalButtonColor;
        _btnApplyJob.userInteractionEnabled=FALSE;
    }
    else
    {
//        [_viewLower setFrame:CGRectMake(_viewLower.frame.origin.x, 380, _viewLower.frame.size.width, _viewLower.frame.size.height)];
//        _tblView.translatesAutoresizingMaskIntoConstraints = true;
//         _viewMain.translatesAutoresizingMaskIntoConstraints = true;
        NSString *website=[dataDict valueForKey:@"website"];
        if([website isKindOfClass:[NSNull class]] || website==nil ||  website == (id)[NSNull null] || website.length == 0)
        {
            
//            [_tblView setFrame:CGRectMake(_tblView.frame.origin.x, 64, _tblView.frame.size.width, [UIScreen mainScreen].bounds.size.height + 120.0)];
        }
        else{
//            [_tblView setFrame:CGRectMake(_tblView.frame.origin.x, 64, _tblView.frame.size.width, [UIScreen mainScreen].bounds.size.height + 64.0)];
        }
       // [_viewMain setFrame:CGRectMake(_viewMain.frame.origin.x, 0, _viewMain.frame.size.width, 1000.0)];
       // [_viewMain setFrame:CGRectMake(_viewMain.frame.origin.x, _viewMain.frame.origin.y,_viewMain.frame.size.width,200)];
       
        _btnApplyJob.backgroundColor=TitleColor;
        _btnApplyJob.userInteractionEnabled=YES;
        [self.btnApplyJob setTitle:NSLocalizedString(@"Apply", @"") forState:UIControlStateNormal];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ------Get Job Details-------

-(void)getJobDetails
{
    //{"job_id":"1","user_id":"1"}
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [dict setValue:self.jobId forKey:@"job_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"GetDetails";
    webhelper.delegate=self;
    [webhelper webserviceHelper:dict webServiceUrl:kGobDetails methodName:@"GetDetails" showHud:YES inWhichViewController:self];
}

-(void)viewDismissed
{
    [self.tabBarController setSelectedIndex:4];
    [self.tabBarController.selectedViewController viewWillAppear:YES];
}
-(void)viewDismissedReLoad
{

}
-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
        {
           // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
           // [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
           // [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
           // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    else if ([methodNameIs isEqualToString:@"applyjob"])
    {
         APPDELEGATE.isNeedLoad = true;
        NSString *apply_On = [[responseDict[@"data"]objectAtIndex:0]valueForKey:@"apply_on"];
        AppliedJobViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AppliedJobViewController"];
        vc.delegate=self;
        [dataDict setValue:apply_On forKey:@"apply_on"];
        [self setData];
        [self presentViewController:vc animated:YES completion:nil];
    }
    if ([methodNameIs isEqualToString:@"GetDetails"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [_viewNoData setHidden:YES];
            dataDict=[[NSMutableDictionary alloc]init];
            dataDict=[[responseDict valueForKey:@"data"] objectAtIndex:0];
            [self setData];
        }
        else
        {
            [_viewNoData setHidden:NO];
        }
    }
    else if ([methodNameIs isEqualToString:@"contentReport"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            //[self showAlert:[responseDict valueForKey:@"msg"]];
        }
        else
        {
            //[self showAlert:[responseDict valueForKey:@"msg"]];
        }
    }
}

-(void)setData
{
    _topView.layer.borderColor=[UIColor colorWithRed:214/255.0 green:214/255.0 blue:223/255.0 alpha:1.0].CGColor;
    _topView.layer.borderWidth = 1.0;
    
    if([[dataDict valueForKey:@"enterprise_name"] isKindOfClass:[NSNull class]] || [dataDict valueForKey:@"enterprise_name"]==nil ||  [dataDict valueForKey:@"enterprise_name"] == (id)[NSNull null])
    {
        _lblCompanyName.text = @"";
    }
    else{
        _lblCompanyName.text=[dataDict valueForKey:@"enterprise_name"];
    }

    _txtViewDescription.text=[dataDict valueForKey:@"job_title"];
    [_imgHotelPic sd_setImageWithURL:[NSURL URLWithString:[dataDict valueForKey:@"job_image"]] placeholderImage:[UIImage imageNamed:@"default_job.png"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        if (error)
        {
            [_imgHotelPic setImage:[UIImage imageNamed:@"default_job.png"]];
        }
    }];
    
    if ([[dataDict valueForKey:@"job_image"] length]==0 && [[dataDict valueForKey:@"origin"] isEqualToString:@"pole-emploi"])
    {
        [_imgHotelPic setImage: [UIImage imageNamed:@""]];
        [_imgHotelPic setImage:[UIImage imageNamed:@"pole.png"]];
    }

    _lblJobOfferedTime.text=[dataDict valueForKey:@"offer_posted_on"];
    
    _lblJobOfferedTime.text=[Alert getDateWithString:[dataDict valueForKey:@"offer_posted_on"] getFormat:GET_FORMAT_TYPE setFormat:SET_FORMAT_TYPE4];
    
    _lblJobOfferPostedDate.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Offer posted on", @""),[Alert getDateWithString:[dataDict valueForKey:@"offer_posted_on"] getFormat:GET_FORMAT_TYPE setFormat:SET_FORMAT_TYPE4]];
    
    NSString *website=[dataDict valueForKey:@"website"];
    if([website isKindOfClass:[NSNull class]] || website==nil ||  website == (id)[NSNull null] || website.length == 0)
    {
     //   website = @"Indisponible";
        _imgWebsiteHeight.constant = 0;
        _lblCompanyWebsiteHeight.constant = 0;
        _btnWebsiteHeight.constant = 0;
        
    }
    else
    {
        if ([website containsString:@"www"])
        {
         // website = @"Indisponible";
        }
        else
        {
            website=[NSString stringWithFormat:@"www.%@",website];
        }
        
        [_btnVisitWebSIte setTitle:website forState:UIControlStateNormal];
        
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:website attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
        [titleString addAttribute:NSForegroundColorAttributeName value:TitleColor range:NSMakeRange(0, titleString.length)];
        
        //use the setAttributedTitle method
        [_btnVisitWebSIte setAttributedTitle:titleString forState:UIControlStateNormal];
       
    }
   
    _lblAppliedDate.text = [dataDict valueForKey:@"apply_on"];
    _lblAppliedCandidateDate.text=[dataDict valueForKey:@"apply_on"];
    NSString *joblocation = [dataDict valueForKey:@"job_location"];
    if(![joblocation isKindOfClass:[NSNull class]] && joblocation!=nil &&  joblocation != (id)[NSNull null] &&  joblocation.length != 0)
    {
    _lblCompanyLocationValue.text = joblocation;
    }
    
    NSString *appyOn=[dataDict valueForKey:@"apply_on"];
    if (appyOn.length>0)
    {
        [self.btnApplyJob setTitle:NSLocalizedString(@"Applied", @"") forState:UIControlStateNormal];
        _btnApplyJob.backgroundColor=InternalButtonColor;
        _btnApplyJob.userInteractionEnabled=FALSE;
    }
    else
    {
        [_viewLower setFrame:CGRectMake(_viewLower.frame.origin.x, 380, _viewLower.frame.size.width, _viewLower.frame.size.height)];
       _tblView.translatesAutoresizingMaskIntoConstraints = true;
        _viewMain.translatesAutoresizingMaskIntoConstraints = true;
        NSString *website=[dataDict valueForKey:@"website"];
        if([website isKindOfClass:[NSNull class]] || website==nil ||  website == (id)[NSNull null] || website.length == 0)
        {
           
              [_tblView setFrame:CGRectMake(_tblView.frame.origin.x, 64, _tblView.frame.size.width, [UIScreen mainScreen].bounds.size.height + 120.0)];
        }
        else{
            [_tblView setFrame:CGRectMake(_tblView.frame.origin.x, 64, _tblView.frame.size.width, [UIScreen mainScreen].bounds.size.height + 64.0)];
        }
     
         [_viewMain setFrame:CGRectMake(_viewMain.frame.origin.x, 0, _viewMain.frame.size.width, 1000.0)];
       // [_tblView setFrame:CGRectMake(_tblView.frame.origin.x, 64, _tblView.frame.size.width, _tblView.frame.size.height - 180.0)];
     
//        [_viewMain setFrame:CGRectMake(_viewMain.frame.origin.x, _viewMain.frame.origin.y,_viewMain.frame.size.width,200)];

        _btnApplyJob.backgroundColor=TitleColor;
        _btnApplyJob.userInteractionEnabled=YES;
        [self.btnApplyJob setTitle:NSLocalizedString(@"Apply", @"") forState:UIControlStateNormal];
    }
    if ([dataDict valueForKey:@"applyStatus"] != [NSNull null] && [[dataDict valueForKey:@"applyStatus"] length]>0)
    {
//        _lblJobOfferDetails.text=[self getDescriptionWithStatus:[[dataDict valueForKey:@"applyStatus"]intValue]];
//        _lblJobOfferDetails.translatesAutoresizingMaskIntoConstraints=YES;
//        CGRect frame=_lblJobOfferDetails.frame;
//        frame.size.height=40;
//        _lblJobOfferDetails.frame=frame;
        
        
        
        
    }
    else
    {
        //_lblJobOfferDetails.text=NSLocalizedString(@"You have applied for this offer", @"");
        
//        _lblJobOfferDetails.translatesAutoresizingMaskIntoConstraints=YES;
//        CGRect frame=_lblJobOfferDetails.frame;
//        frame.size.height=0;
//        _lblJobOfferDetails.frame=frame;
//
//        _imgHotelPic.translatesAutoresizingMaskIntoConstraints=YES;
//        CGRect frame2=_imgHotelPic.frame;
//        frame2.size.height=frame2.size.height+40;
//        _imgHotelPic.frame=frame2;
    }
    
    _lblJobOfferTimeDetails.text=NSLocalizedString(@"You have applied for this offer", @"");
    
    MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    if([[dataDict valueForKey:@"company_lat"] isKindOfClass:[NSNull class]] || [dataDict valueForKey:@"company_lat"]==nil ||  [dataDict valueForKey:@"company_lat"] == (id)[NSNull null])
    {
    }
    else
    {
        
    myCoordinate.latitude=[[dataDict valueForKey:@"company_lat"] doubleValue];
    myCoordinate.longitude=[[dataDict valueForKey:@"company_long"] doubleValue];
        // 2
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, 0.5* METERS_PER_MILE, 0.5* METERS_PER_MILE);
        
        // 3
        [self.mapView setRegion:viewRegion animated:YES];
        
    annotation.coordinate = myCoordinate;
    annotation.title=[dataDict valueForKey:@"enterprise_name"];
    [self.mapView addAnnotation:annotation];

    }

}

-(NSString*)getDescriptionWithStatus:(int)status{
    
    if (status == 0)
    {
        return NSLocalizedString(@"You have applied", @"");
    }
    else if (status == 1)
    {
        return NSLocalizedString(@"You have been pre-selected.", @"");
        
    }
    else if (status ==2)
    {
        return NSLocalizedString(@"Your application has not been accepted.", @"");
        
    }
    else if(status ==3)
    {
        return NSLocalizedString(@"You have selected", @"");
        
    }
    else if(status ==4)
    {
        return NSLocalizedString(@"Your application hasbeen expired", @"");
        
    }
    return @"";
}


-(void)initialSetup
{
    UIButton *btnShare=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, 20, 20, 20)];
    [btnShare setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    UIBarButtonItem *btnSharing =[[UIBarButtonItem alloc]initWithCustomView:btnShare];
    self.navigationItem.rightBarButtonItem = btnSharing;
    [btnShare addTarget:self action:@selector(btnShareClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    [SharedClass setBorderOnButton:self.btnApplyJob];
    [SharedClass setShadowOnView:self.viewCompanyDetail];
    [SharedClass setBorderOnImage:self.imgEmail];
    [SharedClass setBorderOnImage:self.imgFacebook];
    [SharedClass setBorderOnImage:self.imgTwitter];
    [SharedClass setBorderOnImage:self.imgWhatsapp];
    [SharedClass setBorderOnImage:self.imgHotelPic];
    [self.mapView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.mapView.layer setShadowOpacity:0.8];
    [self.mapView.layer setShadowRadius:3.0];
    [self.mapView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    _lblCompanyActivity.text=NSLocalizedString(@"COMPANY'S ACTIVITY", @"");
    _lblCompanyLocation.text=NSLocalizedString(@"LOCATION", @"");
    _lblCompanyWebsite.text=NSLocalizedString(@"COMPANY'S WEBSITE", @"");
    _lblShareThisOffer.text=NSLocalizedString(@"SHARE THIS OFFER", @"");
 
    [_btnReportContent setTitle:NSLocalizedString(@"REPORT INAPPROPRIATE CONTENT", @"") forState:UIControlStateNormal];
    _lblJobOfferDetails.text=NSLocalizedString(@"Your application is active for 24h. You will receive an answer by staying connected to your account.", @"");
    _lblJobOfferTimeDetails.text=NSLocalizedString(@"Your application is active for 24h. You will receive an answer by staying connected to your account.", @"");
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    self.CompanyCoordinate.latitude=[[dataDict valueForKey:@"company_lat"] doubleValue];
//    
//    userLocation.coordinate.latitude=[[dataDict valueForKey:@"company_lat"] doubleValue];
//    userLocation.coordinate.longitude=[[dataDict valueForKey:@"company_long"] doubleValue];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    
//    // Add an annotation
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    point.title = [dataDict valueForKey:@"enterprise_name"];
//    //point.subtitle = [dataDict valueForKey:@"enterprise_name"];
//    
//    [self.mapView addAnnotation:point];
    
//    MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
//    CLLocationCoordinate2D myCoordinate;
//    myCoordinate.latitude=[[dataDict valueForKey:@"company_lat"] doubleValue];
//    myCoordinate.longitude=[[dataDict valueForKey:@"company_long"] doubleValue];
//    annotation.coordinate = myCoordinate;
//    annotation.title=[dataDict valueForKey:@"enterprise_name"];
//    [self.mapView addAnnotation:annotation];
}
- (void)btnShareClicked:(UIButton *)sender
{

//    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
//    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
    
   // NSArray *objectsToShare = @[textToShare, myWebsite];
    
    NSString *data=[NSString stringWithFormat:@"%@\n%@\n%@",NSLocalizedString(@"Discover this job on BonJob", @""),[dataDict valueForKey:@"job_title"],[dataDict valueForKey:@"jobLink"]];
   // [self shareText:data andImage:_imgHotelPic.image andUrl:[NSURL URLWithString:[dataDict valueForKey:@"job_image"]]];
    [self shareText:data andImage:nil andUrl:nil];
    
    //checking
    
    
    
  //  UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
//    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
//                                   UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
//                                   UIActivityTypePostToWeibo,
//                                   UIActivityTypeMessage, UIActivityTypeMail,
//                                   UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
//                                   UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
//                                   UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
//                                   UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
//    
//    activityVC.excludedActivityTypes = excludeActivities;
//    
   // [self presentViewController:activityVC animated:YES completion:nil];

}
    
    
#pragma mark - ------------Share Items-------------

-(void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text)
    {
        [sharingItems addObject:text];
    }
    if (image)
    {
        [sharingItems addObject:image];
    }
    if (url)
    {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [self presentViewController:activityController animated:YES completion:nil];
    }

}


- (IBAction)btnforreportingaction:(UIButton *)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:NSLocalizedString(@"Inappropriate content", @"") otherButtonTitles:nil,nil];
    popup.tag = 1;
    [popup showInView:self.view];
    
  //  popup.message = nil;
   

}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{

            switch (buttonIndex)
            {
                case 0:
                    if ([MFMailComposeViewController canSendMail])
                    {
                        if ([MFMailComposeViewController canSendMail])
                        {
                            NSString *Signature=@"Signalement:Contenu inapproprie";
                            NSString *ReportId=@"ID du signalement:";
                            ReportUniqueID= [self randomStringWithLength:8];
                            NSString *name=[NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"userData"]valueForKey:@"first_name"],[[[NSUserDefaults standardUserDefaults]valueForKey:@"userData"]valueForKey:@"last_name"]];
                            NSString *NameEmail= [NSString stringWithFormat:@"%@  %@-\n%@",@"Utilisateur:",name,[[[NSUserDefaults standardUserDefaults]valueForKey:@"userData"]valueForKey:@"email"]];
                            
                            NSString *StrMessageBody = [NSString stringWithFormat:@"%@\n %@\n %@\n",Signature,[NSString stringWithFormat:@"%@%@",ReportId,ReportUniqueID],NameEmail];
                            MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
                            [composeViewController setMailComposeDelegate:self];
                            [composeViewController setToRecipients:@[@"contact@bonjob.co"]];
                            [composeViewController setSubject:@"Report"];
                            composeViewController.delegate=self;
                            [composeViewController setMessageBody:[NSString stringWithFormat:@"\n\n\n\n\n\n\n\n\n\n%@",StrMessageBody] isHTML:NO];
                            [self presentViewController:composeViewController animated:YES completion:nil];
                        }
                        else
                        {
                            [self showAlert:@"Your device can't send mail"];
                        }
                    }
                    
                    break;
                case 1:
                    //  [self TwitterShare];
                default:
                    break;
            }
    
    
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //Add an alert in case of failure
    if (!error)
    {
        // Call Api here
        //{"report_id":"Oadf","job_id":"23"}
        if (result==MFMailComposeResultSent)
        {
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setObject:ReportUniqueID forKey:@"report_id"];
            [params setObject:[dataDict valueForKey:@"job_id"] forKey:@"job_id"];
            WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
            webhelper.methodName=@"contentReport";
            webhelper.delegate=self;
            [webhelper webserviceHelper:params webServiceUrl:kSendContentReport methodName:@"contentReport" showHud:YES inWhichViewController:self];
        }
    }
    else
    {
        [self showAlert:error.localizedDescription];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - --------Sharing to Social Media--------------
- (IBAction)btnApplyJobAction:(id)sender
{
    if ([[dataDict valueForKey:@"origin"] isEqualToString:@"pole-emploi"])
    {
        NSString *url = [dataDict valueForKey:@"redirect_url"];
        [[UIApplication sharedApplication]openURL: [NSURL URLWithString:url]];
    }
    else
    {
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        NSString *userid=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"];
        
        NSMutableDictionary *dicJob = [dataDict mutableCopy];
        [dicJob setObject:@"apply_date" forKey:@"apply_on"];
        NSMutableArray *arrTempResponse = arrResponse.mutableCopy;
        [arrTempResponse replaceObjectAtIndex:0 withObject:dicJob];
        arrResponse = arrTempResponse.mutableCopy;
        
        
        NSString *jobid=[dataDict valueForKey:@"job_id"];
        [params setValue:userid forKey:@"user_id"];
        [params setValue:jobid forKey:@"job_id"];
        
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.delegate=self;
        webHelper.methodName=@"applyjob";
        [webHelper webserviceHelper:params webServiceUrl:kApplyJob methodName:@"applyjob" showHud:YES inWhichViewController:self];
        
    }
}

-(IBAction)btnforfbshare:(UIButton *)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        //NSString *defaultMsg = @"Decouvrez offre d'emploi sûre";
        NSString *jobtitle=[dataDict valueForKey:@"job_title"];
        NSString *jobUrl=[dataDict valueForKey:@"jobLink"];
        //NSString *job_image=[dataDict valueForKey:@"job_image"];
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:jobtitle];
        [controller addURL:[NSURL URLWithString:jobUrl]];
        //controller addImage:<#(UIImage *)#>
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else
    {
        SLComposeViewController *fbSignInDialog = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [self presentViewController:fbSignInDialog animated:NO completion:nil];
        //[self showAlert:@"Facebook not setup in your device"];
    }
}

- (IBAction)btnforemailsharing:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        NSString *jobtitle=NSLocalizedString(@"Discover this job on BonJob", @"");
        NSString *jobUrl=[dataDict valueForKey:@"jobLink"];
        
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
       // [composeViewController setToRecipients:@[@"contact@bonjob.co"]];
       // [composeViewController setSubject:@"Report"];
        [composeViewController setMessageBody:[NSString stringWithFormat:@"%@\n%@",jobtitle,jobUrl] isHTML:NO];
        composeViewController.delegate=self;
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
    else
    {
      
       [self showAlert:@"Your device can't send mail"];
    }
}
- (IBAction)btnfortwittersharing:(UIButton *)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        NSString *jobtitle=NSLocalizedString(@"Discover this job on BonJob", @"");
        NSString *jobUrl=[dataDict valueForKey:@"jobLink"];
        
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@\n%@",jobtitle,jobUrl]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        SLComposeViewController *twSignInDialog = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [self presentViewController:twSignInDialog animated:NO completion:^{
            NSLog(@"Presented");
        }];
      //  [self showAlert:@"Twitter not setup in your device"];
    }
}

-(void)showAlert:(NSString *)msg
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Bonjob" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)btnforwhatsappsharing:(UIButton *)sender
{
    NSString *jobtitle=[dataDict valueForKey:@"job_title"];
    NSString *jobUrl=[dataDict valueForKey:@"jobLink"];
    NSString *textToShare =[NSString stringWithFormat:@"%@\n%@\n%@\n%@",NSLocalizedString(@"Discover this job on BonJob", @""),@"Bonjob",jobtitle,jobUrl];
    NSString *stringPath=[textToShare stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *finalMSg=[NSString stringWithFormat:@"%@%@",@"whatsapp://send?text=",stringPath];
    NSURL *whatsappURL = [NSURL URLWithString:finalMSg];
    // encode your msg and send it to whatspp
//    NSString *stringFirst=@"whatsapp://send?%@";
    
//     NSURL * whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",stringFirst,stringPath]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL])
    {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"BonJob" message:NSLocalizedString(@"Whatsapp is not installed in your device", @"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
    
    
//    textToShare = [textToShare stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//    textToShare = [textToShare stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
//    textToShare = [textToShare stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
//    textToShare = [textToShare stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
//    textToShare = [textToShare stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
//    textToShare = [textToShare stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
//    textToShare = [textToShare stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
//
//    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",textToShare];
//    NSURL * whatsappURL = [NSURL URLWithString:urlWhats];
//    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL])
//    {
//        [[UIApplication sharedApplication] openURL: whatsappURL];
//    }
//    else
//    {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp" message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnVisitCompanyDetails:(id)sender
{
    CompanyPageDetailsViewController *cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"CompanyPageDetailsViewController"];
    if (self.employer_id.length==0)
    {
        self.employer_id=[dataDict valueForKey:@"user_id"];
    }
    if (self.job_id.length==0)
    {
        self.job_id=[dataDict valueForKey:@"job_id"];
    }
    if (self.CompanyName.length==0)
    {
        self.CompanyName=[dataDict valueForKey:@"enterprise_name"];
    }
    
    cvc.employer_id=self.employer_id;
    cvc.job_id=self.job_id;
    cvc.SelectedJobIndex = self.SelectedJobIndex;
    cvc.CompanyName=self.CompanyName;
    
    [self.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)btnVisitWebSite:(UIButton *)sender
{
    NSString *title=sender.titleLabel.text;
    if([title containsString:@"http://"]||[title containsString:@"https://"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:title]];
    }
    else
    {
        title=[NSString stringWithFormat:@"http://%@",title];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:title]];
    }
    
}

- (IBAction)btnReportInAppropriateAction:(id)sender
{
    
}
NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength: (int) len
{
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end
