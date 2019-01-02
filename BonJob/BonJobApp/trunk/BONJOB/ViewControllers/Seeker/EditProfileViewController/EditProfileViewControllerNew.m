//
//  EditProfileViewControllerNew.m
//  BONJOB
//
//  Created by VISHAL SETH on 10/11/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "EditProfileViewControllerNew.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AVKit/AVPlayerViewController.h>
#import "EditProfileGalleryCell.h"
@implementation EditSeekerProfile

@end

@interface EditProfileViewControllerNew()<ExperienceDelegate,EducationLevelDelegate,locationSelectedDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,LanguageSelectionDelegate,UITextFieldDelegate>
{
    double lattt;
    double langg;
    UIDatePicker *datePicker;
    NSData *thumbnailData,*profileData,*pitchVideoData;
    BOOL videoSelected,_imageSelected;
    NSURL  *newVideoUrl;
    UIImagePickerController *imagePicker;
    NSMutableArray *arrLanguageCell;
    NSMutableDictionary *responseDictionary;
    NSString *selectedSkills,*strMobility,*currentStatus;
    int currentIndexForLanguageCell;
     AVPlayerViewController *playerViewController;
    NSString *currentItem;
    NSMutableArray *arrayforuploadingimages;
    NSMutableArray *arrGallery,*arrEditProfileCellIdentifier;
    int selectedBtnIndex,changablebtntapped;
    NSDictionary *responseGalleryDict;
    UICollectionView *collectionGalleryinCell;
    NSString *selectedEducationId;
    NSString *selectedJobSoughtId;
    BOOL isGallery;
    NSIndexPath *selectedIndex;
}
@end

@implementation EditProfileViewControllerNew

- (void)viewDidLoad
{
    [super viewDidLoad];
     strMobility=@"";
    changablebtntapped = 1;
    arrEditProfileCellIdentifier = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2", @"3",@"4",@"5", @"6",  @"7",@"8",@"9",nil];
    arrayforuploadingimages=[[NSMutableArray alloc]init];
    [_viewImageVideoBackground setHidden:YES];
    [_viewImageHolder setHidden:YES];
    [_viewVideoHolder setHidden:YES];
    
    _txtviewSpecifyTranning.layer.borderWidth=1.0;
    _txtviewSpecifyTranning.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _txtviewAbout.layer.borderWidth=1.0;
    _txtviewAbout.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _txtviewSpecifyTranning.delegate=self;
    _txtviewAbout.delegate=self;
    
    _lblName.text=NSLocalizedString(@"FIRST NAME", @"");
    _lblLastName.text=NSLocalizedString(@"NAME", @"");
    _lblDob.text=NSLocalizedString(@"DATE OF BIRTH", @"");
    _lblCity.text=NSLocalizedString(@"CITY", @"");
    _lblPhoto.text=NSLocalizedString(@"PHOTO", @"");
    _lblPitchVideo.text=NSLocalizedString(@"VIDEO PITCH", @"");

    _lblJobSought.text = NSLocalizedString(@"EMPLOI RECHERCHé", @"");
    _lblExperience.text=NSLocalizedString(@"EXPERIENCE", @"");
    
    _lblLevelofEducation.text=NSLocalizedString(@"LEVEL OF EDUCATION", @"");
    _lblSpecifyTranning.text=NSLocalizedString(@"SPECIFY YOUR TRAINING", @"");
    _lblAbout.text=NSLocalizedString(@"ABOUT", @"");

    arrLanguageCell =[[NSMutableArray alloc]init];
    
    // for gallery
    _viewbackground.hidden=YES;
    _viewzoomimage.hidden=YES;
    arrayforuploadingimages=[[NSMutableArray alloc]init];
    responseDictionary =[[NSMutableDictionary alloc]init];
    arrGallery=[[NSMutableArray alloc]init];
    [self basicArrayInitilization];
    //------------
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:@"" forKey:@"createdOn"];
    [dict setValue:@"" forKey:@"lang_proficiency"];
    [dict setValue:@"" forKey:@"seeker_lang_id"];
    [dict setValue:@"" forKey:@"seeker_lang_name"];
    [dict setValue:@"" forKey:@"seeker_lang"];
    [dict setValue:@"" forKey:@"updatedOn"];
    [dict setValue:@"" forKey:@"user_id"];
    [arrLanguageCell addObject:dict];
    
    
    _txtFirstName.delegate=self;
    _txtLastName.delegate=self;
    _txtDateOfBirth.delegate=self;
     _txtCityLOcation.delegate=self;
     _txtExperience.delegate=self;
     _txtviewAbout.delegate=self;
     _txtviewSpecifyTranning.delegate=self;
     _txtDateOfBirth.delegate=self;
    
    _txtviewSpecifyTranning.layer.cornerRadius=8;
    _txtviewAbout.layer.cornerRadius=8;
    [_txtviewSpecifyTranning setUserInteractionEnabled:YES];
    [_txtviewAbout setUserInteractionEnabled:YES];
    [_btnRemovePic setTitle:NSLocalizedString(@"REMOVE", @"") forState:UIControlStateNormal];
    [_btnRemoveVideo setTitle:NSLocalizedString(@"REMOVE", @"") forState:UIControlStateNormal];
    
    UIColor *color = InternalButtonColor;
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : color };
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"REMOVE", @"") attributes:attrs];
    
    // making text property to underline text-
    [titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [titleString length])];
    
    // using text on button
    [_btnRemovePic setAttributedTitle: titleString forState:UIControlStateNormal];
    [_btnRemoveVideo setAttributedTitle: titleString forState:UIControlStateNormal];
    
    _viewVideoGuidePopup.layer.cornerRadius=15.0;
    _viewVideoGuideInternal.layer.cornerRadius=15.0;
    _scrollView.layer.cornerRadius=15.0;
    [_viewVideoGuidePopup setHidden:YES];
    [self.viewDimBackground setHidden:YES];
    [self.btnSave setTitle:NSLocalizedString(@"Save", @"") forState:UIControlStateNormal];
    [self getData];
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - ----Get Data From Central Stored Named ProfileDataModel and set data---------
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
        [arrayforuploadingimages addObject:@"yes"];
    }
    
    [_tblEditProfile reloadData];
    self.title=@"";
    
}

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
     [_txtFirstName setTextColor:InternalButtonColor];
     [_txtLastName setTextColor:InternalButtonColor];
     [_txtDateOfBirth setTextColor:InternalButtonColor];
     [_txtCityLOcation setTextColor:InternalButtonColor];
     [_lblLabelofEducationValue setTextColor:InternalButtonColor];
    [_lblJobSought setTextColor:InternalButtonColor];
     [_txtExperience setTextColor:InternalButtonColor];
    
    _txtFirstName.text=[responseDictionary valueForKey:@"first_name"];
    _txtLastName.text=[responseDictionary valueForKey:@"last_name"];
    _txtDateOfBirth.text=[responseDictionary valueForKey:@"dob"];
    _txtCityLOcation.text=[responseDictionary valueForKey:@"city"];
    if ([[responseDictionary valueForKey:@"education_level_name"] isEqualToString:@""])
    {
        _lblLabelofEducationValue.text=NSLocalizedString(@"", @"");
    }
    else
    {
        _lblLabelofEducationValue.text=[responseDictionary valueForKey:@"education_level_name"];
        selectedEducationId = [responseDictionary valueForKey:@"education_level"];
    }
    if ([[responseDictionary valueForKey:@"candidate_seek_id"] isEqualToString:@""])
    {
    //    _lblJobSought.text=NSLocalizedString(@"Select", @"");
    }
    else
    {
        _lblJobSought.text=[responseDictionary valueForKey:@"candidate_seek_name"];
        selectedJobSoughtId = [responseDictionary valueForKey:@"candidate_seek_id"];
    }
    
    _txtviewAbout.text=[responseDictionary valueForKey:@"about"];
    _txtviewSpecifyTranning.text=[responseDictionary valueForKey:@"training"];
    
    _lblSpecifyAboutCount.text=[NSString stringWithFormat:@"%lu/%@",[[responseDictionary valueForKey:@"about"]length],@"200"];
    _lblSpecifyTranningCount.text=[NSString stringWithFormat:@"%lu/%@",[[responseDictionary valueForKey:@"training"]length],@"100"];
    currentStatus=[responseDictionary valueForKey:@"current_status"];
    strMobility=[responseDictionary valueForKey:@"mobility"];
    selectedSkills = [responseDictionary valueForKey:@"skills"];
    if ([[responseDictionary valueForKey:@"experience"] count]>0 && ![[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"experience"]  isEqual: @"1"])
    {
        _txtExperience.text=[NSString stringWithFormat:@"%@ %@ %@ %@",[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"position_held_name"],[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"company_name"],[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"description"],[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"experience"]];
    }
    if ([[responseDictionary valueForKey:@"experience"] count]>0 && [[[[responseDictionary valueForKey:@"experience"] objectAtIndex:0] valueForKey:@"experience"]  isEqual: @"1"]) {
    _txtExperience.text = NSLocalizedString(@"No Company added",@"");
    }
    if (_imageSelected)
    {
        [_imgProfilePic setImage:[UIImage imageWithData:profileData]];
    }
    else
    {
        if ([[responseDictionary valueForKey:@"user_pic"] length]>0)
        {
            [_btnRemovePic setHidden:NO];

            [_imgProfilePic sd_setImageWithURL:[NSURL URLWithString:[responseDictionary valueForKey:@"user_pic"]] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 if(error)
                 {
                     [_imgProfilePic setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
                 }
                 _imgProfilePic.layer.cornerRadius=_imgProfilePic.frame.size.width/2;
                 _imgProfilePic.clipsToBounds=YES;
             }];
        }
        else
        {
            [_btnRemovePic setHidden:YES];
            [_imgProfilePic setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
        }
        
    }
    
    
    NSString  *videourl=[responseDictionary valueForKey:@"patch_video_thumbnail"];
    if (videoSelected)
    {
        _imgPitchVideo.image = [[SharedClass sharedInstance]thumbnailFromVideoAtURL:newVideoUrl];
    }
    else
    {
        if (videourl.length>0)
        {
            [_btnRemoveVideo setHidden:NO];
            [_btnPitchVideoPlayer setHidden:NO];
            [_imgPitchVideo sd_setImageWithURL:[NSURL URLWithString:videourl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 if(error)
                 {
                     [_btnPitchVideoPlayer setHidden:YES];
                     [_imgPitchVideo setImage:[UIImage imageNamed:@"defaultPIC.png"]];
                 }
                 _imgPitchVideo.layer.cornerRadius=_imgPitchVideo.frame.size.width/2;
                 _imgPitchVideo.clipsToBounds=YES;
             }];
        }
        else
        {
            [_btnRemoveVideo setHidden:YES];
            [_btnPitchVideoPlayer setHidden:YES];
        }
        
    }
    
    
    if ([[responseDictionary valueForKey:@"languages"] count]>0)
    {
        arrLanguageCell =[[NSMutableArray alloc] initWithArray:[responseDictionary valueForKey:@"languages"]];
    }
    [_tblEditProfile reloadData];
    [self btnEditGalleryAction:nil];
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- Buttons Actions---------

- (IBAction)btnEditFirstNameAction:(id)sender
{
    [_txtFirstName setUserInteractionEnabled:YES];
    [_txtFirstName  becomeFirstResponder];
}

- (IBAction)btnEditLastNameAction:(id)sender
{
    [_txtLastName setUserInteractionEnabled:YES];
    [_txtLastName  becomeFirstResponder];
}

- (IBAction)btnDobAction:(id)sender
{
    [_txtDateOfBirth setUserInteractionEnabled:YES];
    //[_txtDateOfBirth  becomeFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BONJOB" message:NSLocalizedString(@"Indicate your birth date", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"") otherButtonTitles:NSLocalizedString(@"Save", @""), nil];
    alertView.tag =101;
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date]];
    
    [alertView setValue:datePicker forKey:@"accessoryView"];
    
    [alertView show];
}

