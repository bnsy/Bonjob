//
//  EditRecruterScreenViewController.m
//  Recurterscreen
//
//  Created by Infoicon Technologies on 10/07/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//
#define kFirstName                 @"first_name"
#define kLastName                  @"last_name"
#define kEnterPriseName            @"enterprise_name"
#define kCity                      @"city"
#define kRecruiterPic              @"user_pic"
#define kPitchVideo                @"patch_video"
#define kEnterPrisePic             @"enterprise_pic"
#define kEnterPriseCategory        @"company_category"
#define kEnterPriseCategoryId       @"company_category_name"
#define kSalery                    @"salary"
#define kSaleryId                   @"salary_name"
#define kAbout                     @"about"
#define kWebsite                   @"website"

#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "EditRecruterScreenViewController.h"
#import "CategoryTableViewCell.h"
#import "SalaryTableViewCell.h"
#import "RecruiterEditProfileCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AVKit/AVPlayerViewController.h>
#import "ImageCropperViewController.h"
@interface EditRecruterScreenViewController ()<UIAlertViewDelegate,ImageCropperDelegate>
{
    NSArray *arraycategory;
    NSArray *arraysalary;
    int selectedSaleryIndex,selectedCategoryIndex;
    UIImageView *imgProfilePic,*imgEnterprisePic,*imgPitchVideo;
    BOOL imageSelected,CompanyImageSelected,PitchVideoSelected;
    NSData *imgProfileData,*imgCompanyData,*imgPitchVideoData;
    UIImagePickerController *imagePicker;
    NSString *strCategoey,*strNumberOfEmployee;
    NSMutableDictionary *Paramsdict;
    float lattt;
    float longg;
    int counter;
    NSData *thumbnailData;
    NSURL *videoURL;
    AVPlayerViewController *playerViewController;
    NSString *currentItem;
    int selectedTextField;
    NSMutableArray *arrCategory,*arrSalary,*arrSelCategory,*arrSelSalary;
    BOOL isEnterPrisePhoto;
    NSInteger selectedindex;
}
@property (strong, nonatomic) IBOutlet UITableView *tbleditmyprofile;
@property (strong, nonatomic) IBOutlet UIView *viewbackground;
@property (strong, nonatomic) IBOutlet UIView *viewcategory;
@property (strong, nonatomic) IBOutlet UITableView *tblcategory;
@property (strong, nonatomic) IBOutlet UITableView *tblsalary;
@property (strong, nonatomic) IBOutlet UIView *viewsalary;

@end

@implementation EditRecruterScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrCategory = [[NSMutableArray alloc]init];
    arrSelCategory = [[NSMutableArray alloc]init];
    arrSalary = [[NSMutableArray alloc]init];
    arrSelSalary = [[NSMutableArray alloc]init];
    
    [self getProfilePopUpData];
    
     self.tbleditmyprofile.tableFooterView = [UIView new];
    counter=0;
    selectedTextField = 0;
    selectedCategoryIndex=-1;
    selectedSaleryIndex=-1;
    //Company category
    //Number of employees
    arraycategory = [NSArray arrayWithObjects:NSLocalizedString(@"Restaurant",@""), NSLocalizedString(@"Hotel",@""), NSLocalizedString(@"Hotel / Restaurant",@""),NSLocalizedString(@"Cafe, Bar, Brasserie",@""), NSLocalizedString(@"Nightclub, Casino",@""), NSLocalizedString(@"Thalassotherapy",@""), NSLocalizedString(@"Caterer",@""), nil];
    arraysalary = [NSArray arrayWithObjects:NSLocalizedString(@"1-10 employees",@""),NSLocalizedString(@"10-50 employees",@""), NSLocalizedString(@"50-100 employees",@""), NSLocalizedString(@"100+ employees",@""), nil];
    _viewbackground.hidden = YES;
    _viewcategory.hidden = YES;
    _viewcategory.layer.cornerRadius = 20.0;
    _viewsalary.layer.cornerRadius = 20.0;
    _viewsalary.hidden = YES;
    _tblsalary.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tblcategory.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    
    _lblNumberOfSalries.text=NSLocalizedString(@"Number of employees", @"");
    _lblPopupCategoryr.text=NSLocalizedString(@"Company category", @"");
    [_btnSave setTitle:NSLocalizedString(@"Save", @"")];
    Paramsdict=[[NSMutableDictionary alloc]init];
    Paramsdict=[_DictProfile mutableCopy];
    [_viewImageVideoBackground setHidden:YES];
    [_viewVideoHolder setHidden:YES];
    [_viewImageHolder setHidden:YES];
    
    _viewVideoGuidePopup.layer.cornerRadius=15.0;
    [_viewVideoGuidePopup setHidden:YES];
    [self.viewDimBackground setHidden:YES];
    
    
  
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    counter=0;
}

