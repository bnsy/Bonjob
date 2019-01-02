//
//  LookForJobViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/9/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectLocationViewController.h"
#import "ApplyFilterViewController.h"

@interface LookForJobViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,ProcessDataDelegate,ApplyFilterDelegate,locationSelectedDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

- (IBAction)btnFilterApplyAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewTxtHolder;
// for filter popup
@property (weak, nonatomic) IBOutlet UIView *viewBackPopup;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UIButton *btnClosePopup;

@property (weak, nonatomic) IBOutlet UILabel *lblCuisine;
@property (weak, nonatomic) IBOutlet UILabel *lblSales;
@property (weak, nonatomic) IBOutlet UILabel *lblHotels;

@property (weak, nonatomic) IBOutlet UIButton *btnFilters;
@property (weak, nonatomic) IBOutlet UIButton *btnFilterSearch;

- (IBAction)btnFiltersAction:(id)sender;
- (IBAction)btnClosePopupAction:(id)sender;
- (IBAction)btnFilterSearchAction:(id)sender;

- (IBAction)btnRadioCuisine:(id)sender;
- (IBAction)btnRadioSalesAction:(id)sender;
- (IBAction)btnRadioHotelAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnRadioCuisine;
@property (weak, nonatomic) IBOutlet UIButton *btnRadioSales;
@property (weak, nonatomic) IBOutlet UIButton *btnRadioHotel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *viewLOcationDataHolder;
@property (weak, nonatomic) IBOutlet UITableView *tblJobListing;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionTagData;
@property (weak, nonatomic) IBOutlet UIButton *btnEditLocation;
- (IBAction)btnEditLocationAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblFilters;

@end
