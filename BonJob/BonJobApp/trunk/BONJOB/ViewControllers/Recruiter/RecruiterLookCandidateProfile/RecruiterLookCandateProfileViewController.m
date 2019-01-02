//
//  RecruiterLookCandateProfileViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterLookCandateProfileViewController.h"
#import "ProfileCell.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AVKit/AVPlayerViewController.h>
#import "PostedJobData.h"
#import "RecruiterVerifyViewController.h"
#import "HHDropDownList.h"
#import "PaymentDataViewController.h"
#import "PaymentDetailsViewController.h"
#import "PaymentAcceptViewController.h"
#import "PaymentRejectViewController.h"


@implementation JobCell

@end

@interface RecruiterLookCandateProfileViewController ()<UIAlertViewDelegate,HHDropDownListDelegate,PaymentRejectedDelegate,PaymentSuccessDelegate,PaymentAcceptedDelegate,PaymantPlanSelectedDelegate>
{
    NSMutableDictionary *responseDictinary;
    int counter;
    AVPlayerViewController *playerViewController;
    NSMutableDictionary *dictJobData;
    int SelectedJobIndex;
    CLLocationCoordinate2D locationCoordinateCandidate;
    CLLocationCoordinate2D locationCoordinateCurrent;

    BOOL isPublishJob;
    NIDropDown *dropDown;
    
    //Popup Type
    BOOL isPoupUpType;
    NSInteger *selectedJobIndex;
    NSMutableArray *arrayJobTitles;
    NSString * jobId;
}


@end

@implementation RecruiterLookCandateProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayJobTitles = [[NSMutableArray alloc]init];
    SelectedJobIndex=-1;
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"PROFILE", @"")];// NSLocalizedString(@"PROFILE", @"");
    [[self.tabBarController.tabBar.items objectAtIndex:4] setTitle:NSLocalizedString(@"PROFILE", @"")];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    self.title=self.jobTitle;
    
    [_viewImageVideoBackground setHidden:YES];
    [_viewVideoHolder setHidden:YES];
    [_viewImageHolder setHidden:YES];
    [_viewRecruiterJob setHidden:YES];
    [_viewFirstTimeJob setHidden:YES];
    [_viewBackgroundJob setHidden:YES];
    dictJobData =[[NSMutableDictionary alloc]init];
    _viewRecruiterJob.layer.cornerRadius=10;
    _viewRecruiterJob.clipsToBounds=YES;
    _viewFirstTimeJob.layer.cornerRadius=10;
    _viewFirstTimeJob.clipsToBounds=YES;
    
    _btnValidatePopUp1.layer.cornerRadius=23.0;
    _btnValidatePopUp1.clipsToBounds=YES;
    _btnValidatePopUp2.layer.cornerRadius=23.0;
    _btnValidatePopUp2.clipsToBounds=YES;
   // _lblJobTitle.text=NSLocalizedString(@"My offers", @"");
    _lblNoJobofferTitle.text=NSLocalizedString(@"You have no active job offer.", @"");
    _lblPostAjobOfferTitle.text=NSLocalizedString(@"Please post a job offer first to select candidates for your offer.", @"");
    [_btnPublisHNoJob setTitle:NSLocalizedString(@"Post an offer", @"") forState:UIControlStateNormal];
    _btnPublisHNoJob.backgroundColor=InternalButtonColor;
    [SharedClass setBorderOnButton:_btnPublisHNoJob];
    _viewNoJobOffer.layer.cornerRadius=10;
    [_viewNoJobOffer setHidden:YES];
    
    
    [self getProfile];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
   // [self getJobOffers];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -----NI DROPDOWN DELEGATE----------
