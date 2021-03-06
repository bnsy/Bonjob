//
//  ProfileViewController.m
//  BONJOB
//
//  Created by Infoicon Technologies on 02/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ProfileViewController.h"
#import "TabbarViewController.h"
#import "TabbarViewController.h"
#import "EditProfileViewController.h"
#import "ProfileCell.h"
#import "UIImageView+WebCache.h"
// for video
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AVKit/AVPlayerViewController.h>
#import "EditProfileViewControllerNew.h"

#define PRESENT_VIEW_CONTOLLER(viewController,animation) [self.navigationController presentViewController:viewController animated:animation completion:nil];
@interface ProfileViewController ()<AVAudioPlayerDelegate,UserProfileUpdatedDelegate>
{
    NSMutableDictionary *responseDictinary;
    int counter;
    CGImageRef imageRef;
    AVPlayerViewController *playerViewController;
    
}

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   [_myprofiletableview reloadData];
   _myprofiletableview.separatorColor = [UIColor clearColor];
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"PROFILE", @"")]; //NSLocalizedString(@"PROFILE", @"");
    [[self.tabBarController.tabBar.items objectAtIndex:4] setTitle:NSLocalizedString(@"PROFILE", @"")];
    
    UIButton *btnSettings=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnSettings setImage:[UIImage imageNamed:@"SettingsFilled.png"] forState:UIControlStateNormal];
    [btnSettings addTarget:self action:@selector(btnSettingsAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnBarSettings=[[UIBarButtonItem alloc]initWithCustomView:btnSettings];
    [btnBarSettings setTintColor:InternalButtonColor];
    self.navigationItem.rightBarButtonItem=btnBarSettings;
    [self.viewShowImagePopup setHidden:YES];
    [self.viewShowImage setHidden:YES];
    [self.viewShowVideo setHidden:YES];
    //[self getProfile];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setUserActivity:) name:@"setuseractivity" object:nil];
    _myprofiletableview.rowHeight = UITableViewAutomaticDimension;
    _myprofiletableview.estimatedRowHeight = 180;
    
    
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

-(void)viewWillAppear:(BOOL)animated
{
    UIButton *removebtnforthirdvew = (UIButton *)[self.view viewWithTag:315];
    removebtnforthirdvew.backgroundColor =[UIColor whiteColor];
    removebtnforthirdvew.layer.cornerRadius = 20.0;
    removebtnforthirdvew.layer.borderColor = [UIColor colorWithRed:235.0/255.0 green:84.0/255.0 blue:119.0/255.0 alpha:1.0].CGColor;
    removebtnforthirdvew.layer.borderWidth = 2.0;
    removebtnforthirdvew.hidden = YES;
    [self getProfile];
    
    /*"My profile"                =   "My profile";
    "Location"                  =   "Location";
    "Professional experience"   =   "Professional experience";
    "Training"                  =   "Training";
    "Languages"                 =   "Languages";
    "About"                     =   "About";
    "Status"                    =   "Status";
    "Mobility"                  =   "Mobility";
    "Edit my profile"           =   "Edit my profile"; */
}

#pragma mark - ---------TableView Delegates ----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==2)
    {
        UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, 40)];
        vw.backgroundColor =[UIColor whiteColor];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 250, 40)];
        label.textColor=TitleColor;
        [label setFont:[UIFont systemFontOfSize:22]];
        [label setFont:[UIFont fontWithName:@"LobsterTwo" size:22.0]];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [label setFont:[UIFont systemFontOfSize:27]];
            [label setFont:[UIFont fontWithName:@"LobsterTwo" size:27.0]];
        }
        
        label.text=NSLocalizedString(@"Professional experience", @"");
        [vw addSubview:label];
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 20, 20)];
        img.image=[UIImage imageNamed:@"ListeStyle.png"];
        img.contentMode=UIViewContentModeScaleAspectFit;
        [vw addSubview:img];
        return vw;
    }
    else if (section==4)
    {
        UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, 40)];
        vw.backgroundColor =[UIColor whiteColor];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 250, 40)];
        label.textColor=TitleColor;
        [label setFont:[UIFont systemFontOfSize:22]];
        [label setFont:[UIFont fontWithName:@"LobsterTwo" size:22.0]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [label setFont:[UIFont systemFontOfSize:27]];
            [label setFont:[UIFont fontWithName:@"LobsterTwo" size:27.0]];
        }
        label.text=NSLocalizedString(@"Languages", @"");
        [vw addSubview:label];
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 20, 20)];
        img.image=[UIImage imageNamed:@"GLOBE.png"];
        [vw addSubview:img];
        return vw;

    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2 || section==4)
    {
        return 40;
    }
    else
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2)
    {
        return [[responseDictinary valueForKey:@"experience"] count];
    }
    else if (section==3)
    {
        if ([[responseDictinary valueForKey:@"training"] length]==0 && [[responseDictinary valueForKey:@"education_level_name"] length]==0)
        {
            return 0;
        }
        else
            return 1;
    }
    else if (section==4)
    {
        if([[responseDictinary valueForKey:@"languages"] count]>0)
        {
            return [[responseDictinary valueForKey:@"languages"] count];
        }
        else
            return 0;
    }
    else
    return 1;
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_myprofiletableview)
    {
        if (indexPath.section==0)
        {
            return 145;
        }
        else if (indexPath.section==2)
        {
            if ([[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"] length]>400)
            {
                return 200;
            }
            if ([[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"] length]>300)
            {
                return 170;
            }
            if ([[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"] length]>200)
            {
                return 110;
            }
            else if ([[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"] length]<200 && [[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"] length]>150)
            {
                return 100;
            }
            else if ([[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"] length]<150)
            {
                return 120;
            }
            else
            return 80;
        }
        else if (indexPath.section==3)
        {
            if ([[responseDictinary valueForKey:@"training"] length]>98)
            {
                return 170;
            }
            else if ([[responseDictinary valueForKey:@"training"] length]>50 && [[responseDictinary valueForKey:@"training"] length]<98)
            {
                return 130;
            }
            else if ([[responseDictinary valueForKey:@"training"] length]>30 && [[responseDictinary valueForKey:@"training"] length]<50)
            {
                return 100;
            }
            else
            return 80;
        }
        else if (indexPath.section==4)
        {
            
            return 40;
        }
        else if (indexPath.section==5)
        {
            if ([[responseDictinary valueForKey:@"about"] length]>198)
            {
                return 175;
            }
            else if ([[responseDictinary valueForKey:@"about"] length]>150 && [[responseDictinary valueForKey:@"about"] length]<198)
            {
                return 155;
            }
            else if ([[responseDictinary valueForKey:@"about"] length]>50 && [[responseDictinary valueForKey:@"about"] length]<100)
            {
                return 110;
            }
            else if ([[responseDictinary valueForKey:@"about"] length]>30 && [[responseDictinary valueForKey:@"about"] length]<50)
            {
                return 90;
            }
            else
                return 70;
        }
        else
        {
            return 66;
        }
    }
    else
        return 71;
}
 */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCell *cell;
    if (indexPath.section==0)
    {
        cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell0"]];
        if (!cell)
        {
            cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell0"]];
        }
        [cell.btnPlayVideo addTarget:self action:@selector(btnPlayVideoAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnShowImage addTarget:self action:@selector(btnShowImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSingleItem addTarget:self action:@selector(btnSingleItemAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString *videoUrl=[responseDictinary valueForKey:@"patch_video"];
        NSString *imgUrl=[responseDictinary valueForKey:@"user_pic"];
        
        NSString  *videourl=[responseDictinary valueForKey:@"patch_video_thumbnail"];
        
        if (videoUrl.length>0 && imgUrl.length>0)
        {
            [cell.viewSingleItem setHidden:YES];
            [cell.viewPicVideoHolder setHidden:NO];
            [cell.imgVideoIcon sd_setImageWithURL:[NSURL URLWithString:videourl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 if(error)
                 {
                     [cell.imgVideoIcon setImage:[UIImage imageNamed:@"defaultPIC.png"]];
                     
                 }
                 cell.imgVideoIcon.layer.cornerRadius=cell.imgVideoIcon.frame.size.width/2;           cell.imgVideoIcon.clipsToBounds=YES;
                 
             }];
        
            if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
            {
                UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
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
                         UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
                         [imageIndicator stopAnimating];
                         [SharedClass showToast:self toastMsg:error.localizedDescription];
                         cell.imgProfilePic.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                     }
                 }];
                
        
            }
            else
            {
                UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
                [imageIndicator stopAnimating];
                cell.imgProfilePic.image=[UIImage imageNamed:@"default_photo_deactive.png"];
            }
        }
        else
        {
            [cell.viewSingleItem setHidden:NO];
            [cell.viewPicVideoHolder setHidden:YES];
            // for single item
            if (videoUrl.length>0)
            {
                
                
                
                [cell.imgVideoIcon sd_setImageWithURL:[NSURL URLWithString:videourl] placeholderImage:[UIImage imageNamed:@"defaultPic.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                 {
                
//                [cell.imgVideoIcon sd_setImageWithURL:[NSURL URLWithString:videourl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//                 {
                     if(error)
                     {
                         [cell.imgSingleItem setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
                         
                     }
                     cell.imgSingleItem.layer.cornerRadius=cell.imgSingleItem.frame.size.width/2;           cell.imgSingleItem.clipsToBounds=YES;
                     
                 }];
            }
            else if (imgUrl.length>0)
            {
                UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
                [imageIndicator startAnimating];
                UIImageView *Profile_Image=cell.imgSingleItem;
                __weak UIImageView *weakImageView = Profile_Image;
                
                [cell.imgSingleItem sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                 {
                
                
//                [cell.imgSingleItem sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//                 {
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
                         UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
                         [imageIndicator stopAnimating];
                         [SharedClass showToast:self toastMsg:error.localizedDescription];
                         cell.imgSingleItem.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                     }
                 }];
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
           cell.lblLocationValue.text=[responseDictinary valueForKey:@"city"];
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
        
       if(![[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"experience"] isEqualToString:@"1"])
       {
         
        NSString *companyName=[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"company_name"];
        NSString *exp=[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"experience"];
        NSString *year;
        
        if ([exp intValue] - 1 ==0)
        {
            year=NSLocalizedString(@"None", @"");
        }
        else if ([exp intValue] - 1 >0 && [exp intValue] - 1 <2)
        {
            year=NSLocalizedString(@"< 1 year", @"");
        }
        else if ([exp intValue] - 1>1 && [exp intValue]- 1 <3)
        {
            year=NSLocalizedString(@"1-2 years", @"");
        }
        else if ([exp intValue]- 1 >2 && [exp intValue]- 1 <4)
        {
            year=NSLocalizedString(@"3-4 years", @"");
        }

        else if ([exp intValue]- 1 >3 && [exp intValue]- 1 <5)
        {
            year=NSLocalizedString(@"5 years+", @"");
        }
         //  cell.lblCompanyName.text  = @"dsgdfdfghdfgdf";
        if ([exp intValue]- 1 >0)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *strCompanyName=[NSString stringWithFormat:@"%@ %@",companyName,year];

                NSMutableAttributedString *attributed=[[NSMutableAttributedString alloc]initWithString:strCompanyName];
                //        cell.lblCompanyName.attributedText=attributed;
                
                cell.lblCompanyName.attributedText=attributed;
            });
            
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *strCompanyName=[NSString stringWithFormat:@"%@ %@",companyName,year];
                
                NSMutableAttributedString *attributed=[[NSMutableAttributedString alloc]initWithString:strCompanyName];
                
                cell.lblCompanyName.attributedText=attributed;
            });
        }
          cell.lblProfessionalExpValue.text=[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"position_held_name"];
//        NSString *strCompanyName=cell.lblCompanyName.text;
//
//        NSMutableAttributedString *attributed=[[NSMutableAttributedString alloc]initWithString:strCompanyName];
//        cell.lblCompanyName.attributedText=attributed;
        
        cell.txtViewExpDescription.text=[[[responseDictinary valueForKey:@"experience"] objectAtIndex:indexPath.row] valueForKey:@"description"];
       }
        else
        {
             cell.lblProfessionalExpValue.text = NSLocalizedString(@"No Company added" ,@"");
            cell.lblCompanyName.text = @"";
            cell.txtViewExpDescription.text = @"";
        }
    }
    else if (indexPath.section==3)
    {
        cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell2"]];
        if (!cell)
        {
            cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell2"]];
        }
        if ([responseDictinary valueForKey:@"education_level_name"]!=nil && [[responseDictinary valueForKey:@"education_level_name"] length]!=0)
        {
        if ([responseDictinary valueForKey:@"training"]!=nil && [[responseDictinary valueForKey:@"training"] length]!=0)
        {
        
        cell.lblTranningValue.text= [NSString stringWithFormat:@"%@ - %@",[responseDictinary valueForKey:@"education_level_name"],[responseDictinary valueForKey:@"training"]] ;
      cell.lblTranningValue.lineBreakMode=NSLineBreakByWordWrapping;
        }
            else
            {
              cell.lblTranningValue.text= [NSString stringWithFormat:@"%@",[responseDictinary valueForKey:@"education_level_name"]] ;
            }
        }
        else if ([responseDictinary valueForKey:@"training"]!=nil && [[responseDictinary valueForKey:@"training"] length]!=0)
        {
            cell.lblTranningValue.text= [NSString stringWithFormat:@"%@",[responseDictinary valueForKey:@"training"]] ;
            cell.lblTranningValue.lineBreakMode=NSLineBreakByWordWrapping;
        }
        
    }
    else if (indexPath.section==4)
    {
        cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"CellLang"]];
        if (!cell)
        {
            cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"CellLang"]];
        }
        cell.lblLanguageValue.text=[[[responseDictinary valueForKey:@"languages"] objectAtIndex:indexPath.row] valueForKey:@"seeker_lang"];
        cell.lblLangProf.text=[[[responseDictinary valueForKey:@"languages"] objectAtIndex:indexPath.row] valueForKey:@"lang_proficiency_name"];
        
        [cell.lblLanguageValue setFont:[UIFont systemFontOfSize:19]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [cell.lblLanguageValue setFont:[UIFont systemFontOfSize:24]];
        }
        //[cell.lblLangProf setFont:[UIFont systemFontOfSize:19]];
        //cell.lblLangProf.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
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
            cell.lblAboutValue.text=[responseDictinary valueForKey:@"about"];
//            if (cell.lblAboutValue.text.length>190)
//            {
//                cell.lblAboutValue.translatesAutoresizingMaskIntoConstraints=YES;
//                CGRect frame=cell.lblAboutValue.frame;
//                frame.size.height=150;
//                cell.lblAboutValue.frame=frame;
//            }
//            else if (cell.lblAboutValue.text.length>150 && cell.lblAboutValue.text.length<190)
//            {
//                cell.lblAboutValue.translatesAutoresizingMaskIntoConstraints=YES;
//                CGRect frame=cell.lblAboutValue.frame;
////                frame.origin.y=38;
//                frame.size.height=120;
//                cell.lblAboutValue.frame=frame;
//            }
//            else if (cell.lblAboutValue.text.length>100 && cell.lblAboutValue.text.length<150)
//            {
//                cell.lblAboutValue.translatesAutoresizingMaskIntoConstraints=YES;
//                CGRect frame=cell.lblAboutValue.frame;
//                frame.size.height=100;
//                cell.lblAboutValue.frame=frame;
//            }
//            else if (cell.lblAboutValue.text.length>50 && cell.lblAboutValue.text.length<100)
//            {
//                cell.lblAboutValue.translatesAutoresizingMaskIntoConstraints=YES;
//                CGRect frame=cell.lblAboutValue.frame;
//                frame.size.height=80;
//                cell.lblAboutValue.frame=frame;
//            }
//            else if (cell.lblAboutValue.text.length>30 && cell.lblAboutValue.text.length<50)
//            {
//                cell.lblAboutValue.translatesAutoresizingMaskIntoConstraints=YES;
//                CGRect frame=cell.lblAboutValue.frame;
//                frame.size.height=65;
//                cell.lblAboutValue.frame=frame;
//            }
            
        }
    }
    else if (indexPath.section==6)
    {
        cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell4"]];
        if (!cell)
        {
            cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell4"]];
        }
        if ([responseDictinary valueForKey:@"current_status_name"]!=nil)
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
        if ([responseDictinary valueForKey:@"mobility_name"]==nil ||[responseDictinary valueForKey:@"mobility_name"]==[NSNull null])
        {
            
        }
        else
        {
            cell.lblMobilityValue.text=[responseDictinary valueForKey:@"mobility_name"];
        }
    }
    else if (indexPath.section==8)
    {
        cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"CellCompetence"]];
        if (!cell)
        {
            cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"CellCompetence"]];
        }
        if ([responseDictinary valueForKey:@"skills_name"]==nil ||[responseDictinary valueForKey:@"skills_name"]==[NSNull null])
        {
            
        }
        else
        {
            cell.lblCompetenceValue.text=[responseDictinary valueForKey:@"skills_name"];
        }
    }
    else if (indexPath.section==9)
    {
        cell=(ProfileCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell6"]];
        if (!cell)
        {
            cell=[[ProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell6"]];
        }
    }
        [cell setupAppereance];

        cell.lblUserName.text=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[responseDictinary valueForKey:@"first_name"],[responseDictinary valueForKey:@"last_name"]]];
        // actions
        //[cell.btnPlayVideo addTarget:self action:@selector(playPitchVideo:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ---------Button Action----------------

-(void)btnPlayVideoAction:(UIButton *)button
{
    self.viewShowVideo.layer.cornerRadius=10;
    self.viewShowVideo.clipsToBounds=YES;
    [self.viewShowImage setHidden:NO];
    [self.viewShowVideo setHidden:NO];
    [SharedClass showPopupView:self.viewShowImage andTabbar:self.tabBarController];
    [SharedClass showPopupView:self.viewShowVideo];
    NSString *videoUrl=[responseDictinary valueForKey:@"patch_video"];
    NSURL *myVideoUrl=[NSURL URLWithString:videoUrl];

    
    
    playerViewController = [[AVPlayerViewController alloc] init];
    AVURLAsset *asset = [AVURLAsset assetWithURL: myVideoUrl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
    
    AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
    playerViewController.player = player;
    [playerViewController.view setFrame:CGRectMake(0, 0, _viewShowVideo.frame.size.width, _viewShowVideo.frame.size.height)];
    
    playerViewController.showsPlaybackControls = YES;
    
    [_viewAvplayerHolder addSubview:playerViewController.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidExit:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[player currentItem]];
}

- (void)itemDidFinishPlaying:(NSNotification *)notification {
    AVPlayerItem *player = [notification object];
    [player seekToTime:kCMTimeZero];
}

- (void)itemDidExit:(NSNotification *)notification
{
    AVPlayerItem *player = [notification object];
    [playerViewController.view setFrame:CGRectMake(0, 0, _viewShowVideo.frame.size.width, _viewShowVideo.frame.size.height)];
    playerViewController.showsPlaybackControls = NO;
    [_viewAvplayerHolder addSubview:playerViewController.view];
}
    

-(void)btnShowImageAction:(UIButton *)button
{
    [self.viewShowImagePopup setHidden:NO];
    [self.viewShowImage setHidden:NO];
    [SharedClass showPopupView:self.viewShowImage andTabbar:self.tabBarController];
    [SharedClass showPopupView:self.viewShowImagePopup];
    self.viewShowImagePopup.layer.cornerRadius=10;
    NSString *imgUrl=[responseDictinary valueForKey:@"user_pic"];
    if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
    {
        UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
        [imageIndicator startAnimating];
        UIImageView *Profile_Image=_imgPoupUserPic;
        __weak UIImageView *weakImageView = Profile_Image;
        [_imgPoupUserPic sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if (!error)
             {
                 weakImageView.alpha = 0.0;
                 weakImageView.image = image;
                 [UIView animateWithDuration:0.3
                                  animations:^
                  {
                      weakImageView.alpha = 1.0;
                      _imgPoupUserPic.layer.cornerRadius = 10;
                      _imgPoupUserPic.clipsToBounds = YES;
                      [imageIndicator stopAnimating];
                  }];
             }
             else
             {
                 UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
                 [imageIndicator stopAnimating];
                 [SharedClass showToast:self toastMsg:error.localizedDescription];
                 _imgPoupUserPic.image=[UIImage imageNamed:@"default_photo_deactive.png"];
             }
         }];
    }
}

-(void)btnSingleItemAction:(UIButton *)sender
{
    NSString *videoUrl=[responseDictinary valueForKey:@"patch_video"];
    NSString *imgUrl=[responseDictinary valueForKey:@"user_pic"];
    if (videoUrl.length>0)
    {
        self.viewShowVideo.layer.cornerRadius=10;
        self.viewShowVideo.clipsToBounds=YES;
        [self.viewShowImage setHidden:NO];
        [self.viewShowVideo setHidden:NO];
        [SharedClass showPopupView:self.viewShowImage andTabbar:self.tabBarController];
        [SharedClass showPopupView:self.viewShowVideo];
        NSString *videoUrl=[responseDictinary valueForKey:@"patch_video"];
        NSURL *myVideoUrl=[NSURL URLWithString:videoUrl];
        
        
        playerViewController = [[AVPlayerViewController alloc] init];
        AVURLAsset *asset = [AVURLAsset assetWithURL: myVideoUrl];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
        
        AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
        playerViewController.player = player;
        [playerViewController.view setFrame:CGRectMake(0, 0, _viewShowVideo.frame.size.width, _viewShowVideo.frame.size.height)];
        
        playerViewController.showsPlaybackControls = YES;
        
        [_viewAvplayerHolder addSubview:playerViewController.view];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidExit:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:[player currentItem]];
    }
    else if (imgUrl.length>0)
    {
        [self.viewShowImagePopup setHidden:NO];
        [self.viewShowImage setHidden:NO];
        [SharedClass showPopupView:self.viewShowImage andTabbar:self.tabBarController];
        [SharedClass showPopupView:self.viewShowImagePopup];
        self.viewShowImagePopup.layer.cornerRadius=10;
        NSString *imgUrl=[responseDictinary valueForKey:@"user_pic"];
        if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
        {
            UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
            [imageIndicator startAnimating];
            UIImageView *Profile_Image=_imgPoupUserPic;
            __weak UIImageView *weakImageView = Profile_Image;
            [_imgPoupUserPic sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
             {
                 if (!error)
                 {
                     weakImageView.alpha = 0.0;
                     weakImageView.image = image;
                     [UIView animateWithDuration:0.3
                                      animations:^
                      {
                          weakImageView.alpha = 1.0;
                          _imgPoupUserPic.layer.cornerRadius = 10;
                          _imgPoupUserPic.clipsToBounds = YES;
                          [imageIndicator stopAnimating];
                      }];
                 }
                 else
                 {
                     UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
                     [imageIndicator stopAnimating];
                     [SharedClass showToast:self toastMsg:error.localizedDescription];
                     _imgPoupUserPic.image=[UIImage imageNamed:@"default_photo_deactive.png"];
                 }
             }];
        }
    }
    else
    {
        
    }
}