- (IBAction)btnLocationCityaction:(id)sender
{
    //[_txtCityLOcation setEnabled:YES];
    //[_txtCityLOcation  becomeFirstResponder];
    SelectLocationViewController *lvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
    lvc.delegate=self;
    [self.navigationController pushViewController:lvc animated:YES];
}

- (IBAction)btnCameraProfilePicAction:(id)sender
{
    [self openGalleryForPic:sender];
    
}

- (IBAction)btnPitchVideoAction:(id)sender
{
    NSString *vv=[[[NSUserDefaults standardUserDefaults] valueForKey:@"videodata"] valueForKey:@"videopopup"];
    //NSString *uid=[[[NSUserDefaults standardUserDefaults] valueForKey:@"videodata"] valueForKey:@"uid"];
    
    if ([vv isEqualToString:@"yes"])
    {
        [self openGalleryForVideo:sender];
    }
    else
    {
        [self.viewVideoGuidePopup setHidden:NO];
        [self.viewDimBackground setHidden:NO];
        [SharedClass showPopupView:self.viewDimBackground andTabbar:self.tabBarController];
        [SharedClass showPopupView:self.viewVideoGuidePopup];
    }
    
}

- (IBAction)btnExperienceAction:(id)sender
{
    ExperienceViewController *exvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ExperienceViewController"];
    exvc.delegate=self;
    [self.navigationController pushViewController:exvc animated:YES];
}

- (IBAction)btnLevelofEducationAction:(id)sender
{
    SelectLevelofEducationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLevelofEducationViewController"];
    slvc.delegate=self;
    slvc.titled = @"LEVEL OF EDUCATION";
    [self.navigationController pushViewController:slvc animated:YES];
}

- (IBAction)btnLevelofJobSoughtAction:(id)sender
{
    SelectLevelofEducationViewController *slvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLevelofEducationViewController"];
    slvc.delegate=self;
    slvc.titled = @"CANDIDATE SEEKS";
    [self.navigationController pushViewController:slvc animated:YES];
}



