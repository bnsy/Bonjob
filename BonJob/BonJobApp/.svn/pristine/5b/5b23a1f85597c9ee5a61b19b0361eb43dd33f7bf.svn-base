//
//  CompanyPageDetailsViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/14/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "CompanyPageDetailsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#define METERS_PER_MILE 1609.344

@implementation JobOfferedCell


@end


@interface CompanyPageDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MFMailComposeViewControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    BOOL tapped;
    AVPlayer *player;
    AVPlayerLayer *playerLayer;
    MPMoviePlayerController *moviePlayerController;
    NSMutableDictionary *dataDict;
    NSMutableArray *arrJobPosted;
    NSMutableArray *arrOnlineBuddies;
    NSString *ReportUniqueID;
    NSString *letters ;
}
@end

@implementation CompanyPageDetailsViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    _viewPlayPauseHolder.alpha=0.0;
    _viewPlayerLayer.layer.masksToBounds=YES;
    _viewPlayerLayer.layer.cornerRadius=15.0;
    
    UIBezierPath *maskPath = [UIBezierPath
                              bezierPathWithRoundedRect:_viewPlayPauseHolder.bounds
                              byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                              cornerRadii:CGSizeMake(15, 15)
                              ];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.frame = _viewPlayPauseHolder.bounds;
    maskLayer.path = maskPath.CGPath;
    _viewPlayPauseHolder.layer.mask = maskLayer;
    if (self.CompanyName.length != 0) {
         self.title=[SharedClass capitalizeFirstLetterOnlyOfString:self.CompanyName];
    }
    
   
    self.collectionJobOffer.pagingEnabled=NO;
    [self initialSetup];
    [self getCompanyDetails];
    
    arrOnlineBuddies=[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statusChanged:) name:@"statusChanged" object:nil];
    
     [_btnContentReport setTitle:NSLocalizedString(@"REPORT INAPPROPRIATE CONTENT", @"") forState:UIControlStateNormal];
     letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _scrollMain.backgroundColor=[UIColor whiteColor];
    _viewMain.translatesAutoresizingMaskIntoConstraints=YES;
    CGRect viewMainFrame=self.viewMain.frame;
 viewMainFrame.size.height=_btnContentReport.frame.origin.y+_btnContentReport.frame.size.height;
    _viewMain.frame=viewMainFrame;
    
    [_scrollMain setContentSize:CGSizeMake(self.view.frame.size.width, _viewMain.frame.origin.y+_viewMain.frame.size.height+150)];
//    NSURL *url=[[NSURL alloc] initWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
//    [self setupPlayer:url];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