- (IBAction)btnPauseVideoActiones:(id)sender
{
    [playerViewController.player pause];
}

- (IBAction)btnFullScreenVideoACtiones:(id)sender
{
    playerViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:playerViewController animated:NO completion:^{
        UIButton *doneButton = [self findButtonOnView:playerViewController.view withText:@"Done"];
        [doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        
        playerViewController.showsPlaybackControls = YES;
    }];
    
//    [self presentViewController:playerViewController animated:YES completion:nil];
//    playerViewController.showsPlaybackControls = YES;
}

-(void)doneAction:(UIButton *)btn
{
    
}

- (UIButton*)findButtonOnView:(UIView*)view withText:(NSString*)text
{
    __block UIButton *retButton = nil;
    
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)obj;
            if([button.titleLabel.text isEqualToString:text]) {
                retButton = button;
                *stop = YES;
            }
        }
        else if([obj isKindOfClass:[UIView class]]) {
            retButton = [self findButtonOnView:obj withText:text];
            
            if(retButton) {
                *stop = YES;
            }
        }
    }];
    
    return retButton;
}

- (IBAction)btnPlayVideoActiones:(id)sender
{
    //[player play];
    [playerViewController.player play];
}

- (IBAction)btnCloseImagePopupAction:(id)sender
{
    [SharedClass hidePopupView:self.viewShowImage  andTabbar:self.tabBarController];
    [SharedClass hidePopupView:self.viewShowImagePopup];
}