#pragma mark -------Delegates-------
-(void)ExperienceSelected:(NSArray *)arr
{
    _txtExperience.textColor=ButtonTitleColor;
    _txtExperience.text=[NSString stringWithFormat:@"%@-%@",[[arr objectAtIndex:0] valueForKey:@"position_held_name"],[[arr objectAtIndex:0] valueForKey:@"company_name"]];
    
    if([_txtExperience.text isEqualToString:@"-"])
    {
    
        _txtExperience.text = NSLocalizedString(@"No Company added",@"");
    }
   
    
}
-(void)levelofEducationSelected:(NSString *)education title:(NSString*)educationTitle screenTitle:(NSString*)titled
{
    if ([titled isEqualToString:@"LEVEL OF EDUCATION"]) {
        _lblLabelofEducationValue.text=educationTitle;
        selectedEducationId = education;
    }
    else
    {
        _lblJobSought.text=educationTitle;
        selectedJobSoughtId = education;
    }
    
    
}
-(void)languageSelected:(NSString *)languages selectedid:(NSString*)sId
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:@"" forKey:@"createdOn"];
    [dict setValue:@"" forKey:@"lang_proficiency"];
    [dict setValue:sId forKey:@"seeker_lang_name"];
    [dict setValue:languages forKey:@"seeker_lang"];
    [dict setValue:@"" forKey:@"seeker_lang_id"];
    [dict setValue:@"" forKey:@"updatedOn"];
    [dict setValue:@"" forKey:@"user_id"];
    
    BOOL duplicateLanguageDetected=NO;
    [arrLanguageCell replaceObjectAtIndex:currentIndexForLanguageCell withObject:dict];
    [_tblEditProfile reloadData];
    
    
    for (int i=0; i<arrLanguageCell.count -1; i++)
    {
         NSDictionary *dictt=arrLanguageCell[i];
        
        for(int j=i+1; j< arrLanguageCell.count; j++)
        {
            NSDictionary *dictt2=arrLanguageCell[j];
            if ([[dictt2 valueForKey:@"seeker_lang_name"]isEqualToString:[dictt valueForKey:@"seeker_lang_name"]])
            {
                duplicateLanguageDetected=YES;
                NSLog(@"%@",@"Show Alert");
                break;
            }
            else
            {
                duplicateLanguageDetected=NO;
            }
        }
        if(duplicateLanguageDetected)
        {
            break;
        }
    }
    if (duplicateLanguageDetected)
    {
        [Alerter.sharedInstance showWarningWithMsg:NSLocalizedString(@"Déjà pris cette langue.", @"")];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:@"" forKey:@"createdOn"];
        [dict setValue:@"" forKey:@"lang_proficiency"];
        [dict setValue:@"" forKey:@"seeker_lang_name"];
        [dict setValue:@"" forKey:@"seeker_lang"];
        [dict setValue:@"" forKey:@"seeker_lang_id"];
        [dict setValue:@"" forKey:@"updatedOn"];
        [dict setValue:@"" forKey:@"user_id"];
        [arrLanguageCell replaceObjectAtIndex:currentIndexForLanguageCell withObject:dict];
        [_tblEditProfile reloadData];
    }
}
    
-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
    lattt=lattitute;
    langg=Longitute;
    [_txtCityLOcation setText:address];
    [_txtCityLOcation setTextColor:InternalButtonColor];
    //[responseDictionary setValue:address forKey:@"city"];
}

#pragma mark -------Textfields Delegates---------
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField setUserInteractionEnabled:false];
    textField.textColor=InternalButtonColor;
    if(textField==_txtFirstName)
    {
        //[responseDictionary setValue:txtFirstName.text forKey:@"first_name"];
    }
    else if (textField==_txtLastName)
    {
        //[responseDictionary setValue:txtLastName.text forKey:@"last_name"];
    }
    else if (textField==_txtDateOfBirth)
    {
        //[responseDictionary setValue:txtDate.text forKey:@"dob"];
    }
    else if (textField==_txtCityLOcation)
    {
        //[responseDictionary setValue:txtLocation.text forKey:@"city"];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    
    if ((textField == _txtFirstName) || (textField == _txtLastName) ) {
        
        // do not allow the first character to be space | do not allow more than one space
        if ([string isEqualToString:@" "]) {
            if (!textField.text.length)
                return NO;
            if (range.location == 0) {
                return NO;
            }
            if ([[textField.text stringByReplacingCharactersInRange:range withString:string] rangeOfString:@"  "].length)
                return NO;
        }
    }
    
    return YES;
}
#pragma mark ------Textview delegates---------
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView==_txtviewAbout)
    {
        //[responseDictionary setValue:txtViewAbout.text forKey:@"about"];
    }
    else if (textView==_txtviewSpecifyTranning)
    {
       // [responseDictionary setValue:txtViewTranning.text forKey:@"training"];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    NSString *temp=textView.text;
    if (textView==_txtviewSpecifyTranning)
    {
        if(range.length + range.location > textView.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        if(newLength <= 100)
        {
            _lblSpecifyTranningCount.text = [NSString stringWithFormat:@"%lu/100",(unsigned long)newLength];
        }
        return newLength <= 100;
    //}
        
    }
    else if (textView==_txtviewAbout)
    {

    if(range.length + range.location > textView.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        if(newLength <= 200)
        {
            _lblSpecifyAboutCount.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)newLength];
        }
        return newLength <= 200;
        
    }
    return true;
}





-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==2000)
    {
        if (buttonIndex==0)
        {
            if ([currentItem isEqualToString:@"profile"])
            {
                [self removePrfilePic];
            }
            else
            {
                [self removeVideo];
            }
        }
    }
    else
    {
        if (buttonIndex != 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            // txtDate=[formatter stringFromDate:datePicker.date];
            //[responseDictionary setObject:[formatter stringFromDate:datePicker.date] forKey:@"dob"];
            _txtDateOfBirth.text=[formatter stringFromDate:datePicker.date];
            [_txtDateOfBirth setTextColor:ButtonTitleColor];
        }
        else{
            
        }
      
    }
}




#pragma mark - ----------Camera Control for image gallery and video -------

