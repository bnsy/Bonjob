//
//  MyOffersViewController.h
//  BONJOB
//
//  Created by Infoicon Technologies on 02/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOffersViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ProcessDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblViewMyOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchForJob;
- (IBAction)btnSearchForJobAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewNoData;
@property (weak, nonatomic) IBOutlet UIButton *btnGotoSearchJob;
- (IBAction)btnGotoJobAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
