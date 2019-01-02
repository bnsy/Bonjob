//
//  RecruiterConfirmViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/1/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecruiterConfirmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnImRecruiter;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnRecruiteCandidate;
//Actions
- (IBAction)btnImRecruiterAction:(id)sender;
- (IBAction)btnCancelAction:(id)sender;
- (IBAction)btnRecruitaCandidate:(id)sender;

@end