-(void)openGalleryForPic:(id)sender
{
//    [QMImagePicker chooseSourceTypeInVC:self allowsEditing:YES isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL) {
//        _imgProfilePic.image=image;
//        _imgProfilePic.image = image;
//        _imgProfilePic.layer.cornerRadius = _imgProfilePic.frame.size.width/2;
//        _imgProfilePic.clipsToBounds = YES;
//        _imageSelected=YES;
//        profileData = UIImageJPEGRepresentation(image, 0.7);
//    }];
    isGallery = NO;
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
-(void)openGalleryForVideo:(id)sender
{
    
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
    if (actionSheet.tag == 1 || actionSheet.tag == 3) {
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
          
  //  [self hideTheTabBarWithAnimation:YES];
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
       videoRecorder.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
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
       // [self hideTheTabBarWithAnimation:YES];
       // [self dismissViewControllerAnimated:YES completion:^{
            [self presentViewController:imagePicker animated:YES completion:nil];
       // }];
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
      }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if([info[UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)(kUTTypeImage)])
    {
         UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad  && chosenImage == nil)
        {
            chosenImage = info[UIImagePickerControllerOriginalImage];
        }
        if (!isGallery) {
            //image
           
            _imgProfilePic.image=chosenImage;
            //  _imgProfilePic.image = chosenImage;
            _imgProfilePic.layer.cornerRadius = _imgProfilePic.frame.size.width/2;
            _imgProfilePic.clipsToBounds = YES;
            _imageSelected=YES;
            profileData = UIImageJPEGRepresentation(chosenImage, 0.7);
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
        else
        {
            
            static NSString *identifier = @"EditProfileGalleryCell";
            
            EditProfileGalleryCell *cell = (EditProfileGalleryCell*)[collectionGalleryinCell dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:selectedIndex];
            cell.imgGallery.image = chosenImage;
                        [arrGallery insertObject:chosenImage atIndex:selectedIndex.item];
                        cell.imgGallery.layer.cornerRadius =  8.0;
                        cell.imgGallery.clipsToBounds = YES;
                        [arrayforuploadingimages replaceObjectAtIndex:selectedIndex.item withObject:@"no"];
                        [self sendGalleryImageToServer:chosenImage];
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
      
    }
    else
    {
   // [self hideTheTabBarWithAnimation:NO];
    // This is the NSURL of the video object
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    
    NSURL* videoUrl = videoURL;
    newVideoUrl = [[NSURL alloc] initWithString:[videoUrl absoluteString]];
    pitchVideoData = [NSData dataWithContentsOfFile:[newVideoUrl path]];
    long videoSize= pitchVideoData.length/1024.0f/1024.0f;
    
    if (videoSize<8)
    {
        videoSelected=YES;
    }
    else
    {
        videoSelected=NO;
        [SharedClass showToast:self toastMsg:@"Select a video less then 8 Mb in size"];
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
    
    _imgPitchVideo.image = [[SharedClass sharedInstance]thumbnailFromVideoAtURL:newVideoUrl];
    thumbnailData = UIImagePNGRepresentation(_imgPitchVideo.image);
    //imgVideoImg.layer.cornerRadius = 50.0;
    _imgPitchVideo.layer.cornerRadius = _imgPitchVideo.frame.size.width / 2;
    _imgPitchVideo.clipsToBounds = YES;
    NSLog(@"VideoURL = %@", videoURL);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    }
}
-(void)hideTheTabBarWithAnimation:(BOOL) withAnimation
{
    if (withAnimation)
    {
        [self.tabBarController.tabBar setHidden:YES];
    }
    else
    {
        [self.tabBarController.tabBar setHidden:NO];
    }
}

#pragma mark - ---------TableView Delegates ----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0)
    {
        if (arrLanguageCell.count==0)
        {
            return 1;
        }
        else
        return [arrLanguageCell count];
    }
    else
    {
        return 1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (indexPath.section==0)
        {
            return 180;
        }
        else if (indexPath.section==1)
        {
            return 320;
        }
        else if (indexPath.section==2)
        {
            return 250;
        }
        else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 54;
    }
    else
        return 0;
}
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
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
//        UIView *vw2=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,vw.frame.size.height-2, self.view.frame.size.width, 1)];
//        vw2.backgroundColor =[UIColor lightGrayColor];
//        [vw addSubview:vw2];
        
        return vw;
    }
    
    return nil;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditSeekerProfile *cell;
    if (indexPath.section==0)
    {
        cell=(EditSeekerProfile *)[tableView dequeueReusableCellWithIdentifier:@"EditSeekerProfile1"];
        NSLog(@"%d",indexPath.row);
        NSDictionary *dict = [arrLanguageCell objectAtIndex:indexPath.row];
        [cell.btnBeginer setSelected:NO];
        [cell.btnCurrent setSelected:NO];
        [cell.btnAdvanced setSelected:NO];
        [cell.btnIntermedidate setSelected:NO];
        
        if ([[dict objectForKey:@"lang_proficiency"] isEqualToString:@"1"]) {
            [cell.btnBeginer setSelected:YES];
        }
        else if ([[dict objectForKey:@"lang_proficiency"] isEqualToString:@"2"])
        {
             [cell.btnIntermedidate setSelected:YES];
        }
        else if ([[dict objectForKey:@"lang_proficiency"] isEqualToString:@"3"])
        {
            [cell.btnAdvanced setSelected:YES];
        }
        else if ([[dict objectForKey:@"lang_proficiency"] isEqualToString:@"4"])
        {
              [cell.btnCurrent setSelected:YES];
        }
        [cell.btnBeginer setTag:indexPath.row];
        [cell.btnIntermedidate setTag:indexPath.row];
        [cell.btnAdvanced setTag:indexPath.row];
        [cell.btnCurrent setTag:indexPath.row];
        [cell.btnLanguageAdd setTag:indexPath.row+41000];
        [cell.btnLanguageRemove setTag:indexPath.row];
        
        [cell.btnStatusInactive setTag:indexPath.row];
        [cell.btnStatusStudent setTag:indexPath.row];
        [cell.btnStatusJobSeeker setTag:indexPath.row];
        [cell.btnStatusActive setTag:indexPath.row];
        [cell.btnStatusApprentice setTag:indexPath.row];
        cell.lblLangugageKnown.tag=indexPath.row;
        
        cell.lblLangugageKnown.text=NSLocalizedString(@"Select", @"");
        [cell.btnLanguageAdd setTitle:NSLocalizedString(@"+ Add language", @"") forState:UIControlStateNormal];
        [cell.btnLanguageRemove setTitle:NSLocalizedString(@"+ Remove", @"") forState:UIControlStateNormal];
        [cell.btnSelectLanguage setTag:indexPath.row];
    }
    else if (indexPath.section==1)
    {
        cell=(EditSeekerProfile *)[tableView dequeueReusableCellWithIdentifier:@"EditSeekerProfile2"];
    }
    else if (indexPath.section==2)
    {
        cell=(EditSeekerProfile *)[tableView dequeueReusableCellWithIdentifier:@"EditSeekerProfile3"];
        [cell.btnGallery addTarget:self action:@selector(btnEditGalleryAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.lblGallery.text=NSLocalizedString(@"GALLERY", @"");
    }
    [cell.btnSelectLanguage addTarget:self action:@selector(btnSelectLanguageAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnLanguageAdd addTarget:self action:@selector(btnLanguageAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnLanguageRemove addTarget:self action:@selector(btnLanguageRemoveAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnBeginer addTarget:self action:@selector(btnBeginerAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnIntermedidate addTarget:self action:@selector(btnIntermedidateAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAdvanced addTarget:self action:@selector(btnAdvancedAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnCurrent addTarget:self action:@selector(btnCurrentAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnStatusStudent addTarget:self action:@selector(btnStatusStudentAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnStatusApprentice addTarget:self action:@selector(btnStatusApprenticeAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnStatusActive addTarget:self action:@selector(btnStatusActiveAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnStatusJobSeeker addTarget:self action:@selector(btnStatusJobSeekerAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnStatusInactive addTarget:self action:@selector(btnStatusInactiveAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnMobilityYes addTarget:self action:@selector(btnMobilityYesAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnMobilityNo addTarget:self action:@selector(btnMobilityNoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnSkillsHotels addTarget:self action:@selector(btnSkillsHotelsAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnSkillsCuisine addTarget:self action:@selector(btnSkillsCuisineAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnSkillsSalesService addTarget:self action:@selector(btnSkillsSalesServiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnLanguageRemove addTarget:self
                               action:@selector(btnLanguageRemoveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btnLanguageAdd.layer.cornerRadius=15;
    cell.btnLanguageRemove.layer.cornerRadius=15;
    // for language cell
    cell.lblLanguageBegineer.text=NSLocalizedString(@"Beginner", @"");
    cell.lblLanguageIntermediate.text=NSLocalizedString(@"Intermediate", @"");
    cell.lblLanguageAdvanced.text=NSLocalizedString(@"Advanced", @"");
    cell.lblLanguageCurrent.text=NSLocalizedString(@"Fluent", @"");
    [cell.btnLanguageAdd setTitle:NSLocalizedString(@"+ Add language", @"") forState:UIControlStateNormal];
    [cell.btnLanguageRemove setTitle:NSLocalizedString(@"- Remove", @"") forState:UIControlStateNormal];
    //---------for status cell
    cell.lblActualStatus.text=NSLocalizedString(@"STATUS", @"");
    cell.lblStatusJobseeker.text=NSLocalizedString(@"Jobseeker", @"");
    cell.lblStatusStudent.text=NSLocalizedString(@"Student", @"");
    cell.lblStatusApprentice.text=NSLocalizedString(@"Apprentice", @"");
    cell.lblStatusActive.text=NSLocalizedString(@"Employed", @"");
    cell.lblStatusInactive.text=NSLocalizedString(@"Inactive", @"");
    //-----for mobility and skills
    cell.lblMobility.text=NSLocalizedString(@"MOBILITY", @"");
    cell.lblMobilityYes.text=NSLocalizedString(@"Yes", @"");
    cell.lblMobilityNo.text=NSLocalizedString(@"No", @"");
    cell.lblSkill.text=NSLocalizedString(@"SKILLS", @"");
    cell.lblSkillsCuisine.text=NSLocalizedString(@"Catering", @"");
    cell.lblSkillsSalesService.text=NSLocalizedString(@"Service", @"");
    cell.lblSkillsHotels.text=NSLocalizedString(@"Hotel", @"");
    
    // for language known
    if (arrLanguageCell.count>1)
    {
        [cell.btnLanguageRemove setHidden:NO];
    }
    else
    {
        [cell.btnLanguageRemove setHidden:YES];
    }
    
    if (indexPath.row==arrLanguageCell.count-1)
    {
        [cell.btnLanguageAdd setHidden:NO];
    }
    else
    {
        [cell.btnLanguageAdd setHidden:YES];
    }
    
    if (arrLanguageCell.count>indexPath.row)
    {
        if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"seeker_lang"]length]==0)
        {
            cell.lblLangugageKnown.text=NSLocalizedString(@"Select", @"");
        }
        else
        {
            cell.lblLangugageKnown.text=[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"seeker_lang"];
        }
        
        if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency"] isEqualToString:@"1"])
        {
            [cell.btnBeginer setSelected:YES];
        }
        else if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency"] isEqualToString:@"2"])
        {
            
            [cell.btnIntermedidate setSelected:YES];
        }
        else if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency"] isEqualToString:@"3"])
        {
            [cell.btnAdvanced setSelected:YES];
        }
        else if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency"] isEqualToString:@"4"])
        {
            [cell.btnCurrent setSelected:YES];
        }
        else
        {
            [cell.btnBeginer setSelected:NO];
            [cell.btnIntermedidate setSelected:NO];
            [cell.btnAdvanced setSelected:NO];
            [cell.btnCurrent setSelected:NO];
        }
    }
    //for status
    if ([currentStatus isEqualToString:@"4"])
    {
        [cell.btnStatusJobSeeker setSelected:YES];
    }
    else if ([currentStatus isEqualToString:@"1"])
    {
        [cell.btnStatusStudent setSelected:YES];
    }
    else if ([currentStatus isEqualToString:@"2"])
    {
        [cell.btnStatusApprentice setSelected:YES];
    }
    else if ([currentStatus isEqualToString:@"3"])
    {
        [cell.btnStatusActive setSelected:YES];
    }
    else if ([currentStatus isEqualToString:@"5"])
    {
        [cell.btnStatusInactive setSelected:YES];
    }
    else
    {
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
    }
    // for mobility
    if ([responseDictionary valueForKey:@"mobility"]==[NSNull null])
    {
        
    }
    else
    {
        if([strMobility isEqualToString:@"1"])
        {
            [cell.btnMobilityYes setSelected:YES];
        }
        else if ([strMobility isEqualToString:@"2"])
        {
            [cell.btnMobilityNo setSelected:YES];
        }
        else
        {
            [cell.btnMobilityYes setSelected:NO];
            [cell.btnMobilityNo setSelected:NO];
        }
    }
    // for skills
    if ([responseDictionary valueForKey:@"skills"]!=[NSNull null])
    {
        if ([[responseDictionary valueForKey:@"skills"] isEqualToString:@"1"])
        {
            [cell.btnSkillsCuisine setSelected:YES];
        }
        else if ([[responseDictionary valueForKey:@"skills"] isEqualToString:@"2"])
        {
            [cell.btnSkillsSalesService setSelected:YES];
        }
        else if ([[responseDictionary valueForKey:@"skills"] isEqualToString:@"3"])
        {
            [cell.btnSkillsHotels setSelected:YES];
        }
    }
    else
    {
        if ([selectedSkills isEqualToString:@"1"])
        {
            [cell.btnSkillsCuisine setSelected:YES];
        }
        else if ([selectedSkills isEqualToString:@"2"])
        {
            [cell.btnSkillsSalesService setSelected:YES];
        }
        else if ([selectedSkills isEqualToString:@"3"])
        {
            [cell.btnSkillsHotels setSelected:YES];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.collectionGallery reloadData];
    return cell;
}

#pragma mark - ---------Collection Delegates ----------------

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrayforuploadingimages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    collectionGalleryinCell=(UICollectionView *)[self.view viewWithTag:57];
    collectionGalleryinCell.hidden = NO;
    NSLog(@"%d",collectionGalleryinCell.isHidden);
    
    static NSString *identifier = @"EditProfileGalleryCell";
    
    EditProfileGalleryCell *cell = (EditProfileGalleryCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
     cell.imgGallery.image = nil;
    if ([[responseDictionary valueForKey:@"gallery"]count]>indexPath.item)
    {
        NSString *imgUrl=[[[responseDictionary valueForKey:@"gallery"]objectAtIndex:indexPath.item] valueForKey:@"image"];
        [cell.imgGallery setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"photo_img.png"]];
      //  [cell.imgGallery sd_setima]

//        __weak UIImageView *weakImageView = cell.imgGallery;
//        [cell.imgGallery sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"photo_img.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//             weakImageView.alpha = 0.0;
//             weakImageView.image = image;
//             [UIView animateWithDuration:0.3
//                              animations:^
//              {
//                  weakImageView.alpha = 1.0;
//                  //imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.width / 2;
//                  //imgProfilePic.clipsToBounds = YES;
//
//              }];
//
//         }];
        [arrayforuploadingimages replaceObjectAtIndex:indexPath.item withObject:@"no"];
        
    }
    if([[responseDictionary valueForKey:@"gallery"]count] == indexPath.item)
    {
      //  cell.imgGallery.image = nil;
        [cell.imgGallery setImage:[UIImage imageNamed:@"photo_img.png"]];
        
        
//        if (arrGallery.count>indexPath.item)
//        {
//            cell.imgGallery.image = [arrGallery objectAtIndex:indexPath.item];
//        }
//        else
//        {
//
//            [ cell.imgGallery setImage:[UIImage imageNamed:@"photo_img.png"]];
//
//        }
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
//        [QMImagePicker chooseSourceTypeInVC:self allowsEditing:YES isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL)
//         {
//            cell.imgGallery.image = image;
//            [arrGallery insertObject:image atIndex:indexPath.item];
//            cell.imgGallery.layer.cornerRadius =  8.0;
//            cell.imgGallery.clipsToBounds = YES;
//            [arrayforuploadingimages replaceObjectAtIndex:indexPath.item withObject:@"no"];
//            [self sendGalleryImageToServer:image];
//        }];
        isGallery = YES;
        selectedIndex = indexPath;
        NSString *other2=NSLocalizedString(@"Take a picture", nil);
        
        NSString *other1 = NSLocalizedString(@"Choose from gallery", nil);
        
        NSString *cancelTitle = NSLocalizedString(@"Cancel", nil);
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:cancelTitle
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:other1,other2, nil];
        actionSheet.tag = 3;
        [actionSheet showInView:self.view];
        
        [collectionView reloadData];
        
    }
    else
    {
        
        if ([[responseDictionary valueForKey:@"gallery"]count]>indexPath.item)
        {
            NSString *imgUrl=[[[responseDictionary valueForKey:@"gallery"]objectAtIndex:indexPath.item] valueForKey:@"image"];
             selectedBtnIndex=(int)indexPath.item;
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
                        //     _imagezoom.clipsToBounds = YES;
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
    return CGSizeMake(80, 80);
    
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


#pragma mark - ------------------Cell Button Actions--------------
-(void)btnLanguageRemoveAction:(UIButton *)button
{
    int Index=(int)button.tag;
    [arrLanguageCell removeObjectAtIndex:Index];
 //   [_tblEditProfile reloadData];
    CGPoint contentOffset = self.tblEditProfile.contentOffset;
    [self.tblEditProfile reloadData];
    [self.tblEditProfile layoutIfNeeded];
    [self.tblEditProfile setContentOffset:contentOffset];
}

-(void)btnSelectLanguageAction:(UIButton *)button
{
    currentIndexForLanguageCell=(int)button.tag;
    SelectLanguageViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLanguageViewController"];
    vc.delegate=self;
    //CurrentLanguageIndex=(int)indexpath.row;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}
-(void)btnLanguageAddAction:(UIButton *)button
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:@"" forKey:@"createdOn"];
    [dict setValue:@"" forKey:@"lang_proficiency"];
    [dict setValue:@"" forKey:@"seeker_lang_id"];
    [dict setValue:@"" forKey:@"seeker_lang_name"];
    [dict setValue:@"" forKey:@"seeker_lang"];
    [dict setValue:@"" forKey:@"updatedOn"];
    [dict setValue:@"" forKey:@"user_id"];
    long count=arrLanguageCell.count;
    BOOL anyBlankDict=NO;
    if (arrLanguageCell.count>0)
    {
        for (int i=0; i<count; i++)
        {
            NSDictionary *dictt=arrLanguageCell[i];
            if ([[dictt valueForKey:@"seeker_lang_name"] length]==0 || [[dictt valueForKey:@"lang_proficiency"]length]==0)
            {
                anyBlankDict=YES;
                NSLog(@"%@",@"Show Alert");
                [Alerter.sharedInstance showWarningWithMsg:NSLocalizedString(@"Please select a language and language proficiency", @"")];
            }
            else
            {
                anyBlankDict=NO;
            }
            
        }
        if (!anyBlankDict)
        {
            [arrLanguageCell addObject:dict];
            CGPoint contentOffset = self.tblEditProfile.contentOffset;
            [self.tblEditProfile reloadData];
            [self.tblEditProfile layoutIfNeeded];
            [self.tblEditProfile setContentOffset:contentOffset];
//            [_tblEditProfile reloadData];
//            [_tblEditProfile setContentOffset:contentOffset];
          //[_tblEditProfile reloadData];
       
        }
    }
    
}
-(void)btnBeginerAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:button.tag inSection:0];
    NSLog(@"%d",indexPath.row);
    if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"seeker_lang_name"] length]==0)
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
    }
    else
    {
        [cell.btnBeginer setSelected:YES];
        [cell.btnCurrent setSelected:NO];
        [cell.btnAdvanced setSelected:NO];
        [cell.btnIntermedidate setSelected:NO];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        dict=[arrLanguageCell objectAtIndex:indexPath.row];
        [arrLanguageCell replaceObjectAtIndex:indexPath.row withObject:dict];
      
        [dict setValue:@"1" forKey:@"lang_proficiency"];
        [arrLanguageCell replaceObjectAtIndex:indexPath.row withObject:dict];
       // [_tblEditProfile beginUpdates];
     //   [_tblEditProfile reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
      //  [_tblEditProfile endUpdates];
     //   [_tblEditProfile reloadData];
        
    }
}
-(void)btnIntermedidateAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:button.tag inSection:0];
    if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"seeker_lang_name"] length]==0)
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
    }
    else
    {
        [cell.btnBeginer setSelected:NO];
        [cell.btnCurrent setSelected:NO];
        [cell.btnAdvanced setSelected:NO];
        [cell.btnIntermedidate setSelected:YES];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        dict=[arrLanguageCell objectAtIndex:indexPath.row];
        [arrLanguageCell replaceObjectAtIndex:indexPath.row withObject:dict];
        
        [dict setValue:@"2" forKey:@"lang_proficiency"];
        [arrLanguageCell replaceObjectAtIndex:indexPath.row withObject:dict];
      //  [_tblEditProfile reloadData];
    }
}
-(void)btnAdvancedAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:button.tag inSection:0];
    if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"seeker_lang_name"] length]==0)
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
    }
    else
    {
        [cell.btnBeginer setSelected:NO];
        [cell.btnCurrent setSelected:NO];
        [cell.btnAdvanced setSelected:YES];
        [cell.btnIntermedidate setSelected:NO];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        dict=[arrLanguageCell objectAtIndex:indexPath.row];
        [arrLanguageCell replaceObjectAtIndex:indexPath.row withObject:dict];
        
        [dict setValue:@"3" forKey:@"lang_proficiency"];
        [arrLanguageCell replaceObjectAtIndex:indexPath.row withObject:dict];
       // [_tblEditProfile reloadData];
        
    }
}
-(void)btnCurrentAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:button.tag inSection:0];
    if ([[[arrLanguageCell objectAtIndex:indexPath.row] valueForKey:@"seeker_lang_name"] length]==0)
    {
        [Alerter.sharedInstance showInfoWithMsg:@"Please Select language first"];
    }
    else
    {
        [cell.btnBeginer setSelected:NO];
        [cell.btnCurrent setSelected:YES];
        [cell.btnAdvanced setSelected:NO];
        [cell.btnIntermedidate setSelected:NO];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        dict=[arrLanguageCell objectAtIndex:indexPath.row];
        [arrLanguageCell replaceObjectAtIndex:indexPath.row withObject:dict];
        
        [dict setValue:@"4" forKey:@"lang_proficiency"];
        [arrLanguageCell replaceObjectAtIndex:indexPath.row withObject:dict];
      //  [_tblEditProfile reloadData];
        
    }
}
#pragma mark - ---------------Button status Actions------------
-(void)btnStatusStudentAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    
    if(cell.btnStatusStudent.isSelected == YES)
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"";
    }
    else
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:YES];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"1";
    }
}
-(void)btnStatusApprenticeAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    if(cell.btnStatusApprentice.isSelected == YES)
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"";
    }
    else
    {
        [cell.btnStatusApprentice setSelected:YES];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"2";
    }
}
-(void)btnStatusActiveAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    if(cell.btnStatusActive.isSelected == YES)
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"";
    }
    else
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:YES];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"3";
    }
}
-(void)btnStatusJobSeekerAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    if(cell.btnStatusJobSeeker.isSelected == YES)
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"";
    }
    else
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:YES];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"4";
    }
}
-(void)btnStatusInactiveAction:(UIButton *)button
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[button superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    if(cell.btnStatusInactive.isSelected == YES)
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:NO];
        currentStatus = @"";
    }
    else
    {
        [cell.btnStatusApprentice setSelected:NO];
        [cell.btnStatusStudent setSelected:NO];
        [cell.btnStatusActive setSelected:NO];
        [cell.btnStatusJobSeeker setSelected:NO];
        [cell.btnStatusInactive setSelected:YES];
        currentStatus = @"5";
    }
}
#pragma mark ------------Skills Radio Button Action--------------
-(void)btnSkillsHotelsAction:(UIButton *)sender
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[sender superview] superview];
    if(cell.btnSkillsHotels.isSelected == YES)
    {
        [cell.btnSkillsSalesService setSelected:NO];
        [cell.btnSkillsCuisine setSelected:NO];
        [cell.btnSkillsHotels setSelected:NO];
        selectedSkills=@"";
    }
    else
    {
        [cell.btnSkillsSalesService setSelected:NO];
        [cell.btnSkillsCuisine setSelected:NO];
        [cell.btnSkillsHotels setSelected:YES];
        selectedSkills=@"3";
    }
   
 //   selectedSkills=cell.lblSkillsHotels.text;
    
}
-(void)btnSkillsCuisineAction:(UIButton *)sender
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[sender superview] superview];
    if(cell.btnSkillsCuisine.isSelected == YES)
    {
        [cell.btnSkillsSalesService setSelected:NO];
        [cell.btnSkillsCuisine setSelected:NO];
        [cell.btnSkillsHotels setSelected:NO];
        selectedSkills=@"";
    }
    else
    {
        [cell.btnSkillsSalesService setSelected:NO];
        [cell.btnSkillsCuisine setSelected:YES];
        [cell.btnSkillsHotels setSelected:NO];
        selectedSkills=@"1";
    }
}
-(void)btnSkillsSalesServiceAction:(UIButton *)sender
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[sender superview] superview];
    if(cell.btnSkillsSalesService.isSelected == YES)
    {
        [cell.btnSkillsSalesService setSelected:NO];
        [cell.btnSkillsCuisine setSelected:NO];
        [cell.btnSkillsHotels setSelected:NO];
        selectedSkills=@"";
    }
    else
    {
        [cell.btnSkillsSalesService setSelected:YES];
        [cell.btnSkillsCuisine setSelected:NO];
        [cell.btnSkillsHotels setSelected:NO];
        selectedSkills=@"2";
    }
    
}
#pragma mark ----------Mobility Button Action----------