- (IBAction)btnCloseVideoPopup:(id)sender
{
    [SharedClass hidePopupView:self.viewShowImage  andTabbar:self.tabBarController];
    [SharedClass hidePopupView:self.viewShowVideo];
}

- (IBAction)editmyprofileaction:(id)sender
{
//    EditProfileViewController *edvc=[self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
//    edvc.delegate=self;
//    [self.navigationController pushViewController:edvc animated:YES];
    
        EditProfileViewControllerNew *edvc=[self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewControllerNew"];
        //edvc.delegate=self;
        [self.navigationController pushViewController:edvc animated:YES];

}

-(void)profileUpdated
{
    [self getProfile];
}

#pragma mark - -----Get Profile WebServices------

-(void)getProfile
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"getProfile";
    webHelper.delegate=self;
    [webHelper webserviceHelper:params webServiceUrl:kGetProfile methodName:@"getProfile" showHud:YES inWhichViewController:self];
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
           // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
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
    if ([methodNameIs isEqualToString:@"getProfile"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==1)
        {
            [_viewBackground setHidden:YES];
            responseDictinary=[[NSMutableDictionary alloc]init];
            responseDictinary=[responseDict valueForKey:@"data"];
            //NSURL *videoUrl=[NSURL URLWithString:[responseDictinary valueForKey:@"patch_video"]];
            //[self setThumbnailsForVideo:videoUrl andImage:[responseDictinary valueForKey:@"user_pic"]];
            responseDictinary=[self validateDict:responseDictinary];
            [[ProfileDataModel getModel]setResponseDict:[self validateDict:responseDictinary]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                     [_myprofiletableview reloadData];
                });
            });
           
            //[self.myprofiletableview reloadData];
        }
        else
        {
            [Alerter.sharedInstance showWarningWithMsg:[responseDict valueForKey:@"msg"]];
            [_viewBackground setHidden:NO];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}


