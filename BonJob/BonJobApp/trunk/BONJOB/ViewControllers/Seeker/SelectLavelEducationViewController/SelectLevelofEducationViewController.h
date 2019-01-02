//
//  SelectLevelofEducationViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/9/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EducationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnSelectEducation;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@end

@protocol EducationLevelDelegate <NSObject>

-(void)levelofEducationSelected:(NSString *)education title:(NSString*)educationTitle screenTitle:(NSString*)titled;

@end

@interface SelectLevelofEducationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblEducation;
@property (weak, nonatomic) IBOutlet UILabel *lblLevelEducation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSaveEducation;
@property(nonatomic,strong)id<EducationLevelDelegate>delegate;
- (IBAction)btnSaveEducationAction:(id)sender;
@property (nonatomic,strong) NSString *titled;


@end