-(void)btnMobilityYesAction:(id)sender
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[sender superview] superview];
    if(cell.btnMobilityYes.isSelected == YES)
    {
        [cell.btnMobilityYes setSelected:NO];
        [cell.btnMobilityNo setSelected:NO];
          strMobility=@"";
    }
    else
    {
          strMobility=@"1";
        [cell.btnMobilityYes setSelected:YES];
        [cell.btnMobilityNo setSelected:NO];
    }
    
   
 //   strMobility=cell.lblMobilityYes.text;
   
    
}

-(void)btnMobilityNoAction:(id)sender
{
    EditSeekerProfile *cell=(EditSeekerProfile *)[[sender superview] superview];
    //NSIndexPath *indexPath=[_tblEditProfile indexPathForCell:cell];
    if(cell.btnMobilityNo.isSelected == YES)
    {
        [cell.btnMobilityYes setSelected:NO];
        [cell.btnMobilityNo setSelected:NO];
        strMobility=@"";
    }
    else
    {
        strMobility=@"2";
        [cell.btnMobilityYes setSelected:NO];
        [cell.btnMobilityNo setSelected:YES];
    }
}

#pragma mark -----------------Webservice methods (Update Profile)-------------
- (IBAction)btnUpdateProfileAction:(id)sender
{
    if ([self validate])
    {
        [self sendProfileDatatoServer];
    }
}

