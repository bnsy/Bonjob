//
//  SettingsViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/6/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,ProcessDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblReceiveNotification;
@property (weak, nonatomic) IBOutlet UILabel *lblReceiveEmails;
@property (weak, nonatomic) IBOutlet UILabel *lblGiveOpinion;
@property (weak, nonatomic) IBOutlet UILabel *lblTerms;
@property (weak, nonatomic) IBOutlet UILabel *lblFaq;
@property (weak, nonatomic) IBOutlet UIButton *btnsave;
@property (weak, nonatomic) IBOutlet UISwitch *switchEmail;
@property (weak, nonatomic) IBOutlet UISwitch *switchNotification;

- (IBAction)btnGiveOpinionAction:(id)sender;
- (IBAction)switchEmailAction:(id)sender;
- (IBAction)switchNotificationAction:(id)sender;
- (IBAction)btnSaveAction:(id)sender;
- (IBAction)btnFaqAction:(id)sender;
- (IBAction)btnLegalTermsAction:(id)sender;
- (IBAction)btnSubscriptionAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnGiveOpinionAction;
@property (weak, nonatomic) IBOutlet UILabel *lblSubscription;
@property (weak, nonatomic) IBOutlet UIImageView *imgSubscription;
@property (weak, nonatomic) IBOutlet UIButton *btnSubscription;

@end