-(void)showDropDown:(UITextField *)txt;
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray  *dropDownArr =[[NSMutableArray alloc]init];

    if (!isPoupUpType) {
        for (int i = 0; i< arrayJobTitles.count ; i++) {
            JobTitleModel *obj = [arrayJobTitles objectAtIndex:i];
            [arr addObject:obj.job_title];
        }
    }
    else{
        arr = [dictJobData valueForKey:@"ActiveJobs"];
        for (int i = 0; i< arr.count ; i++) {
            [dropDownArr addObject:[[arr objectAtIndex:i]valueForKey:@"job_title"]];
        }
    }
    

    
    
    
   
    if(dropDown == nil)
    {
       
        if (!isPoupUpType) {
            CGFloat f = 120;

             dropDown = [[NIDropDown alloc]showDropDown:txt :&f :arr :nil :@"down"];
        }
        else{
            CGFloat f = 120;
            switch (dropDownArr.count) {
                case 0:
                    
                    break;
                case 1:
                    f = 40;
                    break;
                case 2:
                     f = 80;
                    break;
                default:
                    f = 120;
                    break;
            }
            
            dropDown = [[NIDropDown alloc]showDropDown:txt :&f :dropDownArr :nil :@"down"];
        }
       
        dropDown.delegate = self;
       
    }
    else
    {
        [dropDown hideDropDown:txt];
      //  selectedJobIndex =
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender index:(NSInteger)indexPath
{
    
    NSLog(@"%ld",(long)sender.tag);
    if(!isPoupUpType)
    {
        JobTitleModel * obj = [arrayJobTitles objectAtIndex:indexPath];
        jobId = obj.job_title_id;
    }
    else
    {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        arr = [dictJobData valueForKey:@"ActiveJobs"];
       
        jobId = [arr objectAtIndex:indexPath][@"job_title_id"];
    }
   [self rel];
}

-(void)rel
{
    //    [dropDown release];
    dropDown = nil;
}


#pragma mark - -----:::::::::--------WebService methods for get Job Offers------:::::::::-----
-(void)getJobOffers
{
    NSMutableDictionary *params=[NSMutableDictionary new];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"getMyOffers";
    webHelper.delegate=self;
    NSString *url=[NSString stringWithFormat:@"%@",kGetPostedJob];
    [webHelper webserviceHelper:params webServiceUrl:url methodName:@"getMyOffers" showHud:YES inWhichViewController:self];
}

#pragma mark - -----------Popup Button Actions--------------
-(void)btnViewEnterpriseVideoAction:(UIButton *)btn
{
    self.viewVideoHolder.layer.cornerRadius=10;
    self.viewVideoHolder.clipsToBounds=YES;
    [self.viewImageVideoBackground setHidden:NO];
    [self.viewVideoHolder setHidden:NO];
    [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
    [SharedClass showPopupView:self.viewVideoHolder];
    NSString *videoUrl=[responseDictinary valueForKey:@"patch_video"];
    NSURL *myVideoUrl=[NSURL URLWithString:videoUrl];
    //    player =[[MPMoviePlayerController alloc] initWithContentURL: myVideoUrl];
    //    [[player view] setFrame: [_viewShowVideo bounds]];  // frame must match parent view
    //    [_viewShowVideo addSubview: [player view]];
    
    
    playerViewController = [[AVPlayerViewController alloc] init];
    AVURLAsset *asset = [AVURLAsset assetWithURL: myVideoUrl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
    
    AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
    playerViewController.player = player;
    [playerViewController.view setFrame:CGRectMake(0, 0, _viewVideoBackground.frame.size.width, _viewVideoBackground.frame.size.height)];
    
    playerViewController.showsPlaybackControls = YES;
    
    [_viewVideoBackground addSubview:playerViewController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidExit:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[player currentItem]];
}
-(void)btnViewEnterpriseImageAction:(UIButton *)btn
{
    [self.viewImageVideoBackground setHidden:NO];
    [self.viewImageHolder setHidden:NO];
    [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
    [SharedClass showPopupView:self.viewImageHolder];
    self.viewImageHolder.layer.cornerRadius=10;
    NSString *imgUrl=[responseDictinary valueForKey:@"enterprise_pic"];
    if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
    {
        UIActivityIndicatorView *imageIndicator;
        [imageIndicator startAnimating];
        UIImageView *Profile_Image=_imgEnterPriseRecruiter;
        __weak UIImageView *weakImageView = Profile_Image;
        
        
        
        [_imgEnterPriseRecruiter sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
            
             if (!error)
             {
                 weakImageView.alpha = 0.0;
                 weakImageView.image = image;
                 [UIView animateWithDuration:0.3
                                  animations:^
                  {
                      weakImageView.alpha = 1.0;
                      _imgEnterPriseRecruiter.layer.cornerRadius = 10;
                      _imgEnterPriseRecruiter.clipsToBounds = YES;
                      [imageIndicator stopAnimating];
                  }];
             }
             else
             {
                 UIActivityIndicatorView *imageIndicator;
                 [imageIndicator stopAnimating];
                 [SharedClass showToast:self toastMsg:error.localizedDescription];
                 //imgEnterprisePic.image=[UIImage imageNamed:@"defaultPIC.png"];
             }
         }];
        
//        [_imgEnterPriseRecruiter sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//         {
//             if (!error)
//             {
//                 weakImageView.alpha = 0.0;
//                 weakImageView.image = image;
//                 [UIView animateWithDuration:0.3
//                                  animations:^
//                  {
//                      weakImageView.alpha = 1.0;
//                      _imgEnterPriseRecruiter.layer.cornerRadius = 10;
//                      _imgEnterPriseRecruiter.clipsToBounds = YES;
//                      [imageIndicator stopAnimating];
//                  }];
//             }
//             else
//             {
//                 UIActivityIndicatorView *imageIndicator;
//                 [imageIndicator stopAnimating];
//                 [SharedClass showToast:self toastMsg:error.localizedDescription];
//                 //imgEnterprisePic.image=[UIImage imageNamed:@"defaultPIC.png"];
//             }
//         }];
    }
}
-(void)btnViewProfilePicAction:(UIButton *)btn
{
    [self.viewImageVideoBackground setHidden:NO];
    [self.viewImageHolder setHidden:NO];
    [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
    [SharedClass showPopupView:self.viewImageHolder];
    self.viewImageHolder.layer.cornerRadius=10;
    NSString *imgUrl=[responseDictinary valueForKey:@"user_pic"];
    if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
    {
        UIActivityIndicatorView *imageIndicator;
        [imageIndicator startAnimating];
        UIImageView *Profile_Image=_imgEnterPriseRecruiter;
        __weak UIImageView *weakImageView = Profile_Image;
        [_imgEnterPriseRecruiter sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if (!error)
             {
                 weakImageView.alpha = 0.0;
                 weakImageView.image = image;
                 [UIView animateWithDuration:0.3
                                  animations:^
                  {
                      weakImageView.alpha = 1.0;
                      _imgEnterPriseRecruiter.layer.cornerRadius = 10;
                      _imgEnterPriseRecruiter.clipsToBounds = YES;
                      [imageIndicator stopAnimating];
                  }];
             }
             else
             {
                 UIActivityIndicatorView *imageIndicator;
                 [imageIndicator stopAnimating];
                 [SharedClass showToast:self toastMsg:error.localizedDescription];
                 //imgEnterprisePic.image=[UIImage imageNamed:@"defaultPIC.png"];
             }
         }];
    }
}

-(void)btnSIngleItemAction:(UIButton *)sender
{
    NSString *videoUrl=[responseDictinary valueForKey:@"patch_video_thumbnail"];
    NSString *imgUrl=[responseDictinary valueForKey:@"user_pic"];
    if (videoUrl.length>0)
    {
        self.viewVideoHolder.layer.cornerRadius=10;
        self.viewVideoHolder.clipsToBounds=YES;
        [self.viewImageVideoBackground setHidden:NO];
        [self.viewVideoHolder setHidden:NO];
        [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
        [SharedClass showPopupView:self.viewVideoHolder];
        NSString *videoUrl=[responseDictinary valueForKey:@"patch_video"];
        NSURL *myVideoUrl=[NSURL URLWithString:videoUrl];
        //    player =[[MPMoviePlayerController alloc] initWithContentURL: myVideoUrl];
        //    [[player view] setFrame: [_viewShowVideo bounds]];  // frame must match parent view
        //    [_viewShowVideo addSubview: [player view]];
        
        
        playerViewController = [[AVPlayerViewController alloc] init];
        AVURLAsset *asset = [AVURLAsset assetWithURL: myVideoUrl];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
        
        AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
        playerViewController.player = player;
        [playerViewController.view setFrame:CGRectMake(0, 0, _viewVideoBackground.frame.size.width, _viewVideoBackground.frame.size.height)];
        
        playerViewController.showsPlaybackControls = YES;
        
        [_viewVideoBackground addSubview:playerViewController.view];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidExit:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[player currentItem]];
    }
    else if (imgUrl.length>0)
    {
        [self.viewImageVideoBackground setHidden:NO];
        [self.viewImageHolder setHidden:NO];
        [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
        [SharedClass showPopupView:self.viewImageHolder];
        self.viewImageHolder.layer.cornerRadius=10;
        NSString *imgUrl=[responseDictinary valueForKey:@"user_pic"];
        if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
        {
            UIActivityIndicatorView *imageIndicator;
            [imageIndicator startAnimating];
            UIImageView *Profile_Image=_imgEnterPriseRecruiter;
            __weak UIImageView *weakImageView = Profile_Image;
            [_imgEnterPriseRecruiter sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 if (!error)
                 {
                     weakImageView.alpha = 0.0;
                     weakImageView.image = image;
                     [UIView animateWithDuration:0.3
                                      animations:^
                      {
                          weakImageView.alpha = 1.0;
                          _imgEnterPriseRecruiter.layer.cornerRadius = 10;
                          _imgEnterPriseRecruiter.clipsToBounds = YES;
                          [imageIndicator stopAnimating];
                      }];
                 }
                 else
                 {
                     UIActivityIndicatorView *imageIndicator;
                     [imageIndicator stopAnimating];
                     [SharedClass showToast:self toastMsg:error.localizedDescription];
                     //imgEnterprisePic.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                 }
             }];
        }
    }
    
}

- (IBAction)btnCloseImagePreview:(id)sender
{
    [SharedClass hidePopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
    [SharedClass hidePopupView:self.viewImageHolder];
}

- (IBAction)btnCloseVideoHolderAction:(id)sender
{
    [SharedClass hidePopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
    [SharedClass hidePopupView:self.viewVideoHolder];
}


- (void)itemDidFinishPlaying:(NSNotification *)notification
{
    AVPlayerItem *player = [notification object];
    [player seekToTime:kCMTimeZero];
}

- (void)itemDidExit:(NSNotification *)notification
{
    //    AVPlayerItem *player = [notification object];
                    //    playerViewController.showsPlaybackControls = NO;
    //[_viewAvplayerHolder addSubview:playerViewController.view];
}
- (IBAction)btnValidatePopUp1Action:(id)sender
{
    if (_txtFieldJobTitlePopUp1.text.length == 0) {
        
    }
    else{
        NSMutableArray  *dropDownArr =[[NSMutableArray alloc]init];
        
      
      NSMutableArray *arr = [dictJobData valueForKey:@"ActiveJobs"];
            for (int i = 0; i< arr.count ; i++) {
                [dropDownArr addObject:[[arr objectAtIndex:i]valueForKey:@"job_title"]];
            }
       // NSNumber *num=[NSNumber numberWithInteger:56];
        NSInteger anIndex=[dropDownArr indexOfObject:_txtFieldJobTitlePopUp1.text];
        if(NSNotFound == anIndex) {
            NSLog(@"not found");
            return;
        }
        
       // SelectedJobIndex=(int)btn.tag;
        self.job_id=[[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:anIndex] valueForKey:@"job_id"];
        [_tblRecruiterJobList reloadData];
        
        [SharedClass hidePopupView:self.viewBackgroundJob];
        [SharedClass hidePopupView:self.viewRecruiterJob andTabbar:self.tabBarController];
        
        
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setValue:self.userId forKey:@"user_id"];
        [params setValue:self.job_id forKey:@"job_id"];
        WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
        webhelper.methodName=@"selectCandidatebyRecruiter";
        webhelper.delegate=self;
        [webhelper webserviceHelper:params webServiceUrl:kSelectCandidateForJob methodName:@"selectCandidatebyRecruiter" showHud:YES inWhichViewController:self];
    }
}
- (IBAction)btnValidatePopUp2Action:(id)sender
{
    if (_txtFieldJobTitlePopUp2.text.length == 0) {
        
    }
    else{
        [self publishJobOffer];
        [SharedClass hidePopupView:self.viewBackgroundJob];
        [SharedClass hidePopupView:self.viewFirstTimeJob andTabbar:self.tabBarController];
    }
}
- (IBAction)btnDropDownPopUp1Action:(id)sender
{
    [self showDropDown:_txtFieldJobTitlePopUp1];
}
- (IBAction)btnDropDownPopUp2Action:(id)sender
{
     [self showDropDown:_txtFieldJobTitlePopUp2];
}

-(void)openPaymentData
{
    
    // By Cs Rai....
    // Dismiss overview popup first if it is already appearing
    
//    [SharedClass hidePopupView:_viewbackgroundoverview andTabbar:self.tabBarController];
//    [SharedClass hidePopupView:self.viewoverviewdeatails];
    
    // Show Payment data Popup
    PaymentDataViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDataViewController"];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

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

-(void)paymentPlanSelected:(long)index
{
    PaymentDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDetailsViewController"];
    vc.planDict=[APPDELEGATE.arrPlanData objectAtIndex:index];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
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

#pragma mark - ---------TableView Delegates ----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_tblRecruiterJobList)
    {
        return 1;
    }
    else
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==_tblRecruiterJobList)
    {
        return nil;
    }
    if (section==2)
    {
        if ([[responseDictinary valueForKey:@"experience"] count]>0)
        {
            UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, 30)];
            vw.backgroundColor =[UIColor whiteColor];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 280, 30)];
            label.textColor=TitleColor;
           // [label setFont:[UIFont systemFontOfSize:22]];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [label setFont:[UIFont fontWithName:@"LobsterTwo" size:27]];
            }
            else{
                [label setFont:[UIFont fontWithName:@"LobsterTwo" size:22]];
            }
            label.text=NSLocalizedString(@"Professional experience", @"");
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                 [label setFont:[UIFont fontWithName:@"LobsterTwo" size:30]];
            }
            else{
                  [label setFont:[UIFont fontWithName:@"LobsterTwo" size:25]];
            }
          
            [vw addSubview:label];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 20, 20)];
            img.image=[UIImage imageNamed:@"ListeStyle.png"];
            [vw addSubview:img];
            return vw;
        }
        else
        {
            return nil;
        }
        
    }
    else if (section==4)
    {
        if([[responseDictinary valueForKey:@"languages"] count]>0)
        {
            UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, 30)];
            vw.backgroundColor =[UIColor whiteColor];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 250, 30)];
            label.textColor=TitleColor;
      //      [label setFont:[UIFont systemFontOfSize:22]];
            label.text=NSLocalizedString(@"Languages", @"");
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [label setFont:[UIFont fontWithName:@"LobsterTwo" size:30]];
            }
            else{
                [label setFont:[UIFont fontWithName:@"LobsterTwo" size:25]];
            }
           // [label setFont:[UIFont fontWithName:@"LobsterTwo" size:25]];
            [vw addSubview:label];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 20, 20)];
            img.image=[UIImage imageNamed:@"GLOBE.png"];
            [vw addSubview:img];
            return vw;
        }
        else
        {
            return nil;
        }
        
    }
    else if (section==8)
    {
        if ([[responseDictinary valueForKey:@"gallery"]count]>0)
        {
            UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, 30)];
            vw.backgroundColor =[UIColor whiteColor];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 250, 30)];
            label.textColor=TitleColor;
      //      [label setFont:[UIFont systemFontOfSize:28]];
            label.text=NSLocalizedString(@"VIEWGALLERY", @"");
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                [label setFont:[UIFont fontWithName:@"LobsterTwo" size:30]];
            }
            else{
                [label setFont:[UIFont fontWithName:@"LobsterTwo" size:25]];
            }
            //[label setFont:[UIFont fontWithName:@"LobsterTwo" size:25]];
            [vw addSubview:label];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 20, 20)];
            img.image=[UIImage imageNamed:@"gallery_iconn.png"];
            [vw addSubview:img];
            return vw;
        }
        else
        {
            return nil;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==_tblRecruiterJobList)
    {
        return 0;
    }
    if (section==2 )
    {
        if ([[responseDictinary valueForKey:@"experience"] count]>0)
        {
            return 30;
        }
        else
        {
            return 0;
        }
    }
    else if (section==4)
    {
        if([[responseDictinary valueForKey:@"languages"] count]>0)
        {
            return 30;
        }
        else
        {
            return 0;
        }
    }
    else if (section==8)
    {
        if ([[responseDictinary valueForKey:@"gallery"] count]>0)
        {
            return 30;
        }
        return 0;
    }
    else
        return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tblRecruiterJobList)
    {
        return [[dictJobData valueForKey:@"ActiveJobs"] count];
    }
    if (section==2)
    {
        return [[responseDictinary valueForKey:@"experience"] count];
    }
    else if (section==4)
    {
        if([[responseDictinary valueForKey:@"languages"] count]>0)
        {
            return [[responseDictinary valueForKey:@"languages"] count];
        }
        else
            return 0;
        //return 2;
    }
    else if (section==8)
    {
        return [[responseDictinary valueForKey:@"gallery"]count];
    }
    else if (section==9)
    {
        return 1;
    }
    else
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblRecruiterJobList)
    {
        return 60;
    }
        if (indexPath.section==0)
        {
            return 145;
        }
        else if (indexPath.section==1)
        {
            if ([[responseDictinary valueForKey:@"city"] length]>0)
            {
                return 66;
            }
            else
            {
                return 0;
            }
        }
        else if (indexPath.section==2)
        {
            if ([[responseDictinary valueForKey:@"experience"] count]>0)
            {
//                NSLog(@"Length=%lu",[[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"] length]);
                float lenght=[[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"] length];
                if (lenght>80 && lenght<120)
                {
                    return 110;
                }
                else if (lenght>120 && lenght<200)
                {
                    return 160;
                }
                else if (lenght>20 && lenght<80)
                {
                    return 100;
                }
                else
                    return 80;
            }
            else
            {
                return 0;
            }

        }
        else if (indexPath.section==3)
        {
            if ([[responseDictinary valueForKey:@"training"] length]>0)
            {
                return 80;
            }
//            else if ([[responseDictinary valueForKey:@"training"] length]>50 && [[responseDictinary valueForKey:@"training"] length]<98)
//            {
//                return 120;
//            }
//            else if ([[responseDictinary valueForKey:@"training"] length]>30 && [[responseDictinary valueForKey:@"training"] length]<50)
//            {
//                return 90;
//            }
            else
                return 0;
        }
        else if (indexPath.section==4)
        {
            if([[responseDictinary valueForKey:@"languages"] count]>0)
            {
                if ([[responseDictinary valueForKey:@"languages"] count]>indexPath.row)
                {
                    return 34;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
            
        }
        else if(indexPath.section==5)
        {
            if ([[responseDictinary valueForKey:@"about"] length]>0)
            {
                return 80;
            }
//            else if ([[responseDictinary valueForKey:@"about"] length]>150 && [[responseDictinary valueForKey:@"about"] length]<198)
//            {
//                return 160;
//            }
//            else if ([[responseDictinary valueForKey:@"about"] length]>50 && [[responseDictinary valueForKey:@"about"] length]<100)
//            {
//                return 110;
//            }
//            else if ([[responseDictinary valueForKey:@"about"] length]>30 && [[responseDictinary valueForKey:@"about"] length]<50)
//            {
//                return 95;
//            }
                else
                return 0;
        }
        else if (indexPath.section==6)
        {
            if ([[responseDictinary valueForKey:@"current_status"] length]>0)
            {
                return 66;
            }
            else
            {
                return 0;
            }
        }
        else if (indexPath.section==7)
        {
            if ([[responseDictinary valueForKey:@"mobility"] length]>0)
            {
                return 66;
            }
            else
            {
                return 0;
            }
        }
        else if (indexPath.section==8)
        {
            if ([[responseDictinary valueForKey:@"gallery"]count]>0)
            {
                return 300;
            }
            return 0;
        }
        else
            return 66;


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:indexPath.row]
    if (tableView==_tblCadidate)
    {
        ProfileCell *cell;
        if (indexPath.section==0)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell0"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell0"]];
            }
            
            [cell.btnPlayVideo addTarget:self action:@selector(btnViewEnterpriseVideoAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnShowImage addTarget:self action:@selector(btnViewProfilePicAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnSingleItem addTarget:self action:@selector(btnSIngleItemAction:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *videoUrl=[responseDictinary valueForKey:@"patch_video_thumbnail"];
            NSString *imgUrl=[responseDictinary valueForKey:@"user_pic"];
            cell.lblUserName.text = @"";
            if (videoUrl.length>0 && imgUrl.length>0)
            {
                [cell.viewPicVideoHolder setHidden:NO];
                [cell.viewSingleItem setHidden:YES];
                if (videoUrl.length>0)
                {
                    UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                    [imageIndicator startAnimating];
                    UIImageView *Profile_Image=cell.imgVideoIcon;
                    __weak UIImageView *weakImageView = Profile_Image;
                    [cell.imgVideoIcon sd_setImageWithURL:[NSURL URLWithString:videoUrl] placeholderImage:[UIImage imageNamed:@"defaultPic.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                     {
                         if (!error)
                         {
                             weakImageView.alpha = 0.0;
                             weakImageView.image = image;
                             [UIView animateWithDuration:0.3
                                              animations:^
                              {
                                  weakImageView.alpha = 1.0;
                                  cell.imgVideoIcon.layer.cornerRadius = Profile_Image.frame.size.width / 2;
                                  cell.imgVideoIcon.clipsToBounds = YES;
                                  [imageIndicator stopAnimating];
                              }];
                         }
                         else
                         {
                             UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                             [imageIndicator stopAnimating];
                             [SharedClass showToast:self toastMsg:error.localizedDescription];
                             //cell.imgVideoIcon.image=[UIImage imageNamed:@"defaultPIC.png"];
                         }
                     }];
                }
                
                if (imgUrl.length>0)
                {
                    if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
                    {
                        UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                        [imageIndicator startAnimating];
                        UIImageView *Profile_Image=cell.imgProfilePic;
                        __weak UIImageView *weakImageView = Profile_Image;
                        [cell.imgProfilePic sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                         {
                             if (!error)
                             {
                                 weakImageView.alpha = 0.0;
                                 weakImageView.image = image;
                                 [UIView animateWithDuration:0.3
                                                  animations:^
                                  {
                                      weakImageView.alpha = 1.0;
                                      cell.imgProfilePic.layer.cornerRadius = Profile_Image.frame.size.width / 2;
                                      cell.imgProfilePic.clipsToBounds = YES;
                                      [imageIndicator stopAnimating];
                                  }];
                             }
                             else
                             {
                                 UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                                 [imageIndicator stopAnimating];
                                 [SharedClass showToast:self toastMsg:error.localizedDescription];
                                 cell.imgProfilePic.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                             }
                         }];
                    }
                    else
                    {
                        UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                        [imageIndicator stopAnimating];
                        cell.imgProfilePic.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                    }
                }
            }
            else
            {
                [cell.viewPicVideoHolder setHidden:YES];
                [cell.viewSingleItem setHidden:NO];
                // for single item
                if (videoUrl.length>0)
                {
                    UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                    [imageIndicator startAnimating];
                    UIImageView *Profile_Image=cell.imgSingleItem;
                    __weak UIImageView *weakImageView = Profile_Image;
                    [cell.imgSingleItem sd_setImageWithURL:[NSURL URLWithString:videoUrl] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                     {
                         if (!error)
                         {
                             weakImageView.alpha = 0.0;
                             weakImageView.image = image;
                             [UIView animateWithDuration:0.3
                                              animations:^
                              {
                                  weakImageView.alpha = 1.0;
                                  cell.imgSingleItem.layer.cornerRadius = Profile_Image.frame.size.width / 2;
                                  cell.imgSingleItem.clipsToBounds = YES;
                                  [imageIndicator stopAnimating];
                              }];
                         }
                         else
                         {
                             UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                             [imageIndicator stopAnimating];
                             [SharedClass showToast:self toastMsg:error.localizedDescription];
                             //cell.imgVideoIcon.image=[UIImage imageNamed:@"defaultPIC.png"];
                         }
                     }];
                }
                else if (imgUrl.length>0)
                {
                    if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
                    {
                        UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                        [imageIndicator startAnimating];
                        UIImageView *Profile_Image=cell.imgSingleItem;
                        __weak UIImageView *weakImageView = Profile_Image;
                        [cell.imgSingleItem sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                         {
                             if (!error)
                             {
                                 weakImageView.alpha = 0.0;
                                 weakImageView.image = image;
                                 [UIView animateWithDuration:0.3
                                                  animations:^
                                  {
                                      weakImageView.alpha = 1.0;
                                      cell.imgSingleItem.layer.cornerRadius = Profile_Image.frame.size.width / 2;
                                      cell.imgSingleItem.clipsToBounds = YES;
                                      [imageIndicator stopAnimating];
                                  }];
                             }
                             else
                             {
                                 UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                                 [imageIndicator stopAnimating];
                                 [SharedClass showToast:self toastMsg:error.localizedDescription];
                                 cell.imgSingleItem.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                             }
                         }];
                    }
                    else
                    {
                        UIActivityIndicatorView *imageIndicator=[tableView viewWithTag:9001];
                        [imageIndicator stopAnimating];
                        cell.imgSingleItem.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                    }
                }
                else
                {
                    cell.imgSingleItem.layer.cornerRadius = cell.imgSingleItem.frame.size.width / 2;
                    cell.imgSingleItem.clipsToBounds = YES;
                    cell.imgSingleItem.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                }
            }
            
        }
        else if (indexPath.section==1)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell1"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell1"]];
            }
            if ([responseDictinary valueForKey:@"city"]!=nil)
            {
                if ([responseDictinary valueForKey:@"lattitude"] !=[NSNull null]&&[[responseDictinary valueForKey:@"lattitude"]floatValue]>0 && [[responseDictinary valueForKey:@"lattitude"] length]>0)
                {
                    locationCoordinateCandidate.latitude=[[responseDictinary valueForKey:@"lattitude"] doubleValue];
                    locationCoordinateCandidate.longitude=[[responseDictinary valueForKey:@"longitude"] doubleValue];
                    locationCoordinateCurrent.latitude=APPDELEGATE.latitude;
                    locationCoordinateCurrent.longitude=APPDELEGATE.longitude;
                    float DistanceKm = [self kilometersfromPlace:locationCoordinateCurrent andToPlace:locationCoordinateCandidate];
                    cell.lblLocationValue.text= [NSString stringWithFormat:@"%.2f KM - %@",DistanceKm,[responseDictinary valueForKey:@"city"]];

                  
                }
                else
                {
                    cell.lblLocationValue.text=[responseDictinary valueForKey:@"city"];

                }
                
                
            }
            
        }
        else if (indexPath.section==2)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"CellExp"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"CellExp"]];
            }
            cell.lblDescription.hidden=YES;
            if (indexPath.row>0)
            {
                [cell.lblProfessionalExp setHidden:YES];
                [cell.imgExpIcon setHidden:YES];
            }
            if ([[responseDictinary valueForKey:@"experience"] count]>indexPath.row)
            {
                cell.lblProfessionalExpValue.text=[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"position_held_name"];
                NSString *exp=[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"experience"];
                NSString *year;
                if ([exp intValue] - 1==0)
                {
                    year=NSLocalizedString(@"None", @"");
                }
                else if ([exp intValue] -1>0 && [exp intValue]-1<2)
                {
                    year=NSLocalizedString(@"< 1 year", @"");
                }
                else if ([exp intValue]-1>1 && [exp intValue]-1<3)
                {
                    year=NSLocalizedString(@"1-2 years", @"");
                }
                else if ([exp intValue]-1>2 && [exp intValue]-1<4)
                {
                    year=NSLocalizedString(@"3-4 years", @"");
                }
                
                else if ([exp intValue]-1>3 && [exp intValue]-1<5)
                {
                    year=NSLocalizedString(@"5 years+", @"");
                }
                NSString *companyName=[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"company_name"];
                NSString *strCompanyName=[NSString stringWithFormat:@"%@ %@",companyName,year];
                
//                UIFont *font =[UIFont systemFontOfSize:12.0];
//                //shubham test
//                NSMutableAttributedString *attributedPhoneNumber = [[NSMutableAttributedString alloc] initWithString:strCompanyName];
//                [attributedPhoneNumber addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attributedPhoneNumber length])];
//              //  self.phoneNumberLabel.attributedText = attributedPhoneNumber;
                
               NSAttributedString *attributed=[[NSAttributedString alloc]initWithString:strCompanyName];
                cell.lblCompanyName.attributedText=attributed;
                //cell.lblCompanyName.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
                cell.txtViewEDesc.text=[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"];
                cell.txtViewEDesc.textAlignment=NSTextAlignmentLeft;
                tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            }
            
        }
        else if (indexPath.section==3)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell2"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell2"]];
            }
            if ([responseDictinary valueForKey:@"training"]!=nil)
            {
                cell.txtViewTranning.text=[responseDictinary valueForKey:@"training"];
//                cell.lblTranningValue.translatesAutoresizingMaskIntoConstraints=YES;
//                cell.lblTranningValue.text=[responseDictinary valueForKey:@"training"];
                //CGRect frame=cell.lblTranningValue.frame;
                
//                if ([[responseDictinary valueForKey:@"training"] length]>98)
//                {
//                    frame.size.height=130;
//                }
//                else if ([[responseDictinary valueForKey:@"training"] length]>50)
//                {
//                    frame.size.height=110;
//                }
//                else
//                {
//                    frame.size.height=60;
//                }
//                cell.lblTranningValue.translatesAutoresizingMaskIntoConstraints=YES;
//                cell.lblTranningValue.frame=frame;
//                //cell.lblTranningValue.numberOfLines=30;
//                cell.lblTranningValue.lineBreakMode=NSLineBreakByWordWrapping;
            }
            
        }
        else if (indexPath.section==4)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"CellLang"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"CellLang"]];
            }
            if ([[responseDictinary valueForKey:@"languages"] count]>indexPath.row)
            {
                cell.lblLanguageValue.text=[[[responseDictinary valueForKey:@"languages"] objectAtIndex:indexPath.row] valueForKey:@"seeker_lang"];
                cell.lblLangProf.text=[[[responseDictinary valueForKey:@"languages"] objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency_name"];
            }
            
        }
        else if (indexPath.section==5)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell3"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell3"]];
            }
            if ([responseDictinary valueForKey:@"about"]!=nil)
            {
                cell.txtviewAbout.text=[responseDictinary valueForKey:@"about"];

            }
            
        }
        else if (indexPath.section==6)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell4"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell4"]];
            }
            if ([responseDictinary valueForKey:@"current_status"]!=nil)
            {
                cell.lblActualStatusValue.text=[responseDictinary valueForKey:@"current_status_name"];
            }
        }
        else if (indexPath.section==7)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell5"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell5"]];
            }
            if ([responseDictinary valueForKey:@"mobility"]==nil ||[responseDictinary valueForKey:@"mobility"]==[NSNull null])
            {
                
            }
            else
            {
                cell.lblMobilityValue.text=[responseDictinary valueForKey:@"mobility_name"];
            }
        }
        else if (indexPath.section==8)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"CellGallery"]];
            
            if ([[responseDictinary valueForKey:@"gallery"] count]>0)
            {
                
                NSString *url= [[[responseDictinary valueForKey:@"gallery"] objectAtIndex:indexPath.row] valueForKey:@"image"];
                [cell.imgGallery sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultPic.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                 {
                     if (error)
                     {
                         [cell.imgGallery setImage:kDefaultPlaceHolder];
                     }
                 }];
             cell.viewGalleryImageHolder.layer.cornerRadius=25;
                cell.imgGallery.layer.cornerRadius=25;
                cell.imgGallery.clipsToBounds=YES;
               
                if(([[[[responseDictinary valueForKey:@"gallery"] objectAtIndex:indexPath.row] valueForKey:@"description"]  isEqual: @""]) || ([[[responseDictinary valueForKey:@"gallery"] objectAtIndex:indexPath.row] valueForKey:@"description"] == nil))
                {
                    cell.galleryDesc.hidden = YES;
                }
                else
                {
                 cell.galleryDesc.hidden = NO;
                    cell.lblimgGalleryDesc.text=[[[responseDictinary valueForKey:@"gallery"] objectAtIndex:indexPath.row] valueForKey:@"description"];
                }
                
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
        }
        else if (indexPath.section==9)
        {
            cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell7"]];
            if (!cell)
            {
                cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell7"]];
            }
            [cell.btnSelectCandidate addTarget:self action:@selector(btnSelectCandidateAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if ([self.selectedOrAvailable isEqualToString:@"selected"])
            {
                // show
                if([self.apply_id isEqualToString:@""])
                {
                    [cell.viewSelectedCandidate setHidden:YES];
                    
                }
                else
                {
                    [cell.viewSelectedCandidate setHidden:NO];
                }
            }
            else
            {
                // hide
                
                [cell.viewSelectedCandidate setHidden:YES];
            }
            [SharedClass setBorderOnButton:cell.btnChatCandidate];
            [SharedClass setBorderOnButton:cell.btnHireCandidate];
            cell.btnHireCandidate.backgroundColor=TitleColor;
            cell.btnChatCandidate.backgroundColor=InternalButtonColor;
            [cell.btnChatCandidate setTitle:NSLocalizedString(@"Chat", @"") forState:UIControlStateNormal];
            [cell.btnHireCandidate setTitle:NSLocalizedString(@"Hire", @"") forState:UIControlStateNormal];
            [cell.btnHireCandidate addTarget:self action:@selector(btnHireCandidateAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnChatCandidate addTarget:self action:@selector(btnChatCandidateAction:) forControlEvents:UIControlEventTouchUpInside];
            //||[self.identifier isEqualToString:@"filter"] below if condition
            if ([self.identifier isEqualToString:@"fromchat"])
            {
                [cell.btnSelectCandidate setHidden:YES];
                self.title=[NSString stringWithFormat:@"%@ %@",[responseDictinary valueForKey:@"first_name"],[responseDictinary valueForKey:@"last_name"]];
            }
            else
            {
                if([self.apply_id isEqualToString:@""])
                {
                    [cell.btnSelectCandidate setHidden:YES];
                }
                else
                [cell.btnSelectCandidate setHidden:NO];
                // self.title=[NSString stringWithFormat:@"%@ %@",[responseDictinary valueForKey:@"first_name"],[responseDictinary valueForKey:@"last_name"]];
            }
            
        }
        
        [cell setupAppereance];
        
        if ([self.identifier isEqualToString:@"fromchat"]||[self.identifier isEqualToString:@"filter"])
        {
            [cell.lblUserName setHidden:YES];
        }
        else
        {
            [cell.lblUserName setHidden:NO];
            cell.lblUserName.text=[NSString stringWithFormat:@"%@ %@",[responseDictinary valueForKey:@"first_name"],[responseDictinary valueForKey:@"last_name"]];
        }
        
        // actions
        [cell.btnPlayVideo addTarget:self action:@selector(playPitchVideo:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        JobCell *cell=(JobCell *)[tableView dequeueReusableCellWithIdentifier:@"JobCell"];
        cell.lblJobTitle.text=[[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:indexPath.row] valueForKey:@"job_title"];
        
        cell.lblJobLocation.text=[[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:indexPath.row] valueForKey:@"job_location"];
        [cell.btnSelectJob addTarget:self action:@selector(btnSelectJobAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSelectJob setTag:indexPath.row];
        if (SelectedJobIndex==indexPath.row)
        {
            [cell.btnSelectJob setSelected:YES];
        }
        else
        {
            [cell.btnSelectJob setSelected:NO];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblRecruiterJobList)
    {
        SelectedJobIndex=(int)indexPath.row;
        self.job_id=[[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:indexPath.row] valueForKey:@"job_id"];
        [_tblRecruiterJobList reloadData];
        
        [SharedClass hidePopupView:self.viewBackgroundJob];
        [SharedClass hidePopupView:self.viewRecruiterJob andTabbar:self.tabBarController];
        
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setValue:self.userId forKey:@"user_id"];
        [params setValue:self.job_id forKey:@"job_id"];
        WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
        webhelper.methodName=@"selectCandidatebyRecruiter";
        webhelper.delegate=self;
        [webhelper webserviceHelper:params webServiceUrl:kSelectCandidateForJob methodName:@"selectCandidatebyRecruiter" showHud:YES inWhichViewController:self];
    }
}

-(float)kilometersfromPlace:(CLLocationCoordinate2D)from andToPlace:(CLLocationCoordinate2D)to
{
    CLLocation *userloc = [[CLLocation alloc]initWithLatitude:from.latitude longitude:from.longitude];
    CLLocation *dest = [[CLLocation alloc]initWithLatitude:to.latitude longitude:to.longitude];
    CLLocationDistance dist = [userloc distanceFromLocation:dest]/1000;
    //NSLog(@"%f",dist);
    NSString *distance = [NSString stringWithFormat:@"%f",dist];
    return [distance floatValue];
}


#pragma mark - ---------Button Action----------------

-(void)btnSelectJobAction:(UIButton *)btn
{
    SelectedJobIndex=(int)btn.tag;
    self.job_id=[[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:btn.tag] valueForKey:@"job_id"];
    [_tblRecruiterJobList reloadData];
    
    [SharedClass hidePopupView:self.viewBackgroundJob];
    [SharedClass hidePopupView:self.viewRecruiterJob andTabbar:self.tabBarController];
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:self.userId forKey:@"user_id"];
    [params setValue:self.job_id forKey:@"job_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"selectCandidatebyRecruiter";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:kSelectCandidateForJob methodName:@"selectCandidatebyRecruiter" showHud:YES inWhichViewController:self];
    
}

-(void)showAlert
{
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Bonjob" message:@"Vous n'avez aucun Emploi actif, veuillez d'abord publier un travail" delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Ok", @""), nil];
//    [alert show];
    
//    [_viewNoJobOffer setHidden:NO];
//    [_viewBackgroundJob setHidden:NO];
//    [SharedClass showPopupView:_viewBackgroundJob];
//    [SharedClass showPopupView:_viewNoJobOffer andTabbar:self.tabBarController];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]);
    if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"enterprise_name"] length]==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"BonJob" message:@"Remplissez votre profil avant de poster un travail." delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Ok", @""), nil];
        alert.tag=1005;
        [alert show];
    }
    else
    {
       // if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"mobile_number"] length]>=3)
       // {
        //  [self publishJobOffer];
            isPoupUpType = false;
            [self.viewFirstTimeJob setHidden:NO];
            [self.viewBackgroundJob setHidden:NO];
            [SharedClass showPopupView:self.viewBackgroundJob];
            [SharedClass showPopupView:self.viewFirstTimeJob andTabbar:self.tabBarController];
            //[self.tabBarController setSelectedIndex:3];
//        }
//        else
//        {
//            RecruiterVerifyViewController *rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterVerifyViewController"];
//            [self presentViewController:rvc animated:YES completion:nil];
//        }
        //[self.tabBarController setSelectedIndex:3];
        
    }
    
    
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
    if (buttonIndex==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self.tabBarController setSelectedIndex:3];
    }
    }
}