// for online offline of recruiter
-(void)statusChanged:(NSNotification *)notification
{
    NSDictionary *userDic=notification.userInfo;
     AppDelegate *appdel = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    
    if ([[userDic valueForKey:@"status"] isEqualToString:@"available"])
    {
        if ([arrOnlineBuddies containsObject:[userDic valueForKey:@"username"]])
        {
            
        }
        else
        {
            [arrOnlineBuddies addObject:[userDic valueForKey:@"username"]];
        }
       
        NSString *userAvailable=[NSString stringWithFormat:@"bonjob_%@%@",self.employer_id,@"@bonjob.co"];
        if ([appdel.arrOnlineBuddies containsObject:userAvailable])
        {
            //[self setNavigationbarTitle:NSLocalizedString(@"Online", @"") andColor:[UIColor greenColor]];
            _imgOnlineSymbol.image=[UIImage imageNamed:@"online_active"];
             _lblOnlineStatus.text=NSLocalizedString(@"Online", @"");
        }
        else
        {
            _imgOnlineSymbol.image=[UIImage imageNamed:@"online_deactive"];
             _lblOnlineStatus.text=NSLocalizedString(@"Offline", @"");
        }
        
    }
    else if([[userDic valueForKey:@"status"] isEqualToString:@"unavailable"])
    {
        if ([appdel.arrOnlineBuddies containsObject:[userDic valueForKey:@"username"]] && appdel.arrOnlineBuddies.count>0)
        {
            [appdel.arrOnlineBuddies removeObject:[userDic valueForKey:@"username"]];
        }
        

        
        NSString *userAvailable=[NSString stringWithFormat:@"bonjob_%@%@",self.employer_id,@"@bonjob.co"];
        if ([appdel.arrOnlineBuddies containsObject:userAvailable])
        {
            //[self setNavigationbarTitle:NSLocalizedString(@"Online", @"") andColor:[UIColor greenColor]];
            _imgOnlineSymbol.image=[UIImage imageNamed:@"online_active"];
             _lblOnlineStatus.text=NSLocalizedString(@"Online", @"");
        }
        else
        {
            _imgOnlineSymbol.image=[UIImage imageNamed:@"online_deactive"];
            _lblOnlineStatus.text=NSLocalizedString(@"Offline", @"");
        }
        
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCompanyDetails
{
    //{"employer_id":"54"}
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    //[params setObject:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setObject:self.employer_id forKey:@"employer_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"getCompanyDetails";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:kCompanyDetails methodName:@"getCompanyDetails" showHud:YES inWhichViewController:self];
}

-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
        {
            //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
           // [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
            //[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
           // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([methodNameIs isEqualToString:@"getCompanyDetails"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==1)
        {
            arrJobPosted=[[NSMutableArray alloc]init];
            [arrJobPosted addObjectsFromArray:[[responseDict valueForKey:@"data"]valueForKey:@"allJobs"]];
            dataDict=[[NSMutableDictionary alloc]init];
            //dataDict=[[responseDict valueForKey:@"data"] valueForKey:@"company_details"];
            dataDict=[self validateData:[[responseDict valueForKey:@"data"] valueForKey:@"company_details"]];
            [self.defaultView setHidden:YES];
            [self.collectionJobOffer reloadData];
            [self setData];
        }
    }
}

-(NSMutableDictionary *)validateData:(NSDictionary *)dict
{
    NSMutableDictionary *temp=[dict mutableCopy];
    for (NSString *key in dict)
    {
        if ([dict valueForKey:key]==[NSNull null] || [[dict valueForKey:key] isKindOfClass:[NSNull class]])
        {
            [temp setValue:@"" forKey:key];
        }
        
    }
    return temp;
}

-(void)setData
{
   
    
    for (int i=0; i<[arrJobPosted count]; i++)
    {
        NSString *jobid=[[arrJobPosted objectAtIndex:i] valueForKey:@"job_id"];
        if ([self.job_id isEqualToString:jobid])
        {
            self.SelectedJobIndex=[NSString stringWithFormat:@"%d",i];
            break;
        }
    }
    
    NSURL *url=[[NSURL alloc] initWithString:[dataDict valueForKey:@"patch_video"]];
    [self setupPlayer:url];
    
    _lblDescription.text=[dataDict valueForKey:@"about"];
    if ([[dataDict valueForKey:@"about"] length]==0)
    {
        _lblAboutHeightConstant.constant=0;
        _lblAboutHeight.constant = 0;
        _btnAboutHeight.constant = 0;
    }
    
    _lblUser.text=[NSString stringWithFormat:@"%@ %@",[dataDict valueForKey:@"first_name"],[dataDict valueForKey:@"last_name"]];
    if ([[dataDict valueForKey:@"website"] length]>0 && [dataDict valueForKey:@"website"]!=[NSNull null])
    {
        [_btnWebSite setTitle:[dataDict valueForKey:@"website"] forState:UIControlStateNormal];
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[dataDict valueForKey:@"website"] attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
        [titleString addAttribute:NSForegroundColorAttributeName value:TitleColor range:NSMakeRange(0, titleString.length)];
        //use the setAttributedTitle method
        [_btnWebSite setAttributedTitle:titleString forState:UIControlStateNormal];
        
        [_imgAtTheRate setHidden:NO];
        [_lblCompanyWebsite setHidden:NO];
        [_btnWebSite setHidden:NO];
    }
    else
    {
        [_imgAtTheRate setHidden:YES];
        [_lblCompanyWebsite setHidden:YES];
        [_btnWebSite setHidden:YES];
        
        _websiteatTherateHeight.constant=0;
        _websiteLblHeightConstant.constant=0;
        _webUrlHeightConstant.constant=0;
    }
    [_imgCompany sd_setImageWithURL:[NSURL URLWithString:[dataDict valueForKey:@"enterprise_pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error)
        {
            [_imgCompany setImage:[UIImage imageNamed:@"defaultPic.png"]];
        }
        
    }];
    
    [_imgEmployerProfile sd_setImageWithURL:[NSURL URLWithString:[dataDict valueForKey:@"user_pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error)
        {
            [_imgEmployerProfile setImage:kDefaultPlaceHolder];
        }
        _imgEmployerProfile.layer.cornerRadius=_imgEmployerProfile.frame.size.width/2;
        _imgEmployerProfile.clipsToBounds=YES;
        _imgEmployerProfile.layer.borderColor=[UIColor colorWithRed:214/255.0 green:214/255.0 blue:223/255.0 alpha:1.0].CGColor;
    }];
    
    _lblResturent.text=[dataDict valueForKey:@"company_category"];
    _lblOnlineStatus.text=NSLocalizedString(@"Offline", @"");
    _imgOnlineSymbol.image=[UIImage imageNamed:@"radio_blank.png"];
    if (arrJobPosted.count>0)
    {
        [_imgJobOfferDetails sd_setImageWithURL:[NSURL URLWithString:[[arrJobPosted objectAtIndex:[self.SelectedJobIndex intValue]] valueForKey:@"job_image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if (error)
             {
                 [_imgJobOfferDetails setImage:[UIImage imageNamed:@"default_job.png"]];
             }
         }];
    }
    else
    {
        [_imgJobOfferDetails setImage:kDefaultPlaceHolder];
        _viewJobDetailsHeight.constant=0;
    }
    
    
    
    if ([[dataDict valueForKey:@"patch_video_thumbnail"] length]==0 || [[dataDict valueForKey:@"patch_video_thumbnail"] isEqualToString:@""])
    {
        [_imgVideo setHidden:YES];
        [_imgVideoIcon setHidden:YES];
        [_lblVideo setHidden:YES];
        [_viewPlayerLayer setHidden:YES];
        
        _imgVideoHeightConstant.constant=0;
        _lblVideoHeightConstant.constant=0;
        _viewVideoPlayerHeight.constant=0;
        
        _btnContentReport.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=_btnContentReport.frame;
        frame.origin.y=_lblVideo.frame.origin.y;
        _btnContentReport.frame=frame;
        
        //_viewMain.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect viewMainFrame=self.viewMain.frame;
        viewMainFrame.size.height=_btnContentReport.frame.origin.y+_btnContentReport.frame.size.height+10;
        _viewMain.frame=viewMainFrame;
        
    }
    else
    {
        [_imgVideo setHidden:NO];
        [_imgVideoIcon setHidden:NO];
        [_lblVideo setHidden:NO];
        [_viewPlayerLayer setHidden:NO];
        [self.videoLoader startAnimating];
        [_imgVideo sd_setImageWithURL:[NSURL URLWithString:[dataDict valueForKey:@"patch_video_thumbnail"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if (error)
             {
                 [_imgVideo setImage:kDefaultPlaceHolder];
                 //[self.videoLoader stopAnimating];
             }
             else
             {
                 [self.videoLoader stopAnimating];
             }
         }];
    }
    
    if (arrJobPosted.count>0)
    {
        _lblJobOfferDescriptionDate.text=[[arrJobPosted objectAtIndex:[self.SelectedJobIndex intValue]] valueForKey:@"createdOn"];
        _txtViewJobOfferDescription.text=[[arrJobPosted objectAtIndex:[self.SelectedJobIndex intValue]] valueForKey:@"job_description"];
    }
    else
    {
        _viewJobDetailsHeight.constant=0;
    }
    
    
    _viewJobHolder.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _viewJobHolder.layer.borderWidth=0.9;
    _lblResturent.text=[dataDict valueForKey:@"company_category"];
   // Restaurant
    _lblResturent.text=NSLocalizedString(@"Restaurant", @"");
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[dataDict valueForKey:@"company_lat"] doubleValue];
    zoomLocation.longitude= [[dataDict valueForKey:@"company_long"] doubleValue];

    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5* METERS_PER_MILE, 0.5* METERS_PER_MILE);

    // 3
    [_mapView setRegion:viewRegion animated:YES];
    

    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = [dataDict valueForKey:@"enterprise_name"];
    point.subtitle = [dataDict valueForKey:@"company_category"];
    [self.mapView addAnnotation:point];
    
    
    AppDelegate *appdel = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    
    NSString *userAvailable=[NSString stringWithFormat:@"bonjob_%@%@",self.employer_id,@"@bonjob.co"];
    if ([appdel.arrOnlineBuddies containsObject:userAvailable])
    {
        //[self setNavigationbarTitle:NSLocalizedString(@"Online", @"") andColor:[UIColor greenColor]];
        _imgOnlineSymbol.image=[UIImage imageNamed:@"online_active"];
        _lblOnlineStatus.text=NSLocalizedString(@"Online", @"");
    }
    else
    {
        _imgOnlineSymbol.image=[UIImage imageNamed:@"online_deactive"];
        _lblOnlineStatus.text=NSLocalizedString(@"Offline", @"");
    }
    
}

-(void)initialSetup
{
    _lblResturent.text=NSLocalizedString(@"Restaurant", @"");
    _lblAbout.text=NSLocalizedString(@"About", @"");
    _lblAccountOwner.text=NSLocalizedString(@"Account owner", @"");
    _lblOnlineStatus.text=NSLocalizedString(@"Active", @"");
    _lblCompanyLocation.text=NSLocalizedString(@"Location of the company", @"");
    _lblCompanyWebsite.text=NSLocalizedString(@"Company's website", @"");
    _lblJobOffers.text=NSLocalizedString(@"Job offers", @"");
    _lblVideo.text=NSLocalizedString(@"Video", @"");
    
    
}

#pragma mark - ----------MapKit Delegates----------
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    // Add an annotation
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    point.title = @"Le Bonne Table";
//    point.subtitle = @"Restaurant!";
//    [self.mapView addAnnotation:point];
}



- (void)toggleVideoPlayPause:(id)sender
{
    NSURL *url=[[NSURL alloc] initWithString:[dataDict valueForKey:@"patch_video"]];
    NSString *videoUrl=[dataDict valueForKey:@"patch_video"];
    if (videoUrl.length>0)
    {
        if (tapped)
        {
            tapped=NO;
            //_viewPlayPauseHolder.alpha=0.0;
            [UIView animateWithDuration:0.5 animations:^(void)
             {
                 _viewPlayPauseHolder.alpha=0.0;
             }];
        }
        else
        {
            tapped=YES;
            //_viewPlayPauseHolder.alpha=0.8;
            [UIView animateWithDuration:0.5 animations:^(void)
             {
                 _viewPlayPauseHolder.alpha=0.8;
             }];
        }
    }
    
}

-(IBAction) playVideo:(id)sender
{
    NSURL *url=[[NSURL alloc] initWithString:[dataDict valueForKey:@"patch_video"]];
   // [self setupPlayer:url];
    
    //[player play];
    [self toggleVideoPlayPause:nil];
    [moviePlayerController play];
}

- (IBAction)pauseVideo:(id)sender
{
    //[player pause];
    [self toggleVideoPlayPause:nil];
    [moviePlayerController pause];
}

- (IBAction)fullScreenVideo:(id)sender
{

    [moviePlayerController.view setFrame:self.view.bounds];
    [self.view addSubview:moviePlayerController.view];
    moviePlayerController.fullscreen = YES;
    moviePlayerController.controlStyle=MPMovieControlStyleFullscreen;
}
- (void)setupPlayer:(NSURL *)url
{
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
//    
//    player = [AVPlayer playerWithPlayerItem:playerItem];
//    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    playerLayer.frame = self.viewPlayerLayer.bounds;
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    [self.viewPlayerLayer.layer addSublayer:playerLayer];
    
    moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [moviePlayerController.view setFrame:self.viewPlayerLayer.bounds];
    [moviePlayerController setScalingMode:MPMovieScalingModeAspectFit];
    [self.viewPlayerLayer addSubview:moviePlayerController.view];
    moviePlayerController.fullscreen = NO;
    moviePlayerController.controlStyle=MPMovieControlStyleNone;
    moviePlayerController.shouldAutoplay=NO;
   // moviePlayerController.movieSourceType = MPMovieSourceTypeStreaming;
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:MPMoviePlayerFullscreenAnimationDurationUserInfoKey object:nil];
    
    
}

- (void)MPMoviePlayerDidExitFullscreen:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerDidExitFullscreenNotification
                                                  object:nil];
    
    [moviePlayerController stop];
    [moviePlayerController.view removeFromSuperview];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
}
-(void)playFinished:(NSNotification *) notification
{
    // Will be called when AVPlayer finishes playing playerItem
    [self dismissViewControllerAnimated:YES completion:Nil];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:AVPlayerItemDidPlayToEndTimeNotification
     object:Nil];
    
    
}

