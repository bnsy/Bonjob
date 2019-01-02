//
//  RecruiterJobsCell.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterJobsCell.h"
#import "UIImageView+WebCache.h"



@implementation RecruiterJobsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCells
{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.btnModifyOffer setTitle:NSLocalizedString(@"Modify the offer", @"") forState:UIControlStateNormal];
    [self.btnModifyOffer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnModifyOffer setBackgroundColor:TitleColor];
    [self.btnCloseOffer setTitle:NSLocalizedString(@"Close the offer", @"") forState:UIControlStateNormal];
    [self.btnCloseOffer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnCloseOffer setBackgroundColor:InternalButtonColor];
    
    self.btnCloseOffer.layer.cornerRadius=18.0;
    // border
    [self.btnCloseOffer.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.btnCloseOffer.layer setBorderWidth:0.3f];
    
    self.btnModifyOffer.layer.cornerRadius=18.0;
    // border
    [self.btnModifyOffer.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.btnModifyOffer.layer setBorderWidth:0.3f];
    _viewMainSubViewHolder.layer.borderWidth=1.0;
    _viewMainSubViewHolder.layer.borderColor=[UIColor lightGrayColor].CGColor;
}

-(void)setValues:(NSDictionary *)dict
{
    __weak UIImageView *weakImageView = self.imgJobOffer;
    [self.imgJobOffer sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"job_image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (!error)
         {
             weakImageView.alpha = 0.0;
             weakImageView.image = image;
             [UIView animateWithDuration:0.3
                              animations:^
              {
                  weakImageView.alpha = 1.0;
              }];
         }
         else
         {
             self.imgJobOffer.image=[UIImage imageNamed:@"default_job.png"];
         }
         
         
     }];
    self.imgJobOffer.contentMode=UIViewContentModeScaleAspectFit;
    self.lblJobTitle.text=[dict valueForKey:@"job_title"];
    self.lblJobDesc.text=[dict valueForKey:@"job_description"];
    
}

@end
