//
//  EditProfileViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/2/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ExperienceViewController.h"
#import "EditProfileCell.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "EditProfileGalleryCell.h"
//#import "VideoConverter.h"
//#import "SDAVAssetExportSession.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AVKit/AVPlayerViewController.h>
@interface EditProfileViewController ()<locationSelectedDelegate,UIPickerViewDelegate>
{
    NSMutableArray  *arrEditProfileCellIdentifier,*arrBottomCell,*arrLanguageCell;
    NSMutableArray *arrayforuploadingimages,*arrLanguage,*arrGallery,*arrDescription;
    NSMutableDictionary *languageDictionary,*responseDictionary;
    NSDictionary *responseGalleryDict;
    NSString *strLevelofEducation;
    NSString *strMobility;
    NSString *currentStatus;
    UICollectionView *collectionGalleryinCell;
    int btnLanguageCount,changablebtntapped,selectedBtnIndex;
    NSString *selectedSkills;
    int CurrentLanguageIndex;
    NSArray *arrTempLanguageHolder;
    UIDatePicker *datePicker;
    NSURL  *newVideoUrl;
    // Boolean for Check if user selected a image and a video
    BOOL imageSelected,videoSelected;
    
    //BinaryData for Sendto Server Profile and Video
    NSData *profileData, *pitchVideoData,*thumbnailData;
    
    // Controls On TableView
    UITextField *txtDate;
    UITextField *txtLocation;
    UITextField *txtFirstName;
    UITextField *txtLastName;
    UITextField *txtExperience;
    UILabel *lblLevelEducation;
    UITextView *txtViewTranning;
    UITextView *txtViewAbout;
    UILabel *lblLanguage;
    UILabel *lblTranningCharacter;
    UILabel *lblAboutCharacter;
    UIImageView *imgProfilePic;
    UIImageView *imgVideoImg;
    UIImagePickerController *imagePicker;
    float lattt;
    float langg;
    int counter;
    CGImageRef imageRef;
    AVPlayerViewController *playerViewController;
}
@property (strong, nonatomic) IBOutlet UIView *viewbackground;
@property (strong, nonatomic) IBOutlet UIView *viewzoomimage;
@property (strong, nonatomic) IBOutlet UIImageView *imagezoom;
@property (strong, nonatomic) IBOutlet UIButton *btndeletoutlet;
@property (strong, nonatomic) IBOutlet UIImageView *imagechangble;
@property (strong, nonatomic) IBOutlet UITextView *textviewdescription;
@end

@implementation EditProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_viewImageVideoBackground setHidden:YES];
    [_viewVideoHolder setHidden:YES];
    [_viewImageHolder setHidden:YES];
    btnLanguageCount=0;
    counter=0;
    strLevelofEducation=@"";
    changablebtntapped = 1;
    arrEditProfileCellIdentifier = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2", @"3",@"4",@"5", @"6",  @"7",@"8",@"9",nil];
    arrLanguage=[[NSMutableArray alloc]init];
    arrLanguageCell=[[NSMutableArray alloc]initWithObjects:@"CellLanguage", nil];
    arrBottomCell=[[NSMutableArray alloc]initWithObjects:@"10",@"11",@"12",@"13", nil];
    _viewbackground.hidden=YES;
    _viewzoomimage.hidden=YES;
    arrayforuploadingimages=[[NSMutableArray alloc]init];
    responseDictionary =[[NSMutableDictionary alloc]init];
    arrGallery=[[NSMutableArray alloc]init];
    [self basicArrayInitilization];
    [self performSelector:@selector(InitialArrayInitilisation) withObject:nil afterDelay:1.0];
    //[self InitialArrayInitilisation];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getAllFields];
    [self setupInitial];
    //[self setThumbnailsForVideo:[NSURL URLWithString:[responseDictionary valueForKey:@"patch_video"]] andImage:[responseDictionary valueForKey:@"user_pic"]];
    
}

-(void)InitialArrayInitilisation
{
    [arrLanguage removeAllObjects];
    [arrLanguageCell removeAllObjects];
    if ([[responseDictionary valueForKey:@"languages"] count]>0)
    {
        [arrLanguageCell removeAllObjects];
        for (int i =0; i<[[responseDictionary valueForKey:@"languages"] count];i++)
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[[[responseDictionary valueForKey:@"languages"] objectAtIndex:i] valueForKey:@"seeker_lang_name"] forKey:@"seeker_lang_name"];
            [dict setValue:[[[responseDictionary valueForKey:@"languages"] objectAtIndex:i] valueForKey:@"lang_proficiency"] forKey:@"lang_proficiency"];
            [arrLanguage addObject:dict];
            [arrLanguageCell addObject:@"CellLanguage"];
        }
    }
    else
    {
        [arrLanguageCell addObject:@"CellLanguage"];
       /* languageDictionary=[[NSMutableDictionary alloc]init];

        [languageDictionary setValue:NSLocalizedString(@"Select", @"") forKey:@"seeker_lang_name"];
        [languageDictionary setValue:@"" forKey:@"lang_proficiency"];
        [arrLanguage addObject:languageDictionary];
        */
    }
    
    
    if (arrLanguage.count>0)
    {
        languageDictionary =[[NSMutableDictionary alloc]init];
        [languageDictionary setValue:[[arrLanguage objectAtIndex:0] valueForKey:@"seeker_lang_name"] forKey:@"seeker_lang_name"];
    }
    
    [_tblEditProfile reloadData];

}

-(void)setupInitial
{
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"EDIT PROFILE", @"")];// NSLocalizedString(@"EDIT PROFILE", @"");
    [_btnSave setTitle:NSLocalizedString(@"Save", @"")];
    txtDate=[self.view viewWithTag:27];
    txtLocation=[self.view viewWithTag:29];
    txtFirstName = (UITextField *)[self.view viewWithTag:23];
    txtLastName = (UITextField *)[self.view viewWithTag:25];
    txtExperience = (UITextField *)[self.view viewWithTag:34];
    lblLevelEducation = (UILabel *)[self.view viewWithTag:36];
    txtViewTranning = (UITextView *)[_tblEditProfile viewWithTag:3800]; txtViewTranning.delegate=self;
    txtViewAbout = (UITextView *)[_tblEditProfile viewWithTag:4000];    txtViewAbout.delegate=self;
    lblLanguage=(UILabel *)[self.view viewWithTag:42];
    lblTranningCharacter=(UILabel *)[self.view viewWithTag:59];
    lblAboutCharacter=(UILabel *)[self.view viewWithTag:60];
    imgProfilePic=(UIImageView *)[self.view viewWithTag:201];
    imgVideoImg=(UIImageView *)[self.view viewWithTag:202];
    
    [self getData];
    
}

-(void)basicArrayInitilization
{
    NSDictionary *temp=[[ProfileDataModel getModel]getResponse];
    [arrGallery removeAllObjects];
    [arrayforuploadingimages removeAllObjects];
    if ([[temp valueForKey:@"gallery"] count]>0)
    {
        for (int i=0; i<[[temp valueForKey:@"gallery"] count]+1; i++)
        {
            [arrayforuploadingimages addObject:@"yes"];
            [arrGallery addObject:[UIImage imageNamed:@"photo_img.png"]];
        }
    }
    else
    {
        [arrEditProfileCellIdentifier addObject:@"0"];
        [arrayforuploadingimages addObject:@"no"];
    }
    
    [_tblEditProfile reloadData];
    
}

#pragma mark - Get Data From Central Stored Named ProfileDataModel

-(void)getData
{
    responseDictionary=[[ProfileDataModel getModel]getResponse];
    if (responseDictionary)
    {
        [self setupEditProfileData];
    }
    
}