-(void)btnSelectCandidateAction:(UIButton *)button
{
        [self getJobTitles];
        if ([[APPDELEGATE.currentPlanDict  valueForKey:@"expiredOn"] length]==0||[[APPDELEGATE.currentPlanDict  valueForKey:@"subscription_id"] length]==0)
        {
            if ([[APPDELEGATE.currentPlanDict valueForKey:@"select_candidate_count"] intValue]>=1)
            {
                [self openPaymentData];
            }
    else{
        [self selectCandidate];
        }
    }
    else
    {
        [self selectCandidate];
    }
}
-(void) selectCandidate
{
    if ([self.identifier isEqualToString:@"filter"])
    {
        if ([[dictJobData valueForKey:@"ActiveJobs"] count]==0)
        {
            
            [self showAlert];
        }
        else
        {
            isPoupUpType = true;
            [self.viewRecruiterJob setHidden:NO];
            [self.viewBackgroundJob setHidden:NO];
            [SharedClass showPopupView:self.viewBackgroundJob];
            [SharedClass showPopupView:self.viewRecruiterJob andTabbar:self.tabBarController];
        }
        
        
    }
    else
    {
        //{"aplied_id","8"}
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setValue:self.apply_id forKey:@"aplied_id"];
        WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
        webhelper.methodName=@"selectCandidate";
        webhelper.delegate=self;
        [webhelper webserviceHelper:params webServiceUrl:kSelectCandidate methodName:@"selectCandidate" showHud:YES inWhichViewController:self];
    }
}
- (void)btnHireCandidateAction:(id)sender
{
    //{"aplied_id","8"}
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:self.apply_id forKey:@"aplied_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"hireCandidate";
    [webhelper webserviceHelper:params webServiceUrl:kHireCandidate methodName:@"hireCandidate" showHud:YES inWhichViewController:self];
}

