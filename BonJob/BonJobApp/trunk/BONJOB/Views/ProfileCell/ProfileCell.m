//
//  ProfileCell.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/30/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupAppereance
{
    //self.lblUserName.textColor=TitleColor;
    self.lblLocation.textColor=TitleColor;
    self.lblProfessionalExp.textColor=TitleColor;
    self.lblTranning.textColor=TitleColor;
    self.lblLanguage.textColor=TitleColor;
    self.lblAbout.textColor=TitleColor;
    self.lblActualStatus.textColor=TitleColor;
    self.lblMobility.textColor=TitleColor;
    self.lblUserName.textColor=TitleColor;
    self.lblCompetence.textColor=TitleColor;
    
    //self.lblUserName.text=NSLocalizedString(@"Welcome", nil);
    self.lblLocation.text=NSLocalizedString(@"Location", nil);
    self.lblProfessionalExp.text=NSLocalizedString(@"Professional experience", nil);
    self.lblTranning.text=NSLocalizedString(@"Training", nil);
    self.lblLanguage.text=NSLocalizedString(@"Languages", nil);
    self.lblAbout.text=NSLocalizedString(@"About", nil);
    self.lblActualStatus.text=NSLocalizedString(@"Status", nil);
    self.lblMobility.text=NSLocalizedString(@"Mobility", nil);
    [self.btnEditProfile setTitle:NSLocalizedString(@"Edit my profile", nil) forState:UIControlStateNormal];
    [SharedClass setBorderOnButton:self.btnEditProfile];
    self.btnEditProfile.backgroundColor =  InternalButtonColor;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
    [SharedClass setBorderOnButton:self.btnSelectCandidate];
    self.btnSelectCandidate.backgroundColor=InternalButtonColor;
}

-(void)setuserData:(NSDictionary *)userDict
{
    
}

@end