-(void)sendGalleryImageToServer:(UIImage *)image
{
    NSData *imgData=UIImageJPEGRepresentation(image, 0.7);
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
#pragma mark - WebService Methods For Profile
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

-(void)sendProfileDatatoServer
{
    for (int t=0; t<arrLanguageCell.count; t++)
    {
        
            NSDictionary *dictt=arrLanguageCell[t];
            if ([[dictt valueForKey:@"seeker_lang_name"] length]==0 || [[dictt valueForKey:@"lang_proficiency"]length]==0)
            {
                [arrLanguageCell removeObjectAtIndex:t];
            }
    }
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:_txtFirstName.text forKey:@"first_name"];
    [params setValue:_txtLastName.text forKey:@"last_name"];
    if (_txtDateOfBirth.text.length==0)
    {
        [params setValue:@"" forKey:@"dob"];
    }
    else
    {
        [params setValue:_txtDateOfBirth.text forKey:@"dob"];
    }
    [params setValue:_txtCityLOcation.text forKey:@"city"];
    [params setValue:_txtviewAbout.text forKey:@"about"];
    [params setValue:_txtviewSpecifyTranning.text forKey:@"training"];
    [params setValue:strMobility forKey:@"mobility"];
    [params setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"deviceToken"] forKey:@"device_token"];
    [params setValue:selectedEducationId forKey:@"education_level"];
    [params setValue:selectedJobSoughtId forKey:@"candidate_seek_id"];
    [params setValue:currentStatus forKey:@"current_status"];
    [params setValue:selectedSkills forKey:@"skills"];
    //[params setValue:@"" forKey:@"language"];
    [params setValue:arrLanguageCell forKey:@"language"];
    [params setValue:[NSString stringWithFormat:@"%f",lattt] forKey:@"lattitude"];
    [params setValue:[NSString stringWithFormat:@"%f",langg] forKey:@"longitude"];
    [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"] forKey:@"device_token"];
    
    if (_imageSelected && videoSelected)
    {
        WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
        webHelper.methodName=@"EditProfile";
        webHelper.delegate=self;
        [webHelper webserviceHelper:params uploadData:profileData ImageParam:@"user_pic" andVideoData:pitchVideoData withVideoThumbnail:thumbnailData type:@".mp4" webServiceUrl:kEditProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
        [self showProgress:YES];
    }
    else if (_imageSelected)
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
    
    //_lblProgress.text=[NSString stringWithFormat:@"Uploaded %.2f%%",value];
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
        //_lblProgress.alpha = 0;
        //_lblProgress.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            //_lblProgress.alpha = 1;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            //_lblProgress.alpha = 0;
        } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
            //_lblProgress.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
        }];
    }
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
            [self.navigationController popViewControllerAnimated:YES];
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
            [self btnforzoomingviewcut:nil];
        }
    }
}

