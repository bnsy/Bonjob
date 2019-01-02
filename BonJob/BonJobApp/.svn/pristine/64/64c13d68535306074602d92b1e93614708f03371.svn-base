//
//  PaymentDetailsViewController.h
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

@protocol PaymentSuccessDelegate

-(void)paymentDone:(BOOL)value;
@end


#import <UIKit/UIKit.h>
@interface PaymentDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnClosePopup;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalHtPlaceHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblHtPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTTCPrice;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEnterPrise;
@property (weak, nonatomic) IBOutlet UITextField *txtPpstalCode;
@property (weak, nonatomic) IBOutlet UITextField *txtVill;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtCardNo;
@property (weak, nonatomic) IBOutlet UITextField *txtExpiry;
@property (weak, nonatomic) IBOutlet UITextField *txtCvvCode;
@property (weak, nonatomic) IBOutlet UIButton *btnPayment;
@property (weak, nonatomic) IBOutlet UILabel *lblPaymentType;
@property (nonatomic,strong)id<PaymentSuccessDelegate>delegate;
- (IBAction)btnPaymentAction:(id)sender;
- (IBAction)btnClosePopupAction:(id)sender;
@property (nonatomic,strong)NSDictionary *planDict;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblTotalHTHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblTotalHTPrice;


@end
