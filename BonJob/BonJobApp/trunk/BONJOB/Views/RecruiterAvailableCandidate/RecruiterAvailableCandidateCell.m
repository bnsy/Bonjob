//
//  RecruiterAvailableCandidateCell.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterAvailableCandidateCell.h"
#import "GetAppliedCandidate.h"
@implementation RecruiterAvailableCandidateCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    transform = CATransform3DScale(self.progressCandidateTime.layer.transform, 1.0f, 3.0f, 1.0f);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)dict currentTime:(NSDate *)currentTime
{
    NSString *exp=@"";
    if ([[dict valueForKey:@"experience"] length]>0)
    {
       exp =[dict valueForKey:@"experience"];
       exp = [self getExperience:exp];
    }
    
    exp=[dict valueForKey:@"experience"];
    exp=[self getExperience:exp];
    
    _lblCandidateName.text = [dict valueForKey:@"first_name"];
    _lblCandidateSalrie.text = [dict valueForKey:@"current_status_name"];
    _lblCandidateExp.text = [NSString stringWithFormat:@"%@ %@",exp,NSLocalizedString(@"experienceholder", @"")];
    _lblCandidateAppliedFor.text= [dict valueForKey:@"job_title"];
    [_imgCandidateImage sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"user_pic"]] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (error)
         {
             [_imgCandidateImage setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
         }
     }];
    _imgCandidateImage.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _imgCandidateImage.layer.borderWidth=1.0;
    
    _imgCandidateImage.layer.cornerRadius=_imgCandidateImage.frame.size.width/2;
    _imgCandidateImage.layer.masksToBounds=YES;
    self.progressCandidateTime.layer.borderWidth=0.3;
    self.progressCandidateTime.layer.borderColor=TitleColor.CGColor;
    [self.progressCandidateTime setProgress:0 animated:YES];
    self.lblCandidateTime.text=@"";
    
//    NSString *strCreatedOn=[dict valueForKey:@"createdOn"];
//    NSString *strServerTime =[[[GetAppliedCandidate getCandidate]getResponseData]valueForKey:@"current_date"] ;
    
    
    NSString *strCreatedOn =  [dict valueForKey:@"createdOn"];
    NSDate *dateFrom =  [SharedClass getDateFromStringFormat:strCreatedOn inputDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate *dateTo =  [SharedClass getDateFromStringFormat:currentTime inputDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateTo=currentTime;
    
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    // ignore +11 and use timezone name instead of seconds from gmt
//    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Paris"]];
//    NSDate *dte = [dateFormat dateFromString:strCreatedOn];
//
//
//    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
//    // ignore +11 and use timezone name instead of seconds from gmt
//    [dateFormat1 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Paris"]];
//    NSDate *dte1 = [dateFormat dateFromString:strServerTime];
//
//    NSDate *oldTime = dte;
//    NSDate *dateTo = currentTime;
    NSString *duration = [self calculateDuration:dateFrom secondDate:dateTo];
    if ([duration isEqualToString:@"00:00:00"])
    {
        self.lblCandidateTime.text = @"00:00:00";
    }
    else
    {
        self.lblCandidateTime.text=duration;
    }
    
    //_lblCandidateTime.text=duration;
    
    [self.progressCandidateTime setProgressTintColor:TitleColor];
    [self.progressCandidateTime setBackgroundColor:[UIColor whiteColor]];
    [self.progressCandidateTime setProgress:[[self calculatePercentage:duration] floatValue]/100 animated:YES];
    //transform = CATransform3DScale(self.progressCandidateTime.layer.transform, 1.0f, 3.0f, 1.0f);
    self.progressCandidateTime.layer.transform = transform;
    
    
    
    [self.viewProgressBar setProgressTintColor:TitleColor];
    [self.viewProgressBar setBackgroundColor:[UIColor whiteColor]];
    _viewProgressBar.layer.borderWidth=1.5;
    _viewProgressBar.layer.cornerRadius=8;
    _viewProgressBar.layer.borderColor=TitleColor.CGColor;
    //_viewProgressBar.stripesOrientation       = YLProgressBarStripesOrientationLeft;
    _viewProgressBar.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeNone;
    _viewProgressBar.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    _viewProgressBar.progressStretch          = NO;
    [_viewProgressBar setProgress:[[self calculatePercentage:duration] floatValue]/100 animated:YES];
    
    
    NSArray *tintColors = @[TitleColor];
    
    _viewProgressBar.progressTintColors       = tintColors;
 
}

-(void)setArchievedData:(NSDictionary *)dict
{
    NSString *exp=@"";
//    if ([[dict valueForKey:@"experience"] count]>0)
//    {
        //exp =[[dict valueForKey:@"experience"] objectAtIndex:0];
   // }
    exp=[dict valueForKey:@"experience"];
    exp=[self getExperience:exp];
    _lblCandidateName.text = [dict valueForKey:@"first_name"];
    _lblCandidateSalrie.text = [dict valueForKey:@"current_status_name"];
    _lblCandidateExp.text = [NSString stringWithFormat:@"%@ %@",exp,NSLocalizedString(@"experienceholder", @"")];
    _lblCandidateAppliedFor.text= [dict valueForKey:@"job_title"];
    [_imgCandidateImage sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"user_pic"]] placeholderImage:[UIImage imageNamed:@"default_photo_deactive.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (error)
         {
             [_imgCandidateImage setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
         }
    }];
    _imgCandidateImage.layer.cornerRadius=_imgCandidateImage.frame.size.width/2;
    _imgCandidateImage.layer.masksToBounds=YES;
    _imgCandidateImage.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _imgCandidateImage.layer.borderWidth=1.0;
    self.progressCandidateTime.layer.borderWidth=0.3;
    self.progressCandidateTime.layer.borderColor=TitleColor.CGColor;
    [self.progressCandidateTime setProgress:0 animated:YES];
    self.lblCandidateTime.text=@"";
    
    self.progressCandidateTime.layer.transform = transform;
    [self.progressCandidateTime setHidden:NO];
    _lblCandidateTime.text=NSLocalizedString(@"expired", @"");
    
    
    [self.viewProgressBar setProgressTintColor:TitleColor];
    [self.viewProgressBar setBackgroundColor:[UIColor whiteColor]];
    _viewProgressBar.layer.borderWidth=1.5;
    _viewProgressBar.layer.cornerRadius=8;
    _viewProgressBar.layer.borderColor=TitleColor.CGColor;
    //_viewProgressBar.stripesOrientation       = YLProgressBarStripesOrientationLeft;
    _viewProgressBar.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeNone;
    _viewProgressBar.indicatorTextLabel.font  = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    _viewProgressBar.progressStretch          = NO;
    [_viewProgressBar setProgress:0];
    
    
    NSArray *tintColors = @[TitleColor];
    
    _viewProgressBar.progressTintColors       = tintColors;
}



