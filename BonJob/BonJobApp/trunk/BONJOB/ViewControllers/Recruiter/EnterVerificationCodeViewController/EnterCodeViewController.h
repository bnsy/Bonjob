//
//  EnterCodeViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/10/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnResendCode;
@property (weak, nonatomic) IBOutlet UITextField *txtEnterCodeHere;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
// POPUP PROPERTY
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UILabel *lblPopupMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblPopupSuccess;
@property (weak, nonatomic) IBOutlet UIButton *btnViewMyOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnViewMyProfile;
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;
@property (weak, nonatomic) IBOutlet UIView *viewTxtFieldHolder;
@property (strong, nonatomic) NSString *strNumber;
//--------------
- (IBAction)btnCancelAction:(id)sender;
- (IBAction)btnConfirmAction:(id)sender;
// POPUP ACTIONS
- (IBAction)btnViewMyOfferAction:(id)sender;
- (IBAction)btnViewMYProfile:(id)sender;

@end
