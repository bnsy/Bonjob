//
//  PaymentDataViewController.h
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//
@protocol PaymantPlanSelectedDelegate
-(void)paymentPopupClose;
-(void)paymentPlanSelected:(long)index;

@end



#import <UIKit/UIKit.h>
@interface PaymentDataCell:UITableViewCell
{
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *lblPlanName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlanAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblPlanValidity;


@end

@interface PaymentDataViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tblData;
- (IBAction)btnClosePopupAction:(id)sender;
@property(nonatomic,strong)id<PaymantPlanSelectedDelegate>delegate;
@end
