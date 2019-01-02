//
//  RecruiterCandidateSelectedCell.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterCandidateSelectedCell.h"

@implementation RecruiterCandidateSelectedCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)data
{
    /*
     "aplied_id" = 9;
     createdOn = "2017-08-04 12:49:52";
     "current_status" = Actif;
     "employer_id" = 54;
     experience = 2;
     "first_name" = THEO;
     "job_id" = 12;
     "job_title" = "Femme de chambre";
     "last_name" = Regnault;
     status = 2;
     updatedOn = "2017-08-24 09:30:31";
     "user_id" = 43;
     "user_pic" = "http://139.162.164.98/bonjob//public/uploads/user_pic/63f1856d58dba46022b2ae56e1694e9b_image.jpg";
     */
    _lblUserName.text=[data valueForKey:@"first_name"];
    _lblCandidateExp.text=[data valueForKey:@"current_status_name"];
    NSString *exp=[data valueForKey:@"experience"];
    if ([[data valueForKey:@"experience"]length]>0)
    {
        //NSString *exp=[data valueForKey:@"experience"];
        exp=[self getExperience:exp];
        _lblSalrie.text=[NSString stringWithFormat:@"%@ %@",exp,NSLocalizedString(@"experienceholder", @"")];
    }
    
    exp=[data valueForKey:@"experience"];
    exp=[self getExperience:exp];
    _lblSalrie.text=[NSString stringWithFormat:@"%@ %@",exp,NSLocalizedString(@"experienceholder", @"")];
    
    [_imgDefaultPic sd_setImageWithURL:[NSURL URLWithString:[data valueForKey:@"user_pic"]] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (error)
         {
             [_imgDefaultPic setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
         }
    }];
    
    _lblJobProfile.text=[data valueForKey:@"job_title"];
//    [_imgDefaultPic sd_setImageWithURL:[NSURL URLWithString:[data valueForKey:@"user_pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//    {
//        if (error)
//        {
//            [_imgDefaultPic setImage:[UIImage imageNamed:@"defaultPic.png"]];
//        }
//    }];
    _imgDefaultPic.layer.cornerRadius=_imgDefaultPic.frame.size.width/2;
    _imgDefaultPic.clipsToBounds=YES;
    _imgDefaultPic.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _imgDefaultPic.layer.borderWidth=1.0;
    
    if ([[data valueForKey:@"aplied_id"] isEqualToString:@""]||[[data valueForKey:@"aplied_id"] length]==0)
    {
        [self.btnHired setHidden:YES];
        [self.btnArchieve setHidden:YES];
    }
    else
    {
        [self.btnHired setHidden:NO];
        [self.btnArchieve setHidden:NO];
    }

}

-(void)setCells
{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.btnArchieve setTitle:NSLocalizedString(@"Not selected", @"") forState:UIControlStateNormal];
    [self.btnArchieve setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnHired setBackgroundColor:TitleColor];
    [self.btnHired setTitle:NSLocalizedString(@"Employed", @"") forState:UIControlStateNormal];
    [self.btnHired setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnArchieve setBackgroundColor:InternalButtonColor];
    
    self.btnArchieve.layer.cornerRadius=18.0;
    // border
    [self.btnArchieve.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.btnArchieve.layer setBorderWidth:0.3f];
    
    self.btnHired.layer.cornerRadius=18.0;
    // border
    [self.btnHired.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.btnHired.layer setBorderWidth:0.3f];
//    _viewMainSubViewHolder.layer.borderWidth=1.0;
//    _viewMainSubViewHolder.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    
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



@end