-(void)setVideoOnView:(NSString *)videoUrl
{
    
//    NSURL *myVideoUrl=[NSURL URLWithString:videoUrl];
//    //    player =[[MPMoviePlayerController alloc] initWithContentURL: myVideoUrl];
//    //    [[player view] setFrame: [_viewShowVideo bounds]];  // frame must match parent view
//    //    [_viewShowVideo addSubview: [player view]];
//
//
//    playerViewController = [[AVPlayerViewController alloc] init];
//    AVURLAsset *asset = [AVURLAsset assetWithURL: myVideoUrl];
//    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
//
//    AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
//    playerViewController.player = player;
//    [playerViewController.view setFrame:CGRectMake(0, 0, _viewShowVideo.frame.size.width, _viewShowVideo.frame.size.height)];
//
//    playerViewController.showsPlaybackControls = YES;
//
//    [_viewAvplayerHolder addSubview:playerViewController.view];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidExit:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[player currentItem]];
}

- (void)itemDidFinishPlaying:(NSNotification *)notification {
//    AVPlayerItem *player = [notification object];
//    [player seekToTime:kCMTimeZero];
}

- (void)itemDidExit:(NSNotification *)notification
{
//    AVPlayerItem *player = [notification object];
//    [playerViewController.view setFrame:CGRectMake(0, 0, _viewShowVideo.frame.size.width, _viewShowVideo.frame.size.height)];
//    playerViewController.showsPlaybackControls = NO;
//    [_viewAvplayerHolder addSubview:playerViewController.view];
}

