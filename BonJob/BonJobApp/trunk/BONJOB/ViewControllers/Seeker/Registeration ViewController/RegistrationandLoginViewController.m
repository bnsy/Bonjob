//
//  RegistrationandLoginViewController.m
//  BONJOB
//
//  Created by Infoicon Technologies on 01/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "RegistrationandLoginViewController.h"
#import "TWMessageBarManager.h"
#import "TermsPolicyViewController.h"
#define kOFFSET_FOR_KEYBOARD 80.0
@interface RegistrationandLoginViewController ()<locationSelectedDelegate,ExperienceDelegate>
{
    BOOL termsSelected;
    BOOL imageSelected;
    BOOL videoSelected;
    NSData *videoData;
    NSData *thumbnailData;
     float latt,lang;
    NSArray *arrExperience;
    NSString *selectedEducationId;

}
@property (nonatomic, strong) UIPopoverController *popOver;

- (IBAction)backbtn:(UIButton *)sender;
@property (nonatomic) XMPPManager *xmppManager;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollviewformoveup;
@property (strong, nonatomic) IBOutlet UIButton *connectionbutton;
@property (strong, nonatomic) IBOutlet UIView *registartionview;
@property (strong, nonatomic) IBOutlet UIView *connectionview;
- (IBAction)contionbuttonaction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *registrationoutlet;
@property (strong, nonatomic) IBOutlet UIButton *forgteyourpasswordoutlet;
@property (strong, nonatomic) IBOutlet UITextField *emailtextfieldforconnection;
@property (strong, nonatomic) IBOutlet UITextField *passwordtextfieldforconnection;
- (IBAction)takephotoaction:(UIButton *)sender;
- (IBAction)takevideoaction:(UIButton *)sender;
- (IBAction)registartionaction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageiconofperson;
@property (strong, nonatomic) IBOutlet UIImageView *imageiconofvideo;
//@property (strong, nonatomic) IBOutlet FRHyperLabel *registrationconditionslabel;
@end

