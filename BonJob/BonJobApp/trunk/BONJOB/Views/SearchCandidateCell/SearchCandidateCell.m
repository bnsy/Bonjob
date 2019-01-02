//
//  SearchCandidateCell.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "SearchCandidateCell.h"

@implementation SearchCandidateCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    transform = CATransform3DScale(self.progressView.layer.transform, 1.0f, 3.0f, 1.0f);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)dict withDistance:(float)distanceInKM
{
    if ([[UIScreen mainScreen]bounds].size.width == 320.0) {
        self.lblCandidateName.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"first_name"]];
    }
    else
    {
       self.lblCandidateName.text=[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"first_name"],[dict valueForKey:@"last_name"]];
    }
    if ([dict valueForKey:@"current_status_name"] !=[NSNull null]  && [[dict valueForKey:@"current_status_name"] length]>0)
    {
    self.lblCandidateStatus.text=[dict valueForKey:@"current_status_name"];
    }
    if (distanceInKM>0.0)
    {
       self.lblCandidateLocation.text=[NSString stringWithFormat:@"%.2f KM - %@",distanceInKM,[dict valueForKey:@"city"]];
    }
    else
    {
        if ([[dict valueForKey:@"city"]  isEqual: @""] ||  [[dict valueForKey:@"city"]length] == 0) {
            self.lblCandidateLocation.text = @"Non Renseigné";
        }
        else{
            self.lblCandidateLocation.text=[dict valueForKey:@"city"];
        }
        
    }
    
    self.imgCandidatePic.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.imgCandidatePic.layer.borderWidth=1.0;
    [self.imgCandidatePic sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"user_pic"]] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        if (error)
        {
            [self.imgCandidatePic setImage:kDefaultPlaceHolder];
        }
    }];
//    [self.imgCandidatePic sd_setImageWithURL:[NSURL URLWithString:@"https://preview.ibb.co/cYno6e/i_OS_V3_Feedback_Recruiter_side_17_Sept_2018_1.jpg"] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//         {
//             if (error)
//             {
//                 [self.imgCandidatePic setImage:kDefaultPlaceHolder];
//             }
//         }];
   
    
//    [self.imgCandidatePic sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"user_pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//    {
//        if (error)
//        {
//            [self.imgCandidatePic setImage:[UIImage imageNamed:@"defaultPic.png"]];
//        }
//    }];
    self.imgCandidatePic.layer.cornerRadius = self.imgCandidatePic.frame.size.width / 2;
    self.imgCandidatePic.clipsToBounds = YES;
    self.progressView.layer.borderWidth=0.5;
    self.progressView.layer.borderColor=TitleColor.CGColor;
    self.progressView.layer.transform=transform;
    [self.progressView setProgressTintColor:TitleColor];
    [self.progressView setBackgroundColor:[UIColor whiteColor]];
    
    [self.viewProgressBar setProgressTintColor:TitleColor];
    [self.viewProgressBar setBackgroundColor:[UIColor whiteColor]];
    _viewProgressBar.layer.borderWidth=1.5;
    _viewProgressBar.layer.cornerRadius=8;
    _viewProgressBar.layer.borderColor=TitleColor.CGColor;
    //_viewProgressBar.stripesOrientation       = YLProgressBarStripesOrientationLeft;
    _viewProgressBar.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeNone;
    _viewProgressBar.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    _viewProgressBar.progressStretch          = NO;
    
    
    NSArray *tintColors = @[TitleColor];
    
    _viewProgressBar.progressTintColors       = tintColors;
    
    //transform = CATransform3DScale(self.progressCandidateTime.layer.transform, 1.0f, 3.0f, 1.0f);
    

}

@end
