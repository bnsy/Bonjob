//
//  PaymentAcceptViewController.h
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PaymentAcceptedDelegate
-(void)openPostJobController;
-(void)openSearchCandidateController;
-(void)openEditProfile;
@end

@interface PaymentAcceptViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UIButton *btnPublish;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchCandidate;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfile;
@property (nonatomic,strong)id<PaymentAcceptedDelegate>delegate;
//-----------------------------
- (IBAction)btnPublishJobAction:(id)sender;
- (IBAction)btnSearchCandidateAction:(id)sender;
- (IBAction)btnEditProfileAction:(id)sender;

@end