-(void)viewDidLayoutSubviews
{
    UIBezierPath *maskPath3 = [UIBezierPath
                               bezierPathWithRoundedRect:self.tblcategory.bounds
                               byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                               cornerRadii:CGSizeMake(20, 20)
                               ];
    CAShapeLayer *maskLayer3 = [CAShapeLayer layer];
    maskLayer3.frame = self.tblcategory.bounds;
    maskLayer3.path = maskPath3.CGPath;
    self.tblcategory.layer.mask = maskLayer3;
    
    UIBezierPath *maskPath4 = [UIBezierPath
                               bezierPathWithRoundedRect:self.tblsalary.bounds
                               byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                               cornerRadii:CGSizeMake(20, 20)
                               ];
    CAShapeLayer *maskLayer4 = [CAShapeLayer layer];
    maskLayer4.frame = self.tblsalary.bounds;
    maskLayer4.path = maskPath4.CGPath;
    self.tblsalary.layer.mask = maskLayer4;
}
#pragma mark -----------Tableview delegate--------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_tbleditmyprofile)
    {
    return 11;
    }
    else if(tableView==_tblcategory)
    {
        return [arrCategory count];
    }
    else
    {
        return [arrSalary count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_tbleditmyprofile)
    {
      
        switch (indexPath.row)
        {
            case 0:
                return 54;
                break;
            case 1:
                return 54;
                break;
            case 2:
                return 54;
                break;
            case 3:
                return 54;
                break;
            case 4:
                return 110;
                break;
            case 5:
                return 110;
                break;
            case 6:
                return 110;
                break;
            case 7:
                return 67;
                break;
            case 8:
                return 67;
                break;
            case 9:
                return 120;
                break;
            case 10:
                return 54;
                break;
                
                default:
                return 0;
                break;
        }
    }
    else
    {
        return 60;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_tbleditmyprofile)
    {
        RecruiterEditProfileCell *cell  = (RecruiterEditProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell%ld", (long)indexPath.row]];
        cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.btnEditFirstName addTarget:self action:@selector(editFirstName:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnEditLastName addTarget:self action:@selector(editLastName:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnEditCompanyName addTarget:self action:@selector(editCompanyName:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnLOcation addTarget:self action:@selector(editLocation:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnCamera addTarget:self action:@selector(openCameraForProfile:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnPitchVideo addTarget:self action:@selector(openCameraForPitchVideo:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnPhotoEnterPrize addTarget:self action:@selector(openCameraForEnterprise:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnDesc addTarget:self action:@selector(editDescription:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnEditWebsite addTarget:self action:@selector(editWebSite:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnViewProfilePic addTarget:self action:@selector(btnViewProfilePicAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnViewEnterpriseImage addTarget:self action:@selector(btnViewEnterpriseImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnViewEnterpriseVideo addTarget:self
                                        action:@selector(btnViewEnterpriseVideoAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [cell.btnProfilePicRemove setTitle:NSLocalizedString(@"REMOVE", @"") forState:UIControlStateNormal];
        [cell.btnPitchVideoRemove setTitle:NSLocalizedString(@"REMOVE", @"") forState:UIControlStateNormal];
        [cell.btnEnterpriseImageRemove setTitle:NSLocalizedString(@"REMOVE", @"") forState:UIControlStateNormal];
        
        
        UIColor *color = InternalButtonColor; // select needed color
        //NSString *string = NSLocalizedString(@"REMOVE", @""); // the string to colorize
        NSDictionary *attrs = @{ NSForegroundColorAttributeName : color };
        
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"REMOVE", @"") attributes:attrs];
        
        // making text property to underline text-
        [titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [titleString length])];
        
        // using text on button
        [cell.btnProfilePicRemove setAttributedTitle: titleString forState:UIControlStateNormal];
        [cell.btnPitchVideoRemove setAttributedTitle: titleString forState:UIControlStateNormal];
        [cell.btnEnterpriseImageRemove setAttributedTitle: titleString forState:UIControlStateNormal];
        
        
        [cell.btnProfilePicRemove addTarget:self action:@selector(btnProfilePicRemoveAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnPitchVideoRemove addTarget:self action:@selector(btnPitchVideoRemoveAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnEnterpriseImageRemove addTarget:self action:@selector(btnEnterpriseImageRemoveAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        cell.txtFirstName.delegate=self;
        cell.txtLastName.delegate=self;
        cell.txtCompanyName.delegate=self;
        cell.txtLocation.delegate=self;
        cell.txtEnterPriseType.delegate=self;
        cell.txtviewDesc.delegate=self;
        cell.txtWebsite.delegate=self;
        cell.txtviewDesc.userInteractionEnabled=false;
        cell.txtWebsite.userInteractionEnabled=false;
        cell.btnEditFirstName.tag=indexPath.row;
        cell.btnEditLastName.tag=indexPath.row;
        cell.btnEditCompanyName.tag=indexPath.row;
        cell.btnLOcation.tag=indexPath.row;
        cell.btnCamera.tag=indexPath.row;
        cell.btnPitchVideo.tag=indexPath.row;
        cell.btnPhotoEnterPrize.tag=indexPath.row;
        cell.btnEnterPriseCat.tag=indexPath.row;
        cell.btnNumberSalries.tag=indexPath.row;
        cell.btnDesc.tag=indexPath.row;
        cell.btnEditWebsite.tag=indexPath.row;
        cell.txtFirstName.tag=indexPath.row;
        cell.txtLastName.tag=indexPath.row;
        cell.txtLocation.tag=indexPath.row;
        cell.txtCompanyName.tag=indexPath.row;
        cell.txtEnterPriseType.tag=indexPath.row;
        cell.txtSalrie.tag=indexPath.row;
        cell.txtviewDesc.tag=indexPath.row;
        cell.txtWebsite.tag=indexPath.row;
        // EDIT PROFILE RECRUITER
        
        cell.lblFirstName.text=NSLocalizedString(@"FIRST NAME", @"");
        cell.lblLastName.text=NSLocalizedString(@"NAME", @"");
        cell.lblCompanyName.text=NSLocalizedString(@"COMPANY", @"");
        cell.lblLocation.text=NSLocalizedString(@"CITY", @"");
        cell.lblProfilePic.text=NSLocalizedString(@"PHOTO", @"");
        cell.lblCompanyImage.text=NSLocalizedString(@"COMPANY PHOTO", @"");
        cell.lblPitchVideo.text=NSLocalizedString(@"VIDEO PITCH", @"");
        cell.lblCategoryEnterPrise.text=NSLocalizedString(@"COMPANY CATEGORY", @"");
        cell.lblSalrie.text=NSLocalizedString(@"NUMBER OF EMPLOYEES", @"");
        cell.lblDesc.text=NSLocalizedString(@"ABOUT", @"");
        cell.lblWebsite.text=NSLocalizedString(@"WEBSITE", @"");
        if (imgPitchVideo!=nil)
        {
            cell.imgPitchVideo.image=imgPitchVideo.image;
        }
        if (strCategoey.length>0)
        {
            cell.txtEnterPriseType.text=strCategoey;
        }
        else
        {
            cell.txtEnterPriseType.text=@"";
        }
        if (strNumberOfEmployee.length>0)
        {
            cell.txtSalrie.text=strNumberOfEmployee;
        }
        else
        {
            cell.txtSalrie.text=@"";
        }
        cell.txtWebsite.text=[Paramsdict valueForKey:kWebsite];
        cell.txtviewDesc.text=[Paramsdict valueForKey:kAbout];
        cell.txtSalrie.text=[Paramsdict valueForKey:kSaleryId];
        cell.txtEnterPriseType.text=[Paramsdict valueForKey:kEnterPriseCategoryId];
        cell.txtLocation.text=[Paramsdict valueForKey:kCity];
        cell.txtCompanyName.text=[Paramsdict valueForKey:kEnterPriseName];
        cell.txtLastName.text=[Paramsdict valueForKey:kLastName];
        cell.txtFirstName.text=[Paramsdict valueForKey:kFirstName];
        cell.imgCompanyImage.image=[UIImage imageWithData:imgCompanyData];
        cell.imgProfilePic.image=[UIImage imageWithData:imgProfileData];
        cell.imgPitchVideo.image=imgPitchVideo.image;
        
        if (imgProfileData)
        {
            cell.imgProfilePic.image=[UIImage imageWithData:imgProfileData];
        }
        else
        {
            // for profile pic
            UIImageView *Profile_Image=cell.imgProfilePic;
            __weak UIImageView *weakImageView = Profile_Image;
           NSString *userpicurl= [Paramsdict valueForKey:kRecruiterPic];
            if (userpicurl.length>0 && ([userpicurl.lastPathComponent containsString:@".png"] || [userpicurl.lastPathComponent containsString:@".jpg"]))
            {
                [cell.btnProfilePicRemove setHidden:NO];
                [cell.imgProfilePic sd_setImageWithURL:[NSURL URLWithString:userpicurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                 {
                     if (!error)
                     {
                         [cell.btnProfilePicRemove setHidden:NO];
                         weakImageView.alpha = 0.0;
                         weakImageView.image = image;
                         [UIView animateWithDuration:0.3
                                          animations:^
                          {
                              weakImageView.alpha = 1.0;
                              cell.imgProfilePic.layer.cornerRadius = cell.imgProfilePic.frame.size.width / 2;
                              cell.imgProfilePic.clipsToBounds = YES;
                          }];
                     }
                     else
                     {
                         [cell.btnProfilePicRemove setHidden:YES];
                         [SharedClass showToast:self toastMsg:error.localizedDescription];
                         Profile_Image.image=[UIImage imageNamed:@"defaultPic.png"];
                         cell.imgProfilePic.image=[UIImage imageNamed:@"defaultPic.png"];
                     }
                 }];
            }
            else
            {
                [cell.btnProfilePicRemove setHidden:YES];
                Profile_Image.image=[UIImage imageNamed:@"defaultPic.png"];
                cell.imgProfilePic.image=[UIImage imageNamed:@"defaultPic.png"];
            }
        }
        
        // for company image
        if (imgCompanyData)
        {
            cell.imgCompanyImage.image=[UIImage imageWithData:imgCompanyData];
        }
        else
        {
            UIImageView *Profile_Image2=cell.imgCompanyImage;
            __weak UIImageView *weakImageView2 = Profile_Image2;
            NSString *enterprisepicurl= [Paramsdict valueForKey:kEnterPrisePic];
            if (enterprisepicurl.length>0 && ([enterprisepicurl.lastPathComponent containsString:@".png"] ||[enterprisepicurl.lastPathComponent containsString:@".jpg"]))
            {
                [cell.btnEnterpriseImageRemove setHidden:NO];
                [cell.imgCompanyImage sd_setImageWithURL:[NSURL URLWithString:enterprisepicurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                 {
                     if (!error)
                     {
                         [cell.btnEnterpriseImageRemove setHidden:NO];
                         weakImageView2.alpha = 0.0;
                         weakImageView2.image = image;
                         [UIView animateWithDuration:0.3
                                          animations:^
                          {
                              weakImageView2.alpha = 1.0;
                              cell.imgCompanyImage.layer.cornerRadius = cell.imgCompanyImage.frame.size.width / 2;
                              cell.imgCompanyImage.clipsToBounds = YES;
                          }];
                     }
                     else
                     {
                         [cell.btnEnterpriseImageRemove setHidden:YES];
                         [SharedClass showToast:self toastMsg:error.localizedDescription];
                         Profile_Image2.image=[UIImage imageNamed:@"home_grey.png"];
                         cell.imgCompanyImage.image=[UIImage imageNamed:@"home_grey.png"];
                     }
                 }];
            }
            else
            {
                [cell.btnEnterpriseImageRemove setHidden:YES];
                Profile_Image2.image=[UIImage imageNamed:@"home_grey.png"];
                cell.imgCompanyImage.image=[UIImage imageNamed:@"home_grey.png"];
            }
        }
        
        if (imgPitchVideoData)
        {
            cell.imgPitchVideo.image=[[SharedClass sharedInstance] thumbnailFromVideoAtURL:videoURL];
            //[SharedClass sharedInstance]
        }
        else
        {
            [cell.btnPlayPitchVideo setHidden:NO];
           // [cell.btnPitchVideo setImage:[UIImage imageNamed:@"pitch_play.png"] forState:UIControlStateNormal];
            NSString  *videourl=[Paramsdict valueForKey:@"patch_video_thumbnail"];
            if (videourl.length>0)
            {
                [cell.imgPitchVideo sd_setImageWithURL:[NSURL URLWithString:videourl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                 {
                     if (!error)
                     {
                         [cell.btnPitchVideoRemove setHidden:NO];
                         [UIView animateWithDuration:0.3
                                          animations:^
                          {
                              
                              cell.imgPitchVideo.layer.cornerRadius = cell.imgPitchVideo.frame.size.width / 2;
                              cell.imgPitchVideo.clipsToBounds = YES;
                          }];
                     }
                     else
                     {
                         [cell.btnPlayPitchVideo setHidden:YES];
                         [cell.btnPitchVideoRemove setHidden:YES];
                         [SharedClass showToast:self toastMsg:error.localizedDescription];
                         imgPitchVideo.image=[UIImage imageNamed:@"play_icon_deactive.png"];
                     }
                 }];
            }
            else
            {
                 [cell.btnPlayPitchVideo setHidden:YES];
                
                [cell.btnPitchVideoRemove setHidden:YES];
                cell.imgPitchVideo.layer.cornerRadius = cell.imgPitchVideo.frame.size.width / 2;
                cell.imgPitchVideo.clipsToBounds = YES;
                cell.imgPitchVideo.image=[UIImage imageNamed:@"play_icon_deactive.png"];
            }
            

        }
        
        
        return cell;
    }
    else if(tableView==_tblcategory)
    {
        CategoryTableViewCell *cell  = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.separatorInset = UIEdgeInsetsZero;
        CompanyCategory_Model * obj = [arrCategory objectAtIndex:indexPath.row];
        
        cell.labelcategorycell.text = obj.company_category_title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.btnCategorySelected setTag:indexPath.row];
        [cell.btnCategorySelected addTarget:self action:@selector(categorySelected:) forControlEvents:UIControlEventTouchUpInside];
        if (selectedCategoryIndex==indexPath.row)
        {
            [cell.btnCategorySelected setSelected:YES];
        }
        else
        {
            [cell.btnCategorySelected setSelected:NO];
        }
        return cell;

    }
    else
    {
        SalaryTableViewCell *cell  = (SalaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.separatorInset = UIEdgeInsetsZero;
        NumberOfEmpModel * obj = [arrSalary objectAtIndex:indexPath.row];
        
        cell.labelsalary.text = obj.number_of_employee_title;
        [cell.btnSalerySelected setTag:indexPath.row];
        [cell.btnSalerySelected addTarget:self action:@selector(salerySelected:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (selectedSaleryIndex==indexPath.row)
        {
            [cell.btnSalerySelected setSelected:YES];
        }
        else
        {
            [cell.btnSalerySelected setSelected:NO];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_tblcategory)
    {
        [arrSelCategory removeAllObjects];
        selectedCategoryIndex=(int)indexPath.row;
        [_tblcategory reloadData];
        CompanyCategory_Model *obj = [arrCategory objectAtIndex:indexPath.row];
        [arrSelCategory addObject:obj];
        [SharedClass hidePopupView:_viewbackground];
        [SharedClass hidePopupView:_viewcategory];
     //   strCategoey=[arraycategory objectAtIndex:selectedCategoryIndex];
        [Paramsdict setValue:obj.company_category_id forKey:kEnterPriseCategory];
        [Paramsdict setValue:obj.company_category_title forKey:kEnterPriseCategoryId];
        [_tbleditmyprofile reloadData];
       
        //[self btncutcategory:nil];
    }
    else if(tableView==_tblsalary)
    {
        [arrSelSalary removeAllObjects];
        selectedSaleryIndex=(int)indexPath.row;
        [_tblsalary reloadData];
        NumberOfEmpModel *obj = [arrSalary objectAtIndex:indexPath.row];
        [arrSelSalary addObject:obj];
        [SharedClass hidePopupView:_viewbackground];
        [SharedClass hidePopupView:_viewsalary];
       // strNumberOfEmployee=[arraysalary objectAtIndex:selectedSaleryIndex];
        [Paramsdict setObject:obj.number_of_employee_id forKey:kSalery];
         [Paramsdict setObject:obj.number_of_employee_title forKey:kSaleryId];
        [_tbleditmyprofile reloadData];
        
        //[self btncutsalary:nil];
    }
}

#pragma mark - ---------Textview Delagets-----------

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"Yes");
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    selectedTextField = textField.tag;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.userInteractionEnabled=false;
    return TRUE;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:textField.tag inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    if (textField==cell.txtFirstName)
    {
        [Paramsdict setValue:cell.txtFirstName.text forKey:kFirstName];
    }
    else if (textField==cell.txtLastName)
    {
        [Paramsdict setValue:cell.txtLastName.text forKey:kLastName];
    }
    else if (textField==cell.txtCompanyName)
    {
        [Paramsdict setValue:cell.txtCompanyName.text forKey:kEnterPriseName];
    }
    else if (textField==cell.txtLocation)
    {
        [Paramsdict setValue:cell.txtLocation.text forKey:kCity];
    }
    else if (textField==cell.txtEnterPriseType)
    {
        [Paramsdict setValue:cell.txtEnterPriseType.text forKey:kEnterPriseCategory];
    }
    else if (textField==cell.txtSalrie)
    {
        [Paramsdict setValue:cell.txtSalrie.text forKey:kSalery];
    }
    else if (textField==cell.txtWebsite)
    {
        [Paramsdict setValue:cell.txtWebsite.text forKey:kWebsite];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:textField.tag inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    
   
    
    if ((textField == cell.txtFirstName) || (textField == cell.txtLastName)  || (textField == cell.txtCompanyName) || (textField == cell.txtWebsite)) {
        
        // do not allow the first character to be space | do not allow more than one space
        if ([string isEqualToString:@" "]) {
            if (!textField.text.length)
                return NO;
            if (range.location == 0) {
                return NO;
            }
            if ((range.length == 0 && textField == cell.txtWebsite)) {
                return NO;
            }
            
            if ([[textField.text stringByReplacingCharactersInRange:range withString:string] rangeOfString:@"  "].length)
                return NO;
            
        }
    }
    
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        textView.userInteractionEnabled=FALSE;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:textView.tag inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    if (textView==cell.txtviewDesc)
    {
        [Paramsdict setValue:cell.txtviewDesc.text forKey:kAbout];
    }
}

#pragma mark --------Cell button action ------

-(void)salerySelected:(UIButton *)btn
{
    
    [arrSelSalary removeAllObjects];
    selectedSaleryIndex=(int)btn.tag;
    NumberOfEmpModel *obj = [arrSalary objectAtIndex:selectedSaleryIndex];
    [arrSelSalary addObject:obj];
    [Paramsdict setObject:obj.number_of_employee_id forKey:kSalery];
    [Paramsdict setObject:obj.number_of_employee_title forKey:kSaleryId];
    [_tblsalary reloadData];
    [self btncutsalary:nil];
    [_tbleditmyprofile reloadData];
    
  
}
-(void)categorySelected:(UIButton *)btn
{
    
    selectedCategoryIndex=(int)btn.tag;
    
    [arrSelCategory removeAllObjects];
    CompanyCategory_Model *obj = [arrCategory objectAtIndex:selectedCategoryIndex];
    [arrSelCategory addObject:obj];
    [Paramsdict setValue:obj.company_category_id forKey:kEnterPriseCategory];
    [Paramsdict setValue:obj.company_category_title forKey:kEnterPriseCategoryId];
    [self btncutsalary:nil];

    
   // strCategoey=[arraycategory objectAtIndex:selectedCategoryIndex];
   // [Paramsdict setValue:strCategoey forKey:kEnterPriseCategory];
    [_tblcategory reloadData];
    [self btncutcategory:nil];
    [_tbleditmyprofile reloadData];
    
    
    
}

- (IBAction)btncellcategory:(id)sender
{
    _viewcategory.hidden = NO;
    _viewbackground.hidden = NO;
//    [[[UIApplication sharedApplication]keyWindow] addSubview:_viewbackground];
//    [[[UIApplication sharedApplication]keyWindow] addSubview:_viewcategory];
    [SharedClass showPopupView:_viewbackground];
    [SharedClass showPopupView:_viewcategory];
}

- (IBAction)btncellnumbersalary:(id)sender
{
    _viewsalary.hidden = NO;
    _viewbackground.hidden = NO;
//    [[[UIApplication sharedApplication]keyWindow] addSubview:_viewbackground];
//    [[[UIApplication sharedApplication]keyWindow] addSubview:_viewsalary];
    [SharedClass showPopupView:_viewbackground];
    [SharedClass showPopupView:_viewsalary];
}

-(void)editFirstName:(UIButton *)sender
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:sender.tag inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    cell.txtFirstName.userInteractionEnabled=YES;
    [cell.txtFirstName becomeFirstResponder];
}

-(void)editLastName:(UIButton *)sender
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:sender.tag inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    cell.txtLastName.userInteractionEnabled=YES;
    [cell.txtLastName becomeFirstResponder];
}

-(void)editCompanyName:(UIButton *)sender
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:sender.tag inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    cell.txtCompanyName.userInteractionEnabled=YES;
    [cell.txtCompanyName becomeFirstResponder];
}

-(void)editLocation:(UIButton *)sender
{
    SelectLocationViewController *slvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
    slvc.delegate=self;
    [self.navigationController pushViewController:slvc animated:YES];
}

-(void)openCameraForProfile:(UIButton *)sender
{
    isEnterPrisePhoto = NO;
     selectedindex = sender.tag;
//    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:sender.tag inSection:0];
//    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
//    imgProfilePic=cell.imgProfilePic;
//    [QMImagePicker chooseSourceTypeInVC:self allowsEditing:YES isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL)
//    {
//        cell.imgProfilePic.image=image;
//        imgProfilePic.image = image;
//        cell.imgProfilePic.layer.cornerRadius = cell.imgProfilePic.frame.size.width/2;
//        imgProfilePic.clipsToBounds = YES;
//        imageSelected=YES;
//        imgProfileData = UIImageJPEGRepresentation(image, 0.7);
//    }];
    
    NSString *other1;
    NSString *other2;
    
    
    other2=NSLocalizedString(@"Take a picture", nil);
    
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
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
    
}

-(void)openCameraForPitchVideo:(UIButton *)sender
{
    NSString *alreadyShowed=[[NSUserDefaults standardUserDefaults] valueForKey:@"videopopup"];
//    if ([alreadyShowed isEqualToString:@"yes"])
//    {
        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:sender.tag inSection:0];
        RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
        imgPitchVideo=cell.imgPitchVideo;
        [self openActionSheet:YES isPhoto:NO];
//    }
//    else
//    {
//        [self.viewVideoGuidePopup setHidden:NO];
//        [self.viewDimBackground setHidden:NO];
//        [SharedClass showPopupView:self.viewDimBackground andTabbar:nil];
//        [SharedClass showPopupView:self.viewVideoGuidePopup];
//    }
    
}

-(void)openCameraForEnterprise:(UIButton *)sender
{
    isEnterPrisePhoto = YES;
    selectedindex = sender.tag;
//    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:sender.tag inSection:0];
//    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
//    [QMImagePicker chooseSourceTypeInVC:self allowsEditing:NO isVideo:NO isPhoto:YES result:^(UIImage* image,NSURL* videoURL)
//    {
//        imgEnterprisePic.image=image;
//        cell.imgCompanyImage.image = image;
//        cell.imgCompanyImage.layer.cornerRadius = cell.imgCompanyImage.frame.size.width/2;
//        cell.imgCompanyImage.clipsToBounds = YES;
//        CompanyImageSelected=YES;
//        imgCompanyData = UIImageJPEGRepresentation(image, 0.7);
//
//
//        ImageCropperViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ImageCropperViewController"];
//        vc.selectedImage=image;
//        vc.delegate=self;
//        [self presentViewController:vc animated:YES completion:nil];
//
//    }];
    
    NSString *other1;
    NSString *other2;
    
   
    other2=NSLocalizedString(@"Take a picture", nil);
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
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];

}

-(void)rectunglarImage:(UIImage *)croppedImage
{
    imgEnterprisePic.image=croppedImage;
    CompanyImageSelected=YES;
    imgCompanyData = UIImageJPEGRepresentation(croppedImage, 0.7);
}

-(void)editDescription:(UIButton *)sender
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:sender.tag inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    cell.txtviewDesc.userInteractionEnabled=YES;
    [cell.txtviewDesc becomeFirstResponder];
    
}

-(void)editWebSite:(UIButton *)sender
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:sender.tag inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    cell.txtWebsite.userInteractionEnabled=YES;
    [cell.txtWebsite becomeFirstResponder];
}

#pragma mark - -----------Popup Button Actions--------------
-(void)btnProfilePicRemoveAction:(UIButton *)btn
{
    currentItem=@"profile";
    [self confirmationAlert:@"profile"];
}

-(void)btnEnterpriseImageRemoveAction:(UIButton *)btn
{
    currentItem=@"enterprise";
    [self confirmationAlert:@"enterprise"];
}
-(void)btnPitchVideoRemoveAction:(UIButton *)btn
{
    currentItem=@"video";
    [self confirmationAlert:@"video"];
}
-(void)btnViewEnterpriseVideoAction:(UIButton *)btn
{
    NSString *videoUrl=[Paramsdict valueForKey:@"patch_video"];
    if (videoUrl.length>0)
    {
        self.viewVideoHolder.layer.cornerRadius=10;
        self.viewVideoHolder.clipsToBounds=YES;
        [self.viewImageVideoBackground setHidden:NO];
        [self.viewVideoHolder setHidden:NO];
        [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:nil];
        [SharedClass showPopupView:self.viewVideoHolder];
        
        NSURL *myVideoUrl=[NSURL URLWithString:videoUrl];
        //    player =[[MPMoviePlayerController alloc] initWithContentURL: myVideoUrl];
        //    [[player view] setFrame: [_viewShowVideo bounds]];  // frame must match parent view
        //    [_viewShowVideo addSubview: [player view]];
        [_btnPopupDeleteVideo setBackgroundColor:InternalButtonColor];
        [_btnPopupDeleteVideo setTitle:[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"REMOVE", @"")] forState:UIControlStateNormal];
        _btnPopupDeleteVideo.layer.cornerRadius=17;
        
        
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
    
}
-(void)btnViewEnterpriseImageAction:(UIButton *)btn
{
    NSString *imgUrl=[Paramsdict valueForKey:@"enterprise_pic"];
    if (imgUrl.length>0)
    {
         currentItem = @"enterprise";
        [self.viewImageVideoBackground setHidden:NO];
        [self.viewImageHolder setHidden:NO];
        [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:nil];
        [SharedClass showPopupView:self.viewImageHolder];
        self.viewImageHolder.layer.cornerRadius=10;
        
        
        
        [_btnPopupRemoveImage setBackgroundColor:InternalButtonColor];
        [_btnPopupRemoveImage setTitle:[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"REMOVE", @"")] forState:UIControlStateNormal];
        _btnPopupRemoveImage.layer.cornerRadius=17;
        
        
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
                     //imgEnterprisePic.image=[UIImage imageNamed:@"defaultPic.png"];
                 }
             }];
        }
    }
    
}
-(void)btnViewProfilePicAction:(UIButton *)btn
{
    NSString *imgUrl=[Paramsdict valueForKey:@"user_pic"];
    if (imgUrl.length>0)
    {
        currentItem = @"profile";
        [self.viewImageVideoBackground setHidden:NO];
        [self.viewImageHolder setHidden:NO];
        [SharedClass showPopupView:self.viewImageVideoBackground andTabbar:nil];
        [SharedClass showPopupView:self.viewImageHolder];
        self.viewImageHolder.layer.cornerRadius=10;
        
        
        [_btnPopupRemoveImage setBackgroundColor:InternalButtonColor];
        [_btnPopupRemoveImage setTitle:[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"REMOVE", @"")] forState:UIControlStateNormal];
        _btnPopupRemoveImage.layer.cornerRadius=17;
        
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
                     //imgEnterprisePic.image=[UIImage imageNamed:@"defaultPic.png"];
                 }
             }];
        }
    }
    
}

- (IBAction)btnPopupRemoveImage:(id)sender
{
    if ([currentItem isEqualToString:@"profile"])
    {
        [self confirmationAlert:@"profile"];
    }
    else if ([currentItem isEqualToString:@"enterprise"])
    {
        [self confirmationAlert:@"enterprise"];
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

- (IBAction)btnRemoveVideoAction:(id)sender
{
    [self confirmationAlert:@"video"];
}



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
    if ([str isEqualToString:@"profile"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Bonjob" message:NSLocalizedString(@"Do you want to remove profile pic ?", @"") delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [alert show];
    }
    else if ([str isEqualToString:@"enterprise"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Bonjob" message:NSLocalizedString(@"Do you want to remove enterprise pic ?", @"") delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Bonjob" message:NSLocalizedString(@"Do you want to remove Pitch video ?", @"") delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        if ([currentItem isEqualToString:@"profile"])
        {
            [self removePrfilePic];
        }
        else if ([currentItem isEqualToString:@"enterprise"])
        {
            [self removeEnterprise];
        }
        else
        {
            [self removeVideo];
        }
    }
    
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

#pragma mark - ---------LOcation Selection Delgate----------
-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
    lattt=lattitute;
    longg=Longitute;
    [Paramsdict setObject:address forKey:kCity];
    [_tbleditmyprofile reloadData];
}

#pragma mark --------Category button ------

- (IBAction)btncutcategory:(UIButton *)sender
{
    //_viewcategory.hidden = YES;
    //_viewbackground.hidden = YES;
    [SharedClass hidePopupView:_viewbackground];
    [SharedClass hidePopupView:_viewcategory];
    //selectedIndex=-1;
}

#pragma mark --------Salary button------
- (IBAction)btncutsalary:(UIButton *)sender
{
    //_viewsalary.hidden = YES;
    //_viewbackground.hidden = YES;
    [SharedClass hidePopupView:_viewbackground];
    [SharedClass hidePopupView:_viewsalary];
    //selectedIndex=-1;
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
    
    if (actionSheet.tag == 1 ||  actionSheet.tag == 2) {
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
          
   // [self hideTheTabBarWithAnimation:YES];
 //   [self dismissViewControllerAnimated:YES completion:^{
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
        //[self dismissViewControllerAnimated:YES completion:^{
            [self presentViewController:imagePicker animated:YES completion:nil];
       // }];
        
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
        //image
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad  && chosenImage == nil)
        {
           chosenImage = info[UIImagePickerControllerOriginalImage];
        }
        if (isEnterPrisePhoto == NO) {
            imageSelected=YES;
                NSIndexPath *indexpath=[NSIndexPath indexPathForRow:selectedindex inSection:0];
                RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
                imgProfilePic=cell.imgProfilePic;
            
                    cell.imgProfilePic.image=chosenImage;
                    imgProfilePic.image = chosenImage;
                    cell.imgProfilePic.layer.cornerRadius = cell.imgProfilePic.frame.size.width/2;
                    imgProfilePic.clipsToBounds = YES;
                    imageSelected=YES;
                    imgProfileData = UIImageJPEGRepresentation(chosenImage, 0.7);
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
        else{
           
             
                NSIndexPath *indexpath=[NSIndexPath indexPathForRow:selectedindex inSection:0];
                RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
            
                    imgEnterprisePic.image=chosenImage;
                    cell.imgCompanyImage.image = chosenImage;
                    cell.imgCompanyImage.layer.cornerRadius = cell.imgCompanyImage.frame.size.width/2;
                    cell.imgCompanyImage.clipsToBounds = YES;
                    CompanyImageSelected=YES;
                    imgCompanyData = UIImageJPEGRepresentation(chosenImage, 0.7);
            
             [picker dismissViewControllerAnimated:YES completion:^{
                    ImageCropperViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ImageCropperViewController"];
                    vc.selectedImage=chosenImage;
                    vc.delegate=self;
                    [self presentViewController:vc animated:YES completion:nil];
        
            }];
        }
        
    }
    else
    {
    
   //[self hideTheTabBarWithAnimation:NO];
    // This is the NSURL of the video object
    videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    
    NSURL* videoUrl = videoURL;
    NSURL  *newVideoUrl = [[NSURL alloc] initWithString:[videoUrl absoluteString]];
    
    imgPitchVideoData = [NSData dataWithContentsOfFile:[newVideoUrl path]];
    long videoSize= imgPitchVideoData.length/1024.0f/1024.0f;
    
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
    
    if (videoSize<8)
    {
        PitchVideoSelected=YES;
    }
    else
    {
        PitchVideoSelected=NO;
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
    
    imgPitchVideo.image = [[SharedClass sharedInstance]thumbnailFromVideoAtURL:newVideoUrl];
    thumbnailData=UIImagePNGRepresentation(imgPitchVideo.image);
    //imgVideoImg.layer.cornerRadius = 50.0;
    imgPitchVideo.layer.cornerRadius = imgPitchVideo.frame.size.width / 2;
    imgPitchVideo.clipsToBounds = YES;
    NSLog(@"VideoURL = %@", videoURL);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [_tbleditmyprofile reloadData];
    }
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

#pragma mark - ---------Webservice methos for updating Profile Data--------

-(void)getProfilePopUpData
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"ProfilePopUpData";
    [webhelper webserviceHelper:kgetEmpProfileDropdowns showHud:YES];
    
}

- (IBAction)btnSaveProfileAction:(id)sender
{
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:selectedTextField inSection:0];
    RecruiterEditProfileCell *cell=[_tbleditmyprofile cellForRowAtIndexPath:indexpath];
    if (cell.txtFirstName.tag == selectedTextField)
    {
         [cell.txtFirstName resignFirstResponder];
    }
    else if (cell.txtLastName.tag == selectedTextField)
    {
        [cell.txtLastName resignFirstResponder];
    }
    else if (cell.txtCompanyName.tag == selectedTextField)
    {
        [cell.txtCompanyName resignFirstResponder];
    }
    else if (cell.txtLocation.tag == selectedTextField)
    {
       [cell.txtLocation resignFirstResponder];
    }
    else if (cell.txtEnterPriseType.tag == selectedTextField)
    {
         [cell.txtEnterPriseType resignFirstResponder];
    }
    else if (cell.txtSalrie.tag == selectedTextField)
    {
        [cell.txtSalrie resignFirstResponder];
    }
    else if (cell.txtWebsite.tag == selectedTextField)
    {
        [cell.txtWebsite resignFirstResponder];
    }
    
    [Paramsdict setValue:[NSString stringWithFormat:@"%f",lattt] forKey:@"lattitude"];
    [Paramsdict setValue:[NSString stringWithFormat:@"%f",longg] forKey:@"longitude"];
    [Paramsdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"] forKey:@"device_token"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"EditProfile";
    webHelper.delegate=self;
    if (PitchVideoSelected && imageSelected && CompanyImageSelected)
    {
        [webHelper webserviceHelper:Paramsdict uploadData:imgProfileData ImageParam:kRecruiterPic EnterPriseImage:imgCompanyData andVideoData:imgPitchVideoData withVideoThumbnail:thumbnailData  type:@".mp4" webServiceUrl:kRecruiterUpdateProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
    }
    else if (PitchVideoSelected && !imageSelected && !CompanyImageSelected)
    {
        [webHelper webserviceHelper:Paramsdict uploadData:nil ImageParam:kRecruiterPic EnterPriseImage:nil andVideoData:imgPitchVideoData withVideoThumbnail:thumbnailData type:@".mp4" webServiceUrl:kRecruiterUpdateProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
    }
    else if (!PitchVideoSelected && imageSelected && !CompanyImageSelected)
    {
        [webHelper webserviceHelper:Paramsdict uploadData:imgProfileData ImageParam:kRecruiterPic EnterPriseImage:nil andVideoData:nil withVideoThumbnail:nil type:@".mp4" webServiceUrl:kRecruiterUpdateProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
    }
    else if (!PitchVideoSelected && !imageSelected && CompanyImageSelected)
    {
        [webHelper webserviceHelper:Paramsdict uploadData:nil ImageParam:kRecruiterPic EnterPriseImage:imgCompanyData andVideoData:nil withVideoThumbnail:nil type:@".mp4" webServiceUrl:kRecruiterUpdateProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
    }
    else if (!PitchVideoSelected && imageSelected && CompanyImageSelected)
    {
        [webHelper webserviceHelper:Paramsdict uploadData:imgProfileData ImageParam:kRecruiterPic EnterPriseImage:imgCompanyData andVideoData:nil withVideoThumbnail:nil type:@".mp4" webServiceUrl:kRecruiterUpdateProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
    }
    else
    {
        [webHelper webserviceHelper:Paramsdict webServiceUrl:kRecruiterUpdateProfile methodName:@"EditProfile" showHud:YES inWhichViewController:self];
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
    if ([methodNameIs isEqualToString:@"deleteProfileVideo"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            [self.delegate recruiterProfileUpdated];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [SharedClass hidePopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
            [SharedClass hidePopupView:self.viewVideoHolder];
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
            [self.delegate recruiterProfileUpdated];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [SharedClass hidePopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
            [SharedClass hidePopupView:self.viewImageHolder];
        }
        else
        {
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"deleteEnterPic"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            [self.delegate recruiterProfileUpdated];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [SharedClass hidePopupView:self.viewImageVideoBackground andTabbar:self.tabBarController];
            [SharedClass hidePopupView:self.viewImageHolder];
        }
        else
        {
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"EditProfile"])
    {
        if ([[responseDict valueForKey:@"success"] intValue]==1)
        {
            [Alerter.sharedInstance ShowSuccessWithMsg:[responseDict valueForKey:@"msg"]];
            [self.delegate recruiterProfileUpdated];
            [self.navigationController popViewControllerAnimated:YES];
            
            NSMutableDictionary *dict=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] mutableCopy];
            [dict setObject:[Paramsdict valueForKey:kCity] forKey:@"address"];
             [dict setObject:[Paramsdict valueForKey:kEnterPriseName] forKey:@"enterprise_name"];
            [dict setObject:[Paramsdict valueForKey:kFirstName] forKey:@"first_name"];
            [dict setObject:[Paramsdict valueForKey:kLastName] forKey:@"last_name"];
            [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]);
            //[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"address"]
            
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        else
        {
            [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"ProfilePopUpData"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==1)
        {
            for (NSDictionary *dict in [responseDict valueForKey:@"companyCategories"]) {
                
                CompanyCategory_Model *obj = [[CompanyCategory_Model alloc]init];
                [arrCategory addObject:[obj initWithDict:dict]];
            }
            
            for (NSDictionary *dict in [responseDict valueForKey:@"numberOfEmployees"]) {
                
               NumberOfEmpModel  *obj = [[NumberOfEmpModel alloc]init];
                [arrSalary addObject:[obj initWithDict:dict]];
            }
            [_tblcategory reloadData];
             [_tblsalary reloadData];
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

- (IBAction)btnCloseVideoGuidePopupAction:(id)sender
{
    //[[NSUserDefaults standardUserDefaults] valueForKey:@"videopopup"]
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"videopopup"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [SharedClass hidePopupView:self.viewDimBackground andTabbar:nil];
    [SharedClass hidePopupView:self.viewVideoGuidePopup];
}


@end
