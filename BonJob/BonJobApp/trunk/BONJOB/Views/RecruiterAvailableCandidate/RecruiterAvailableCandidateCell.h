//
//  RecruiterAvailableCandidateCell.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLProgressBar.h"
@interface RecruiterAvailableCandidateCell : UITableViewCell
{
    CATransform3D transform;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgCandidateImage;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateName;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateSalrie;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateExp;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateAppliedFor;
@property (weak, nonatomic) IBOutlet UIProgressView *progressCandidateTime;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateTime;
@property (weak, nonatomic) IBOutlet YLProgressBar *viewProgressBar;


-(void)setArchievedData:(NSDictionary *)dict;
-(void)setData:(NSDictionary *)dict currentTime:(NSDate *)currentTime;
-(void)setCells;
@end
