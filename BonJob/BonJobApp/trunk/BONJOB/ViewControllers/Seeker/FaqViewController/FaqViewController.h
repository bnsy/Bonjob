//
//  FaqViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/16/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaqViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ProcessDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblFaq;
@property (weak, nonatomic) IBOutlet UILabel *lblFaqHeader;

@end
