//
//  AppliedJobViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/13/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppiledControllerDissmissedDelegate<NSObject>

-(void)viewDismissed;
-(void)viewDismissedReLoad;

@end
@interface AppliedJobViewController : UIViewController
@property(nonatomic,strong)id<AppiledControllerDissmissedDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UIButton *btnContinueSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnGotoProfile;
- (IBAction)btnContinueSearchAction:(id)sender;
- (IBAction)btnGotoProfileAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblApplicationSent;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodluck;



@end
