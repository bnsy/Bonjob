//
//  FaqCell.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/16/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaqCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *lblAnswer;
@property (weak, nonatomic) IBOutlet UIButton *btnExpand;

@end
