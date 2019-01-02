//
//  IntroPopupViewController.h
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IntrroViewDelegate
-(void)gotoMyProfile;
-(void)gotoPostJob;
-(void)openPaymentDataScreen;
-(void)searchCandidate;
@end

@interface IntroPopupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcomeMesg;
@property (weak, nonatomic) IBOutlet UIButton *btnPublishOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchCandidate;
@property (weak, nonatomic) IBOutlet UIButton *btnGotoPayment;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;
@property(nonatomic,strong)id<IntrroViewDelegate>delegate;
//-----------_ACTIONS----------
- (IBAction)btnPublishAction:(id)sender;
- (IBAction)btnSearchCandidateAction:(id)sender;
- (IBAction)btnGotoPaymentAction:(id)sender;
- (IBAction)btnModifyProfileAction:(id)sender;


@end
