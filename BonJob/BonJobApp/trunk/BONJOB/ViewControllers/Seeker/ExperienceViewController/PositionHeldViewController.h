//
//  PositionHeldViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/6/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemovePositionViewDelegate<NSObject>

-(void)removeCurrentView:(UIViewController *)viewController;

@end

@interface PositionHeldViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)id<RemovePositionViewDelegate> delegate;
- (IBAction)closePositionHeldView:(id)sender;
@end
