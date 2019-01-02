//
//  PaymentRejectViewController.h
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PaymentRejectedDelegate
-(void)openPaymentData;
@end
@interface PaymentRejectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UIButton *btnOpenMail;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchCandidate;
@property (nonatomic,strong)id<PaymentRejectedDelegate>delegate;
- (IBAction)btnSearchCandidateAction:(id)sender;
- (IBAction)btnOpenMailAction:(id)sender;

@end