-(NSString *)calculatePercentage:(NSString *)duration
{
    NSArray *components = [duration componentsSeparatedByString:@":"];
    
    int hours   = [[components objectAtIndex:0] intValue];
    int minutes = [[components objectAtIndex:1] intValue];
    int seconds = [[components objectAtIndex:2] intValue];
    
    
    //NSNumber *Totalseconds =[NSNumber numberWithInteger:(hours * 60 * 60) + (minutes * 60) + seconds];
    int totalSeconds=(hours * 60 * 60) + (minutes * 60) + seconds;
    int totalSecondsInaDay = 48*60*60;
    
    float Percentage = (totalSeconds * 100)/totalSecondsInaDay;
    
    return [NSString stringWithFormat:@"%.2f",Percentage];
    
}

- (NSString *)calculateDuration:(NSDate *)oldTime secondDate:(NSDate *)currentTime
{
    NSDate *date1 = oldTime;
    NSDate *date2 = currentTime;
    
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
    int hh = secondsBetween / (60*60);
    double rem = fmod(secondsBetween, (60*60));
    int mm = rem / 60;
    rem = fmod(rem, 60);
    int ss = rem;
    
    //NSString *str = [NSString stringWithFormat:@"%02d:%02d:%02d",hh,mm,ss];
    
    float totalSecondsInaDay=48*60*60;
    float totalSecondsDiff=hh*60*60+mm*60+ss;
    
    float diff=totalSecondsInaDay-totalSecondsDiff;
    
    int hh1 = diff / (60*60);
    double rem1 = fmod(diff, (60*60));
    int mm1 = rem1 / 60;
    rem1 = fmod(rem1, 60);
    int ss1 = rem1;
    NSString *str1 = [NSString stringWithFormat:@"%02d:%02d:%02d",hh1,mm1,ss1];

    return str1;
}

-(void)setCells
{
    //self.progressCandidateTime.layer.borderColor =TitleColor.CGColor;
   // self.progressCandidateTime.layer.borderWidth=1.8;
    //[self.progressCandidateTime setProgress:0.0];
    self.layer.cornerRadius=5.0;
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
