//
//  LookingJobCell.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "LookingJobCell.h"

@implementation LookingJobCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setdata:(NSDictionary *)dict
{
   /* 
    "added_by" = 0;
    "apply_on" = "";
    "contact_mode" = "T\U00e9l\U00e9phone:0667215749";
    "contract_type" = CDD;
    createdOn = "2017-07-28 06:19:59";
    "education_level" = CAP;
    "enterprise_name" = "Cooking Co.";
    experience = "Moins d'1 an";
    "job_description" = facultatif;
    "job_id" = 12;
    "job_image" = "http://139.162.164.98/bonjob//public/uploads/job_image/9b7931fd0aa926c0ed19397ef1d7f2ff_image.jpg";
    "job_location" = "Mare Palu, M\U00e9autis, France";
    "job_title" = "Femme de chambre";
    lang = Anglais;
    "num_of_hours" = "10h/semaine";
    salarie = "16 \U20ac/heure";
    "start_date" = "11-7-2017";
    status = 1;
    updatedOn = "2017-08-17 08:57:43";
    "user_id" = 54;
    */
    if ([dict valueForKey:@"enterprise_name"]==[NSNull null]|| [[dict valueForKey:@"enterprise_name"] isKindOfClass:[NSNull class]])
    {
        self.lblCompanyName.text = @"";
    }
    else
    {
        self.lblCompanyName.text=[dict valueForKey:@"enterprise_name"];
    }
    //self.txtviewDesc.text=[dict valueForKey:@"job_description"];
    
    
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.paragraphSpacing = 0.25 * font.lineHeight;
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:[UIColor blackColor],
                                 NSBackgroundColorAttributeName:[UIColor clearColor],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    if ([dict objectForKey:@"job_description"]!=nil)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[dict valueForKey:@"job_description"] attributes:attributes];
        
        _lblJobDesc.attributedText=attributedText;
    }
    
    /*[[NSAttributedString alloc] initWithData:[[dict valueForKey:@"job_description"] dataUsingEncoding:NSUTF8StringEncoding]
                                     options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                               NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                          documentAttributes:nil error:nil];
    */
    
    //_lblJobDesc.text=[dict valueForKey:@"job_description"];
    _lblJobLocation.text=[dict valueForKey:@"job_location"];
    
    NSString *apply_on=[dict valueForKey:@"apply_on"];
    if ([apply_on isEqualToString:@""])
    {
        [self.btnApplyJob setBackgroundColor:TitleColor];
        [self.btnApplyJob setUserInteractionEnabled:YES];
        [self.btnApplyJob setTitle:NSLocalizedString(@"Apply", @"") forState:UIControlStateNormal];
    }
    else
    {
        [self.btnApplyJob setBackgroundColor:InternalButtonColor];
        [self.btnApplyJob setUserInteractionEnabled:NO];
        [self.btnApplyJob setTitle:NSLocalizedString(@"Applied", @"") forState:UIControlStateNormal];
    }
    [self.activityLoader startAnimating];
    [self.imgJobImage sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"job_image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        if (error)
        {
            
            [_imgJobImage setImage:[UIImage imageNamed:@"default_job.png"]];
        }
        [self.activityLoader stopAnimating];
    }];
    // Job details Placeholders
    _lblNameOfJob.text=NSLocalizedString(@"Job title", @"");
    _lblContractType.text=NSLocalizedString(@"Contract", @"");
    _lblExperience.text=NSLocalizedString(@"Experience", @"");
    _lblNumberOfHrs.text=NSLocalizedString(@"Number of hours", @"");
    _lblDateOfJob.text=NSLocalizedString(@"Start date", @"");
    _lblModeOfContact.text=NSLocalizedString(@"Contact", @"");
    _lblLevelOfEducation.text=NSLocalizedString(@"Education", @"");
    _lblLanguages.text=NSLocalizedString(@"Languages", @"");
    _lblSalry.text=NSLocalizedString(@"Salary", @"");
    
    // job details data
    _lblSalryValue.text=[dict valueForKey:@"salarie"];
    if ([dict valueForKey:@"lang"]==[NSNull null])
    {
        _lblLanguagesValue.text=@"";
    }
    else
    {
        _lblLanguagesValue.text=[dict valueForKey:@"lang"];
    }
    
    _lblLevelOfEducationValue.text=[dict valueForKey:@"education_level"];
    _lblNameOfJobValue.text=[dict valueForKey:@"job_title"];
    _lblContractTypeValue.text=[dict valueForKey:@"contract_type"];
    _lblExperienceValue.text=[dict valueForKey:@"experience"];
    _lblNumberOfHrsValue.text=[dict valueForKey:@"num_of_hours"];
    _lblDateOfJobValue.text=[dict valueForKey:@"start_date"];
    
    NSArray *temp=[[dict valueForKey:@"contact_mode"] componentsSeparatedByString:@":"];
    if (temp.count>1)
    {
        //_lblModeOfContactValue.text=[dict valueForKey:@"contact_mode"];
        if ([[temp objectAtIndex:1]length]==0)
        {
            _lblModeOfContactValue.text=[temp objectAtIndex:0];
        }
        else
        {
            _lblModeOfContactValue.text=[temp objectAtIndex:1];
        }
        
    }
    else
    {
        _lblModeOfContactValue.text=[temp objectAtIndex:0];
    }
    
    
    if ([[dict valueForKey:@"contract_type"] length]==0)
    {
        

        self.contractHeight.constant=0;
        
    }
    else
    {
        self.contractHeight.constant=24;
    }
    if ([[dict valueForKey:@"education_level"] length]==0)
    {

        self.educationHeight.constant=0;
        
    }
    else
    {
        self.educationHeight.constant=24;
    }
    if ([[dict valueForKey:@"experience"] length]==0)
    {

        self.experienceHeight.constant=0;
        
    }
    else
    {
        self.experienceHeight.constant=24;
    }
    if ([[dict valueForKey:@"lang"] length]==0)
    {

        self.languageHeight.constant=0;
        
    }
    else
    {
        self.languageHeight.constant=24;
    }
    if ([[dict valueForKey:@"num_of_hours"] length]==0)
    {

        self.numberofHrsHeight.constant=0;
       
    }
    else
    {
        self.numberofHrsHeight.constant=24;
    }
    if ([[dict valueForKey:@"start_date"] length]==0)
    {

        self.dateHeight.constant=0;
        
    }
    else
    {
        self.dateHeight.constant=24;
    }
    if ([[dict valueForKey:@"salarie"] length]==0)
    {

        self.salryHeight.constant=0;
        
    }
    else
    {
        self.salryHeight.constant=24;
    }
    
    if ([[dict valueForKey:@"job_image"] length]==0 && [[dict valueForKey:@"origin"] isEqualToString:@"pole-emploi"])
    {
        self.lblModeOfContactValue.text=@"Pôle emploi";
    }

    
    
}

@end