-(NSMutableDictionary *)validateDict:(NSMutableDictionary *)dict
{
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
    tempDict=[dict mutableCopy];
    for (NSString *key in dict)
    {
        if ([[tempDict valueForKey:key]isKindOfClass:[NSNull class]])
        {
            [tempDict setValue:@"" forKey:key];
        }
    }
    return tempDict;
}

-(void)setData
{
    
}

-(void)setThumbnailsForVideo:(NSURL *)videoUrl andImage:(NSString *)imgUrl
{
    
    if ([videoUrl.lastPathComponent containsString:@".mp4"])
    {
        dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(q, ^{
            
            AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:videoUrl options:nil];
            AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            generator.appliesPreferredTrackTransform=TRUE;
            CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
            
            
            
            AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
            {
                if (result != AVAssetImageGeneratorSucceeded)
                {
                    NSLog(@"couldn't generate thumbnail, error:%@", error);
                    UIActivityIndicatorView *VideoIndicator=[_myprofiletableview viewWithTag:9002];
                    [VideoIndicator stopAnimating];
                }
                else
                {
                    if (!error)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // code here
                            UIActivityIndicatorView *VideoIndicator=[_myprofiletableview viewWithTag:9002];
                            UIImageView *pitch_video=[_myprofiletableview viewWithTag:10000];
                            __weak UIImageView *weakImageVideoView = pitch_video;
                            [VideoIndicator startAnimating];
                            //__strong UIImage *img=[UIImage imageWithCGImage:im];
                            if (im)
                            {
                                @try
                                {
                                    pitch_video.image=[UIImage imageWithCGImage:im];
                                }
                                @catch(NSException *e)
                                {
                                    NSLog(@"Exception=%@",e);
                                }
                            }
                            
                            pitch_video.layer.cornerRadius = pitch_video.frame.size.width / 2;
                            pitch_video.clipsToBounds = YES;
                            weakImageVideoView.alpha = 0.0;
                            weakImageVideoView.image = [UIImage imageWithCGImage:im];
                            [UIView animateWithDuration:0.3
                                             animations:^
                             {
                                 weakImageVideoView.alpha = 1.0;
                                 //[self.imgLoaderIndicator stopAnimating];
                             }];
                            [VideoIndicator stopAnimating];
                            
                        });
                    }
                    else
                    {
                        UIImageView *pitch_video=[_myprofiletableview viewWithTag:10000];
                        [SharedClass showToast:self toastMsg:error.localizedDescription];
                        pitch_video.image=[UIImage imageNamed:@"play_icon_deactive.png"];
                    }
                    
                }
                // TODO Do something with the image
            };
            
            CGSize maxSize = CGSizeMake(128, 128);
            generator.maximumSize = maxSize;
            [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
            dispatch_async(dispatch_get_main_queue(), ^{
                //cell.imgPitchVideo.image=[UIImage imageWithCGImage:imageg];
            });
        });
    }
    
    
    