//-------------------------



- (IBAction)btnWebSiteAction:(id)sender
{
    NSString *website=[dataDict valueForKey:@"website"];
    if ([website containsString:@"http://"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
    }
    else
    {
        website=[NSString stringWithFormat:@"http://%@",website];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
        
    }
    
}

#pragma mark - ----------Colelction View Delegates--------------
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    //UIImageView *cellimage = (UIImageView *)[self.view viewWithTag:201];
    
    CGSize size = CGSizeMake(self.view.frame.size.width,278);
    return size;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrJobPosted count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JobOfferedCell *cell=(JobOfferedCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"JobOfferedCell" forIndexPath:indexPath];
    NSURL *imgUrl=[[arrJobPosted objectAtIndex:indexPath.item]valueForKey:@"job_image"];
    [cell.activityLoader startAnimating];
    [cell.imgJobOffer sd_setImageWithURL:imgUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        if (error)
        {
            cell.imgJobOffer.image=[UIImage imageNamed:@"default_job.png"];
        }
        [cell.activityLoader stopAnimating];
    }];
    
    NSString *date=[Alert getDateWithString:[[arrJobPosted objectAtIndex:indexPath.item] valueForKey:@"createdOn"] getFormat:GET_FORMAT_TYPE setFormat:SET_FORMAT_TYPE4];
    cell.lblJobOfferdDate.text=date;//[[arrJobPosted objectAtIndex:indexPath.item] valueForKey:@"createdOn"];
    cell.txtViewJobDesc.text=[[arrJobPosted objectAtIndex:indexPath.item] valueForKey:@"job_title"];
    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.collectionJobOffer flashScrollIndicators];
