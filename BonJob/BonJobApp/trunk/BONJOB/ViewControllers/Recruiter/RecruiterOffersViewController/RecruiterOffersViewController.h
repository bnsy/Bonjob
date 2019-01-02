//
//  RecruiterOffersViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/10/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RecruiterOffersViewController : UIViewController

//CONTAINERVIEW PROPERTY HERE
@property (weak, nonatomic) IBOutlet UIView *containerCandidate;
@property (weak, nonatomic) IBOutlet UIView *containerCandidateSelected;
@property (weak, nonatomic) IBOutlet UIView *containerCandidateHired;
@property (weak, nonatomic) IBOutlet UIView *containerMyOffers;

//UPPER TAB PROPERTY HERE
@property (weak, nonatomic) IBOutlet UIButton *btnCandiate;
@property (weak, nonatomic) IBOutlet UIButton *btnCandidateSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnCandidateHired;
@property (weak, nonatomic) IBOutlet UIButton *btnMyOffers;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidate;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateSelected;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateHired;
@property (weak, nonatomic) IBOutlet UILabel *lblMyOffers;
@property (weak, nonatomic) IBOutlet UIImageView *imgCadidate;
@property (weak, nonatomic) IBOutlet UIImageView *imgBookMark;
@property (weak, nonatomic) IBOutlet UIImageView *imgHired;
@property (weak, nonatomic) IBOutlet UIImageView *imgMyOffer;
//--------------------
@property (weak, nonatomic) IBOutlet UILabel *lblMyOfferNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblHiredCandidateNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedCandidateNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblAvailabelCandidateNumber;

//BUTTONS ACTIONS HERE
- (IBAction)btnCandidateAction:(id)sender;
- (IBAction)btnCandidateSelectedAction:(id)sender;
- (IBAction)btnCandidateHiredAction:(id)sender;
- (IBAction)btnMyOffersAction:(id)sender;

@end