//    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:videoUrl options:nil];
//    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//    generator.appliesPreferredTrackTransform=TRUE;
//
//    CMTime thumbTime = CMTimeMakeWithSeconds(1,1);
//
//    UIImageView *pitch_video=[_myprofiletableview viewWithTag:10000];
//     __weak UIImageView *weakImageVideoView = pitch_video;
//    UIActivityIndicatorView *VideoIndicator=[_myprofiletableview viewWithTag:9002];
//    [VideoIndicator startAnimating];
//    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
//    {
//        if (result != AVAssetImageGeneratorSucceeded)
//        {
//            NSLog(@"couldn't generate thumbnail, error:%@", error);
//            [VideoIndicator stopAnimating];
//        }
//        else
//        {
//            if (!error)
//            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    // code here
//                    __strong UIImage *img=[UIImage imageWithCGImage:im];
//                    pitch_video.image=img;
//                    pitch_video.layer.cornerRadius = pitch_video.frame.size.width / 2;
//                    pitch_video.clipsToBounds = YES;
//
//                    weakImageVideoView.alpha = 0.0;
//                    weakImageVideoView.image = img;
//                    [UIView animateWithDuration:0.3
//                                     animations:^
//                     {
//                         weakImageVideoView.alpha = 1.0;
//                         //[self.imgLoaderIndicator stopAnimating];
//                     }];
//                    [VideoIndicator stopAnimating];
//
//                });
//            }
//            else
//            {
//                [SharedClass showToast:self toastMsg:error.localizedDescription];
//                pitch_video.image=[UIImage imageNamed:@"play_icon_deactive.png"];
//            }
//
//        }
//        // TODO Do something with the image
//    };
//
//    CGSize maxSize = CGSizeMake(128, 128);
//    generator.maximumSize = maxSize;
//    [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
    
    if (imgUrl.length>0 && ([[imgUrl lastPathComponent]containsString:@".png"] || [[imgUrl lastPathComponent] containsString:@".jpg"]))
    {
        UIActivityIndicatorView *imageIndicator=[_myprofiletableview viewWithTag:9001];
        [imageIndicator startAnimating];
        UIImageView *Profile_Image=[_myprofiletableview viewWithTag:9999];
        __weak UIImageView *weakImageView = Profile_Image;
        [Profile_Image sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if (!error)
             {
                 weakImageView.alpha = 0.0;
                 weakImageView.image = image;
                 [UIView animateWithDuration:0.3
                                  animations:^
                  {
                      weakImageView.alpha = 1.0;
                      Profile_Image.layer.cornerRadius = Profile_Image.frame.size.width / 2;
                      Profile_Image.clipsToBounds = YES;
                      [imageIndicator stopAnimating];
                  }];
             }
             else
             {
                 [SharedClass showToast:self toastMsg:error.localizedDescription];
                 Profile_Image.image=[UIImage imageNamed:@"default_photo_deactive.png"];
             }
             
             
         }];
    }
    else
    {
        UIImageView *Profile_Image=[_myprofiletableview viewWithTag:9999];
        Profile_Image.image=[UIImage imageNamed:@"default_photo_deactive.png"];
    }
    
}


