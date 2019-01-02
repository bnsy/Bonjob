//
//  ExperienceViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/6/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExperienceDelegate <NSObject>

-(void)ExperienceSelected:(NSArray *)arr;

@end

@interface ExperienceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblExperience;
@property(strong,nonatomic) NSMutableArray *tempArrExp;
@property (weak, nonatomic) IBOutlet UIView *viewBgGrey;
@property (weak, nonatomic) IBOutlet UIView *viewHolderTable;
@property (weak, nonatomic) IBOutlet UITableView *tblPositionHold;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityArea;
@property (weak, nonatomic) IBOutlet UIButton *btnPositionHeldBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (weak, nonatomic) IBOutlet UILabel *lblIndicateExperience;
@property(nonatomic) BOOL isFromSignUp;
@property(nonatomic,strong)id<ExperienceDelegate> delegate;
- (IBAction)btnPositionHeldBackAction:(id)sender;
- (IBAction)btnClosePositionHeldValue:(id)sender;
- (IBAction)btnSaveAction:(id)sender;





@end