-(BOOL)validate
{
    if ([_txtFirstName.text isEqualToString:@""]||_txtFirstName.text.length==0)
    {
       
        [Alerter.sharedInstance showWarningWithMsg:@"Enter FirstName"];
        return false;
    }
    else if ([_txtLastName.text isEqualToString:@""]||_txtLastName.text.length==0)
    {
       // [SharedClass showToast:self toastMsg:NSLocalizedString(@"Enter LastName",@"")];
          [Alerter.sharedInstance showWarningWithMsg:@"Enter LastName"];
        return false;
    }
//    else if ([_txtDateOfBirth.text isEqualToString:@""]||_txtDateOfBirth.text.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Enter DOB",@"")];
//        return false;
//    }
    else if ([_txtCityLOcation.text isEqualToString:@""]||_txtCityLOcation.text.length==0)
    {
       // [SharedClass showToast:self toastMsg:NSLocalizedString(@"Enter City",@"")];
        [Alerter.sharedInstance showWarningWithMsg:@"Enter City"];
        return false;
    }
    else if ([_txtExperience.text isEqualToString:@""]||_txtExperience.text.length==0)
    {
        [Alerter.sharedInstance showWarningWithMsg:@"Enter Your Experience"];
       // [SharedClass showToast:self toastMsg:NSLocalizedString(@"Enter Your Experience",@"")];
        return false;
    }
//    else if ([_lblLabelofEducationValue.text isEqualToString:NSLocalizedString(@"Select",@"")]||_lblLabelofEducationValue.text.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please select your education",@"")];
//        return false;
//    }
    else if ([_lblLabelofEducationValue.text isEqualToString:@""]||_lblLabelofEducationValue.text.length==0)
    {
      //  [SharedClass  // showToast:self toastMsg:NSLocalizedString(@"Enter Training",@"")];
        NSLog(@"%@",NSLocalizedString(@"Enter Training",@"Enter Training"));
          [Alerter.sharedInstance showWarningWithMsg:NSLocalizedString(@"Enter Training",@"Enter Training")];
        return false;
    }
//    else if ([_txtviewAbout.text isEqualToString:@""]||_txtviewAbout.text.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Write About yourself",@"")];
//        return false;
//    }
//    else if ([[[arrLanguageCell objectAtIndex:0] valueForKey:NSLocalizedString(@"seeker_lang_name",@"")] length]==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please select a language",@"")];
//        return false;
//    }
//
//    else if (arrLanguageCell.count==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please select any known language and Proficiency Level",@"")];
//        return false;
//    }
//    else if ([currentStatus isEqualToString:@""]||currentStatus.length==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please select Current Status",@"")];
//        return false;
//    }
//    else if ([strMobility length]==0)
//    {
//        [SharedClass showToast:self toastMsg:NSLocalizedString(@"Please select Mobility",@"")];
//        return false;
//    }
    
    return true;
}

