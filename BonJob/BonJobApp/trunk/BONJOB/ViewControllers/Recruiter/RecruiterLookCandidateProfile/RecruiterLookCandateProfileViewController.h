//
//  RecruiterLookCandateProfileViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"


@interface JobCell:UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblJobTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectJob;
@property (weak, nonatomic) IBOutlet UILabel *lblJobLocation;

@end

@interface RecruiterLookCandateProfileViewController : UIViewController<ProcessDataDelegate,UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblCadidate;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *jobTitle;
@property(nonatomic,strong)NSString *apply_id;
@property(nonatomic,strong)NSString *job_id;
@property(nonatomic,strong)NSString *selectedOrAvailable;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property(nonatomic,strong) NSString *identifier;


@property (weak, nonatomic) IBOutlet UIView *viewImageVideoBackground;
@property (weak, nonatomic) IBOutlet UIView *viewVideoBackground;
@property (weak, nonatomic) IBOutlet UIView *viewImageHolder;
@property (weak, nonatomic) IBOutlet UIView *viewVideoHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgEnterPriseRecruiter;
- (IBAction)btnCloseImagePreview:(id)sender;
- (IBAction)btnCloseVideoHolderAction:(id)sender;
// For select a job before selecting the candidate
@property (weak, nonatomic) IBOutlet UITableView *tblRecruiterJobList;
@property (weak, nonatomic) IBOutlet UIView *viewRecruiterJob;
@property (weak, nonatomic) IBOutlet UIView *viewFirstTimeJob;

@property (weak, nonatomic) IBOutlet UIView *viewBackgroundJob;
@property (weak, nonatomic) IBOutlet UILabel *lblJobTitle;
- (IBAction)btnCloseJobPopup:(id)sender;
    @property (weak, nonatomic) IBOutlet UILabel *lblNoJobofferTitle;
    @property (weak, nonatomic) IBOutlet UIButton *btnPublisHNoJob;
    @property (weak, nonatomic) IBOutlet UILabel *lblPostAjobOfferTitle;
    @property (weak, nonatomic) IBOutlet UIView *viewNoJobOffer;
    
- (IBAction)btnPublishNoJobAction:(id)sender;
    
@property (weak, nonatomic) IBOutlet UIButton *btnValidatePopUp1;
@property (weak, nonatomic) IBOutlet UIButton *btnDropDownPopUp1;

@property (weak, nonatomic) IBOutlet UITextField *txtFieldJobTitlePopUp1;
@property (weak, nonatomic) IBOutlet UIButton *btnValidatePopUp2;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldJobTitlePopUp2;
@property (weak, nonatomic) IBOutlet UIButton *btnDropDownPopUp2;


@end
