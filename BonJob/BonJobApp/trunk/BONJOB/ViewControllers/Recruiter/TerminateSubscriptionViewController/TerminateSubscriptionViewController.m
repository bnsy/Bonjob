//
//  TerminateSubscriptionViewController.m
//  BONJOB
//
//  Created by VISHAL SETH on 13/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import "TerminateSubscriptionViewController.h"

@interface TerminateSubscriptionViewController ()

@end

@implementation TerminateSubscriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewPopup.layer.cornerRadius=17;
    self.btnCancel.layer.cornerRadius=20;
    self.btnConfirm.layer.cornerRadius=20;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnConfirmAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnCancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