#pragma mark - ------------View Video & Image--------------

- (IBAction)btnViewProfileImage:(id)sender
{
    NSString *url=[responseDictionary valueForKey:@"user_pic"];
    if (url.length>0)
    {
        [self.viewImageHolder setHidden:NO];
        [self.viewImageVideoBackground setHidden:NO];
        self.viewImageHolder.layer.cornerRadius=15;
        self.imgEnterPriseRecruiter.layer.cornerRadius=15;
        self.imgEnterPriseRecruiter.clipsToBounds=YES;
        
        _btnRemoveImageFromPopup.layer.cornerRadius=17;
        [_btnRemoveImageFromPopup setTitle:[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"REMOVE", @"")] forState:UIControlStateNormal];
        [_btnRemoveImageFromPopup setBackgroundColor:InternalButtonColor];
        
        [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
        [SharedClass showPopupView:self.viewImageHolder];
        
        [_imgEnterPriseRecruiter sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kDefaultPlaceHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if (error)
             {
                 [_imgEnterPriseRecruiter setImage:kDefaultPlaceHolder];
             }
         }];
    }
    
}

- (IBAction)btnViewProfileVideo:(id)sender
{
    NSString *videoUrl=[responseDictionary valueForKey:@"patch_video"];
    if (videoUrl.length>0)
    {
        self.viewVideoBackground.layer.cornerRadius=15;
        self.viewVideoHolder.layer.cornerRadius=15;
        self.viewVideoBackground.layer.cornerRadius=15;
        self.viewVideoBackground.clipsToBounds=YES;
        [self.viewImageVideoBackground setHidden:NO];
        [self.viewVideoHolder setHidden:NO];
        _btnRemoveVideoFromPopup.layer.cornerRadius=17;
        [_btnRemoveVideoFromPopup setTitle:[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"REMOVE", @"")] forState:UIControlStateNormal];
        [_btnRemoveVideoFromPopup setBackgroundColor:InternalButtonColor];
        [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
        [SharedClass showPopupView:self.viewVideoHolder];
        
        NSURL *myVideoUrl=[NSURL URLWithString:videoUrl];
        
        playerViewController = [[AVPlayerViewController alloc] init];
        AVURLAsset *asset = [AVURLAsset assetWithURL: myVideoUrl];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
        
        AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
        playerViewController.player = player;
        [playerViewController.view setFrame:CGRectMake(0, 0, _viewVideoBackground.frame.size.width, _viewVideoBackground.frame.size.height)];
        
        playerViewController.showsPlaybackControls = YES;
        
        [_viewVideoBackground addSubview:playerViewController.view];
        _viewVideoBackground.alpha=1.0;
        playerViewController.view.alpha=1.0;
        _viewVideoHolder.alpha=1.0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidExit:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[player currentItem]];
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
- (IBAction)btnRemoveProfilePicAction:(id)sender
{
    [self confirmationAlert:@"profile"];
}

- (IBAction)btnRemovePitchVideoAction:(id)sender
{
    [self confirmationAlert:@"video"];
}

- (IBAction)btnRemoveVideoFromPopup:(id)sender
{
    [self confirmationAlert:@"profile"];
}

- (IBAction)btnRemoveImageFromPopupAction:(id)sender
{
    [self confirmationAlert:@"video"];
}

- (void)itemDidFinishPlaying:(NSNotification *)notification
{
    AVPlayerItem *player = [notification object];
    [player seekToTime:kCMTimeZero];
}

- (void)itemDidExit:(NSNotification *)notification
{
    
}
#pragma mark - ----------—-------Remove Video & Profile--------------
-(void)removeVideo
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"deleteProfileVideo";
    webhelper.delegate=self;
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"patch_video" forKey:@"field_name"];
    [webhelper webserviceHelper:params webServiceUrl:kDeleteProfilePic methodName:@"deleteProfileVideo" showHud:YES inWhichViewController:self];
}

-(void)removeEnterprise
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"deleteEnterPic";
    webhelper.delegate=self;
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"enterprise_pic" forKey:@"field_name"];
    [webhelper webserviceHelper:params webServiceUrl:kDeleteProfilePic methodName:@"deleteEnterPic" showHud:YES inWhichViewController:self];
}
-(void)removePrfilePic
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"deleteProfilePic";
    webhelper.delegate=self;
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"user_pic" forKey:@"field_name"];
    [webhelper webserviceHelper:params webServiceUrl:kDeleteProfilePic methodName:@"deleteProfilePic" showHud:YES inWhichViewController:self];
}


-(void)confirmationAlert:(NSString *)str
{
    currentItem=str;
    UIAlertView *alert;
    if ([str isEqualToString:@"profile"])
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Bonjob" message:NSLocalizedString(@"Do you want to remove profile pic ?", @"") delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        alert.tag=2000;
        [alert show];
    }
    
    else
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Bonjob" message:NSLocalizedString(@"Do you want to remove Pitch video ?", @"") delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        alert.tag=2000;
        [alert show];
    }
    
}

- (IBAction)btnCloseVideoGuidePopupAction:(id)sender
{
    //[[NSUserDefaults standardUserDefaults] valueForKey:@"videopopup"]
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[SharedClass getUserId] forKey:@"uid"];
    [params setValue:@"yes" forKey:@"videopopup"];
    [[NSUserDefaults standardUserDefaults]setObject:params forKey:@"videodata"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [SharedClass hidePopupView:self.viewDimBackground andTabbar:self.tabBarController];
    [SharedClass hidePopupView:self.viewVideoGuidePopup];
    [self.scrollView setHidden:YES];
    [self.viewVideoGuideInternal setHidden:YES];
}


@end