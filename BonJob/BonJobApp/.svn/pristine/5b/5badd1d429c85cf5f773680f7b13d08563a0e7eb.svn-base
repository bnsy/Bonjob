//
//  CompanyPageDetailsViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/14/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobOfferedCell:UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgJobOffer;
@property (weak, nonatomic) IBOutlet UITextView *txtViewJobDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblJobOfferdDate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoader;



@end


@interface CompanyPageDetailsViewController : UIViewController<ProcessDataDelegate>
- (IBAction)toggleVideoPlayPause:(id)sender;
-(IBAction) playVideo:(id)sender;
- (IBAction)pauseVideo:(id)sender;

- (IBAction)fullScreenVideo:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionJobOffer;

@property (weak, nonatomic) IBOutlet UIView *viewPlayPauseHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgVideo;
@property (weak, nonatomic) IBOutlet UIView *viewPlayerLayer;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *lblResturent;

@property (weak, nonatomic) IBOutlet UILabel *lblAbout;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountOwner;
@property (weak, nonatomic) IBOutlet UILabel *lblUser;
@property (weak, nonatomic) IBOutlet UILabel *lblOnlineStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyWebsite;
@property (weak, nonatomic) IBOutlet UILabel *lblJobOffers;
@property (weak, nonatomic) IBOutlet UILabel *lblVideo;
@property (weak, nonatomic) NSString *employer_id;
@property (weak, nonatomic) NSString *SelectedJobIndex;
@property (weak, nonatomic) NSString *job_id;
@property (weak, nonatomic) NSString *CompanyName;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmployerProfile;
@property (weak, nonatomic) IBOutlet UIImageView *imgOnlineSymbol;
@property (weak, nonatomic) IBOutlet UIView *viewJobHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgAtTheRate;
@property (weak, nonatomic) IBOutlet UIImageView *imgCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnWebSite;
@property (weak, nonatomic) IBOutlet UIImageView *imgJobOfferDetails;
@property (weak, nonatomic) IBOutlet UITextView *txtViewJobOfferDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblJobOfferDescriptionDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgVideoIcon;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *videoLoader;
@property (weak, nonatomic) IBOutlet UIView *defaultView;

- (IBAction)btnWebSiteAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnContentReport;
- (IBAction)btnContentReportAction:(id)sender;
//------------------
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollMain;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblAboutHeightConstant;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *websiteLblHeightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *websiteatTherateHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webUrlHeightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewJobDetailsHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblVideoHeightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgVideoHeightConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewVideoPlayerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblAboutHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnAboutHeight;



@end
