//
//  JobOfferDetailViewController.h
//  BonjobScreen9
//
//  Created by Infoicon Technologies on 14/06/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>
@interface JobOfferDetailViewController : UIViewController<MKMapViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate,ProcessDataDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *viewCompanyDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnApplyJob;
@property (weak, nonatomic) IBOutlet UIImageView *imgFacebook;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgTwitter;
@property (weak, nonatomic) IBOutlet UIImageView *imgWhatsapp;
@property (weak, nonatomic) IBOutlet UIImageView *imgHotelPic;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyActivity;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyWebsite;
@property (weak, nonatomic) IBOutlet UILabel *lblShareThisOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnReportContent;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIView *viewLower;
@property (weak, nonatomic) IBOutlet UIView *tblView;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblJobOfferedTime;
@property (weak, nonatomic) IBOutlet UILabel *lblJobOfferPostedDate;
@property (weak, nonatomic) IBOutlet UIButton *btnVisitWebSIte;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) NSString *jobId;
@property (strong, nonatomic) NSString *job_id;
@property (strong, nonatomic) NSString *employer_id;
@property (strong, nonatomic) NSString *SelectedJobIndex;
@property (strong, nonatomic) NSString *CompanyName;
@property (strong, nonatomic) NSString *jobTitle;


@property (weak, nonatomic) IBOutlet UILabel *lblAppliedDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAppliedCandidateDate;
@property (weak, nonatomic) IBOutlet UILabel *lblJobOfferDetails;
    @property (weak, nonatomic) IBOutlet UILabel *lblJobOfferTimeDetails;
@property (nonatomic, assign) CLLocationCoordinate2D CompanyCoordinate;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyLocationValue;
- (IBAction)btnVisitCompanyDetails:(id)sender;
- (IBAction)btnVisitWebSite:(id)sender;
- (IBAction)btnReportInAppropriateAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewNoData;
- (IBAction)btnApplyJobAction:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWebsiteHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblCompanyWebsiteHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWebsiteHeight;

@end