#pragma mark  ---------Text  Delegates ----------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;  // Hide both keyboard and blinking cursor.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    UITextField *label23 = (UITextField *)[self.view viewWithTag:23];
    UITextField *label25 = (UITextField *)[self.view viewWithTag:25];
    UITextField *textfield311 = (UITextField *)[self.view viewWithTag:311];
    if(textField==label23)
    {
    [label23 resignFirstResponder];
    return YES;
    }
    else if(textField==label25)
    {
    [label25 resignFirstResponder];
    return YES;
    }
    else
    {
    [textfield311 resignFirstResponder];
    if([textfield311.text isEqualToString: @"" ])
    {
    textfield311.text = @"Company name";
    textfield311.textColor =[UIColor colorWithRed:83.0/255.0 green:180.0/255.0 blue:227.0/255.0 alpha:1.0];
    }
    return YES;
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    UITextView *label38 = (UITextView *)[self.view viewWithTag:38];
    UITextView *label40 = (UITextView *)[self.view viewWithTag:40];
    UILabel *label59 = (UILabel *)[self.view viewWithTag:59];
    UILabel *label60 = (UILabel *)[self.view viewWithTag:60];
    UILabel *label316 = (UILabel *)[self.view viewWithTag:316];
    UITextView *textview313 = (UITextView *)[self.view viewWithTag:313];
    if(textView==label38)
    {
    NSUInteger len = label38.text.length;
    label59.text  = [NSString stringWithFormat:@"%lu/100", len];
    }
    else if(textView==label40)
    {
    NSUInteger len = label40.text.length;
    label60.text  = [NSString stringWithFormat:@"%lu/200", len];
    }
    else
    {
    NSUInteger len = textview313.text.length;
    label316.text  = [NSString stringWithFormat:@"%lu/200", len];
    }
}


- (void)btnSettingsAction:(id)sender
{
    SettingsViewController *edvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [self.navigationController pushViewController:edvc animated:YES];
}
@end
