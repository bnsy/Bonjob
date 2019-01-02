//
//  HomeViewController.h
//  BONJOB
//
//  Created by Infoicon Technologies on 29/04/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *defaultview;
@property (strong, nonatomic) IBOutlet UIView *secondviewforshow;
@property (strong, nonatomic) IBOutlet UIButton *editmyprofileoutlet;
@property (strong, nonatomic) IBOutlet UIButton *lookingforajoboutlet;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcomeTitile;

- (IBAction)editmyprofileaction:(UIButton *)sender;
- (IBAction)addonebuttonaction:(UIButton *)sender;
- (IBAction)indicateyourexpbuttonaction:(UIButton *)sender;
- (IBAction)btnLookForJobAction:(id)sender;
- (IBAction)registeapitchvideoaction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeaderLogo;

@end
