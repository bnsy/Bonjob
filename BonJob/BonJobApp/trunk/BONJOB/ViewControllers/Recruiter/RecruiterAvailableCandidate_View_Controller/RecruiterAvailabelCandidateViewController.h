//
//  RecruiterAvailabelCandidateViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecruiterAvailabelCandidateViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ProcessDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchCandidate;
@property (weak, nonatomic) IBOutlet UIButton *btnJobTemplate;
@property (weak, nonatomic) IBOutlet UIView *viewNoData;

@property (weak, nonatomic) IBOutlet UITableView *tblAvilableCandidate;
@property (weak, nonatomic) IBOutlet UITableView *tblBlockedCandidate;
@property (weak, nonatomic) IBOutlet UIView *viewBlockCandidate;
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)UIRefreshControl *refreshControl;
@end
