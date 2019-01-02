//
//  RecruiterLoginRegistraionViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/19/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecruiterLoginRegistraionViewController : UIViewController<ProcessDataDelegate,UITextFieldDelegate>


{
    // By CS Rai
    BOOL isComingFromMap;
}
//Outlets
@property (weak, nonatomic) IBOutlet UIView *viewLogin;
@property (weak, nonatomic) IBOutlet UIView *viewSIgnup;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnPhotoEnterPrise;
@property (weak, nonatomic) IBOutlet UIButton *btnPitchVideo;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhotoEnterPrise;
@property (weak, nonatomic) IBOutlet UIImageView *imgPitchVideo;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollMain;

@property (weak, nonatomic) IBOutlet UILabel *lblPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblPhotoEnterprise;
@property (weak, nonatomic) IBOutlet UILabel *lblPitchVideo;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtSurName;
@property (weak, nonatomic) IBOutlet UITextField *txtCompanyName;
@property (weak, nonatomic) IBOutlet UITextField *txtLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPhonenumber;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnAcpet;
@property (weak, nonatomic) IBOutlet UILabel *lblTermsConditions;
@property (weak, nonatomic) IBOutlet UIButton *btnSignup;
@property (weak, nonatomic) IBOutlet UITextField *txtLoginEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtLoginPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigation;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic) XMPPManager *xmppManager;
//Actions
- (IBAction)btnForgotPasswordAction:(id)sender;

- (IBAction)segmentSwitch:(id)sender;
- (IBAction)btnSinupAction:(id)sender;
- (IBAction)btnLoginAction:(id)sender;
- (IBAction)btnPhotoAction:(id)sender;
- (IBAction)btnPhotoEnterPriseAction:(id)sender;
- (IBAction)btnVideoAction:(id)sender;
- (IBAction)btnTermsConditionsAction:(id)sender;
- (IBAction)btnTermsAction:(id)sender;
//
@property(nonatomic,assign) int SegmentIndex;
// Outlets for One time Popup (Video Guide)
@property (weak, nonatomic) IBOutlet UIView *viewDimBackground;
@property (weak, nonatomic) IBOutlet UIView *viewVideoGuidePopup;
- (IBAction)btnCloseVideoGuidePopupAction:(id)sender;
@end
