//
//  ProfileViewController.h
//  BONJOB
//
//  Created by Infoicon Technologies on 02/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDataModel.h"
@interface ProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,  UITextFieldDelegate,UITextViewDelegate,ProcessDataDelegate,SeekerProfileUpdatedDelegate>
{
    
    NSMutableDictionary *parameters;
}
@property (weak, nonatomic) IBOutlet UIView *viewAvplayerHolder;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITableView *myprofiletableview;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UIView *viewShowImage;
@property (weak, nonatomic) IBOutlet UIView *viewShowImagePopup;
@property (weak, nonatomic) IBOutlet UIImageView *imgPoupUserPic;
@property (weak, nonatomic) IBOutlet UIView *viewShowVideo;
@property (weak, nonatomic) IBOutlet UIView *viewShowVideoPopup;

- (IBAction)btnPauseVideoActiones:(id)sender;
- (IBAction)btnFullScreenVideoACtiones:(id)sender;

- (IBAction)btnPlayVideoActiones:(id)sender;

- (IBAction)btnCloseImagePopupAction:(id)sender;
- (IBAction)btnCloseVideoPopup:(id)sender;
- (IBAction)editmyprofileaction:(id)sender;
- (void)btnSettingsAction:(id)sender;
@end
