//
//  RegistrationandLoginViewController.h
//  BONJOB
//
//  Created by Infoicon Technologies on 01/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "VSTextField.h"
#import "WebserviceHelper.h"
@class Alerter;
@interface RegistrationandLoginViewController : UIViewController<UITextFieldDelegate,ProcessDataDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *imagePicker;
}



@property (weak, nonatomic) IBOutlet UITextField *txtRegisterName;
@property (weak, nonatomic) IBOutlet UITextField *txtRegisterLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtRegisterEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtRegisterPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtRegisterExperience;
@property (weak, nonatomic) IBOutlet UITextField *txtRegisterCity;
@property (weak, nonatomic) IBOutlet UITextField *txtRegisterTraining;
@property (weak, nonatomic) IBOutlet UILabel *lblTermsAndConditions;
@property (weak, nonatomic) IBOutlet UIButton *btnTermsAndConditions;
- (IBAction)btnTermsAction:(id)sender;


@property(nonatomic, strong)NSString *whichsegmentisshow;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentviewcontrolleroutlet;

- (IBAction)segmentviewcontrolleraction:(UISegmentedControl *)sender;
@property(strong, nonatomic)NSMutableDictionary *parameters;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblPitchVideo;
- (IBAction)btnRadioAction:(id)sender;

// Outlets for One time Popup (Video Guide)
@property (weak, nonatomic) IBOutlet UIView *viewDimBackground;
@property (weak, nonatomic) IBOutlet UIView *viewVideoGuidePopup;
- (IBAction)btnCloseVideoGuidePopupAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewVideoGuideInternal;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;




@end
