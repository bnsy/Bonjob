//
//  SelectLanguageViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/9/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LanguageSelectionDelegate <NSObject>

-(void)languageSelected:(NSString *)languages selectedid:(NSString*)sId;

@end

@interface SelectLanguageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UITableView *tblLanguage;
@property(nonatomic,strong)id<LanguageSelectionDelegate> delegate;
@end
