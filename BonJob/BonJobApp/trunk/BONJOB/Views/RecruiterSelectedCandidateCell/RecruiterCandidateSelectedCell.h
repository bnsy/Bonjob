//
//  RecruiterCandidateSelectedCell.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecruiterCandidateSelectedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgDefaultPic;
@property (weak, nonatomic) IBOutlet UIButton *btnArchieve;
@property (weak, nonatomic) IBOutlet UIButton *btnHired;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblSalrie;
@property (weak, nonatomic) IBOutlet UILabel *lblExp;
@property (weak, nonatomic) IBOutlet UILabel *lblJobProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblCandidateExp;

-(void)setData:(NSDictionary *)data;
-(void)setCells;
@end
