//
//  SearchCandidateCell.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLProgressBar.h"
@interface SearchCandidateCell : UITableViewCell
{
        CATransform3D transform;
}
@property (weak, nonatomic) IBOutlet UILabel *lblSearchPercentage;
@property (weak, nonatomic) IBOutlet YLProgressBar *viewProgressBar;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateName;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateLocation;
@property (weak, nonatomic) IBOutlet UIImageView *imgCandidatePic;
-(void)setData:(NSDictionary *)dict withDistance:(float)distanceInKM;
@end
