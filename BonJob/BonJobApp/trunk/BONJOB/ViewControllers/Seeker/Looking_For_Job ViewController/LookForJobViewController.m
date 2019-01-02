//
//  LookForJobViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/9/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//
#import "GetJobModel.h"
#import "LookForJobViewController.h"
#import "LookingJobCell.h"
#import "ApplyFilterViewController.h"
#import "AppliedJobViewController.h"
#import "TagCell.h"
#import "CompanyPageDetailsViewController.h"
#import "JobOfferDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "UIImage+GIF.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVPlayerViewController.h>
@interface LookForJobViewController ()<AppiledControllerDissmissedDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *arrTags;
    float tableHeight;
    NSMutableArray *arrResponse;
    int PageNumber;
    BOOL stopReload;
    BOOL increased;
    
    CLLocation *currLocation;
    double latitude , longitude;
    NSString *address;
    BOOL stopPaging;
    
    NSMutableArray *arrAdvertiseData;
    NSMutableArray *finalResponseArray;
    AVPlayerViewController *playerViewController;
}
@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation LookForJobViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PageNumber=1;
    _lblLocation.text=@"";
    [SharedClass setShadowOnView:self.viewTxtHolder];
    self.viewBackPopup.hidden=YES;
    self.viewPopup.hidden=YES;
    _txtSearch.delegate=self;
    arrTags=[[NSMutableArray alloc]init];
 //   tableHeight=_tblJobListing.frame.size.height;
    tableHeight = [[UIScreen mainScreen ] bounds].size.height - 200;
    _txtSearch.placeholder=NSLocalizedString(@"Keyword (eg waiter, cook, ...)", @"");
    [_btnEditLocation setTitle:NSLocalizedString(@"Edit", @"") forState:UIControlStateNormal];
    _lblFilters.text=NSLocalizedString(@"Filters", @"");
    [_btnFilters setTitle:NSLocalizedString(@"+ Filters", @"") forState:UIControlStateNormal];
    [_btnFilterSearch setTitle:NSLocalizedString(@"Search", @"") forState:UIControlStateNormal];
    _lblCuisine.text=NSLocalizedString(@"Catering", @"");
    _lblSales.text=NSLocalizedString(@"Service", @"");
    _lblHotels.text=NSLocalizedString(@"Hotel", @"");
    [IQKeyboardManager sharedManager].enable=YES;
    _txtSearch.delegate=self;
    //[self getJobList:@"d"];
    [self getDefaultJobList:@""];
    arrResponse=[[NSMutableArray alloc]init];
    
    // Add a "textFieldDidChange" notification method to the text field control.
    [_txtSearch addTarget:self
                  action:@selector(textFieldSearchDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setUserActivity:) name:@"setuseractivity" object:nil];
   
    
    _tblJobListing.rowHeight          = UITableViewAutomaticDimension;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
       _tblJobListing.estimatedRowHeight = 720;
            } else {
       _tblJobListing.estimatedRowHeight = 550;
            }
    
    
//    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
//    _collectionTagData.collectionViewLayout=layout;
//    layout.estimatedItemSize=CGSizeMake(200, 35);
    
//    _tblJobListing.rowHeight=590;
    
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusChanged:) name:@"statusChanged" object:nil];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getAdvertiseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            // update ui here
            //[_tblJobListing reloadData];
        });
    });
    
}

-(void)getAdvertiseData
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"getAdvertiseData";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:kGetAdvertise methodName:@"getAdvertiseData" showHud:YES inWhichViewController:self];
}


-(void)statusChanged:(NSNotification *)notification
{
   AppDelegate  *appdel= ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    NSDictionary *userDic=notification.userInfo;
    if ([[userDic valueForKey:@"status"] isEqualToString:@"available"])
    {
        if ([appdel.arrOnlineBuddies containsObject:[userDic valueForKey:@"username"]])
        {
            
        }
        else
        {
            [appdel.arrOnlineBuddies addObject:[userDic valueForKey:@"username"]];
            
        }
    
    }
    else if([[userDic valueForKey:@"status"] isEqualToString:@"unavailable"])
    {
        if ([appdel.arrOnlineBuddies containsObject:[userDic valueForKey:@"username"]] && appdel.arrOnlineBuddies.count>0)
        {
            [appdel.arrOnlineBuddies removeObject:[userDic valueForKey:@"username"]];
        }
        
    }
    
}