@implementation RegistrationandLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _parameters = [[NSMutableDictionary alloc]init];
    _connectionview.hidden = YES;
    _segmentviewcontrolleroutlet.layer.cornerRadius = 2.0;
    [self setup];
   
    self.emailtextfieldforconnection.text=@"";
    self.passwordtextfieldforconnection.text=@"";
    _viewVideoGuidePopup.layer.cornerRadius=15.0;
    _viewVideoGuideInternal.layer.cornerRadius=15.0;
    _scrollView.layer.cornerRadius=15.0;
    [_forgteyourpasswordoutlet setTitle:NSLocalizedString(@"Forgot your password ?", @"") forState:UIControlStateNormal];
    [_viewVideoGuidePopup setHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([_whichsegmentisshow isEqualToString:@"Inscription"])
    {
        _registartionview.hidden = NO;
        _connectionview.hidden = YES;
        _segmentviewcontrolleroutlet.selectedSegmentIndex = 0;
        [_segmentviewcontrolleroutlet setTitle:NSLocalizedString(@"Sign Up", nil) forSegmentAtIndex:0];
        [_scrollviewformoveup setContentSize:CGSizeMake(self.view.frame.size.width,_registrationoutlet.frame.origin.y+_registrationoutlet.frame.size.height+20)];
        
        
        self.registartionview.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=self.registartionview.frame;
        frame.size.height=_registrationoutlet.frame.size.height+_registrationoutlet.frame.origin.y+20;
        self.registartionview.frame=frame;
    }
    else
    {
        _connectionview.hidden = NO;
        _registartionview.hidden  = YES;
        _segmentviewcontrolleroutlet.selectedSegmentIndex = 1;
        [_segmentviewcontrolleroutlet setTitle:NSLocalizedString(@"Login", nil) forSegmentAtIndex:1];
        [_scrollviewformoveup setContentSize:CGSizeMake(self.view.frame.size.width,_forgteyourpasswordoutlet.frame.origin.y+_forgteyourpasswordoutlet.frame.size.height+20)];
        
        self.connectionview.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=self.connectionview.frame;
        frame.size.height=_connectionbutton.frame.size.height+_connectionbutton.frame.origin.y+100;
        self.connectionview.frame=frame;
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //[self registerForKeyboardNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
    
    /*
    NSString *isSecLogined = [[NSUserDefaults standardUserDefaults] valueForKey:@"logined"];
    
    if ([isSecLogined isEqualToString:@"yes"])
    {
        UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
        vc.tabBar.translucent = NO;
        [self presentViewController:vc animated:YES completion:nil];
        
        //[[vc.tabBar.items objectAtIndex:2]setBadgeValue:@"0"];
        [[vc.tabBar.items objectAtIndex:2]setBadgeColor:ButtonTitleColor];
        //[[vc.tabBar.items objectAtIndex:3]setBadgeValue:@"0"];
        [[vc.tabBar.items objectAtIndex:3]setBadgeColor:ButtonTitleColor];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
    }
     */
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self deregisterFromKeyboardNotifications];
}
- (void)reachabilityChanged:(NSNotification *)notification
{
    if([AFNetworkReachabilityManager sharedManager].isReachable)
    {
        // Do web service stuff here
        [[[[[iToast makeText:NetworkSuccess]
            setGravity:iToastGravityBottom] setDuration:iToastDurationNormal]setBgRed:1.0] show];
    }
    else
    {
        [[[[[iToast makeText:NetworkError]
            setGravity:iToastGravityBottom] setDuration:iToastDurationNormal]setBgRed:1.0] show];
        // Do non webservice stuff
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons Actions

- (IBAction)btnCityPressed:(UIButton *)sender
{
    SelectLocationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
    slvc.delegate=self;
    [self.navigationController pushViewController:slvc animated:YES];
}
- (IBAction)btnExperiencePressed:(UIButton *)sender
{
  
    ExperienceViewController *exvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ExperienceViewController"];
    exvc.delegate=self;
    exvc.isFromSignUp = YES;
    exvc.tempArrExp = [arrExperience mutableCopy];
    [self.navigationController pushViewController:exvc animated:YES];
}

- (IBAction)btnTrainingPressed:(UIButton *)sender
{
    SelectLevelofEducationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLevelofEducationViewController"];
    slvc.delegate=self;
    slvc.titled = @"LEVEL OF EDUCATION";
    [self.navigationController pushViewController:slvc animated:YES];
    
    
}
- (IBAction)backbtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnRadioAction:(id)sender
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

- (IBAction)segmentviewcontrolleraction:(UISegmentedControl *)sender
{
    if(_segmentviewcontrolleroutlet.selectedSegmentIndex ==0)
    {
        _whichsegmentisshow = @"Inscription";
        _connectionview.hidden = YES;
        _registartionview.hidden = NO;
        [_scrollviewformoveup setContentSize:CGSizeMake(self.view.frame.size.width,_registrationoutlet.frame.origin.y+_registrationoutlet.frame.size.height+20)];
        
        self.registartionview.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=self.registartionview.frame;
        frame.size.height=_registrationoutlet.frame.size.height+_registrationoutlet.frame.origin.y+20;
        self.registartionview.frame=frame;
        
    }
    else
    {
        _whichsegmentisshow = @"Login";
        _connectionview.hidden = NO;
        _registartionview.hidden = YES;
        [_scrollviewformoveup setContentSize:CGSizeMake(self.view.frame.size.width,_forgteyourpasswordoutlet.frame.origin.y+_forgteyourpasswordoutlet.frame.size.height+20)];
        
        self.connectionview.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect frame=self.connectionview.frame;
        frame.size.height=_connectionbutton.frame.size.height+_connectionbutton.frame.origin.y+100;
        self.connectionview.frame=frame;
    }
    [self.view endEditing:YES];
}

-(IBAction)takephotoaction:(UIButton *)sender
{
//     [QMImagePicker chooseSourceTypeInVC:self allowsEditing:YES isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL)
//     {
//         imageSelected=YES;
//          _imageiconofperson.image = image;
//          _imageiconofperson.layer.cornerRadius = 50.0;
//          _imageiconofperson.clipsToBounds = YES;
//     }];
  
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

-(IBAction)takevideoaction:(UIButton *)sender
{
    
    NSString *vv=[[[NSUserDefaults standardUserDefaults] valueForKey:@"videodata"] valueForKey:@"videopopup"];
    NSString *uid=[[[NSUserDefaults standardUserDefaults] valueForKey:@"videodata"] valueForKey:@"uid"];
    
    if ([vv isEqualToString:@"yes"])
    {
         [self openActionSheet:YES isPhoto:NO];
    }
    else
    {
       
        
        [SharedClass showPopupView:self.viewDimBackground andTabbar:nil];
        [SharedClass showPopupView:self.viewVideoGuidePopup];
         [self.viewVideoGuidePopup setHidden:NO];
    }
    
}

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
    if (actionSheet.tag == 1) {
        switch (buttonIndex)
        {
            case 0:

                 [self openGalleryforPic];
                break;
            case 1:
                  [self openCameraforPic];
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//
//                }];
              
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
   // videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    videoPicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    videoPicker.videoMaximumDuration = 60.0f;
        
    videoPicker.allowsEditing = YES;
    
  //  [self dismissViewControllerAnimated:YES completion:^{
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
       // videoRecorder.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeMovie];
         videoRecorder.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
        videoRecorder.videoQuality = UIImagePickerControllerQualityTypeMedium;
        videoRecorder.videoMaximumDuration = 60;
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
        {
            
            videoRecorder.cameraDevice =  UIImagePickerControllerCameraDeviceFront;
        } else
        {
            videoRecorder.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        imagePicker = videoRecorder;
        [imagePicker setShowsCameraControls:YES];
      //  [self dismissViewControllerAnimated:YES completion:^{
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if([info[UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)(kUTTypeImage)])
    {
        NSLog(@"Image");
        //image
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad  && chosenImage == nil)
        {
            chosenImage = info[UIImagePickerControllerOriginalImage];
        }
                    imageSelected = YES;
                  _imageiconofperson.image = chosenImage;
                  _imageiconofperson.layer.cornerRadius = 50.0;
                  _imageiconofperson.clipsToBounds = YES;
        
        [picker dismissViewControllerAnimated:YES completion:NULL];
        
    }
    else
    {
    
    // This is the NSURL of the video object
       NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
       NSURL* videoUrl = videoURL;
       NSURL  *newVideoUrl = [[NSURL alloc] initWithString:[videoUrl absoluteString]];
       videoData = [NSData dataWithContentsOfFile:[newVideoUrl path]];
       long videoSize = videoData.length/1024.0f/1024.0f;

        if (videoSize<8)
        {
            videoSelected=YES;
        }
        else
        {
            videoSelected=NO;
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
    
    _imageiconofvideo.image = [[SharedClass sharedInstance]thumbnailFromVideoAtURL:newVideoUrl];

    thumbnailData = UIImagePNGRepresentation(_imageiconofvideo.image);
    _imageiconofvideo.layer.cornerRadius = 50.0;
    _imageiconofvideo.clipsToBounds = YES;
    NSLog(@"VideoURL = %@", videoURL);
    [picker dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"Video");
        //video
    }
}

-(IBAction)registartionaction:(UIButton *)sender
{
    [self Register];
}

-(IBAction)contionbuttonaction:(UIButton *)sender
{
//    [_emailtextfieldforconnection setEmailField:YES];
//    [_passwordtextfieldforconnection setPasswordField:YES];
    [self login];
}

-(IBAction)forgetyourpasswordactiononconnection:(UIButton *)sender
{
    UIAlertView *myView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Forgot your password ?", @"") message:NSLocalizedString(@"Enter your email address", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Ok", @""), nil];
    myView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [myView textFieldAtIndex:0].delegate = self;
    [myView show];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
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
            NSString *url=[NSString stringWithFormat:@"%@",kForgotPassword];
            [webHelper webserviceHelper:params webServiceUrl:url methodName:@"forgotpass" showHud:YES inWhichViewController:self];
        }
        else
        {
            [self forgetyourpasswordactiononconnection:nil];
        }
        NSLog(@"%@", textField.text);
    }
}

#pragma mark - Webservice Methods
-(void)login
{
    //{“email”:”sushant@infoicon.co.in”,”password”:”12345678”}
    if ([self validateLoginForm])
    {
        NSMutableDictionary *params=[NSMutableDictionary new];
        [params setValue:_emailtextfieldforconnection.text forKey:@"email"];
        [params setValue:_passwordtextfieldforconnection.text forKey:@"password"];
        [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"] forKey:@"device_token"];
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.methodName=@"login";
        webHelper.delegate=self;
        NSString *url=[NSString stringWithFormat:@"%@",kLoginWebUrl];
        [webHelper webserviceHelper:params webServiceUrl:url methodName:@"login" showHud:YES inWhichViewController:self];
    }
    else
    {
        
    }
    
}
-(void)Register
{

    if ([self validateRegister])
    {
        if (termsSelected)
        {
            NSMutableDictionary *params=[NSMutableDictionary new];
            [params setValue:_txtRegisterName.text forKey:@"first_name"];
            [params setValue:_txtRegisterLastName.text forKey:@"last_name"];
            [params setValue:_txtRegisterEmail.text forKey:@"email"];
            [params setValue:_txtRegisterPassword.text forKey:@"password"];
            [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]
             forKey:@"device_token"];
            [params setValue:@"seeker" forKey:@"user_type"];
            [params setValue:_txtRegisterEmail.text forKey:@"username"];
             [params setValue:_txtRegisterCity.text forKey:@"city"];
            [params setValue:[NSString stringWithFormat:@"%f",latt] forKey:@"latitude"];
            [params setValue:[NSString stringWithFormat:@"%f",lang] forKey:@"longitude"];
            [params setValue:selectedEducationId forKey:@"education_level"];
             [params setValue:arrExperience forKey:@"experience"];
            
            //[params setValue:@"" forKey:@"user_pic"];
            //[params setValue:@"" forKey:@"patch_video"];
            
            WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
            webHelper.methodName=@"register";
            webHelper.delegate=self;
            if (videoSelected && imageSelected)
            {
                NSString *url=[NSString stringWithFormat:@"%@",kRegisterUrl];
                NSData *imgData= UIImageJPEGRepresentation(_imageiconofperson.image, 0.6);
                [webHelper webserviceHelper:params uploadData:imgData ImageParam:@"user_pic" andVideoData:videoData withVideoThumbnail:thumbnailData  type:@".mp4" webServiceUrl:url methodName:@"register" showHud:YES inWhichViewController:self];
            }
            else if (imageSelected)
            {
                NSString *url=[NSString stringWithFormat:@"%@",kRegisterUrl];
                NSData *imgData = UIImageJPEGRepresentation(_imageiconofperson.image, 0.6);
                
                
                [webHelper webserviceHelper:params uploadData:imgData ImageParam:@"user_pic" andVideoData:videoData withVideoThumbnail:nil type:@".png" webServiceUrl:url methodName:@"register" showHud:YES inWhichViewController:self];
            }
            else if (videoSelected)
            {
                NSString *url=[NSString stringWithFormat:@"%@",kRegisterUrl];
                NSData *imgData ;//= UIImageJPEGRepresentation(_imageiconofperson.image, 0.9);
                [webHelper webserviceHelper:params uploadData:imgData ImageParam:@"user_pic" andVideoData:videoData withVideoThumbnail:thumbnailData type:@".mp4" webServiceUrl:url methodName:@"register" showHud:YES inWhichViewController:self];
            }
            else
            {
                [webHelper webserviceHelper:params webServiceUrl:kRegisterUrl methodName:@"register" showHud:YES inWhichViewController:self];
            }
            
        }
        else
        {
        
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Bonjob"
                                                           description:NSLocalizedString(@"Select Terms & Conditions", @"Select Terms & Conditions")
                                                                  type:TWMessageBarMessageTypeInfo
                                                        statusBarStyle:UIStatusBarStyleLightContent
                                                              callback:nil];
            
            //[SharedClass showToast:self toastMsg:@"Select Terms & Conditions"];
        }
        
        
        /* NSMutableDictionary *paramNew=[[NSMutableDictionary alloc]init];
        [paramNew setValue:params forKey:@"data"];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:params options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
        NSLog(@"%@",myString); */
        
    }
    
}