- (void)btnChatCandidateAction:(id)sender
{
    [self hitWebService];
    //[self.tabBarController setSelectedIndex:2];
}

-(void)hitWebService
{
    //{"user_id":"","employer_id":""}
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"employer_id"];
    [params setValue:self.userId forKey:@"user_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"startChat";
    [webhelper webserviceHelper:params webServiceUrl:kGetFirstMessage methodName:@"startChat" showHud:YES inWhichViewController:self];
    
}


-(void)playPitchVideo:(UIButton *)button
{
    
}
#pragma mark - -----Get Job Titles WebServices------
-(void)getJobTitles
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"postionDropDowns";
    [webhelper webserviceHelper:kGetjobTitles showHud:YES];
 //   [webhelper webserviceHelper:kGetjobTitles showHud:YES];
    
}

#pragma mark - -----Get Profile WebServices------

-(void)getProfile
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:self.userId forKey:@"user_id"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"getProfile";
    webHelper.delegate=self;
    [webHelper webserviceHelper:params webServiceUrl:kGetProfile methodName:@"getProfile" showHud:YES inWhichViewController:self];
    
}

#pragma mark - ----------Publish Job Offer webservice Delegates------------
-(void)publishJobOffer
{
    
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
    
    if ([[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] length]==0||[[APPDELEGATE.currentPlanDict  valueForKey:@"subscription_id"] length]==0)
    {
        
        
        
        if ([[APPDELEGATE.currentPlanDict valueForKey:@"job_post_count"] intValue]>=1)
        {
            
            
            if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"email"] isEqualToString:@" bonjobcontact@gmail.com"])
            {
                if ([[APPDELEGATE.currentPlanDict valueForKey:@"job_post_count"] intValue]>3)
                {
                    NSLog(@"Test");
                 [self openPaymentData];
                }
                else
                {
                    NSLog(@"Else added By CS Rai");
                    
                    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
                    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
                    [params setValue:self.txtFieldJobTitlePopUp2.text forKey:@"job_title"];
                    [params setValue:jobId forKey:@"job_title_id"];
                    [params setValue:@"" forKey:@"job_description"];
                    [params setValue:APPDELEGATE.userAddress forKey:@"job_location"];
                    
                    [params setValue:@"" forKey:@"contract_type"];
                    [params setValue:@"" forKey:@"education_level"];
                    [params setValue:@"" forKey:@"experience"];
                    [params setValue:@"" forKey:@"lang"];
                    [params setValue:@"" forKey:@"num_of_hours"];
                    [params setValue:@"" forKey:@"salarie"];
                    [params setValue:@"" forKey:@"start_date"];
                    
                    
                    
                    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                    
                    [dict setValue:@"BonJob Chat" forKey:@"name"];
                    [dict setValue:@"BonJob Chat" forKey:@"value"];
                    //[arr addObject:dict];
                    [params setValue:dict forKey:@"contact_mode"];
                    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
                    webHelper.methodName=@"publishoffer";
                    webHelper.delegate=self;
                    
                
                        [webHelper webserviceHelper:params webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
                    
                }
            }
        
            else
            {
                [self openPaymentData];
            }
            
        }
        
        else {
            
            NSLog(@"Else added By CS Rai");
            
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
            [params setValue:self.txtFieldJobTitlePopUp2.text forKey:@"job_title"];
             [params setValue:jobId forKey:@"job_title_id"];
            [params setValue:@"" forKey:@"job_description"];
            [params setValue:APPDELEGATE.userAddress forKey:@"job_location"];
            
            [params setValue:@"" forKey:@"contract_type"];
            [params setValue:@"" forKey:@"education_level"];
            [params setValue:@"" forKey:@"experience"];
            [params setValue:@"" forKey:@"lang"];
            [params setValue:@"" forKey:@"num_of_hours"];
            [params setValue:@"" forKey:@"salarie"];
            [params setValue:@"" forKey:@"start_date"];
            
            
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            
            [dict setValue:@"BonJob Chat" forKey:@"name"];
            [dict setValue:@"BonJob Chat" forKey:@"value"];
            //[arr addObject:dict];
            [params setValue:dict forKey:@"contact_mode"];
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.methodName=@"publishoffer";
            webHelper.delegate=self;
            
           
           
                [webHelper webserviceHelper:params webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
           
        }
    }
    else
    {
        
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
            [params setValue:self.txtFieldJobTitlePopUp2.text forKey:@"job_title"];
            [params setValue:jobId forKey:@"job_title_id"];
            [params setValue:@"" forKey:@"job_description"];
            [params setValue:@"" forKey:@"job_location"];
            
            [params setValue:@"" forKey:@"contract_type"];
            [params setValue:@"" forKey:@"education_level"];
            [params setValue:@"" forKey:@"experience"];
            [params setValue:@"" forKey:@"lang"];
            [params setValue:@"" forKey:@"num_of_hours"];
            [params setValue:@"" forKey:@"salarie"];
            [params setValue:@"" forKey:@"start_date"];
            
            
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            
        [dict setValue:@"BonJob Chat" forKey:@"name"];
        [dict setValue:@"BonJob Chat" forKey:@"value"];
            //[arr addObject:dict];
        [params setValue:dict forKey:@"contact_mode"];
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.methodName=@"publishoffer";
            webHelper.delegate=self;
            
        
        
                [webHelper webserviceHelper:params webServiceUrl:kPostaJob methodName:@"publishoffer" showHud:YES inWhichViewController:self];
        
            
        
    }
    
    
}