-(void)setupEditProfileData
{
    txtFirstName.text=[responseDictionary valueForKey:@"first_name"];
    txtLastName.text=[responseDictionary valueForKey:@"last_name"];
    txtDate.text=[responseDictionary valueForKey:@"dob"];
    txtLocation.text=[responseDictionary valueForKey:@"city"];
    lblLevelEducation.text=[responseDictionary valueForKey:@"education_level"];
    strLevelofEducation=[responseDictionary valueForKey:@"education_level"];
    txtViewAbout.text=[responseDictionary valueForKey:@"about"];
    txtViewTranning.text=[responseDictionary valueForKey:@"training"];
    currentStatus=[responseDictionary valueForKey:@"current_status"];
    strMobility=[responseDictionary valueForKey:@"mobility"];
    if (imageSelected)
    {
        [imgProfilePic setImage:[UIImage imageWithData:profileData]];
    }
    else
    {
          [imgProfilePic sd_setImageWithURL:[NSURL URLWithString:[responseDictionary valueForKey:@"user_pic"]] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if(error)
             {
                 [imgProfilePic setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
             }
             imgProfilePic.layer.cornerRadius=imgProfilePic.frame.size.width/2;
             imgProfilePic.clipsToBounds=YES;
         }];
    }
    
    
    NSString  *videourl=[responseDictionary valueForKey:@"patch_video_thumbnail"];
    if (videoSelected)
    {
        imgVideoImg.image = [[SharedClass sharedInstance]thumbnailFromVideoAtURL:newVideoUrl];
    }
    else
    {
        [imgVideoImg sd_setImageWithURL:[NSURL URLWithString:videourl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if(error)
             {
                 [imgVideoImg setImage:[UIImage imageNamed:@"defaultPIC.png"]];
             }
             imgVideoImg.layer.cornerRadius=imgVideoImg.frame.size.width/2;
             imgVideoImg.clipsToBounds=YES;
         }];
        
//        if (videourl.length>0 && [videourl.lastPathComponent containsString:@".mp4"])
//        {
//
//            if (counter<2)
//            {
////                counter=counter+1;
////                dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
////                dispatch_async(q, ^{
////                    /* Fetch the image from the server... */
////                    //UIImage * Vimage = [[SharedClass sharedInstance] imageFromMovie:[NSURL URLWithString:videourl] atTime:1];
////
////
////
////
////                    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videourl] options:nil];
////                    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
////                    generator.appliesPreferredTrackTransform=TRUE;
////
////                    CMTime thumbTime = CMTimeMakeWithSeconds(0,1);
////
////                    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
////                    {
////                        imageRef=im;
////                        if (error)
////                        {
////                            NSLog(@"Error=%@",error.localizedDescription);
////                        }
////                        else
////                        {
////                            if (result == AVAssetImageGeneratorFailed || result==AVAssetImageGeneratorCancelled)
////                            {
////                                NSLog(@"couldn't generate thumbnail, error:%@", error);
////                            }
////                            else
////                            {
////                                dispatch_async(dispatch_get_main_queue(), ^{
////                                    if (imageRef)
////                                    {
////                                        imgVideoImg.image=[UIImage imageWithCGImage:imageRef];
////                                    }
////                                    else
////                                    {
////
////                                    }
////
////                                    imgVideoImg.layer.cornerRadius=imgVideoImg.frame.size.width/2;
////                                    imgVideoImg.clipsToBounds=YES;
////                                });
////                            }
////
////                        }
////
////                    };
////
////                    CGSize maxSize = CGSizeMake(320, 180);
////                    generator.maximumSize = maxSize;
////                    [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
////
////
////
////                    dispatch_async(dispatch_get_main_queue(), ^{
////
////                        //cell.imgPitchVideo.image=[UIImage imageWithCGImage:imageg];
////                    });
////                });
//            }
//            else
//            {
//
//            }
//
//
//        }
//        else
//        {
//            imgVideoImg.image=[UIImage imageNamed:@"play_icon_deactive.png"];
//        }
    }
    
    
}
    
#pragma mark - ----------Textfield delegates-------------
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
    
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==txtFirstName)
    {
        [responseDictionary setValue:txtFirstName.text forKey:@"first_name"];
    }
    else if (textField==txtLastName)
    {
        [responseDictionary setValue:txtLastName.text forKey:@"last_name"];
    }
    else if (textField==txtDate)
    {
        [responseDictionary setValue:txtDate.text forKey:@"dob"];
    }
    else if (textField==txtLocation)
    {
        [responseDictionary setValue:txtLocation.text forKey:@"city"];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
    
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView==txtViewAbout)
    {
        [responseDictionary setValue:txtViewAbout.text forKey:@"about"];
    }
    else if (textView==txtViewTranning)
    {
        [responseDictionary setValue:txtViewTranning.text forKey:@"training"];
    }
}


#pragma mark - -----------Popup Button Actions--------------

