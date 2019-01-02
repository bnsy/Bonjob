//
//  ActivityCell.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/16/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setdata:(NSDictionary *)dict currentTime:(NSString*)currentTime
{
    /*
     "current_time" = "2017-08-23 12:54:11";
     data =     (
     {
     "aplied_id" = 18;
     createdOn = "2017-08-22 14:48:58";
     "employer_id" = 54;
     "job_id" = 12;
     "job_image" = "http://139.162.164.98/bonjob//public/uploads/job_image/9b7931fd0aa926c0ed19397ef1d7f2ff_image.jpg";
     "job_title" = "Femme de chambre";
     status = 0;
     updatedOn = "2017-08-22 14:48:58";
     "user_id" = 42;
     },
     
     */

    self.lblTitle.text=[dict valueForKey:@"job_title"];
    NSString *status =[dict valueForKey:@"status"];
    
    self.lblDescription.text= [dict valueForKey:@"activity_title"];//[self getDescriptionWithStatus:[status intValue]];
    
    self.lblTime.text=[self getAgoTime:currentTime dateCreatedOn:[dict valueForKey:@"createdOn"]];
    
    [self.imgProfilePic sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"job_image"]] placeholderImage:[UIImage imageNamed:@"default_job.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        if (error)
        {
            [self.imgProfilePic setImage:[UIImage imageNamed:@"default_job.png"]];
        }
    }];
    
    
//    [self.imgProfilePic sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"job_image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//     {
//         if (!error)
//         {
//
//         }
//         else
//         {
//             [_imgProfilePic setImage:[UIImage imageNamed:@"dummy.png"]];
//         }
//     }];
    
}

// status===>0(You have applied),1(You have been pre-selected.),2(Your application has not been accepted.),3(You have selected)for Activity
-(NSString*)getDescriptionWithStatus:(int)status{
   
    if (status == 0)
    {
        return NSLocalizedString(@"You have applied", @"");
    }
    else if (status == 1)
    {
        return NSLocalizedString(@"You have been pre-selected.", @"");
     
    }
    else if (status ==2)
    {
        return NSLocalizedString(@"Your application has not been accepted.", @"");
    
    }
    else if(status ==3)
    {
        return NSLocalizedString(@"You have selected", @"");

    }
    else if(status ==4)
    {
        return NSLocalizedString(@"Your application hasbeen expired", @"");
        
    }
  return @"";
}

-(NSString*)getAgoTime:(NSString*)currentDate dateCreatedOn:(NSString*)createdOn{
    
    //converting the date to required format.
    NSDate *date1 = [SharedClass getDateFromStringFormat:createdOn inputDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [SharedClass getDateFromStringFormat:currentDate inputDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //Calculating the time interval
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
    int numberOfDays = secondsBetween / 86400;
    int timeResult = ((int)secondsBetween % 86400);
    int hour = timeResult / 3600;
    int hourResult = ((int)timeResult % 3600);
    int minute = hourResult / 60;
    int second = ((int)timeResult % 60);

    
//    "There is" = "";
//    "minutes" = "minutes ago";
//    "hours" = "hours ago";
//    "seconds" = "seconds ago";
    NSString *thereIs =  NSLocalizedString(@"There is", @"");
    if(numberOfDays > 0)
    {
        
        if(numberOfDays == 1)
        {
            return [NSString stringWithFormat:@"%@ %d %@",thereIs,numberOfDays,NSLocalizedString(@"days", @"")];
            
        }
        else
        {
            return [NSString stringWithFormat:@"%@ %d %@",thereIs,numberOfDays,NSLocalizedString(@"days", @"")];
        }
    }
    
    else if(numberOfDays == 0 && hour > 0)
    {
        if(numberOfDays == 0 && hour == 1)
        {
            return [NSString stringWithFormat:@"%@ %d %@",thereIs,hour,NSLocalizedString(@"hours", @"")];
        }
        else
        {
            return [NSString stringWithFormat:@"%@ %d %@",thereIs,hour,NSLocalizedString(@"hours", @"")];
        }
    }
    else if(numberOfDays == 0 && hour == 0 && minute > 0)
    {
        if(numberOfDays == 0 && hour == 0 && minute == 1)
        {
            return  [NSString stringWithFormat:@"%@ %d %@",thereIs,minute,NSLocalizedString(@"minutes", @"")];
            
        }
        else
        {
           
            return  [NSString stringWithFormat:@"%@ %d %@",thereIs,minute,NSLocalizedString(@"minutes", @"")];
        }
        
    }
    else
    {
        return  [NSString stringWithFormat:@"%@ %d %@",thereIs,second,NSLocalizedString(@"seconds", @"")];
    }

}

@end