#pragma mark - ---------Process Successful ----------------
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
    if ([methodNameIs isEqualToString:@"getProfile"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==1)
        {
            [_viewBackground setHidden:YES];
            responseDictinary=[[NSMutableDictionary alloc]init];
            responseDictinary=[responseDict valueForKey:@"data"];
            //NSURL *videoUrl=[NSURL URLWithString:[responseDictinary valueForKey:@"patch_video"]];
            
            //[self setThumbnailsForVideo:videoUrl andImage:[responseDictinary valueForKey:@"user_pic"]];
            
            NSMutableDictionary *prunedDictionary=[[NSMutableDictionary alloc]init];
            prunedDictionary = [responseDict valueForKey:@"data"];
            for (NSString * key in [prunedDictionary allKeys])
            {
                if ([[prunedDictionary valueForKey:key] isKindOfClass:[NSNull class]])
                {
                    if ([[prunedDictionary valueForKey:key] isKindOfClass:[NSArray class]])
                    {
                        
                    }
                    else
                    {
                        [responseDictinary setObject:@"" forKey:key];
                    }
                    
                }
                else
                {
                    //[responseDictinary setObject:[prunedDictionary objectForKey:key] forKey:key];
                }
                
            }
            
            [[ProfileDataModel getModel]setResponseDict:responseDictinary];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tblCadidate reloadData];
                });
            });
            
      
            if ([self.identifier isEqualToString:@"fromchat"]||[self.identifier isEqualToString:@"filter"])
            {
                self.title=[NSString stringWithFormat:@"%@ %@",[responseDictinary valueForKey:@"first_name"],[responseDictinary valueForKey:@"last_name"]];
            }
            [self getJobOffers];
        }
        else
        {
            [_viewBackground setHidden:NO];
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"selectCandidate"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            dict=[APPDELEGATE.currentPlanDict mutableCopy];
            [dict setValue:@"1" forKey:@"select_candidate_count"];
            APPDELEGATE.currentPlanDict=dict;
            
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"AvailableCandidate" object:self];
            [self.navigationController popViewControllerAnimated:YES];
            // here manage data fro candidate
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"hireCandidate"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HiredCandidate" object:self];
            [self.navigationController popViewControllerAnimated:YES];
            // here manage data fro candidate
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"startChat"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"chatStarted" object:self];
            [self.tabBarController setSelectedIndex:2];
            // here manage data fro candidate
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"getMyOffers"])
    {
        if ([[responseDict valueForKey:@"success"]intValue]==1)
        {
            [[PostedJobData getData]setJobData:[responseDict mutableCopy]];
            dictJobData=[[NSMutableDictionary alloc]init];
            dictJobData=[[PostedJobData getData]getJobData];
            if (isPublishJob) {
                
        self.job_id = [[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:0] valueForKey:@"job_id"];
                
                //  [SharedClass hidePopupView:self.viewBackgroundJob];
                // [SharedClass hidePopupView:self.viewRecruiterJob andTabbar:self.tabBarController];
                
                NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
                [params setValue:self.userId forKey:@"user_id"];
                [params setValue:self.job_id forKey:@"job_id"];
                WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
                webhelper.methodName=@"selectCandidatebyRecruiter";
                webhelper.delegate=self;
                [webhelper webserviceHelper:params webServiceUrl:kSelectCandidateForJob methodName:@"selectCandidatebyRecruiter" showHud:YES inWhichViewController:self];
            }
            else
            {
               
            
            [_tblRecruiterJobList reloadData];
            }
        }
        else
        {
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tblCadidate reloadData];
        });

    }
    else if ([methodNameIs isEqualToString:@"selectCandidatebyRecruiter"])
    {
        if ([[responseDict valueForKey:@"success"]intValue]==1)
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            dict=[APPDELEGATE.currentPlanDict mutableCopy];
            [dict setValue:@"1" forKey:@"select_candidate_count"];
            APPDELEGATE.currentPlanDict=dict;
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"publishoffer"])
    {
        if ([[responseDict valueForKey:@"success"] intValue]==1)
        {
            isPublishJob = true;
            [self getJobOffers];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            dict=[APPDELEGATE.currentPlanDict mutableCopy];
            [dict setValue:@"1" forKey:@"job_post_count"];
            APPDELEGATE.currentPlanDict=dict;
            
            
           
            
            
         
        }
        else
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"postionDropDowns"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            
            for (NSDictionary *dict in [responseDict valueForKey:@"jobTitles"]) {
                
                JobTitleModel *obj = [[JobTitleModel alloc]init];
                [arrayJobTitles addObject:[obj initWithDict:dict]];
            }
           
        }
    }
}

