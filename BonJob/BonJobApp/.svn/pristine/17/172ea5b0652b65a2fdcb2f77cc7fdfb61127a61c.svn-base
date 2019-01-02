//
//  ApplyFilterViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/13/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterPopupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnRadio;
@property (weak, nonatomic) IBOutlet UILabel *lblItemName;

@end



@protocol ApplyFilterDelegate <NSObject>

-(void)applyFilter:(BOOL)b andMessage:(NSString *)msg;

@end

@interface ApplyFilterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ProcessDataDelegate>
- (IBAction)btnCancelTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)btnSearchTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (weak, nonatomic) IBOutlet UILabel *lblCuisine;
@property (weak, nonatomic) IBOutlet UILabel *lblService;
@property (weak, nonatomic) IBOutlet UILabel *lblHotel;
@property (weak, nonatomic) IBOutlet UILabel *lblTypeofContact;
@property (weak, nonatomic) IBOutlet UILabel *lblLevelofEducation;
@property (weak, nonatomic) IBOutlet UILabel *lblFullPartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblExperience;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UITableView *tblPopup;
@property (weak, nonatomic) IBOutlet UITableView *maintblView;
@property (weak, nonatomic) IBOutlet UIButton *btnClosePopup;
@property (weak, nonatomic) IBOutlet UIButton *btnCuisine;
@property (weak, nonatomic) IBOutlet UIButton *btnService;
@property (weak, nonatomic) IBOutlet UIButton *btnHotel;
@property (weak, nonatomic) IBOutlet UILabel *lblpopUpTtle;
@property(nonatomic,retain)id<ApplyFilterDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;



- (IBAction)btnOkAction:(id)sender;
- (IBAction)btnClosePopupAction:(id)sender;
- (IBAction)btnCusineAction:(id)sender;
- (IBAction)btnServiceAction:(id)sender;
- (IBAction)btnHoteAction:(id)sender;
- (IBAction)btnTyoeOfContractAction:(id)sender;
- (IBAction)btnLevelOfEducationAction:(id)sender;
- (IBAction)btnFullTimeAction:(id)sender;
- (IBAction)btnExperienceAction:(id)sender;




@end