-(void)serviceUploadImagePostStr:(NSString *)postStr
{
    //[MyUtility SVProgressHUDShowWithMessage:WAIT];
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        NSString *dataString =postStr;
        
        NSData *imgData = UIImageJPEGRepresentation(_imageiconofperson.image, 0.6);
        NSString *str   = kRegisterUrl;
        NSString *urlString = [NSString stringWithFormat:@"%@",str];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //  parameter Image
        NSString *imageName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_pic\"; filename=\"IMG.jpg\"\r\n"];
        [body appendData:[imageName dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imgData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        //  parameter post String
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        //  parameter Pubilc
      /*  [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"public\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]]; */
        
        //Close Form
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // setting the body of the post to the reqeust
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //[MyUtility SVProgressImmediateDismiss];
            if (![returnData isKindOfClass:[NSNull class]]|| returnData !=nil)
            {
                NSDictionary *result=[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"result =%@",result);
                //NSMutableDictionary *dataDict = [[result objectForKey:@"data"] valueForKey:USER_DETAILS];
                BOOL success = [[result valueForKey:@"success"] boolValue];
                
                if (success)
                {
                   /* 
                    dataDict = [MyUtility removeNSNullClass:dataDict];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MyUtility showAlert:kAPPICATION_TITLE message:[result valueForKey:@"msg"]];
                        [self showProfileData:dataDict];
                        [[NSUserDefaults standardUserDefaults]setObject:dataDict forKey:USER_DETAILS];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                                                [[NSNotificationCenter defaultCenter] postNotificationName: @"ProfileNotification" object:nil userInfo:dataDict];
                    });
                    */
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                       // [MyUtility showAlert:kAPPICATION_TITLE message:[result valueForKey:@"msg"]];
                    });
                }
            }
        });
    });
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
    else if ([methodNameIs isEqualToString:@"login"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            
            [Alerter.sharedInstance ShowSuccessWithMsg:[NSString stringWithFormat:@"%@ %@ %@",NSLocalizedString(@"Welcome", @""),[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"first_name"],[[[responseDict valueForKey:@"data"] objectAtIndex:0] valueForKey:@"last_name"]]];
            
            

            [[NSUserDefaults standardUserDefaults]setValue:[[responseDict valueForKey:@"data"] objectAtIndex:0]forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults]setValue:[[responseDict valueForKey:@"data"] objectAtIndex:0]forKey:@"userData"];

            [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"prevLogined"] forKey:@"prevLogined"];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"S" forKey:@"userType"];
             [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
            [[NSUserDefaults standardUserDefaults]setObject:@"S" forKey:@"AUTOLOGIN"];
            
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            UITabBarController *vc = (UITabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
            vc.tabBar.translucent = NO;
            
            APPDELEGATE.window.rootViewController=vc;
            
            //[self presentViewController:vc animated:YES completion:nil];
            
            //[[vc.tabBar.items objectAtIndex:2]setBadgeValue:@"0"];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
               
            }
            else
            {
                [[vc.tabBar.items objectAtIndex:2]setBadgeColor:ButtonTitleColor];
                
                //[[vc.tabBar.items objectAtIndex:3]setBadgeValue:@"0"];
                [[vc.tabBar.items objectAtIndex:3]setBadgeColor:ButtonTitleColor];
            }
            
           
            
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"logined"];
//            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SeekerLogined"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [self loginUserForChat];
            self.emailtextfieldforconnection.text=@"";
            self.passwordtextfieldforconnection.text=@"";
        }
        else
        {
            [Alerter.sharedInstance showWarningWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        
    }
    else if ([methodNameIs isEqualToString:@"register"])
    {
        NSLog(@"response=%@",responseDict);
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            _txtRegisterName.text=@"";
            _txtRegisterLastName.text=@"";
            _txtRegisterEmail.text=@"";
            _txtRegisterCity.text= @"";
            _txtRegisterTraining.text = @"";
            _txtRegisterExperience.text = @"";
            _txtRegisterPassword.text=@"";
            _connectionview.hidden = NO;
            _registartionview.hidden = YES;
            [_btnTermsAndConditions setSelected:NO];
            termsSelected=NO;
            _imageiconofvideo.image = [UIImage imageNamed:@"play_icon.png"];
            _imageiconofperson.image = [UIImage imageNamed:@"default_photo.png"];
            [self.segmentviewcontrolleroutlet setSelectedSegmentIndex:1];
        }
        else
        {
            NSArray *dict=[responseDict valueForKey:@"data"];
            if (dict.count>0)
            {
                NSMutableDictionary *megDict=[dict objectAtIndex:0];
                [Alerter.sharedInstance showErrorWithMsg:[megDict valueForKey:@"email"]];
            }
            else
            {
                [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
            }
            
        }
    }
    else if ([methodNameIs isEqualToString:@"forgotpass"])
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

#pragma mark - Register Form Validation
-(BOOL)validateLoginForm
{
    if ([self validateEmailWithString:_emailtextfieldforconnection.text]==NO)
    {
        [SharedClass MakeAlert:_emailtextfieldforconnection];
        
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter valid email"];
        return NO;
    }
    else if ([_emailtextfieldforconnection.text length]==0)
    {
        [SharedClass MakeAlert:_emailtextfieldforconnection];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter email"];
        return NO;
    }
    else if (_passwordtextfieldforconnection.text.length==0)
    {
        [SharedClass MakeAlert:_passwordtextfieldforconnection];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter password"];
        return NO;
    }
    return YES;
}

-(BOOL)validateRegister
{
    if (_txtRegisterName.text.length==0)
    {
        [SharedClass MakeAlert:_txtRegisterName];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter name"];
        return NO;
    }
    else if(_txtRegisterName.text.length==0)
    {
        [SharedClass MakeAlert:_txtRegisterName];
        return NO;
    }
    else if(_txtRegisterLastName.text.length==0)
    {
        [SharedClass MakeAlert:_txtRegisterLastName];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter last name"];
        return NO;
    }
    else if(_txtRegisterEmail.text.length==0)
    {
        [SharedClass MakeAlert:_txtRegisterEmail];
        
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter email"];
        return NO;
    }
    else if([self validateEmailWithString:_txtRegisterEmail.text]==NO)
    {
        [SharedClass MakeAlert:_txtRegisterEmail];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter valid email"];
        return NO;
    }
    else if(_txtRegisterCity.text.length==0)
    {
        [SharedClass MakeAlert:_txtRegisterCity];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter city"];
        return NO;
    }
    else if(arrExperience.count==0)
    {
        [SharedClass MakeAlert:_txtRegisterExperience];
        [Alerter.sharedInstance showWarningWithMsg:@"Please enter experience"];
        return NO;
    }
    else if(_txtRegisterTraining.text.length==0)
    {
        [SharedClass MakeAlert:_txtRegisterTraining];
        [Alerter.sharedInstance showWarningWithMsg:NSLocalizedString(@"Please specify your training", @"Please specify your training")];
        return NO;
    }
    
    
    
    else if(_txtRegisterPassword.text.length<6)
    {
        [SharedClass MakeAlert:_txtRegisterPassword];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BonJob"
                                                        message:@"Minimum length for password is 6 characters."                                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok",nil];
        [alert show];
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

//-----------

#pragma mark - Keyboard Notifications
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

-(void)deregisterFromKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

-(void)keyboardWasShown:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if(_connectionview.hidden)
    {
        CGPoint buttonOrigin = self.registrationoutlet.frame.origin;
        CGFloat buttonHeight = self.registrationoutlet.frame.size.height;
        CGRect visibleRect = self.view.frame;
        visibleRect.size.height -= keyboardSize.height;
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight - 9);
        [self.scrollviewformoveup setContentOffset:scrollPoint animated:YES];
    }
    }
    else
    {
    CGPoint buttonOrigin = self.connectionbutton.frame.origin;
    CGFloat buttonHeight = self.connectionbutton.frame.size.height;
    CGRect visibleRect = self.view.frame;
    visibleRect.size.height -= keyboardSize.height;
          if (!CGRectContainsPoint(visibleRect, buttonOrigin))
          {
                  CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
                  [self.scrollviewformoveup setContentOffset:scrollPoint animated:YES];
          }
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
   [self.scrollviewformoveup setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Textfield Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (([textField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].location != NSNotFound && textField == _txtRegisterEmail) || ([textField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].location != NSNotFound && textField == _txtRegisterPassword) ) {
        return NO;
    }
    
    if ((textField == _txtRegisterName) || (textField == _txtRegisterLastName) ||(textField == _txtRegisterPassword) || (textField == _txtRegisterEmail) || (textField == _txtRegisterTraining) ) {
        
        // do not allow the first character to be space | do not allow more than one space
        if ([string isEqualToString:@" "]) {
            if (!textField.text.length)
                return NO;
            if (range.location == 0) {
                return NO;
            }
            if ((range.length == 0 && textField == _txtRegisterEmail) || (range.length == 0 && textField == _txtRegisterPassword)) {
                return NO;
            }
            if ([[textField.text stringByReplacingCharactersInRange:range withString:string] rangeOfString:@"  "].length)
                return NO;
            
        }
    }
    
    return YES;
}
-(void)setup
{
    [SharedClass setBorderOnButton:_connectionbutton];
    [SharedClass setBorderOnButton:_registrationoutlet];
    [_emailtextfieldforconnection setDelegate:self];
    [_passwordtextfieldforconnection setDelegate:self];
    _segmentviewcontrolleroutlet.layer.borderColor = TitleColor.CGColor;
    _segmentviewcontrolleroutlet.layer.borderWidth = 1.0;
    _segmentviewcontrolleroutlet.layer.masksToBounds = YES;
    
    if([_whichsegmentisshow isEqualToString:@"Inscription"])
    {
        _registartionview.hidden = NO;
        _connectionview.hidden = YES;
        _segmentviewcontrolleroutlet.selectedSegmentIndex = 0;
        [_segmentviewcontrolleroutlet setTitle:NSLocalizedString(@"Sign Up", nil) forSegmentAtIndex:0];
        [_scrollviewformoveup setContentSize:CGSizeMake(self.view.frame.size.width,_registrationoutlet.frame.origin.y+_registrationoutlet.frame.size.height+20)];
    }
    else
    {
        _connectionview.hidden = NO;
        _registartionview.hidden  = YES;
        _segmentviewcontrolleroutlet.selectedSegmentIndex = 1;
        [_segmentviewcontrolleroutlet setTitle:NSLocalizedString(@"Login", nil) forSegmentAtIndex:1];
        [_scrollviewformoveup setContentSize:CGSizeMake(self.view.frame.size.width,_forgteyourpasswordoutlet.frame.origin.y+_forgteyourpasswordoutlet.frame.size.height+20)];
        
    }
    [_segmentviewcontrolleroutlet setTitle:NSLocalizedString(@"Sign Up", nil) forSegmentAtIndex:0];
    [_segmentviewcontrolleroutlet setTitle:NSLocalizedString(@"Login", nil) forSegmentAtIndex:1];
    _txtRegisterName.placeholder = NSLocalizedString(@"First name", nil);
    _txtRegisterLastName.placeholder = NSLocalizedString(@"Name", nil);
    _txtRegisterCity.placeholder = NSLocalizedString(@"City", nil);
    _txtRegisterExperience.placeholder = NSLocalizedString(@"Experience", nil);
    _txtRegisterTraining.placeholder = NSLocalizedString(@"Level of training", nil);
    
    
    
    _txtRegisterEmail.placeholder = NSLocalizedString(@"E-mail", nil);
    _txtRegisterPassword.placeholder = NSLocalizedString(@"Password", nil);
    [_registrationoutlet setTitle:NSLocalizedString(@"Sign Up", nil) forState:UIControlStateNormal];
    _emailtextfieldforconnection.placeholder  = NSLocalizedString(@"E-mail", nil);
    _passwordtextfieldforconnection.placeholder =  NSLocalizedString(@"Password", nil);
    
    
    
    [_connectionbutton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [_forgteyourpasswordoutlet setTitle:NSLocalizedString(@"Forgot your password", nil) forState:UIControlStateNormal];
    //FRHyperLabel *label = self.registrationconditionslabel;
    //NSString *stringr =NSLocalizedString(@"I have read and agree to the terms of use", nil);
    
    _lblPhoto.text=NSLocalizedString(@"+ PHOTO", @"");
    _lblPitchVideo.text=NSLocalizedString(@"+ VIDEO PITCH", @"");
    
    //NSDictionary *attributes = @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
    //label.attributedText = [[NSAttributedString alloc]initWithString:stringr attributes:attributes];
    //label.textColor =[UIColor grayColor];
//    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring)
//    {
//        NSLog(@"Selected: %@", substring);
//    };
//    [label setLinksForSubstrings:@[@"Conditions"]withLinkHandler:handler];
//    [label setFont:[UIFont systemFontOfSize:14]];
//    [_txtRegisterName setNameField:YES];
//    [_txtRegisterLastName setNameField:YES];
//    [_txtRegisterEmail setEmailField:YES];
//    [_txtRegisterPassword setPasswordField:YES];
//    [_emailtextfieldforconnection setEmailField:YES];
//    [_passwordtextfieldforconnection setPasswordField:YES];
    [_connectionbutton setBackgroundColor:InternalButtonColor];
    [_registrationoutlet setBackgroundColor:InternalButtonColor];
   // [self setColoredLabel];
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
    _lblTermsAndConditions.attributedText = attString;
}

- (IBAction)btnTermsAction:(id)sender
{
    TermsPolicyViewController *tvc=[self.storyboard instantiateViewControllerWithIdentifier:@"TermsPolicyViewController"];
    tvc.identifier=@"terms";
    tvc.title=NSLocalizedString(@"Terms of Use", @"");
    [self.navigationController pushViewController:tvc animated:YES];
}

- (IBAction)btnCloseVideoGuidePopupAction:(id)sender
{

    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[SharedClass getUserId] forKey:@"uid"];
    [params setValue:@"yes" forKey:@"videopopup"];
    [[NSUserDefaults standardUserDefaults]setObject:params forKey:@"videodata"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [SharedClass hidePopupView:self.viewDimBackground andTabbar:nil];
    [SharedClass hidePopupView:self.viewVideoGuidePopup];
    [self.scrollView setHidden:YES];
    [self.viewVideoGuideInternal setHidden:YES];
}

#pragma mark - Delegates

-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
    _txtRegisterCity.text = address;
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
    _txtRegisterExperience.text = NSLocalizedString(str,@"");
    
}
-(void)levelofEducationSelected:(NSString *)education title:(NSString*)educationTitle screenTitle:(NSString*)titled
{
    if ([titled isEqualToString:@"LEVEL OF EDUCATION"]) {
        _txtRegisterTraining.text=educationTitle;
        selectedEducationId = education;
    }
    
}

@end