-(void)setData
{
    
}

-(void)setThumbnailsForVideo:(NSURL *)videoUrl andImage:(NSString *)imgUrl
{
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform=TRUE;
    
    CMTime thumbTime = CMTimeMakeWithSeconds(1,1);
    
    UIImageView *pitch_video=[_tblCadidate viewWithTag:10000];
    __weak UIImageView *weakImageVideoView = pitch_video;
    UIActivityIndicatorView *VideoIndicator=[_tblCadidate viewWithTag:9002];
    [VideoIndicator startAnimating];
    /* AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
     {
     if (result != AVAssetImageGeneratorSucceeded)
     {
     NSLog(@"couldn't generate thumbnail, error:%@", error);
     [VideoIndicator stopAnimating];
     }
     else
     {
     dispatch_async(dispatch_get_main_queue(), ^{
     // code here
     UIImage *img=[UIImage imageWithCGImage:im];
     pitch_video.image=img;
     pitch_video.layer.cornerRadius = pitch_video.frame.size.width / 2;
     pitch_video.clipsToBounds = YES;
     
     weakImageVideoView.alpha = 0.0;
     weakImageVideoView.image = img;
     [UIView animateWithDuration:0.3
     animations:^
     {
     weakImageVideoView.alpha = 1.0;
     //[self.imgLoaderIndicator stopAnimating];
     }];
     [VideoIndicator stopAnimating];
     
     });
     }
     // TODO Do something with the image
     };
     
     CGSize maxSize = CGSizeMake(128, 128);
     generator.maximumSize = maxSize;
     [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
     */
    
    UIActivityIndicatorView *imageIndicator=[_tblCadidate viewWithTag:9001];
    [imageIndicator startAnimating];
    UIImageView *Profile_Image=[_tblCadidate viewWithTag:9999];
    __weak UIImageView *weakImageView = Profile_Image;
    [Profile_Image sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"defaultPic.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         weakImageView.alpha = 0.0;
         weakImageView.image = image;
         [UIView animateWithDuration:0.3
                          animations:^
          {
              weakImageView.alpha = 1.0;
              Profile_Image.layer.cornerRadius = pitch_video.frame.size.width / 2;
              Profile_Image.clipsToBounds = YES;
              [imageIndicator stopAnimating];
          }];
         
     }];
}




- (IBAction)btnCloseJobPopup:(id)sender
{
    [SharedClass hidePopupView:self.viewBackgroundJob];
    [SharedClass hidePopupView:self.viewRecruiterJob andTabbar:self.tabBarController];
}
- (IBAction)btnCloseFirstJobPopup:(id)sender
{
    [SharedClass hidePopupView:self.viewBackgroundJob];
    [SharedClass hidePopupView:self.viewFirstTimeJob andTabbar:self.tabBarController];
}
- (IBAction)btnPublishNoJobAction:(id)sender
{
//    [_viewNoJobOffer setHidden:NO];
    [SharedClass hidePopupView:_viewBackgroundJob];
    [SharedClass hidePopupView:_viewNoJobOffer andTabbar:self.tabBarController];
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:3];
}
    
- (IBAction)btnCloseNoJobPopup:(id)sender
{
    [SharedClass hidePopupView:_viewBackgroundJob];
    [SharedClass hidePopupView:_viewNoJobOffer andTabbar:self.tabBarController];
    
}
    
    
@end