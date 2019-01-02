//
//  ActiveViewController.h
//  BONJOB
//
//  Created by Infoicon Technologies on 02/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedClass.h"

@interface ActiveViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ProcessDataDelegate>
@property(nonatomic,weak)IBOutlet UITableView *tblActivity;
//@property (weak, nonatomic) IBOutlet UIView *viewDefault;
//@property (weak, nonatomic) IBOutlet UIButton *btnGotoSearchJob;
//
//- (IBAction)btnGotoSearchJobAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewNoData;

@property (weak, nonatomic) IBOutlet UIButton *btnSearchForJob;
- (IBAction)btnSearchForJobAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnGotoSearchJob;
- (IBAction)btnGotoJobAction:(id)sender;

@end
