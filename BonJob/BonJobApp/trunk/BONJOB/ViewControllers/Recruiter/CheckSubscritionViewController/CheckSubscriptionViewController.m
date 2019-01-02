//
//  CheckSubscriptionViewController.m
//  BONJOB
//
//  Created by VISHAL SETH on 13/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import "CheckSubscriptionViewController.h"
#import "PaymentRejectViewController.h"
#import "PaymentAcceptViewController.h"
#import "PaymentDetailsViewController.h"
#import "PaymentDataViewController.h"
#import "TerminateSubscriptionViewController.h"
@interface CheckSubscriptionViewController ()<PaymentRejectedDelegate,PaymentAcceptedDelegate,PaymentSuccessDelegate,PaymantPlanSelectedDelegate>

@end

@implementation CheckSubscriptionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title=@"Abonnement";
    [SharedClass setBorderOnButton:self.btnSubsCribe];
    [SharedClass setBorderOnButton:_btnRenew];
    [SharedClass setBorderOnButton:_btnTerminate];
    _btnSubsCribe.layer.borderColor=InternalButtonColor.CGColor;
    _btnSubsCribe.layer.borderWidth=1.0;
    if ([[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] length]>0 && [[APPDELEGATE.currentPlanDict valueForKey:@"subscription_title"] length]>0)
    {
        [self.viewNoSubscription setHidden:YES];
        if ([[APPDELEGATE.currentPlanDict valueForKey:@"subscription_title"] isEqualToString:@"1 An"])
        {
            _lblPrice.textColor=InternalButtonColor;
            _lblPeriod.textColor=InternalButtonColor;
//            1 An
        }
        NSLog(@"%@",[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"]);
        NSString *date =
        [Alert getDateWithString:[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] getFormat:SET_FORMAT_TYPE2 setFormat:SET_FORMAT_TYPE5];
        
                
        _lblPrice.text=[APPDELEGATE.currentPlanDict valueForKey:@"description"];
        _lblPeriod.text=[APPDELEGATE.currentPlanDict valueForKey:@"subscription_title"];
        _lblExpirationDate.text=[NSString stringWithFormat:@"%@ %@",@"Votre abonnement expire le :",date];
    }
    else
    {
        [self.viewNoSubscription setHidden:NO];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)paymentPopupClose {

}

- (IBAction)btnSubscriptionAction:(id)sender
{
    PaymentDataViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDataViewController"];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark - -------PAYMNET MODULE CALLBACKS----------
- (void)paymentDone:(BOOL)value
{
    if (!value)
    {
        PaymentRejectViewController *pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentRejectViewController"];
        pvc.delegate=self;
        [pvc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        [pvc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self presentViewController:pvc animated:YES completion:nil];
    }
    else
    {
        PaymentAcceptViewController *pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentAcceptViewController"];
        pvc.delegate=self;
        [pvc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        [pvc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self presentViewController:pvc animated:YES completion:nil];
    }
}
//-(void)paymentPopupClose
//{
//    
//}
-(void)paymentPlanSelected:(long)index
{
    PaymentDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDetailsViewController"];
    vc.planDict=[APPDELEGATE.arrPlanData objectAtIndex:index];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)openEditProfile
{
    [self.tabBarController setSelectedIndex:4];
}

- (void)openPostJobController
{
    [self.tabBarController setSelectedIndex:3];
}

- (void)openSearchCandidateController
{
    [self.tabBarController setSelectedIndex:0];
}

- (void)openPaymentData
{
    
}

- (IBAction)btnTernimateAction:(id)sender
{
    TerminateSubscriptionViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"TerminateSubscriptionViewController"];
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btnRenewAction:(id)sender
{
    PaymentDataViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDataViewController"];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
