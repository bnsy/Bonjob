//
//  RecruiterHiredCandidateCell.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterHiredCandidateCell.h"

@implementation RecruiterHiredCandidateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setdata:(NSDictionary *)data
{
   /* "aplied_id" = 18;
    createdOn = "2017-08-22 14:48:58";
    "current_status" = Apprentice;
    "employer_id" = 54;
    experience = 4;
    "first_name" = "Vishal \t";
    "job_id" = 12;
    "job_title" = "Femme de chambre";
    "last_name" = Kumar;
    status = 3;
    updatedOn = "2017-09-08 13:09:24";
    "user_id" = 42;
    "user_pic" = "http://139.162.164.98/bonjob//public/uploads/user_
    */
    _lblUserName.text=[data valueForKey:@"first_name"];
    _lblStatus.text=[data valueForKey:@"current_status_name"];
    
    //if ([[data valueForKey:@"experience"] count]>0)
    
    if ([[data valueForKey:@"experience"] length]>0 && [data valueForKey:@"experience"]!=[NSNull null])
    {
        //NSString *exp=[[data valueForKey:@"experience"] objectAtIndex:0];
        NSString *exp=[data valueForKey:@"experience"];
        NSString *expRange=[self getExperience:exp];
        _lblExp.text=[NSString stringWithFormat:@"%@ %@",expRange,NSLocalizedString(@"experienceholder", @"")];
    }
    else
    {
        _lblExp.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"None", @""),NSLocalizedString(@"experienceholder", @"")];
    }
    
    _lblJobtitle.text=[data valueForKey:@"job_title"];
    
    [_imgUserpic sd_setImageWithURL:[NSURL URLWithString:[data valueForKey:@"user_pic"]] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (error)
         {
             [_imgUserpic setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
         }
    }];
    
//    [_imgUserpic sd_setImageWithURL:[NSURL URLWithString:[data valueForKey:@"user_pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//     {
//         if (error)
//         {
//             [_imgUserpic setImage:[UIImage imageNamed:@"default.png"]];
//         }
//    }];
    self.imgUserpic.layer.cornerRadius=self.imgUserpic.frame.size.width/2;
    self.imgUserpic.clipsToBounds=YES;
    self.imgUserpic.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.imgUserpic.layer.borderWidth=1.0;

}

-(NSString *)getExperience:(NSString *)exp
{
    
    NSString *year;
    if ([exp intValue]==0)
    {
        year=NSLocalizedString(@"None", @"");
    }
    else if ([exp intValue]>0 && [exp intValue]<2)
    {
        year=NSLocalizedString(@"< 1 year", @"");
    }
    else if ([exp intValue]>1 && [exp intValue]<3)
    {
        year=NSLocalizedString(@"1-2 years", @"");
    }
    else if ([exp intValue]>2 && [exp intValue]<4)
    {
        year=NSLocalizedString(@"3-4 years", @"");
    }
    
    else if ([exp intValue]>3 && [exp intValue]<5)
    {
        year=NSLocalizedString(@"5 years+", @"");
    }
    else
    {
        year=NSLocalizedString(@"None", @"");
    }
    return year;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
