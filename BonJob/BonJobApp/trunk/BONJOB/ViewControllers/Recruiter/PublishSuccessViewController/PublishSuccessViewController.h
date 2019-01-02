//
//  PublishSuccessViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/7/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PublishSuccessDelegate <NSObject>

-(void)viewMyOfferTapped;
-(void)gotoMyProfileTapped;

@end

@interface PublishSuccessViewController : UIViewController
@property(nonatomic,strong)id<PublishSuccessDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnSeeMyOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnGotoMyProfile;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end