-(void)setMyOfferCount:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:1]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"]];
    }
}

-(void)setUserActivity:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
        }
        else
        {
        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeColor:InternalButtonColor];
        }
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (APPDELEGATE.isNeedLoad) {
        [arrResponse removeAllObjects];
        [self getDefaultJobList:@""];
        
    }
    APPDELEGATE.isNeedLoad = false;
    [self.navigationController setNavigationBarHidden:YES];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
        }
        else
        {
        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeColor:InternalButtonColor];
        }
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ------------Search Text field action---------------

-(void)textFieldSearchDidChange:(UITextField*)textField
{
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    if(_txtSearch.text.length>0)
//    {
//        [self performSelector:@selector(getJobList:) withObject:_txtSearch.text afterDelay:2];
//    }
}

#pragma mark - ------------Get Job List Here---------------

-(void)getDefaultJobList:(NSString *)address
{
    
    NSString *strAddress = @"";
    if (address.length > 0) {
        NSArray *arr = [address componentsSeparatedByString:@","];
        if (arr.count > 0)
        {
            strAddress = arr[0];
        }
    }
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:@"1" forKey:@"start"];
    [params setValue:strAddress forKey:@"job_location"];
    [params setValue:@"" forKey:@"job_title"];
    [params setValue:@"" forKey:@"contract_type"];
    [params setValue:@"" forKey:@"education_level"];
    [params setValue:@"" forKey:@"experience"];
    [params setValue:@"" forKey:@"num_of_hours"];
    
    //{"start":0,"user_id":"42","job_title":"","contract_type":"","education_level":"","experience":"","num_of_hours":"","job_location":"Noida"}
    // implement first time with get default job list;
    

    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"getDefaultJob";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:kGetJobList methodName:@"getDefaultJob" showHud:YES inWhichViewController:self];
}

//-(void)getJobListByFilter:(NSString *)address
//{
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
//    [params setValue:@"0" forKey:@"start"];
//    [params setValue:address forKey:@"job_location"];
//    [params setValue:@"" forKey:@"job_title"];
//    [params setValue:@"" forKey:@"contract_type"];
//    [params setValue:@"" forKey:@"education_level"];
//    [params setValue:@"" forKey:@"experience"];
//    [params setValue:@"" forKey:@"num_of_hours"];
//
//    //{"start":0,"user_id":"42","job_title":"","contract_type":"","education_level":"","experience":"","num_of_hours":"","job_location":"Noida"}
//    // implement first time with get default job list;
//
//
//    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
//    webhelper.methodName=@"getJobListByFilter";
//    webhelper.delegate=self;
//    [webhelper webserviceHelper:params webServiceUrl:kGetJobList methodName:@"getJobListByFilter" showHud:YES inWhichViewController:self];
//}

-(void)getDefaultJobListWithPage:(NSString *)page
{
    NSString *strAddress = @"";
    if (_lblLocation.text.length > 0) {
         NSArray *arr = [_lblLocation.text componentsSeparatedByString:@","];
        if (arr.count > 0)
        {
            strAddress = arr[0];
        }
        else
        {
            strAddress = _lblLocation.text;
        }
    }
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:page forKey:@"start"];
    [params setValue:strAddress forKey:@"job_location"];
    [params setValue:@"" forKey:@"job_title"];
    NSLog(@"%id",APPDELEGATE.isFilterSeeker);
    if(APPDELEGATE.isFilterSeeker == YES)
    {
        [params setValue:APPDELEGATE.arrSelContractSeeker forKey:@"contract_type"];
        [params setValue:APPDELEGATE.arrSelEducationSeeker forKey:@"education_level"];
        [params setValue:APPDELEGATE.arrSelExperienceSeeker forKey:@"experience"];
        [params setValue:APPDELEGATE.arrSelHoursSeeker forKey:@"num_of_hours"];

    }
    else
    {
        [params setValue:@"" forKey:@"contract_type"];
        [params setValue:@"" forKey:@"education_level"];
        [params setValue:@"" forKey:@"experience"];
        [params setValue:@"" forKey:@"num_of_hours"];
    }
    
    
    
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"getDefaultJob";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:kGetJobList methodName:@"getDefaultJob" showHud:YES inWhichViewController:self];
}

