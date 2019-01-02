//
//  MyOffersCell.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/16/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLProgressBar.h"
@interface MyOffersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet YLProgressBar *viewProgressBar;

-(void)setdata:(NSDictionary *)dict currentTime:(NSDate *)currentTime;
@end