////    *targetContentOffset = scrollView.contentOffset; // set acceleration to 0.0
////    float pageWidth = (float)self.collectionJobOffer.bounds.size.width;
////    int minSpace = 5;
////
////    int cellToSwipe = (scrollView.contentOffset.x)/(pageWidth + minSpace) + 0.5; // cell width + min spacing for lines
////    if (cellToSwipe < 0)
////    {
////        cellToSwipe = 0;
////    }
////    else if (cellToSwipe >= arrJobPosted.count)
////    {
////        cellToSwipe = (int)arrJobPosted.count - 1;
////    }
////    [self.collectionJobOffer scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//
//    float pageWidth = (float)self.view.frame.size.width+5;
//    float currentOffset = scrollView.contentOffset.x;
//    float targetOffset = targetContentOffset->x;
//    float newTargetOffset = 0;
//
//    if (targetOffset > currentOffset)
//        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
//    else
//        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
//
//    if (newTargetOffset < 0)
//        newTargetOffset = 0;
//    else if (newTargetOffset > scrollView.contentSize.width)
//        newTargetOffset = scrollView.contentSize.width;
//
//    targetContentOffset->x = currentOffset;
//    [scrollView setContentOffset:CGPointMake(newTargetOffset, scrollView.contentOffset.y) animated:YES];
}



#pragma mark - ------REPORT APPROPRIATE CONTENT-------

- (IBAction)btnContentReportAction:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:NSLocalizedString(@"Inappropriate content", @"")  otherButtonTitles:nil,nil];
    popup.tag = 1;
    [popup showInView:self.view];
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

-(NSString *) randomStringWithLength: (int) len
{

    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (int i=0; i<len; i++)
    {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }

    return randomString;
}
-(void)showAlert:(NSString *)msg
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Bonjob" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


@end
