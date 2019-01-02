//
//  EditProfileViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/2/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExperienceViewController.h"
#import "ProfileDataModel.h"

typedef enum
{
    EditProfileCommonFormData=0,
    EditProfileLanguageData,
    EditProfileActualStatus,
    EditProfileMobility,
    EditProfileGallery,
    EditProfileSection
} EditProfileSections;

@protocol SeekerProfileUpdatedDelegate<NSObject>
    
-(void)profileUpdated;
    
@end


@interface EditProfileViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,ProcessDataDelegate,EducationLevelDelegate,ExperienceDelegate,LanguageSelectionDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblEditProfile;
@property (weak, nonatomic) IBOutlet UITableView *tblExperience;
@property (weak, nonatomic) IBOutlet UITableView *_tblActivityAreaView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
- (IBAction)btnSaveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblProgress;
@property(nonatomic,strong)id<SeekerProfileUpdatedDelegate>delegate;


@property (weak, nonatomic) IBOutlet UIView *viewImageVideoBackground;
@property (weak, nonatomic) IBOutlet UIView *viewImageHolder;
@property (weak, nonatomic) IBOutlet UIView *viewVideoHolder;
@property (weak, nonatomic) IBOutlet UIView *viewVideoBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imgEnterPriseRecruiter;
- (IBAction)btnCloseImagePreview:(id)sender;
- (IBAction)btnCloseVideoHolderAction:(id)sender;



@end
