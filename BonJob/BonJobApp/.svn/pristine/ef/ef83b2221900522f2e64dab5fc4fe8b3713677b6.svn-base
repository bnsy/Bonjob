//
//  RecruiterJobOffersViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentDataViewController.h"
#import "PaymentAcceptViewController.h"
#import "PaymentRejectViewController.h"
#import "PaymentDetailsViewController.h"

@interface RecruiterJobOffersViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ProcessDataDelegate,PaymentRejectedDelegate,PaymentSuccessDelegate,PaymentAcceptedDelegate,PaymantPlanSelectedDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblJobOffers;
@property (weak, nonatomic) IBOutlet UIView *viewBlockOffers;
@property (weak, nonatomic) IBOutlet UITableView *tblBlockOffers;

@property (weak, nonatomic) IBOutlet UIView *viewNoData;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchCandidate;
@property (weak, nonatomic) IBOutlet UIButton *btnJobTemplate;
- (IBAction)btnSearchCandidateAction:(id)sender;
- (IBAction)btnJobTemplateAction:(id)sender;
@property(nonatomic,strong)UIRefreshControl *refreshControl;
@end
