//
//  RecruiterFilterCandidateVC.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DimplomaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectEducation;
@end



@protocol appliedFilterProtocol <NSObject>

-(void)showProgress;

@end


@interface RecruiterFilterCandidateVC : UIViewController<locationSelectedDelegate,UITextFieldDelegate>
@property(nonatomic,strong)id<appliedFilterProtocol> delegate;
@property (weak, nonatomic) IBOutlet UITableView *mainTblView;

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblLocationOfCandidate;
@property (weak, nonatomic) IBOutlet UILabel *lblChooseCategory;

@property (weak, nonatomic) IBOutlet UIButton *btnFind;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIView *viewBackgroundPopup;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UITableView *tblEducation;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIView *viewTxtFieldHolder;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UILabel *lblPopupTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imgCompetences;
@property (weak, nonatomic) IBOutlet UILabel *lblCompetences;
@property (weak, nonatomic) IBOutlet UIImageView *imgDiploma;
@property (weak, nonatomic) IBOutlet UILabel *lblDiploma;
@property (weak, nonatomic) IBOutlet UIImageView *imgExp;
@property (weak, nonatomic) IBOutlet UILabel *lblExp;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgMobility;
@property (weak, nonatomic) IBOutlet UILabel *lblMobility;
@property (weak, nonatomic) IBOutlet UIImageView *imgGlobe;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguage;

- (IBAction)btnLocationAction:(id)sender;
- (IBAction)btnCompetencesAction:(id)sender;
- (IBAction)btnDiplomaAction:(id)sender;
- (IBAction)btnExperinceAction:(id)sender;
- (IBAction)btnStatusActualAction:(id)sender;
- (IBAction)btnMobilityAction:(id)sender;
- (IBAction)btnLanguagesAction:(id)sender;



- (IBAction)btnFindAction:(id)sender;
- (IBAction)btnCancelTapped:(id)sender;
- (IBAction)btnClosePopupAction:(id)sender;

@end