-(void)btnRemovePitchVideoAction:(UIButton *)button
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"deleteProfileVideo";
    webhelper.delegate=self;
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"patch_video" forKey:@"field_name"];
    [webhelper webserviceHelper:params webServiceUrl:kDeleteProfilePic methodName:@"deleteProfileVideo" showHud:YES inWhichViewController:self];
}
-(void)btnRemoveProfilePicAction:(UIButton *)button
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"deleteProfilePic";
    webhelper.delegate=self;
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"user_pic" forKey:@"field_name"];
    [webhelper webserviceHelper:params webServiceUrl:kDeleteProfilePic methodName:@"deleteProfilePic" showHud:YES inWhichViewController:self];
}
-(void)btnViewEnterpriseVideoAction:(UIButton *)btn
{
    self.viewVideoHolder.layer.cornerRadius=10;
    self.viewVideoHolder.clipsToBounds=YES;
    [self.viewImageVideoBackground setHidden:NO];
    [self.viewVideoHolder setHidden:NO];
    [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
    [SharedClass showPopupView:self.viewVideoHolder];
    NSString *videoUrl=[responseDictionary valueForKey:@"patch_video"];
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
    playerViewController.view.alpha=0.8;
    _viewVideoBackground.alpha=0.8;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidExit:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[player currentItem]];
}
-(void)btnViewEnterpriseImageAction:(UIButton *)btn
{
    [self.viewImageVideoBackground setHidden:NO];
    [self.viewImageHolder setHidden:NO];
    [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:nil];
    [SharedClass showPopupView:self.viewImageHolder];
    self.viewImageHolder.layer.cornerRadius=10;
    NSString *imgUrl=[responseDictionary valueForKey:@"enterprise_pic"];
    if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
    {
        UIActivityIndicatorView *imageIndicator;
        [imageIndicator startAnimating];
        UIImageView *Profile_Image=_imgEnterPriseRecruiter;
        __weak UIImageView *weakImageView = Profile_Image;
        [_imgEnterPriseRecruiter sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
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
-(void)btnViewProfilePicAction:(UIButton *)btn
{
    [self.viewImageVideoBackground setHidden:NO];
    [self.viewImageHolder setHidden:NO];
    [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
    [SharedClass showPopupView:self.viewImageHolder];
    self.viewImageHolder.layer.cornerRadius=10;
    NSString *imgUrl=[responseDictionary valueForKey:@"user_pic"];
    if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
    {
        UIActivityIndicatorView *imageIndicator;
        [imageIndicator startAnimating];
        UIImageView *Profile_Image=_imgEnterPriseRecruiter;
        __weak UIImageView *weakImageView = Profile_Image;
        [_imgEnterPriseRecruiter sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
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
    //    [playerViewController.view setFrame:CGRectMake(0, 0, _viewShowVideo.frame.size.width, _viewShowVideo.frame.size.height)];
    //    playerViewController.showsPlaybackControls = NO;
    //[_viewAvplayerHolder addSubview:playerViewController.view];
}
    
#pragma mark - ------------Set Video------------------

-(void)setThumbnailsForVideo:(NSURL *)videoUrl andImage:(NSString *)imgUrl
{
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform=TRUE;
    
    CMTime thumbTime = CMTimeMakeWithSeconds(1,1);
    
    
    __weak UIImageView *weakImageVideoView = imgVideoImg;
    
    
     AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
     {
     if (result != AVAssetImageGeneratorSucceeded)
     {
     NSLog(@"couldn't generate thumbnail, error:%@", error);
     
     }
     else
     {
         if (!error)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 // code here
                __strong UIImage *img=[UIImage imageWithCGImage:im];
                 imgVideoImg.image=img;
                 imgVideoImg.layer.cornerRadius = imgVideoImg.frame.size.width / 2;
                 imgVideoImg.clipsToBounds = YES;
                 
                 weakImageVideoView.alpha = 0.0;
                 weakImageVideoView.image = img;
                 [UIView animateWithDuration:0.3
                                  animations:^
                  {
                      weakImageVideoView.alpha = 1.0;
                      //[self.imgLoaderIndicator stopAnimating];
                  }];
                 
                 
             });
         }
         else
         {
             [SharedClass showToast:self toastMsg:error.localizedDescription];
             imgVideoImg.image=[UIImage imageNamed:@"play_icon_deactive.png"];
         }
         
     }
         // TODO Do something with the image
     };
     
     CGSize maxSize = CGSizeMake(128, 128);
     generator.maximumSize = maxSize;
     [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
    
    
    __weak UIImageView *weakImageView = imgProfilePic;
    [imgProfilePic sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (!error)
         {
             weakImageView.alpha = 0.0;
             weakImageView.image = image;
             [UIView animateWithDuration:0.3
                              animations:^
              {
                  weakImageView.alpha = 1.0;
                  imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.width / 2;
                  imgProfilePic.clipsToBounds = YES;
                  
              }];
         }
         else
         {
             [Alerter.sharedInstance showErrorWithMsg:error.localizedDescription];
             //[SharedClass showToast:self toastMsg:error.localizedDescription];
             imgProfilePic.image=[UIImage imageNamed:@"default_photo_deactive.png"];
         }
         
         
     }];
}

#pragma mark - ---------TableView Delegates ----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==_tblExperience)
    {
        return EditProfileSection;
    }
    else
    {
        return 3;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_tblEditProfile)
    {
        if (section==0)
        {
            return [arrEditProfileCellIdentifier count];
        }
        else if (section==1)
        {
            return [arrLanguageCell count];
        }
        else if (section==2)
        {
            return [arrBottomCell count];
        }
    }
    else if(tableView== _tblExperience)
    {
        return 0; //[cellarray count];
    }
    else if(tableView==__tblActivityAreaView)
    {
        return 0;//[activityarray count];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_tblEditProfile)
    {
        if (indexPath.section==0)
        {
            if (indexPath.row<3)
            {
                return 54;
            }
            else if (indexPath.row==4 || indexPath.row==5)
            {
                return 100;
            }
            else if(indexPath.row==9)
            {
                return 440;
            }
            else
                return 54;
        }
        else if (indexPath.section==1)
        {
            return 180;
        }
        else if (indexPath.section==2)
        {
            if (indexPath.row==0)
            {
                return 101;
            }
            else if (indexPath.row==1)
            {
                return 55;
            }
            else if(indexPath.row==2)
            {
                return 160;
            }
            else if(indexPath.row==3)
            {
                return 411;
            }
        }
        
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        return 54;
    }
    else
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, 54)];
        vw.backgroundColor =[UIColor whiteColor];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(16, 6, 250, 40)];
        label.textColor=TitleColor;
        [label setFont:[UIFont systemFontOfSize:17]];
        label.text=NSLocalizedString(@"LANGUAGES", @"");
        [vw addSubview:label];
        UIView *vw1=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 2, self.view.frame.size.width, 1)];
        vw1.backgroundColor =[UIColor lightGrayColor];
        [vw addSubview:vw1];
        UIView *vw2=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,vw.frame.size.height-2, self.view.frame.size.width, 1)];
        vw2.backgroundColor =[UIColor lightGrayColor];
        [vw addSubview:vw2];
        return vw;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView ==_tblEditProfile)
    {
        EditProfileCell *cell;
        if (indexPath.section==0)
        {
            NSString *strIdentifier = [NSString stringWithFormat:@"Cell%@",arrEditProfileCellIdentifier[indexPath.row]];
            cell = (EditProfileCell *)[tableView dequeueReusableCellWithIdentifier:strIdentifier];
        }
        else if (indexPath.section==1)
        {

            cell = (EditProfileCell *)[tableView dequeueReusableCellWithIdentifier:[arrLanguageCell objectAtIndex:indexPath.row]];
            
            [cell.btnLanguageBeginer setTag:indexPath.row];
            [cell.btnLanguageIntermediate setTag:indexPath.row];
            [cell.btnLanguageAdvanced setTag:indexPath.row];
            [cell.btnLanguageCurrent setTag:indexPath.row];
            [cell.btnLanguageAdd setTag:indexPath.row+41000];
            cell.lblLanguageSelect.text=NSLocalizedString(@"Select", @"");
            if (arrLanguage.count>indexPath.row)
            {
                
                cell.lblLanguageSelect.text=[[arrLanguage objectAtIndex:indexPath.row] valueForKey:@"seeker_lang_name"];

                if ([[[arrLanguage objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency"] isEqualToString:NSLocalizedString(@"Beginner", @"")])
                {
                    [cell.btnLanguageBeginer setSelected:YES];
                }
                else if ([[[arrLanguage objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency"] isEqualToString:NSLocalizedString(@"Intermediate", @"")])
                {
                    [cell.btnLanguageIntermediate setSelected:YES];
                }
                else if ([[[arrLanguage objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency"] isEqualToString:NSLocalizedString(@"Advanced", @"")])
                {
                    [cell.btnLanguageAdvanced setSelected:YES];
                }
                else if ([[[arrLanguage objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency"] isEqualToString:NSLocalizedString(@"Fluent", @"")])
                {
                    [cell.btnLanguageCurrent setSelected:YES];
                }
            }
        }
        else if (indexPath.section==2)
        {
            NSString *strIdentifier = [NSString stringWithFormat:@"Cell%@",arrBottomCell[indexPath.row]];
            cell = (EditProfileCell *)[tableView dequeueReusableCellWithIdentifier:strIdentifier];
        }

        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor whiteColor];
        [cell setSelectedBackgroundView:bgColorView];
        
        [cell.collectionGallery reloadData];
        [cell.btnLanguageAdd addTarget:self action:@selector(AddLanguageCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnCamera addTarget:self action:@selector(openGalleryForPic:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnVideo addTarget:self action:@selector(openGalleryForVideo:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnLocation addTarget:self action:@selector(openLocationPicker:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnCalender addTarget:self action:@selector(openDatePickerController:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnExperience addTarget:self action:@selector(openExperienceController:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnGallery addTarget:self action:@selector(showGallery:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnFirstNameEdit addTarget:self action:@selector(firstNameEditAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnNameEdit addTarget:self action:@selector(NameEditAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnLanguageSelect addTarget:self action:@selector(SelectLanguageAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSelectLevelofEducation addTarget:self action:@selector(selectLavelofEducation:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnGallery addTarget:self action:@selector(btnEditGalleryAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnLanguageBeginer addTarget:self action:@selector(btnLanguageBeginerAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnLanguageIntermediate addTarget:self action:@selector(btnLanguageIntermediateAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnLanguageAdvanced addTarget:self action:@selector(btnLanguageAdvancedAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnLanguageCurrent addTarget:self action:@selector(btnLanguageCurrentAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnApprentice addTarget:self action:@selector(btnApprenticeAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnStatusStudent addTarget:self action:@selector(btnStatusStudentAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnStatusActive addTarget:self action:@selector(btnStatusActiveAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnStatusJobSeeker addTarget:self action:@selector(btnStatusJobSeekerAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnStatusInactive addTarget:self action:@selector(btnStatusInactiveAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnMobilityYes addTarget:self action:@selector(btnMobilityYesAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnMobilityNo addTarget:self action:@selector(btnMobilityNoAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSkillsHotels addTarget:self action:@selector(btnSkillsHotelsAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSkillsCuisine addTarget:self action:@selector(btnSkillsCuisineAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSkillsSalesService addTarget:self action:@selector(btnSkillsSalesServiceAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnViewImage addTarget:self action:@selector(btnViewProfilePicAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnViewVideo addTarget:self action:@selector(btnViewEnterpriseVideoAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnRemovePitchVideo addTarget:self action:@selector(btnRemovePitchVideoAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnRemoveProfilePic addTarget:self action:@selector(btnRemoveProfilePicAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.txtViewTranning.layer.borderWidth=1.0;
        cell.txtViewTranning.layer.borderColor=[UIColor lightGrayColor].CGColor;
        cell.txtViewTranning.layer.cornerRadius=5.0;
        cell.txtViewAbout.layer.borderWidth=1.0;
        cell.txtViewAbout.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
        cell.txtViewAbout.layer.cornerRadius=5.0;
        cell.btnLanguageAdd.layer.cornerRadius=15;
        cell.txtFirstName.userInteractionEnabled=false;
        cell.txtName.userInteractionEnabled=false;
        cell.txtDateofBirth.userInteractionEnabled=false;
        cell.txtCity.userInteractionEnabled=false;
        cell.txtExperience.userInteractionEnabled=false;
        
        cell.lblFirstName.text=NSLocalizedString(@"FIRST NAME", @"");
        cell.lblName.text=NSLocalizedString(@"NAME", @"");
        cell.lblBorn.text=NSLocalizedString(@"DATE OF BIRTH", @"");
        cell.lblCity.text=NSLocalizedString(@"CITY", @"");
        cell.lblPhoto.text=NSLocalizedString(@"PHOTO", @"");
        cell.lblPitchVideo.text=NSLocalizedString(@"VIDEO PITCH", @"");
        cell.lblExperience.text=NSLocalizedString(@"EXPERIENCE", @"");
        
        cell.lblLevelOfEducation.text=NSLocalizedString(@"LEVEL OF EDUCATION", @"");
        cell.lblSpecifyTranning.text=NSLocalizedString(@"SPECIFY YOUR TRAINING", @"");
        cell.lblAbout.text=NSLocalizedString(@"ABOUT", @"");
        
        //cell.lblLanguage.text=NSLocalizedString(@"LANGUAGES", @"");
        
        if ([strLevelofEducation isEqualToString:@""])
        {
            cell.lblLevelEducationSelect.text=NSLocalizedString(@"Select", @"");
        }
        else
        {
            cell.lblLevelEducationSelect.text=strLevelofEducation;
        }
        cell.lblLanguageBeginer.text=NSLocalizedString(@"Beginner", @"");
        cell.lblLanguageIntermediate.text=NSLocalizedString(@"Intermediate", @"");
        cell.lblLanguageAdvanced.text=NSLocalizedString(@"Advanced", @"");
        cell.lblLanguageCurrent.text=NSLocalizedString(@"Fluent", @"");
        [cell.btnLanguageAdd setTitle:NSLocalizedString(@"+ Add language", @"") forState:UIControlStateNormal];
        
        cell.lblActualStatus.text=NSLocalizedString(@"STATUS", @"");
        cell.lblStatusJobSeeker.text=NSLocalizedString(@"Jobseeker", @"");
        cell.lblStatusStudent.text=NSLocalizedString(@"Student", @"");
        cell.lblApprentice.text=NSLocalizedString(@"Apprentice", @"");
        cell.lblStatusActive.text=NSLocalizedString(@"Employed", @"");
        cell.lblStatusInactive.text=NSLocalizedString(@"Inactive", @"");
        
        cell.lblMobility.text=NSLocalizedString(@"MOBILITY", @"");
        cell.lblMobilityYes.text=NSLocalizedString(@"Yes", @"");
        cell.lblMobilityNo.text=NSLocalizedString(@"No", @"");
        cell.lblSkillsTitle.text=NSLocalizedString(@"SKILLS", @"");
        cell.lblSkillsCuisine.text=NSLocalizedString(@"Catering", @"");
        cell.lblSkillsSalesService.text=NSLocalizedString(@"Service", @"");
        cell.lblSkillsHotels.text=NSLocalizedString(@"Hotel", @"");
        cell.lblGallery.text=NSLocalizedString(@"GALLERY", @"");
        cell.txtViewTranning.delegate=self;
        cell.txtViewAbout.delegate=self;
        
        if ([[responseDictionary valueForKey:@"current_status"] isEqualToString:NSLocalizedString(@"Jobseeker", @"")])
        {
            [cell.btnStatusJobSeeker setSelected:YES];
        }
        else if ([[responseDictionary valueForKey:@"current_status"] isEqualToString:NSLocalizedString(@"Student", @"")])
        {
            [cell.btnStatusStudent setSelected:YES];
        }
        else if ([[responseDictionary valueForKey:@"current_status"] isEqualToString:NSLocalizedString(@"Apprentice", @"")])
        {
            [cell.btnApprentice setSelected:YES];
        }
        else if ([[responseDictionary valueForKey:@"current_status"] isEqualToString:NSLocalizedString(@"Employed", @"")])
        {
            [cell.btnStatusActive setSelected:YES];
        }
        else if ([[responseDictionary valueForKey:@"current_status"] isEqualToString:NSLocalizedString(@"Inactive", @"")])
        {
            [cell.btnStatusInactive setSelected:YES];
        }
        else
        {
            [cell.btnStatusJobSeeker setSelected:NO];
            [cell.btnApprentice setSelected:NO];
            [cell.btnStatusStudent setSelected:NO];
            [cell.btnStatusActive setSelected:NO];
            [cell.btnStatusInactive setSelected:NO];
        }
        
        if ([responseDictionary valueForKey:@"mobility"]==[NSNull null])
        {
            
        }
        else
        {
            if([cell.lblMobilityYes.text isEqualToString:NSLocalizedString(@"Yes", @"")])
            {
                [cell.btnMobilityYes setSelected:YES];
            }
            else if ([cell.lblMobilityYes.text isEqualToString:NSLocalizedString(@"No", @"")])
            {
                [cell.btnMobilityNo setSelected:YES];
            }
            else
            {
                [cell.btnMobilityYes setSelected:NO];
                [cell.btnMobilityNo setSelected:NO];
            }
        }
        
        if ([responseDictionary valueForKey:@"skills"]!=[NSNull null])
        {
            if ([[responseDictionary valueForKey:@"skills"] isEqualToString:NSLocalizedString(@"Catering",@"")])
            {
                [cell.btnSkillsCuisine setSelected:YES];
            }
            else if ([[responseDictionary valueForKey:@"skills"] isEqualToString:NSLocalizedString(@"Service",@"")])
            {
                [cell.btnSkillsSalesService setSelected:YES];
            }
            else if ([[responseDictionary valueForKey:@"skills"] isEqualToString:NSLocalizedString(@"Hotel",@"")])
            {
                [cell.btnSkillsHotels setSelected:YES];
            }
        }
        else
        {
            if ([selectedSkills isEqualToString:NSLocalizedString(@"Catering",@"")])
            {
                [cell.btnSkillsCuisine setSelected:YES];
            }
            else if ([selectedSkills isEqualToString:NSLocalizedString(@"Service",@"")])
            {
                [cell.btnSkillsSalesService setSelected:YES];
            }
            else if ([selectedSkills isEqualToString:NSLocalizedString(@"Hotel",@"")])
            {
                [cell.btnSkillsHotels setSelected:YES];
            }
        }
        
        if ([[responseDictionary valueForKey:@"experience"] count]>0)
        {
            txtExperience.text=[NSString stringWithFormat:@"%@ %@ %@ %@",[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"position_held"],[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"company_name"],[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"description"],[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"experience"]];
        }
        
        [cell.collectionGallery reloadData];
        [self setupInitial];
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    NSString *temp=textView.text;
    if (textView==txtViewTranning)
    {
        if ([txtViewTranning.text length]+ (text.length - range.length) >=101)
        {
            textView.text=[temp substringToIndex:[temp length]-1];
        }
        else
        lblTranningCharacter.text=[NSString stringWithFormat:@"%lu/100",(unsigned long)[txtViewTranning.text length]+ (text.length - range.length)];
    }
    else if (textView==txtViewAbout)
    {
        if ([txtViewAbout.text length]+ (text.length - range.length) >=201)
        {
            textView.text=[temp substringToIndex:[temp length]-1];
        }
        else
        lblAboutCharacter.text=[NSString stringWithFormat:@"%lu/200",(unsigned long)[txtViewAbout.text length]+ (text.length - range.length)];
    }
    return true;
}

#pragma mark - ----------Camera Control for image gallery and video -------

-(void)openGalleryForPic:(id)sender
{
    [QMImagePicker chooseSourceTypeInVC:self allowsEditing:YES isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL) {
        imgProfilePic.image=image;
        imgProfilePic.image = image;
        imgProfilePic.layer.cornerRadius = 30.0;
        imgProfilePic.clipsToBounds = YES;
        imageSelected=YES;
        profileData = UIImageJPEGRepresentation(image, 0.9);
    }];
}
-(void)openGalleryForVideo:(id)sender
{
//    [QMImagePicker chooseSourceTypeInVC:self allowsEditing:YES isVideo:YES isPhoto:NO result:^(UIImage* image,NSURL* videoURL) {
//        
//        imageiconofvideo.image = image;
//        imageiconofvideo.layer.cornerRadius = 30.0;
//        imageiconofvideo.clipsToBounds = YES;
//        videoSelected =YES;
//    }];
    [self openActionSheet:YES isPhoto:NO];
}


// custom methods for Camera and Video
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

-(void)openGallery
{
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc]init];
    videoPicker.delegate = self;
    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    videoPicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    videoPicker.videoMaximumDuration = 60.0f;
    videoPicker.allowsEditing = YES;
    
    [self hideTheTabBarWithAnimation:YES];
    [self presentViewController:videoPicker animated:YES completion:nil];
    
}

-(void)openFrontCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *videoRecorder = [[UIImagePickerController alloc]init];
        videoRecorder.delegate = self;
        NSArray *sourceTypes = [UIImagePickerController availableMediaTypesForSourceType:videoRecorder.sourceType];
        NSLog(@"Available types for source as camera = %@", sourceTypes);
        if (![sourceTypes containsObject:(NSString*)kUTTypeMovie])
        {
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
        videoRecorder.videoQuality = UIImagePickerControllerQualityTypeHigh;
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
        [self hideTheTabBarWithAnimation:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
        //[self presentModalViewController:imagePicker animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Camera Not Available"                                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self hideTheTabBarWithAnimation:NO];
    // This is the NSURL of the video object
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    
    NSURL* videoUrl = videoURL;
    newVideoUrl = [[NSURL alloc] initWithString:[videoUrl absoluteString]];
    pitchVideoData = [NSData dataWithContentsOfFile:[newVideoUrl path]];
    long videoSize= pitchVideoData.length/1024.0f/1024.0f;
    
    //long videoSize;
    //NSURL *outputURL = [NSURL fileURLWithPath:@"/Users/josh/Desktop/output.mov"];
//    [[VideoConverter sharedInstance]convertVideoToLowQuailtyWithInputURL:videoURL outputURL:videoURL handler:^(AVAssetExportSession *exportSession)
//    {
//        if (exportSession.status == AVAssetExportSessionStatusCompleted)
//        {
//            NSLog(@"completed\n");
//            pitchVideoData = [NSData dataWithContentsOfFile:[newVideoUrl path]];
//            long videoSize= pitchVideoData.length/1024.0f/1024.0f;
//            
//        }
//        else
//        {
//            NSLog(@"error\n");
//            
//        }
//    }];
    //---------------
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    //NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *finalVideoURLString = [documentsDirectory stringByAppendingPathComponent:@"compressedVideo.mp4"];
//    NSURL *outputVideoUrl = ([[NSURL URLWithString:finalVideoURLString] isFileURL] == 1)?([NSURL URLWithString:finalVideoURLString]):([NSURL fileURLWithPath:finalVideoURLString]); // Url Should be a file Url, so here we check and convert it into a file Url
//    
//    
//    SDAVAssetExportSession *compressionEncoder = [SDAVAssetExportSession.alloc initWithAsset:[AVAsset assetWithURL:videoURL]]; // provide inputVideo Url Here
//    compressionEncoder.outputFileType = AVFileTypeMPEG4;
//    compressionEncoder.outputURL = outputVideoUrl; //Provide output video Url here
//    compressionEncoder.videoSettings = @
//    {
//    AVVideoCodecKey: AVVideoCodecH264,
//    AVVideoWidthKey: @800,   //Set your resolution width here
//    AVVideoHeightKey: @600,  //set your resolution height here
//    AVVideoCompressionPropertiesKey: @
//        {
//        AVVideoAverageBitRateKey: @45000, // Give your bitrate here for lower size give low values
//        AVVideoProfileLevelKey: AVVideoProfileLevelH264High40,
//        },
//    };
//    compressionEncoder.audioSettings = @
//    {
//    AVFormatIDKey: @(kAudioFormatMPEG4AAC),
//    AVNumberOfChannelsKey: @2,
//    AVSampleRateKey: @44100,
//    AVEncoderBitRateKey: @128000,
//    };
//    
//    [compressionEncoder exportAsynchronouslyWithCompletionHandler:^
//     {
//         if (compressionEncoder.status == AVAssetExportSessionStatusCompleted)
//         {
//             pitchVideoData = [NSData dataWithContentsOfFile:[newVideoUrl path]];
//             long videoSize= pitchVideoData.length/1024.0f/1024.0f;
//             NSLog(@"Video Size=%ld",videoSize);
//             NSLog(@"Compression Export Completed Successfully");
//         }
//         else if (compressionEncoder.status == AVAssetExportSessionStatusCancelled)
//         {
//             NSLog(@"Compression Export Canceled");
//         }
//         else
//         {
//             NSLog(@"Compression Failed");
//             
//         }
//     }];
    
    
    
    // testing area
    
    if (videoSize<6)
    {
        videoSelected=YES;
    }
    else
    {
        videoSelected=NO;
        [SharedClass showToast:self toastMsg:@"Select a video less then 2 Mb in size"];
    }
    
        NSDictionary * properties = [[NSFileManager defaultManager] attributesOfItemAtPath:newVideoUrl.path error:nil];
        NSNumber * size = [properties objectForKey: NSFileSize];
        NSLog(@"Vide info :- %@",properties);
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:newVideoUrl options:nil];
    
    NSTimeInterval durationInSeconds = 0.0;
    if (asset)
        durationInSeconds = CMTimeGetSeconds(asset.duration);
    
    if (durationInSeconds>60)
    {
        NSString *msg=[NSString stringWithFormat:@"Video Length is %f",durationInSeconds];
        [SharedClass showToast:self toastMsg:msg];
    }
    
    imgVideoImg.image = [[SharedClass sharedInstance]thumbnailFromVideoAtURL:newVideoUrl];
    thumbnailData = UIImagePNGRepresentation(imgVideoImg.image);
    //imgVideoImg.layer.cornerRadius = 50.0;
    imgVideoImg.layer.cornerRadius = imgVideoImg.frame.size.width / 2;
    imgVideoImg.clipsToBounds = YES;
    NSLog(@"VideoURL = %@", videoURL);
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - ----------Custom Methods for Buttons on Cell--------------
-(void)AddLanguageCell:(id)sender
{
    /*languageDictionary=[[NSMutableDictionary alloc]init];
    
    [languageDictionary setValue:NSLocalizedString(@"Select", @"") forKey:@"seeker_lang_name"];
    [languageDictionary setValue:@"" forKey:@"lang_proficiency"];
    [arrLanguage addObject:languageDictionary];
     */
    [arrLanguageCell addObject:@"CellLanguage"];
    [_tblEditProfile reloadData];
}

-(void)openLocationPicker:(id)sender
{
    SelectLocationViewController *lvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
    lvc.delegate=self;
    [self.navigationController pushViewController:lvc animated:YES];
}

-(void)openDatePickerController:(id)sender
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
//        if(date)
//        {
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-mm-dd"];
//
//            [txtDate setText:[formatter stringFromDate:date]];
//            [txtDate setTextColor:ButtonTitleColor];
//            [responseDictionary setValue:[formatter stringFromDate:date] forKey:@"dob"];
//            //[_dateTextField setText:[formatter stringFromDate:date]];
//        }
//    }];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BONJOB" message:NSLocalizedString(@"Enter the contract start date", @"") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Save", @""), nil];
    alertView.tag =101;
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date]];
    
    [alertView setValue:datePicker forKey:@"accessoryView"];

    [alertView show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
   // txtDate=[formatter stringFromDate:datePicker.date];
    [responseDictionary setObject:[formatter stringFromDate:datePicker.date] forKey:@"dob"];
    txtDate.text=[formatter stringFromDate:datePicker.date];
    [txtDate setTextColor:ButtonTitleColor];
}

- (void) hideTheTabBarWithAnimation:(BOOL) withAnimation
{
    if (withAnimation)
    {
        [self.tabBarController.tabBar setHidden:YES];
    }
    else
    {
        [self.tabBarController.tabBar setHidden:NO];
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDelegate:nil];
//        [UIView setAnimationDuration:0.75];
//        [self.tabBarController.tabBar setAlpha:0.0];
//        [UIView commitAnimations];
    }
}

-(void)getAllFields
{
    txtFirstName = (UITextField *)[self.view viewWithTag:23];
    txtLastName = (UITextField *)[self.view viewWithTag:25];
    txtDate = (UITextField *)[self.view viewWithTag:27];
    txtLocation=(UITextField *)[self.view viewWithTag:29];
    txtExperience=(UITextField *)[self.view viewWithTag:34];
    lblLevelEducation=(UILabel *)[self.view viewWithTag:36];
    txtViewTranning =(UITextView *)[self.view viewWithTag:3800];
    txtViewAbout =(UITextView *)[self.view viewWithTag:4000];
    lblLanguage  =(UILabel *)[self.view viewWithTag:42];
    
    
    txtFirstName.delegate=self;
    txtLastName.delegate=self;
    txtDate.delegate=self;
    txtLocation.delegate=self;
}

- (void)firstNameEditAction:(id)sender
{
    
    txtFirstName.userInteractionEnabled = YES;
    txtFirstName.textColor =[UIColor colorWithRed:235.0/255.0 green:84.0/255.0 blue:119.0/255.0 alpha:1.0];
    [txtFirstName becomeFirstResponder];
    [txtFirstName setDelegate:self];
    
}

- (void)NameEditAction:(id)sender
{
    
    txtLastName.userInteractionEnabled = YES;
    txtLastName.textColor = [UIColor colorWithRed:235.0/255.0 green:84.0/255.0 blue:119.0/255.0 alpha:1.0];
    [txtLastName becomeFirstResponder];
    [txtLastName setDelegate:self];
    
}

-(void)SelectLanguageAction:(UIButton *)sender
{
    [txtViewAbout resignFirstResponder];
    [txtViewTranning resignFirstResponder];
    
    EditProfileCell *cell=(EditProfileCell *)[[sender superview] superview];
    NSIndexPath *indexpath=[_tblEditProfile indexPathForCell:cell];
//    if (arrLanguage.count>indexpath.row)
//    {
//        cell.lblLanguageSelect.text=NSLocalizedString(@"Select", @"");
//        [arrLanguage removeObjectAtIndex:indexpath.row];
//        [cell.btnLanguageBeginer setSelected:NO];
//        [cell.btnLanguageCurrent setSelected:NO];
//        [cell.btnLanguageAdvanced setSelected:NO];
//        [cell.btnLanguageIntermediate setSelected:NO];
//        [_tblEditProfile reloadData];
//    }
    
    
    
    SelectLanguageViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLanguageViewController"];
    vc.delegate=self;
    CurrentLanguageIndex=(int)indexpath.row;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (void)borneditaction:(id)sender
{
    [self.view endEditing:YES];
}


-(void)openExperienceController:(id)sender
{
    ExperienceViewController *exvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ExperienceViewController"];
    exvc.delegate=self;
    [self.navigationController pushViewController:exvc animated:YES];
}
-(void)showGallery:(id)sender
{
   
}

-(void)selectLavelofEducation:(id)sender
{
    SelectLevelofEducationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLevelofEducationViewController"];
    slvc.delegate=self;
    [self.navigationController pushViewController:slvc animated:YES];
}

#pragma mark ------------Skills Radio Button Action--------------
-(void)btnSkillsHotelsAction:(UIButton *)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[sender superview] superview];
    [cell.btnSkillsSalesService setSelected:NO];
    [cell.btnSkillsCuisine setSelected:NO];
    [cell.btnSkillsHotels setSelected:YES];
    selectedSkills=cell.lblSkillsHotels.text;
}
-(void)btnSkillsCuisineAction:(UIButton *)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[sender superview] superview];
    [cell.btnSkillsSalesService setSelected:NO];
    [cell.btnSkillsCuisine setSelected:YES];
    [cell.btnSkillsHotels setSelected:NO];
    selectedSkills=cell.lblSkillsCuisine.text;
}
-(void)btnSkillsSalesServiceAction:(UIButton *)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[sender superview] superview];
    [cell.btnSkillsSalesService setSelected:YES];
    [cell.btnSkillsCuisine setSelected:NO];
    [cell.btnSkillsHotels setSelected:NO];
    selectedSkills=cell.lblSkillsSalesService.text;
    
}
#pragma mark - -------Languages Radio Buttons Actions------
-(void)btnLanguageBeginerAction:(UIButton *)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:sender.tag inSection:1];
    
    
    if ([languageDictionary valueForKey:@"seeker_lang_name"])
    {
        if ([cell.lblLanguageSelect.text isEqualToString:NSLocalizedString(@"Select", @"")])
        {
            [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
            //[SharedClass showToast:self toastMsg:@"Please Select language first"];
        }
        else
        {
            [cell.btnLanguageBeginer setSelected:YES];
            [cell.btnLanguageCurrent setSelected:NO];
            [cell.btnLanguageAdvanced setSelected:NO];
            [cell.btnLanguageIntermediate setSelected:NO];
            if ([arrLanguage count]>indexPath.row)
            {
                languageDictionary =[[NSMutableDictionary alloc]init];
                [languageDictionary setValue:cell.lblLanguageBeginer.text forKey:@"lang_proficiency"];
                [languageDictionary setValue:cell.lblLanguageSelect.text forKey:@"seeker_lang_name"];
                
                [arrLanguage replaceObjectAtIndex:indexPath.row withObject:languageDictionary];
                
                NSLog(@"Indexpath=%ld",(long)indexPath.row);
                NSLog(@"New Array=%@,",arrLanguage);
            }
            else
            {
                [languageDictionary setValue:cell.lblLanguageBeginer.text forKey:@"lang_proficiency"];
                [languageDictionary setValue:cell.lblLanguageSelect.text forKey:@"seeker_lang_name"];
                [arrLanguage addObject:languageDictionary];
            }
            [_tblEditProfile reloadData];
        }
    }
    else
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
        //[SharedClass showToast:self toastMsg:@"Please Select language first"];
    }
}
-(void)btnLanguageIntermediateAction:(UIButton *)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:sender.tag inSection:1];
    
    
    if ([languageDictionary valueForKey:@"seeker_lang_name"])
    {
        if ([cell.lblLanguageSelect.text isEqualToString:NSLocalizedString(@"Select", @"")])
        {
            [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
            //[SharedClass showToast:self toastMsg:@"Please Select language first"];
        }
        else
        {
            [cell.btnLanguageBeginer setSelected:NO];
            [cell.btnLanguageCurrent setSelected:NO];
            [cell.btnLanguageAdvanced setSelected:NO];
            [cell.btnLanguageIntermediate setSelected:YES];
            if ([arrLanguage count]>indexPath.row)
            {
                languageDictionary =[[NSMutableDictionary alloc]init];
                [languageDictionary setValue:cell.lblLanguageIntermediate.text forKey:@"lang_proficiency"];
                [languageDictionary setValue:cell.lblLanguageSelect.text forKey:@"seeker_lang_name"];
                [arrLanguage replaceObjectAtIndex:indexPath.row withObject:languageDictionary];
                
                NSLog(@"Indexpath=%ld",(long)indexPath.row);
                NSLog(@"New Array=%@,",arrLanguage);
            }
            else
            {
                [languageDictionary setValue:cell.lblLanguageIntermediate.text forKey:@"lang_proficiency"];
                [languageDictionary setValue:cell.lblLanguageSelect.text forKey:@"seeker_lang_name"];
                [arrLanguage addObject:languageDictionary];
            }
            [_tblEditProfile reloadData];
        }
    }
    else
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
        //[SharedClass showToast:self toastMsg:@"Please Select language first"];
    }
}
-(void)btnLanguageAdvancedAction:(UIButton *)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:sender.tag inSection:1];
    if ([languageDictionary valueForKey:@"seeker_lang_name"])
    {
        if ([cell.lblLanguageSelect.text isEqualToString:NSLocalizedString(@"Select", @"")])
        {
            [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
            //[SharedClass showToast:self toastMsg:@"Please Select language first"];
        }
        else
        {
            [cell.btnLanguageBeginer setSelected:NO];
            [cell.btnLanguageCurrent setSelected:NO];
            [cell.btnLanguageAdvanced setSelected:YES];
            [cell.btnLanguageIntermediate setSelected:NO];
            if ([arrLanguage count]>indexPath.row)
            {
                languageDictionary =[[NSMutableDictionary alloc]init];
                [languageDictionary setValue:cell.lblLanguageAdvanced.text forKey:@"lang_proficiency"];
                [languageDictionary setValue:cell.lblLanguageSelect.text forKey:@"seeker_lang_name"];
                
                [arrLanguage replaceObjectAtIndex:indexPath.row withObject:languageDictionary];
                NSLog(@"Indexpath=%ld",(long)indexPath.row);
                NSLog(@"New Array=%@,",arrLanguage);
            }
            else
            {
                [languageDictionary setValue:cell.lblLanguageAdvanced.text forKey:@"lang_proficiency"];
                [languageDictionary setValue:cell.lblLanguageSelect.text forKey:@"seeker_lang_name"];
                [arrLanguage addObject:languageDictionary];
            }
            [_tblEditProfile reloadData];
        }
        
        
        
    }
    else
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
        //[SharedClass showToast:self toastMsg:@"Please Select language first"];
    }
    
    
    
}
-(void)btnLanguageCurrentAction:(UIButton *)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:sender.tag inSection:1];
    if ([languageDictionary valueForKey:@"seeker_lang_name"])
    {
        if ([cell.lblLanguageSelect.text isEqualToString:NSLocalizedString(@"Select", @"")])
        {
            [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
           // [SharedClass showToast:self toastMsg:@"Please Select language first"];
        }
        else
        {
            [cell.btnLanguageBeginer setSelected:NO];
            [cell.btnLanguageCurrent setSelected:YES];
            [cell.btnLanguageAdvanced setSelected:NO];
            [cell.btnLanguageIntermediate setSelected:NO];
            if ([arrLanguage count]>indexPath.row)
            {
                languageDictionary =[[NSMutableDictionary alloc]init];
                [languageDictionary setValue:cell.lblLanguageCurrent.text forKey:@"lang_proficiency"];
                [languageDictionary setValue:cell.lblLanguageSelect.text forKey:@"seeker_lang_name"];
                
                [arrLanguage replaceObjectAtIndex:indexPath.row withObject:languageDictionary];
                
                NSLog(@"Indexpath=%ld",(long)indexPath.row);
                NSLog(@"New Array=%@,",arrLanguage);
            }
            else
            {
                [languageDictionary setValue:cell.lblLanguageCurrent.text forKey:@"lang_proficiency"];
                [languageDictionary setValue:cell.lblLanguageSelect.text forKey:@"seeker_lang_name"];
                [arrLanguage addObject:languageDictionary];
            }

            [_tblEditProfile reloadData];
        }
    }
    else
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
        //[SharedClass showToast:self toastMsg:@"Please Select language first"];
    }
    

}

#pragma mark -----------Status button Action-----------

-(void)btnApprenticeAction:(id)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    [cell.btnApprentice setSelected:YES];
    [cell.btnStatusStudent setSelected:NO];
    [cell.btnStatusActive setSelected:NO];
    [cell.btnStatusJobSeeker setSelected:NO];
    [cell.btnStatusInactive setSelected:NO];
    currentStatus=cell.lblApprentice.text;
    
}

-(void)btnStatusStudentAction:(id)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    [cell.btnApprentice setSelected:NO];
    [cell.btnStatusStudent setSelected:YES];
    [cell.btnStatusActive setSelected:NO];
    [cell.btnStatusJobSeeker setSelected:NO];
    [cell.btnStatusInactive setSelected:NO];
    currentStatus=cell.lblStatusStudent.text;
}

-(void)btnStatusActiveAction:(id)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    [cell.btnApprentice setSelected:NO];
    [cell.btnStatusStudent setSelected:NO];
    [cell.btnStatusActive setSelected:YES];
    [cell.btnStatusJobSeeker setSelected:NO];
    [cell.btnStatusInactive setSelected:NO];
    currentStatus=cell.lblStatusActive.text;

}

-(void)btnStatusJobSeekerAction:(id)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    [cell.btnApprentice setSelected:NO];
    [cell.btnStatusStudent setSelected:NO];
    [cell.btnStatusActive setSelected:NO];
    [cell.btnStatusJobSeeker setSelected:YES];
    [cell.btnStatusInactive setSelected:NO];
    currentStatus=cell.lblStatusJobSeeker.text;

}

-(void)btnStatusInactiveAction:(id)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    [cell.btnApprentice setSelected:NO];
    [cell.btnStatusStudent setSelected:NO];
    [cell.btnStatusActive setSelected:NO];
    [cell.btnStatusJobSeeker setSelected:NO];
    [cell.btnStatusInactive setSelected:YES];
    currentStatus=cell.lblStatusInactive.text;

}

#pragma mark ----------Mobility Button Action----------

-(void)btnMobilityYesAction:(id)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    [cell.btnMobilityYes setSelected:YES];
    [cell.btnMobilityNo setSelected:NO];
    strMobility=cell.lblMobilityYes.text;
}

-(void)btnMobilityNoAction:(id)sender
{
    EditProfileCell *cell=(EditProfileCell *)[[[sender superview] superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    [cell.btnMobilityYes setSelected:NO];
    [cell.btnMobilityNo setSelected:YES];
    strMobility=cell.lblMobilityNo.text;
}

#pragma mark - ------Location Selection delegate------
-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
    lattt=lattitute;
    langg=Longitute;
    [txtLocation setText:address];
    [txtLocation setTextColor:ButtonTitleColor];
    [responseDictionary setValue:address forKey:@"city"];
}

-(void)languageSelected:(NSString *)languages;
{
    if ([[responseDictionary valueForKey:@"languages"] count]>CurrentLanguageIndex)
    {
        languageDictionary =[[NSMutableDictionary alloc]init];
        [languageDictionary setValue:languages forKey:@"seeker_lang_name"];
        [languageDictionary setValue:@"" forKey:@"lang_proficiency"];
        [arrLanguage replaceObjectAtIndex:CurrentLanguageIndex withObject:languageDictionary];
    }
    else
    {
        languageDictionary =[[NSMutableDictionary alloc]init];
        [languageDictionary setValue:languages forKey:@"seeker_lang_name"];
        if ([arrLanguage containsObject:languages])
        {
            
        }
        else
        {
            [arrLanguage addObject:languageDictionary];
            
        }
        lblLanguage.text=languages;
    }
    
    [_tblEditProfile reloadData];
    
}

-(void)levelofEducationSelected:(NSString *)education
{
    [responseDictionary setValue:education forKey:@"education_level"];
    strLevelofEducation=education;
    lblLevelEducation.text=education;
    [_tblEditProfile reloadData];
}

-(void)ExperienceSelected:(NSArray *)arr
{
    txtExperience.textColor=ButtonTitleColor;
    txtExperience.text=[NSString stringWithFormat:@"%@-%@",[[arr objectAtIndex:0] valueForKey:@"position_held"],[[arr objectAtIndex:0] valueForKey:@"company_name"]];
}

- (void)btnEditGalleryAction:(UIButton *)sender
{
    collectionGalleryinCell=(UICollectionView *)[self.view viewWithTag:57];
    collectionGalleryinCell.hidden = NO;
    for(int i=0;i<[arrayforuploadingimages count];i++)
    {
        [arrayforuploadingimages replaceObjectAtIndex:i withObject:@"yes"];
    }
    [collectionGalleryinCell reloadData];
}

#pragma mark - ---------Collection Delegates ----------------

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrayforuploadingimages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"EditProfileGalleryCell";
    
    EditProfileGalleryCell *cell = (EditProfileGalleryCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([[responseDictionary valueForKey:@"gallery"]count]>indexPath.item)
    {
        NSString *imgUrl=[[[responseDictionary valueForKey:@"gallery"]objectAtIndex:indexPath.item] valueForKey:@"image"];
        __weak UIImageView *weakImageView = cell.imgGallery;
        [cell.imgGallery sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             weakImageView.alpha = 0.0;
             weakImageView.image = image;
             [UIView animateWithDuration:0.3
                              animations:^
              {
                  weakImageView.alpha = 1.0;
                  //imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.width / 2;
                  //imgProfilePic.clipsToBounds = YES;
                  
              }];
             
         }];
        [arrayforuploadingimages replaceObjectAtIndex:indexPath.item withObject:@"no"];

    }
    else
    {
        if (arrGallery.count>indexPath.item)
        {
            cell.imgGallery.image = [arrGallery objectAtIndex:indexPath.item];
        }
    }
    
    //cellimage.image =[UIImage imageNamed:@"photo_img.png"];
    cell.imgGallery.layer.cornerRadius = 8.0;
    cell.imgGallery.layer.borderColor = [UIColor colorWithRed:211.0/255.0 green:210.0/255.0 blue:209.0/255.0 alpha:1.0].CGColor;
    cell.imgGallery.layer.borderWidth = 1.0;
    cell.imgGallery.clipsToBounds = YES;
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10; // This is the minimum inter item spacing, can be more
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"EditProfileGalleryCell";
    
    EditProfileGalleryCell *cell = (EditProfileGalleryCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if([[arrayforuploadingimages objectAtIndex:indexPath.item] isEqualToString:@"yes"])
    {
        [QMImagePicker chooseSourceTypeInVC:self allowsEditing:YES isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL) {
            cell.imgGallery.image = image;
            [arrGallery insertObject:image atIndex:indexPath.item];
            cell.imgGallery.layer.cornerRadius =  8.0;
            cell.imgGallery.clipsToBounds = YES;
            [arrayforuploadingimages replaceObjectAtIndex:indexPath.item withObject:@"no"];
            [self sendGalleryImageToServer:image];
        }];
        [collectionView reloadData];
        
    }
    else
    {
        
        if ([[responseDictionary valueForKey:@"gallery"]count]>indexPath.item)
        {
            NSString *imgUrl=[[[responseDictionary valueForKey:@"gallery"]objectAtIndex:indexPath.item] valueForKey:@"image"];
            __weak UIImageView *weakImageView = _imagezoom;
            [_imagezoom sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 weakImageView.alpha = 0.0;
                 weakImageView.image = image;
                 [UIView animateWithDuration:0.3
                                  animations:^
                  {
                      weakImageView.alpha = 1.0;
                      //imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.width / 2;
                      //imgProfilePic.clipsToBounds = YES;
                      
                  }];
                 
                 
             }];
            
            
        }
        else
        {
            if (arrGallery.count>indexPath.item)
            {
                _imagezoom.image = [arrGallery objectAtIndex:indexPath.item];
            }
        }
        
        NSString *desc=[[[responseDictionary valueForKey:@"gallery"]objectAtIndex:indexPath.item] valueForKey:@"description"];
        if ([desc isKindOfClass:[NSNull class]] || [desc isEqualToString:@""])
        {
            _textviewdescription.text = NSLocalizedString(@"Add a description ?", nil);
        }
        else
        {
            _textviewdescription.text=desc;
        }
        
        selectedBtnIndex=(int)indexPath.item;
        [arrayforuploadingimages replaceObjectAtIndex:indexPath.item withObject:@"no"];

        
        
        //_imagezoom.image = cell.imgGallery.image;
        //_imagezoom.image = cell.imgGallery.image;//arrGallery objectAtIndex:indexPath.item];
        //[_imagezoom setImage:cell.imgGallery.image];
        _textviewdescription.textColor = [UIColor whiteColor];
        
        _textviewdescription.editable = NO;
        [_btndeletoutlet setTitle:NSLocalizedString(@"x Delete photo", nil) forState:UIControlStateNormal];
        [SharedClass setBorderOnButton:_btndeletoutlet];
        CGRect cgRect = [[UIScreen mainScreen] bounds];
        CGSize cgSize   = cgRect.size;
        float deviceheight  = cgSize.height;
        float devicewidth  = cgSize.width;
        float aspectratiowidth = devicewidth/320;
        float aspectratioheight  = deviceheight/568;
        [_viewbackground setTranslatesAutoresizingMaskIntoConstraints:YES];
        _viewbackground.frame = CGRectMake(0, deviceheight, devicewidth, deviceheight);
        _viewbackground.hidden = NO;
        [_viewzoomimage setTranslatesAutoresizingMaskIntoConstraints:YES];
        _viewzoomimage.frame = CGRectMake(20*aspectratiowidth, deviceheight- 100*aspectratioheight,aspectratiowidth*280 , aspectratioheight*331);
        [UIView animateWithDuration:0.2
                         animations:^{
                             _viewbackground.frame = CGRectMake(0, 0, devicewidth, deviceheight);
                             [self.tabBarController.view addSubview:_viewbackground];
                             
                             _viewzoomimage.hidden = NO;
                             _viewzoomimage.layer.cornerRadius = 10.0;
                             _imagezoom.layer.cornerRadius = 10.0;
                             _imagezoom.clipsToBounds = YES;
                             _viewzoomimage.clipsToBounds = YES;
                             _viewzoomimage.frame = CGRectMake(20*aspectratiowidth,100*aspectratioheight,aspectratiowidth*280 , aspectratioheight*331);
                             
                             [self.tabBarController.view addSubview:_viewzoomimage];
                         }
                         completion:^(BOOL finished) {
                         }];
        
        
    }
}

#pragma mark
#pragma mark-------Collection view layout things---------
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"SETTING SIZE FOR ITEM AT INDEX %ld", (long)indexPath.row);
    //CGSize mElementSize = CGSizeMake(175, 175);
    
    //return CGSizeMake((UIScreen.mainScreen().bounds.width-15)/4,120);
    //[[UIScreen mainScreen] bounds].size.width/2-12
    return CGSizeMake(90, 90);
    
    //return mElementSize;
}


// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(5,5,8,8);  // top, left, bottom, right
}

- (IBAction)btnforzoomingviewcut:(UIButton *)sender {
    
    _viewzoomimage.hidden = YES;
    _viewbackground.hidden  = YES;
    [self.view endEditing:YES];
    changablebtntapped = 1;
    [_textviewdescription setDelegate:self];
    [_textviewdescription resignFirstResponder];
    //[self.tabBarController.view setFrame:CGRectMake(0,0,_viewzoomimage.frame.size.width,_viewzoomimage.frame.size.height)];
}


- (IBAction)btnfortextimage:(UIButton *)sender
{
    
    if(changablebtntapped==1)
    {
        _imagechangble.image = [UIImage imageNamed:@"checkmarkLUDO.png"];
        _textviewdescription.editable = YES;
        _textviewdescription.tintColor=ButtonTitleColor;
        [_textviewdescription becomeFirstResponder];
        _textviewdescription.text = @"";
        [_textviewdescription setFont:[UIFont systemFontOfSize:20.0]];
        [_textviewdescription setDelegate:self];
        changablebtntapped = 2;
        // [self registerForKeyboardNotifications];
    }
    else
    {
        _imagechangble.image = [UIImage imageNamed:@"pencil_icon.png"];
        _viewzoomimage.hidden = YES;
        _viewbackground.hidden  = YES;
        changablebtntapped = 1;
        [_textviewdescription setDelegate:self];
        [_textviewdescription resignFirstResponder];
        [self.tabBarController.view setFrame:CGRectMake(0,0,_viewbackground.frame.size.width,_viewbackground.frame.size.height)];
        [self addDescriptionToPhotos];
    }
    [self.view endEditing:YES];
}



- (IBAction)btnDeletePhoto:(UIButton *)sender
{
    [self deletePhotoFromGallery];
}




- (IBAction)btnSaveAction:(id)sender
{
    if ([self validate])
    {
        [self sendProfileDatatoServer];
    }
}

-(BOOL)validate
{
    if ([txtFirstName.text isEqualToString:@""]||txtFirstName.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Enter FirstName"];
        return false;
    }
    else if ([txtLastName.text isEqualToString:@""]||txtLastName.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Enter LastName"];
        return false;
    }
    else if ([txtDate.text isEqualToString:@""]||txtDate.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Enter DOB"];
        return false;
    }
    else if ([txtLocation.text isEqualToString:@""]||txtLocation.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Enter City"];
        return false;
    }
    else if ([txtExperience.text isEqualToString:@""]||txtExperience.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Enter Your Experience"];
        return false;
    }
    else if ([lblLevelEducation.text isEqualToString:NSLocalizedString(@"Select",@"")]||lblLevelEducation.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Please select your education"];
        return false;
    }
    else if ([txtViewTranning.text isEqualToString:@""]||txtViewTranning.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Enter Tranning"];
        return false;
    }
    else if ([txtViewAbout.text isEqualToString:@""]||txtViewAbout.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Write About yourself"];
        return false;
    }
    else if ([lblLanguage.text isEqualToString:NSLocalizedString(@"Select", @"")]||lblLanguage.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Please select a language"];
        return false;
    }
    else if ([txtViewTranning.text isEqualToString:@""]||txtViewTranning.text.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Enter Any Tranning"];
        return false;
    }
    else if (arrLanguage.count==0)
    {
        [SharedClass showToast:self toastMsg:@"Please select any known language and Proficiency Level"];
        return false;
    }
    else if ([currentStatus isEqualToString:@""]||currentStatus.length==0)
    {
        [SharedClass showToast:self toastMsg:@"Please select Current Status"];
        return false;
    }
    else if ([strMobility isKindOfClass:[NSNull class]])
    {
        [SharedClass showToast:self toastMsg:@"Please select Mobility"];
        return false;
    }
    
    return true;
}

#pragma mark - WebService Methods For Profile
-(void)deletePhotoFromGallery
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    //{"gallery_id":"1","description":"jdjhd jdhjhdjhj jdhjdhajd aj"}
    if (responseGalleryDict)
    {
        [params setValue:[responseGalleryDict valueForKey:@"gallery_id"] forKey:@"gallery_id"];
    }
    else
    {
        [params setValue:[[[responseDictionary valueForKey:@"gallery"] objectAtIndex:selectedBtnIndex] valueForKey:@"gallery_id"]forKey:@"gallery_id"];
    }
    
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"DeleteGalleryImage";
    webHelper.delegate=self;
    [webHelper webserviceHelper:params webServiceUrl:kDeleteGalleryImage methodName:@"DeleteGalleryImage" showHud:YES inWhichViewController:self];
}

-(void)addDescriptionToPhotos
{
    if (_textviewdescription.text.length>0)
    {
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        //{"gallery_id":"1","description":"jdjhd jdhjhdjhj jdhjdhajd aj"}
        if (responseGalleryDict)
        {
            [params setValue:[responseGalleryDict valueForKey:@"gallery_id"] forKey:@"gallery_id"];
        }
        else
        {
            [params setValue:[[[responseDictionary valueForKey:@"gallery"] objectAtIndex:selectedBtnIndex] valueForKey:@"gallery_id"]forKey:@"gallery_id"];
        }
        [params setValue:_textviewdescription.text forKey:@"description"];
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.methodName=@"EditGallery";
        webHelper.delegate=self;
        [webHelper webserviceHelper:params webServiceUrl:kEditGallery methodName:@"EditGallery" showHud:YES inWhichViewController:self];
    }
}

-(void)sendGalleryImageToServer:(UIImage *)image
{
    NSData *imgData=UIImageJPEGRepresentation(image, 0.9);
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    //{"gallery_id":"1","user_id":"1","gallery":"image","description":"sdsdsdsd"}
    [dict setValue:@"" forKey:@"gallery_id"];
    [dict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [dict setValue:@"" forKey:@"description"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"uploadGallery";
    webHelper.delegate=self;
    [webHelper webserviceHelper:dict uploadData:imgData ImageParam:@"gallery" andVideoData:nil withVideoThumbnail:nil type:@"" webServiceUrl:kUpdateGallery methodName:@"uploadGallery" showHud:YES inWhichViewController:self];
}

-(void)sendProfileDatatoServer
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:txtFirstName.text forKey:@"first_name"];
    [params setValue:txtLastName.text forKey:@"last_name"];
    [params setValue:txtDate.text forKey:@"dob"];
    [params setValue:txtLocation.text forKey:@"city"];
    [params setValue:txtViewAbout.text forKey:@"about"];
    [params setValue:txtViewTranning.text forKey:@"training"];
    [params setValue:strMobility forKey:@"mobility"];
    [params setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"deviceToken"] forKey:@"device_token"];
    [params setValue:lblLevelEducation.text forKey:@"education_level"];
    [params setValue:currentStatus forKey:@"current_status"];
    [params setValue:selectedSkills forKey:@"skills"];
    //[params setValue:@"" forKey:@"language"];
    [params setValue:arrLanguage forKey:@"language"];
    [params setValue:[NSString stringWithFormat:@"%f",lattt] forKey:@"lattitude"];
    [params setValue:[NSString stringWithFormat:@"%f",langg] forKey:@"longitude"];
    [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"] forKey:@"device_token"];
    
    if (imageSelected && videoSelected)
    {
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.methodName=@"EditProfile";
        webHelper.delegate=self;
//        [webHelper webserviceHelper:params uploadData:profileData ImageParam:@"user_pic" andVideoData:pitchVideoData withVideoThumbnail:nil type:@".mp4" webServiceUrl:kEditProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
        
        
        [webHelper webserviceHelper:params uploadData:profileData ImageParam:@"user_pic" andVideoData:pitchVideoData withVideoThumbnail:thumbnailData type:@".mp4" webServiceUrl:kEditProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
        [self showProgress:YES];
    }
    else if (imageSelected)
    {
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.methodName=@"EditProfile";
        webHelper.delegate=self;
        [webHelper webserviceHelper:params uploadData:profileData ImageParam:@"user_pic" andVideoData:nil withVideoThumbnail:nil  type:@".mp4" webServiceUrl:kEditProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
        [self showProgress:YES];
    }
    else if (videoSelected)
    {
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.methodName=@"EditProfile";
        webHelper.delegate=self;
        [webHelper webserviceHelper:params uploadData:nil ImageParam:nil andVideoData:pitchVideoData withVideoThumbnail:thumbnailData  type:@".mp4" webServiceUrl:kEditProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
        [self showProgress:YES];
    }
    else
    {
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.methodName=@"EditProfile";
        webHelper.delegate=self;
        [webHelper webserviceHelper:params webServiceUrl:kEditProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
    }
}

#pragma mark - ------------WebService Response--------------

-(void)inProgress:(float)value
{
    
    _lblProgress.text=[NSString stringWithFormat:@"Uploaded %.2f%%",value];
    [self showProgress:YES];
    if (value>=100)
    {
        [self showProgress:NO];
    }
}

-(void)showProgress:(BOOL)B
{
    if (B)
    {
        _lblProgress.alpha = 0;
        _lblProgress.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _lblProgress.alpha = 1;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _lblProgress.alpha = 0;
        } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
            _lblProgress.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
        }];
    }
    
    
    
}

-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([methodNameIs isEqualToString:@"deleteProfileVideo"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            [self.delegate profileUpdated];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        else
        {
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"deleteProfilePic"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            [self.delegate profileUpdated];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        else
        {
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"EditProfile"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
             [self.delegate profileUpdated];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        else
        {
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if([methodNameIs isEqualToString:@"uploadGallery"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            responseGalleryDict=[responseDict valueForKey:@"data"];
            [arrayforuploadingimages addObject:@"yes"];
            [arrGallery addObject:[UIImage imageNamed:@"photo_img.png"]];
            [collectionGalleryinCell reloadData];
            [_tblEditProfile reloadData];
            [[ProfileDataModel getModel]addObjectToGallery:responseGalleryDict];
            [self basicArrayInitilization];
        }
    }
    else if([methodNameIs isEqualToString:@"EditGallery"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [[ProfileDataModel getModel]updateGallery:_textviewdescription.text atIndex:selectedBtnIndex];
            [self basicArrayInitilization];
            
        }
    }
    else if ([methodNameIs isEqualToString:@"DeleteGalleryImage"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [[ProfileDataModel getModel]deleteGalleryatIndex:selectedBtnIndex];
            [self basicArrayInitilization];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
