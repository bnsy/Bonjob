//
//  JobOfferedViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/18/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobOfferdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblJobOffered;
@property (weak, nonatomic) IBOutlet UIButton *btnRadioSelect;
@end

@protocol JobOfferSelectedProtocol <NSObject>

-(void)selectedJobOffer:(NSString *)jobOffer jobId:(NSString*)job_id;

@end

@interface JobOfferedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UITableView *tblJobOffered;
@property (weak, nonatomic) IBOutlet UIView *viewTxtHolder;
@property(nonatomic,weak)id<JobOfferSelectedProtocol> delegate;
@end
