//
//  LookingJobCell.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookingJobCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoader;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIButton *btnApplyJob;
@property (weak, nonatomic) IBOutlet UIView *viewUpDetails;
@property (weak, nonatomic) IBOutlet UIButton *btnVisitCompanyPage;
@property (weak, nonatomic) IBOutlet UIButton *btnMoreInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imgJobImage;
@property (weak, nonatomic) IBOutlet UITextView *txtviewDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblJobLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UIView *viewJobPostDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblNameOfJob;
@property (weak, nonatomic) IBOutlet UILabel *lblContractType;
@property (weak, nonatomic) IBOutlet UILabel *lblExperience;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOfHrs;
@property (weak, nonatomic) IBOutlet UILabel *lblDateOfJob;
@property (weak, nonatomic) IBOutlet UILabel *lblModeOfContact;
@property (weak, nonatomic) IBOutlet UILabel *lblLevelOfEducation;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguages;
@property (weak, nonatomic) IBOutlet UILabel *lblSalry;
//
@property (weak, nonatomic) IBOutlet UILabel *lblNameOfJobValue;
@property (weak, nonatomic) IBOutlet UILabel *lblContractTypeValue;
@property (weak, nonatomic) IBOutlet UILabel *lblExperienceValue;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOfHrsValue;
@property (weak, nonatomic) IBOutlet UILabel *lblDateOfJobValue;
@property (weak, nonatomic) IBOutlet UILabel *lblModeOfContactValue;
@property (weak, nonatomic) IBOutlet UILabel *lblLevelOfEducationValue;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguagesValue;
@property (weak, nonatomic) IBOutlet UILabel *lblSalryValue;
// for image
@property (weak, nonatomic) IBOutlet UIImageView *imgSearch;
@property (weak, nonatomic) IBOutlet UIImageView *imgContract;
@property (weak, nonatomic) IBOutlet UIImageView *imgEducation;
@property (weak, nonatomic) IBOutlet UIImageView *imgExperience;
@property (weak, nonatomic) IBOutlet UIImageView *imgLanguages;
@property (weak, nonatomic) IBOutlet UIImageView *imgNumberofHrs;
@property (weak, nonatomic) IBOutlet UIImageView *imgStartDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgSalry;
@property (weak, nonatomic) IBOutlet UIImageView *imgContact;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSearchLabel;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSearchImage;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSearchLabelValue;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contractHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *educationHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *experienceHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *languageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberofHrsHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *salryHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contactHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeight;
@property (weak, nonatomic) IBOutlet UIView *viewApplyButoonHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblJobDesc;
@property (weak, nonatomic) IBOutlet UIImageView *imgAdvertise;
@property (weak, nonatomic) IBOutlet UIView *viewVideoAdvertise;









-(void)setdata:(NSDictionary *)dict;
@end