static NSString * extracted() {
    return kGetJobList;
}

-(void)getJobList:(NSString*)searchTitle
{
 //{"user_id":"1","start":"10","job_title":"dsdsds","contract_type":"zxxxzx","education_level":"B.Tech","experience":"4 years","num_of_hours":"4 hours"}
    NSString *location = @"";
    if (_lblLocation.text.length > 0) {
    NSArray *arr = [_lblLocation.text componentsSeparatedByString:@","];
    if (arr.count > 0) {
        location = arr[0];
    }
    else
    {
        location = _lblLocation.text;
    }
    }
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:@"1" forKey:@"start"];
    [params setValue:searchTitle forKey:@"job_title"];
    [params setValue:@"" forKey:@"contract_type"];
    [params setValue:@"" forKey:@"education_level"];
    [params setValue:@"" forKey:@"experience"];
    [params setValue:@"" forKey:@"num_of_hours"];
    [params setValue:location forKey:@"job_location"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"getJob";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:extracted() methodName:@"getjob" showHud:YES inWhichViewController:self];
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
            //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([methodNameIs isEqualToString:@"getJob"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            stopReload=NO;
            if ([[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"]count]==0)
            {
               // [SharedClass addLabelInUITableViewViewBackGround:self.tblJobListing];
                [self showBackgroundLabel:[responseDict valueForKey:@"msg"]];
                stopReload=YES;
            }
            [[GetJobModel getModel]setResponseDict:[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"]];
            arrResponse=[[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"] mutableCopy];
            arrResponse=[self validate:arrResponse];
            [self mergeArray:arrResponse];
            [_tblJobListing reloadData];
        }
        else
        {
            stopReload=YES;
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"applyjob"])
    {
        
        [_txtSearch resignFirstResponder];
        AppliedJobViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AppliedJobViewController"];
        vc.delegate=self;
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([methodNameIs isEqualToString:@"getDefaultJob"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            stopReload=NO;
            if ([[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"]count]==0)
            {
                //[SharedClass addLabelInUITableViewViewBackGround:self.tblJobListing];
                [self showBackgroundLabel:[responseDict valueForKey:@"msg"]];
                stopReload=YES;
            }
            [[GetJobModel getModel]setResponseDict:[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"]];
            //arrResponse=[[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"] mutableCopy];
            
            [arrResponse addObjectsFromArray:[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"]];
            [self mergeArray:arrResponse];
            //arrResponse=[self validate:arrResponse];
            [_tblJobListing reloadData];
            //PageNumber=PageNumber+1;
        }
        else
        {
            stopPaging=YES;
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"getJobListByFilter"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            stopReload=NO;
            if ([[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"]count]==0)
            {
                [self showBackgroundLabel:[responseDict valueForKey:@"msg"]];
                //[SharedClass addLabelInUITableViewViewBackGround:self.tblJobListing];
                 stopReload=YES;
            }
            [[GetJobModel getModel]setResponseDict:[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"]];
            //arrResponse=[[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"] mutableCopy];
            [arrResponse removeAllObjects];
            [arrResponse addObjectsFromArray:[[responseDict valueForKey:@"data"] valueForKey:@"allJobs"]];
            [self mergeArray:arrResponse];
            //arrResponse=[self validate:arrResponse];
            [_tblJobListing reloadData];
            //PageNumber=PageNumber+1;
        }
        else
        {
            stopPaging=YES;
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"getAdvertiseData"])
    {
        arrAdvertiseData=[[NSMutableArray alloc]init];
        [arrAdvertiseData addObjectsFromArray:[responseDict valueForKey:@"data"]];
        if (arrResponse.count>0)
        {
            [self mergeArray:arrResponse];
        }
        
        
        [_tblJobListing reloadData];
    }
}

-(void)mergeArray:(NSMutableArray *)arr
{
    
    finalResponseArray=[[NSMutableArray alloc]init];
    [finalResponseArray addObjectsFromArray:arr];
    if (arr.count>0)
    {
        int i=0;

        for (int k=0; k<arr.count; k++)
        {
            int index=(3*k)+2;
            if (i<arrAdvertiseData.count)
            {
                
                if (index<finalResponseArray.count)
                {
                    [finalResponseArray insertObject:arrAdvertiseData[i] atIndex:index];
                     i=i+1;
                }
            }
        }
    }
    
    //finalResponseArray=arr?[arr arrayByAddingObjectsFromArray:arrAdvertiseData]:[[NSArray alloc] initWithArray:arrAdvertiseData];
    [_tblJobListing reloadData];
}

-(void)inProgress:(float)value
{
    
}

-(NSMutableArray*)validate:(NSMutableArray *)arr
{
    NSMutableArray *temparr=[arr mutableCopy];
    for (NSDictionary *dict in arr)
    {
        NSArray *tempKey =[dict allKeys];
        NSMutableDictionary *tempdic =[dict mutableCopy];
        for (NSString *str in tempKey)
        {
            if ([tempdic valueForKey:str]==[NSNull null]||[[tempdic valueForKey:str]isKindOfClass:[NSNull class]]||[tempdic valueForKey:str]==NULL||[[tempdic valueForKey:str] isEqualToString:@"<null>"])
            {
                [tempdic setValue:@"" forKey:str];
            }
            
        }
        [temparr replaceObjectAtIndex:[arr indexOfObject:dict] withObject:tempdic];
    }
    return temparr;
}

#pragma mark - -------Table View dataSOurces & delegates-----------

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    LookingJobCell *cell = (LookingJobCell *)[self tableView:_tblJobListing cellForRowAtIndexPath:indexPath];
////    NSLog(@"Height=%f",cell.viewApplyButoonHolder.frame.origin.y+cell.viewApplyButoonHolder.frame.size.height);
////    return cell.viewApplyButoonHolder.frame.origin.y+cell.viewApplyButoonHolder.frame.size.height;
//    
//    
////    if ([[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"job_description"] length]==0)
////    {
////        return 540;
////    }
////    else if ([[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"job_description"] length]>100 && [[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"job_description"] length]<150)
////    {
////        return 570;
////    }
////    else
//    //return 0;
//    
//        //return 590;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"video"])
//    {
//        return 150;
//    }
//    else if ([[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"image"])
//    {
//        return 160;
//
//    }
//    else
//
//}

- (void)itemDidFinishPlaying:(NSNotification *)notification {
    AVPlayerItem *player = [notification object];
    [player seekToTime:kCMTimeZero];
}

- (void)itemDidExit:(NSNotification *)notification
{
    AVPlayerItem *player = [notification object];
    //[playerViewController.view setFrame:CGRectMake(0, 0, _viewShowVideo.frame.size.width, _viewShowVideo.frame.size.height)];
    //playerViewController.showsPlaybackControls = NO;
   // [_viewAvplayerHolder addSubview:playerViewController.view];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [finalResponseArray count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        return  719;
//    } else {
//        return 549;
//    }
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LookingJobCell *cell;
    if ([[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"video"])
    {
        cell=(LookingJobCell *)[tableView dequeueReusableCellWithIdentifier:@"LookingJobCellVideo"];
        
        
        NSString *videoUrl=[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"advertisement_image"];
        NSURL *myVideoUrl=[NSURL URLWithString:videoUrl];
        
        
        
        playerViewController = [[AVPlayerViewController alloc] init];
        AVURLAsset *asset = [AVURLAsset assetWithURL: myVideoUrl];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
        
        AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
        playerViewController.player = player;
        [playerViewController.view setFrame:CGRectMake(0, 0, cell.viewMain.frame.size.width, cell.viewMain.frame.size.height)];
        
        playerViewController.showsPlaybackControls = YES;
        
        [cell.viewMain addSubview:playerViewController.view];
        
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidExit:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[player currentItem]];
        
    }
    else if ([[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"image"])
    {
        cell=(LookingJobCell *)[tableView dequeueReusableCellWithIdentifier:@"LookingJobCellImage"];
        if ([[[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"advertisement_file"] lastPathComponent] isEqualToString:@".gif"])
        {
            NSString *urlString=[finalResponseArray[indexPath.row] valueForKey:@"advertisement_image"];
            cell.imgAdvertise.image=[UIImage sd_animatedGIFNamed:urlString];
        }
        else
        {
            NSString *urlString=[finalResponseArray[indexPath.row] valueForKey:@"advertisement_image"];
            NSURL *url=[NSURL URLWithString:urlString];
            [cell.imgAdvertise sd_setImageWithURL:url];
        }
        
    }
    
    else
    {
        cell=(LookingJobCell *)[tableView dequeueReusableCellWithIdentifier:@"LookingJobCell"];
        if (!cell)
        {
            cell=(LookingJobCell *)[[LookingJobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookingJobCell"];
        }
        //[SharedClass setShadowLookView:cell.viewMain];
        cell.viewMain.layer.borderColor=[UIColor lightGrayColor].CGColor;
        cell.viewMain.layer.borderWidth=0.7;
        [SharedClass setBorderOnButton:cell.btnApplyJob];
        [SharedClass setShadowOnView:cell.viewUpDetails];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.btnApplyJob.tag = indexPath.row;
        [cell.btnApplyJob addTarget:self action:@selector(applyForJob:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnVisitCompanyPage addTarget:self action:@selector(visitCompanyPage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnVisitCompanyPage setTag:indexPath.row];
        [cell.btnMoreInfo setTag:indexPath.row];
        [cell.btnMoreInfo addTarget:self action:@selector(btnMoreInfoAction:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:cell.btnMoreInfo.titleLabel.attributedText];
        [attributedString.mutableString setString:NSLocalizedString(@"More information", @"")];
        [cell.btnMoreInfo setAttributedTitle:attributedString forState:UIControlStateNormal];
        
        
        if (finalResponseArray.count>0)
        {
            [cell setdata:finalResponseArray[indexPath.row]];
            if ([[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"job_image"] length]==0 && [[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"origin"] isEqualToString:@"pole-emploi"])
            {
                [cell.imgJobImage setImage:[UIImage imageNamed:@"pole.png"]];
            }
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
            
            
        
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"video"])
    {
        NSString *urlString=[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"url"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    else if ([[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"file_type"] isEqualToString:@"image"])
    {
        NSString *urlString=[[finalResponseArray objectAtIndex:indexPath.row] valueForKey:@"url"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger lastSectionIndex = [tableView numberOfSections] -1;
//    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
//    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
//        // This is the last cell
//        if (stopReload==NO)
//        {
//                //[spinner startAnimating];
//                PageNumber=PageNumber+1;
//            [self getDefaultJobListWithPage:[NSString stringWithFormat:@"%d",PageNumber]];
//        }
//    }
    if (arrResponse.count>=4)
    {
        if (stopReload==NO)
        {
            if (indexPath.row == [arrResponse count] - 1 )
            {
                NSLog(@"Calling.................");
                
                PageNumber=PageNumber+1;
                [self getDefaultJobListWithPage:[NSString stringWithFormat:@"%d",PageNumber]];
            }
        }
        
    }
    
    
}





//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == [arrResponse count] - 1 )
//    {
//        if (stopReload==NO)
//        {
//            if(_txtSearch.text.length>0)
//            {
//                PageNumber=PageNumber+(int)[arrResponse count];
//                [self getJobList:_txtSearch.text];
//            }
//            else
//            {
//                [self getDefaultJobList];
//            }
//        }
//        
//    }
//}

#pragma mark - ---------Collection Delegates ----------------

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrTags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TagCell";
    TagCell *cell = (TagCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.lblSearchItem.text=[arrTags objectAtIndex:indexPath.item];
    [cell.btnRemoveTag addTarget:self action:@selector(removeTag:) forControlEvents:UIControlEventTouchUpInside];
    cell.viewBg.layer.borderWidth=1.0;
    cell.viewBg.layer.borderColor=InternalButtonColor.CGColor;
    cell.viewBg.layer.cornerRadius=15.0;
    cell.viewBg.layer.masksToBounds=YES;
    cell.btnRemoveTag.tag=indexPath.item;
    cell.btnRemoveTag.accessibilityLabel=[NSString stringWithFormat:@"%ld",(long)indexPath.item];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1; // This is the minimum inter item spacing, can be more
}

#pragma mark
#pragma mark-------Collection view layout things---------
// Layout: Set cell size


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"SETTING SIZE FOR ITEM AT INDEX %ld", (long)indexPath.row);
    //CGSize mElementSize = CGSizeMake(175, 175);
    
    //return CGSizeMake((UIScreen.mainScreen().bounds.width-15)/4,120);
//    float size=[[arrTags objectAtIndex:indexPath.item] length];
//    if (size<5)
//    {
//        return CGSizeMake(size*20, 30);
//    }
//    else
//    return CGSizeMake(size*12, 30);
    
    NSString *testString = [arrTags objectAtIndex:indexPath.row];
    CGSize calCulateSizze =[testString sizeWithAttributes:NULL];
    calCulateSizze.width = calCulateSizze.width+90;
    calCulateSizze.height = 30;
    return calCulateSizze;
    
    //return [(NSString*)[arrTags objectAtIndex:indexPath.row] sizeWithAttributes:NULL];
}


// Layout: Set Edges
//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
//    return UIEdgeInsetsMake(5,5,8,8);  // top, left, bottom, right
//}

#pragma mark - -------Textfileds Delegates-----------
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text=@"";
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([arrTags containsObject:textField.text])
    {
        
    }
    else
    {
        [arrTags addObject:textField.text];
    }
    [self increaseHeight:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0) {
        [self getJobList:textField.text];
        [_tblJobListing scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

    }
    else
    {
      [self getDefaultJobList:@""];
        [_tblJobListing scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

    }
    [textField resignFirstResponder];
    return TRUE;
}

#pragma mark - -------Buttons Actions-----------
- (IBAction)btnFilterApplyAction:(id)sender
{
//    _viewBackPopup.hidden=NO;
//    _viewPopup.hidden=NO;
//    [SharedClass showPopupView:_viewBackPopup andTabbar:self.tabBarController];
//    [SharedClass showPopupView:_viewPopup];
//    _viewPopup.layer.cornerRadius=15.0;
//    _viewPopup.layer.masksToBounds=YES;
//    
//    [SharedClass setBorderOnButton:self.btnFilterSearch];
//    _btnFilters.layer.cornerRadius=23.0;
//    // border
//    [_btnFilters.layer setBorderColor:InternalButtonColor.CGColor];
//    [_btnFilters.layer setBorderWidth:1.0f];
//    
//    // drop shadow
//    [_btnFilters.layer setShadowColor:InternalButtonColor.CGColor];
    
    
    [SharedClass hidePopupView:_viewBackPopup andTabbar:self.tabBarController];
    [SharedClass hidePopupView:_viewPopup];
    ApplyFilterViewController *afvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ApplyFilterViewController"];
    afvc.delegate=self;
    [self.navigationController pushViewController:afvc animated:YES];
    
    //[_btnFilters.layer setShadowOpacity:0.8];
    //[_btnFilters.layer setShadowRadius:3.0];
    //[_btnFilters.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

- (IBAction)btnFiltersAction:(id)sender
{
    [SharedClass hidePopupView:_viewBackPopup andTabbar:self.tabBarController];
    [SharedClass hidePopupView:_viewPopup];
    ApplyFilterViewController *afvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ApplyFilterViewController"];
    afvc.delegate=self;
    [self.navigationController pushViewController:afvc animated:YES];
}

-(IBAction)btnFilterSearchAction:(id)sender
{
    [SharedClass hidePopupView:_viewBackPopup andTabbar:self.tabBarController];
    [SharedClass hidePopupView:_viewPopup];
}


-(void)removeTag:(UIButton *)btn
{
    TagCell *cell=(TagCell *)[[[btn superview] superview] superview];
    NSIndexPath *index=[self.collectionTagData indexPathForCell:cell];
    [arrTags removeObjectAtIndex:index.item];
    if (arrTags.count==0)
    {
        [self increaseHeight:NO];
    }
    [self.collectionTagData reloadData];
}

-(void)btnMoreInfoAction:(UIButton *)btn
{
    JobOfferDetailViewController *jvc=[self.storyboard instantiateViewControllerWithIdentifier:@"JobOfferDetailViewController"];
    jvc.jobId=[[arrResponse objectAtIndex:btn.tag] valueForKey:@"job_id"];
    jvc.jobTitle=[[arrResponse objectAtIndex:btn.tag] valueForKey:@"job_title"];
    jvc.employer_id=[[arrResponse objectAtIndex:btn.tag] valueForKey:@"user_id"];
    jvc.job_id=[[arrResponse objectAtIndex:btn.tag] valueForKey:@"job_id"];
    jvc.SelectedJobIndex = [NSString stringWithFormat:@"%ld", (long)btn.tag];
    jvc.CompanyName=[[arrResponse objectAtIndex:btn.tag] valueForKey:@"enterprise_name"];
    [self.navigationController pushViewController:jvc animated:YES];
}

-(void)applyForJob:(UIButton *)btn
{
    if ([[[arrResponse objectAtIndex:btn.tag]valueForKey:@"origin"] isEqualToString:@"pole-emploi"])
    {
        NSString *url = [[arrResponse objectAtIndex:btn.tag] valueForKey:@"redirect_url"];
        [[UIApplication sharedApplication]openURL: [NSURL URLWithString:url]];
    }
    else
    {
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        NSString *userid=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"];
        
        NSMutableDictionary *dicJob = [[arrResponse objectAtIndex:btn.tag] mutableCopy];
        [dicJob setObject:@"apply_date" forKey:@"apply_on"];
        NSMutableArray *arrTempResponse = arrResponse.mutableCopy;
        [arrTempResponse replaceObjectAtIndex:btn.tag withObject:dicJob];
        arrResponse = arrTempResponse.mutableCopy;
        
        
        NSString *jobid=[[arrResponse objectAtIndex:btn.tag] valueForKey:@"job_id"];
        [params setValue:userid forKey:@"user_id"];
        [params setValue:jobid forKey:@"job_id"];
        
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.delegate=self;
        webHelper.methodName=@"applyjob";
        [webHelper webserviceHelper:params webServiceUrl:kApplyJob methodName:@"applyjob" showHud:YES inWhichViewController:self];
        [self.tblJobListing reloadData];
    }
    //{"user_id":"1","job_id":"1"}
    
    
}

-(void)visitCompanyPage:(UIButton *)btn
{
    NSIndexPath *index=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    LookingJobCell *cell=(LookingJobCell *)[_tblJobListing cellForRowAtIndexPath:index];
    
    CompanyPageDetailsViewController *cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"CompanyPageDetailsViewController"];
    cvc.employer_id=[[arrResponse objectAtIndex:btn.tag] valueForKey:@"user_id"];
    cvc.job_id=[[arrResponse objectAtIndex:btn.tag] valueForKey:@"job_id"];
    cvc.SelectedJobIndex = [NSString stringWithFormat:@"%ld", (long)btn.tag];
    if ([cell.lblCompanyName.text  isEqual: @""]) {
        cvc.CompanyName = @"";
    }
    else{
        cvc.CompanyName=cell.lblCompanyName.text;
    }
    
    [self.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)btnClosePopupAction:(id)sender
{
    [SharedClass hidePopupView:_viewBackPopup andTabbar:self.tabBarController];
    [SharedClass hidePopupView:_viewPopup];
    _viewBackPopup.hidden=YES;
    _viewPopup.hidden=YES;
}

- (IBAction)btnRadioCuisine:(id)sender
{
    [_btnRadioCuisine setSelected:YES];
}

- (IBAction)btnRadioSalesAction:(id)sender
{
    [_btnRadioSales setSelected:YES];
}

- (IBAction)btnRadioHotelAction:(id)sender
{
    [_btnRadioHotel setSelected:YES];
}



#pragma mark - --------Custom methods & delegates-------

-(void)increaseHeight:(BOOL)B
{
    
    if (B)
    {
        
        CGFloat height=40;
        CGFloat y=150;
        self.viewLOcationDataHolder.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=self.viewLOcationDataHolder.frame;
        frame.origin.y=y;
        self.viewLOcationDataHolder.frame=frame;
        
        
//        self.collectionViewHeightConstraint.constant=height;
//        CGRect frame=self.collectionTagData.frame;
//        frame.size.height=height;
//        self.collectionTagData.frame=frame;
        [self.collectionTagData reloadData];
    }
    else
    {
//        CGFloat height=0;
//        self.collectionViewHeightConstraint.constant=height;
//        CGRect frame=self.collectionTagData.frame;
//        frame.size.height=height;
//        self.collectionTagData.frame=frame;
        [self.collectionTagData reloadData];
        CGFloat height=40;
        CGFloat y=79;
        self.viewLOcationDataHolder.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=self.viewLOcationDataHolder.frame;
        frame.origin.y=y;
        self.viewLOcationDataHolder.frame=frame;
    }
    
    [_viewLOcationDataHolder setTranslatesAutoresizingMaskIntoConstraints:YES];
    [_tblJobListing setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    //[_viewLOcationDataHolder setFrame:CGRectMake(_viewLOcationDataHolder.frame.origin.x, self.collectionTagData.frame.origin.y+self.collectionTagData.frame.size.height, _viewLOcationDataHolder.frame.size.width, _viewLOcationDataHolder.frame.size.height)];
    if (B)
    {
       [_tblJobListing setFrame:CGRectMake(_tblJobListing.frame.origin.x, self.viewLOcationDataHolder.frame.origin.y+self.viewLOcationDataHolder.frame.size.height, _tblJobListing.frame.size.width, tableHeight-70)];
    }
    else
    {
        [_tblJobListing setFrame:CGRectMake(_tblJobListing.frame.origin.x, self.viewLOcationDataHolder.frame.origin.y+self.viewLOcationDataHolder.frame.size.height, _tblJobListing.frame.size.width, tableHeight)];
    }
    
    
}
-(void)viewDismissed
{
    [self.tabBarController setSelectedIndex:4];
    [self.tabBarController.selectedViewController viewWillAppear:YES];
}
-(void)viewDismissedReLoad
{
    NSLog(@"%lu",self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count == 2) {
         [self getDefaultJobList:@""];
    }
    
}

-(void)applyFilter:(BOOL)b andMessage:(NSString *)msg
{
    arrResponse=[[NSMutableArray alloc]init];
    arrResponse=[[[GetJobModel getModel]getResponse] mutableCopy];
    [self mergeArray:arrResponse];

    [_tblJobListing reloadData];
    if (arrResponse.count>0)
    {
        //[SharedClass addLabelInUITableViewViewBackGround:self.tblJobListing];
    }
    else
    {
        if (msg.length>0)
        {
            [self showBackgroundLabel:msg];
        }
        //[SharedClass addLabelInUITableViewViewBackGround:self.tblJobListing];
    }
}

-(void)showBackgroundLabel:(NSString *)msg
{
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tblJobListing.bounds.size.width, self.tblJobListing.bounds.size.height)];
    messageLabel.text =msg;
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [messageLabel sizeToFit];
    self.tblJobListing.backgroundView = messageLabel;
    self.tblJobListing.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
     _lblLocation.text=address;
    if (_txtSearch.text.length>0)
    {
        [self getJobList:_txtSearch.text];
    }
    else
    {
       
        _lblLocation.text=address;
        [arrResponse removeAllObjects];
        PageNumber=1;
        [self getDefaultJobListWithPage:[NSString stringWithFormat:@"%d",PageNumber]];
        //[self getJobListByFilter:address];
    }
   
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (IBAction)btnEditLocationAction:(id)sender
{
    SelectLocationViewController *slc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
    slc.delegate=self;
   [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:slc animated:YES];
    
}

#pragma mark - ----CLLOcationManager Delegate------–-------
#pragma mark - -------CLLocation Manager Delegate-------
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currLocation=newLocation;
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [_locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
                       
                       if (error)
                       {
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       
                       if (placemarks && placemarks.count > 0)
                       {
                           CLPlacemark *placemark = placemarks[0];
                           //address = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                           latitude = placemark.location.coordinate.latitude;
                           longitude = placemark.location.coordinate.longitude;
                         //  latitude = 50.278990;
                          // longitude = 3.969226;
                           address=placemark.locality;
                           //address= @"Maubege, 59600";
                           //_lblLocation.text=address;
                        //   [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(getDefaultJobList:) object:nil];

                          // [self performSelector:@selector(getDefaultJobList:) withObject:nil afterDelay:2.0];

                         

                          
                       }
    }];
}
@end