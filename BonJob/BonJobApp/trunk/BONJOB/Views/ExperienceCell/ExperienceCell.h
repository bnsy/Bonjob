//
//  ExperienceCell.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/6/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExperienceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *expSegment;
@property (weak, nonatomic) IBOutlet UILabel *lblPositionHeld;
@property (weak, nonatomic) IBOutlet UITextField *lblCompanyName;
@property (weak, nonatomic) IBOutlet UIButton *btnCompanyName;
@property (weak, nonatomic) IBOutlet UIButton *btnPositionHeld;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblCharacterCount;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnRemove;
@property (weak, nonatomic) IBOutlet UILabel *lblIndustryType;
@property (weak, nonatomic) IBOutlet UIView *viewNoExp;

//By CS Rai

@property (weak, nonatomic) IBOutlet UILabel *labelSepratorSearch;
@property (weak, nonatomic) IBOutlet UILabel *labelSepratorPencil;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewSearch;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewEdit;

@end
