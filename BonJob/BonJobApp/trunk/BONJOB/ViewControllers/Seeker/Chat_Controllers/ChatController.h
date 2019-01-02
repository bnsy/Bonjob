//
//  ChatListController.h
//  Whatsapp
//
//  Created by Rafael Castro on 7/24/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import <UIKit/UIKit.h>

//
// This class is a list of chat conversations
//
@interface ChatController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewDefaultView;
@property (weak, nonatomic) IBOutlet UIButton *btnGotoSearchJob;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcomeTitle;

- (IBAction)btnGotoJobAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
