//
//  EditRecruterScreenViewController.h
//  Recurterscreen
//
//  Created by Infoicon Technologies on 10/07/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RecruiterProfileUpdatedDelegate<NSObject>
-(void)recruiterProfileUpdated;
@end
@interface EditRecruterScreenViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,locationSelectedDelegate,ProcessDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOfSalries;
@property (weak, nonatomic) IBOutlet UILabel *lblPopupCategoryr;
@property(nonatomic,strong)NSDictionary *DictProfile;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
- (IBAction)btnSaveProfileAction:(id)sender;
@property(nonatomic,strong)id<RecruiterProfileUpdatedDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *viewImageVideoBackground;
@property (weak, nonatomic) IBOutlet UIView *viewVideoBackground;
@property (weak, nonatomic) IBOutlet UIView *viewImageHolder;
@property (weak, nonatomic) IBOutlet UIView *viewVideoHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgEnterPriseRecruiter;
@property (weak, nonatomic) IBOutlet UIButton *btnPopupDeleteVideo;
@property (weak, nonatomic) IBOutlet UIButton *btnPopupRemoveImage;
- (IBAction)btnPopupRemoveImage:(id)sender;

- (IBAction)btnCloseImagePreview:(id)sender;
- (IBAction)btnCloseVideoHolderAction:(id)sender;
- (IBAction)btnRemoveVideoAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewDimBackground;
@property (weak, nonatomic) IBOutlet UIView *viewVideoGuidePopup;
- (IBAction)btnCloseVideoGuidePopupAction:(id)sender;


@end
