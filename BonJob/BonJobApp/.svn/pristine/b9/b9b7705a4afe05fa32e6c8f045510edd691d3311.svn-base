//
//  EditProfileViewControllerNew.h
//  BONJOB
//
//  Created by VISHAL SETH on 10/11/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditSeekerProfile:UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnLanguageRemove;

@property (weak, nonatomic) IBOutlet UILabel  *lblLangugageKnown;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectLanguage;
@property (weak, nonatomic) IBOutlet UIButton *btnBeginer;
@property (weak, nonatomic) IBOutlet UIButton *btnIntermedidate;
@property (weak, nonatomic) IBOutlet UIButton *btnAdvanced;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrent;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguageBegineer;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguageIntermediate;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguageAdvanced;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguageCurrent;
@property (weak, nonatomic) IBOutlet UIButton *btnLanguageAdd;
//-------------ACTUAL STATUS------------
@property (weak, nonatomic) IBOutlet UILabel *lblActualStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusStudent;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusApprentice;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusActive;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusJobSeeker;
@property (weak, nonatomic) IBOutlet UIButton *btnStatusInactive;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusStudent;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusApprentice;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusActive;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusJobseeker;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusInactive;
@property (weak, nonatomic) IBOutlet UILabel *lblMobility;
@property (weak, nonatomic) IBOutlet UIButton *btnMobilityYes;
@property (weak, nonatomic) IBOutlet UIButton *btnMobilityNo;
@property (weak, nonatomic) IBOutlet UILabel *lblMobilityYes;
@property (weak, nonatomic) IBOutlet UILabel *lblMobilityNo;

@property (weak, nonatomic) IBOutlet UILabel *lblSkill;
@property (weak, nonatomic) IBOutlet UILabel *lblSkillsCuisine;
@property (weak, nonatomic) IBOutlet UILabel *lblSkillsSalesService;
@property (weak, nonatomic) IBOutlet UILabel *lblSkillsHotels;

@property (weak, nonatomic) IBOutlet UIButton *btnSkillsCuisine;
@property (weak, nonatomic) IBOutlet UIButton *btnSkillsSalesService;
@property (weak, nonatomic) IBOutlet UIButton *btnSkillsHotels;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UILabel *lblGallery;


@end

@protocol UserProfileUpdatedDelegate<NSObject>

-(void)profileUpdated;

@end

@interface EditProfileViewControllerNew : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)id<UserProfileUpdatedDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UITableView *tblEditProfile;
//---------For Video Preview-----------
@property (weak, nonatomic) IBOutlet UIView *viewImageVideoBackground;
@property (weak, nonatomic) IBOutlet UIView *viewImageHolder;
@property (weak, nonatomic) IBOutlet UIView *viewVideoHolder;
@property (weak, nonatomic) IBOutlet UIView *viewVideoBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imgEnterPriseRecruiter;
@property (weak, nonatomic) IBOutlet UIButton *btnRemoveImageFromPopup;
@property (weak, nonatomic) IBOutlet UIButton *btnRemoveVideoFromPopup;
@property (weak, nonatomic) IBOutlet UIButton *btnRemoveVideo;
@property (weak, nonatomic) IBOutlet UIButton *btnRemovePic;



- (IBAction)btnRemoveVideoFromPopup:(id)sender;
- (IBAction)btnRemoveImageFromPopupAction:(id)sender;
- (IBAction)btnCloseImagePreview:(id)sender;
- (IBAction)btnCloseVideoHolderAction:(id)sender;
- (IBAction)btnViewProfileImage:(id)sender;
- (IBAction)btnViewProfileVideo:(id)sender;
//-------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtDateOfBirth;
@property (weak, nonatomic) IBOutlet UITextField *txtCityLOcation;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePic;
@property (weak, nonatomic) IBOutlet UIImageView *imgPitchVideo;
@property (weak, nonatomic) IBOutlet UITextField *txtExperience;
@property (weak, nonatomic) IBOutlet UILabel *lblJobSought;
@property (weak, nonatomic) IBOutlet UILabel *lblLabelofEducationValue;
@property (weak, nonatomic) IBOutlet UITextView *txtviewSpecifyTranning;
@property (weak, nonatomic) IBOutlet UITextView *txtviewAbout;
//Outlets for label text which should be dynamic according to language
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastName;
@property (weak, nonatomic) IBOutlet UILabel *lblDob;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblPitchVideo;
@property (weak, nonatomic) IBOutlet UILabel *lblExperience;
@property (weak, nonatomic) IBOutlet UILabel *lblLevelofEducation;
@property (weak, nonatomic) IBOutlet UILabel *lblSpecifyTranning;
@property (weak, nonatomic) IBOutlet UILabel *lblAbout;
@property (weak, nonatomic) IBOutlet UILabel *lblSpecifyTranningCount;
@property (weak, nonatomic) IBOutlet UILabel *lblSpecifyAboutCount;

// Now Button Action for handle events--------------------------------
- (IBAction)btnEditFirstNameAction:(id)sender;
- (IBAction)btnEditLastNameAction:(id)sender;
- (IBAction)btnDobAction:(id)sender;
- (IBAction)btnLocationCityaction:(id)sender;
- (IBAction)btnCameraProfilePicAction:(id)sender;
- (IBAction)btnPitchVideoAction:(id)sender;
- (IBAction)btnRemoveProfilePicAction:(id)sender;
- (IBAction)btnRemovePitchVideoAction:(id)sender;
- (IBAction)btnExperienceAction:(id)sender;
- (IBAction)btnLevelofEducationAction:(id)sender;
- (IBAction)btnLevelofJobSoughtAction:(id)sender;
- (IBAction)btnUpdateProfileAction:(id)sender;
//For Gallery
@property (strong, nonatomic) IBOutlet UIView *viewbackground;
@property (strong, nonatomic) IBOutlet UIView *viewzoomimage;
@property (strong, nonatomic) IBOutlet UIImageView *imagezoom;
@property (strong, nonatomic) IBOutlet UIButton *btndeletoutlet;
@property (strong, nonatomic) IBOutlet UIImageView *imagechangble;
@property (strong, nonatomic) IBOutlet UITextView *textviewdescription;
// Outlets for One time Popup (Video Guide)
@property (weak, nonatomic) IBOutlet UIButton *btnPitchVideoPlayer;

@property (weak, nonatomic) IBOutlet UIView *viewDimBackground;
@property (weak, nonatomic) IBOutlet UIView *viewVideoGuidePopup;
- (IBAction)btnCloseVideoGuidePopupAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewVideoGuideInternal;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
