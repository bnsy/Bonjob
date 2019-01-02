//
//  PaymentDataViewController.m
//  BONJOB
//
//  Created by VISHAL SETH on 09/02/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import "PaymentDataViewController.h"
@implementation PaymentDataCell


@end

@interface PaymentDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PaymentDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [SharedClass setShadowOnView:self.viewPopup];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btncloseAction) name:@"Close" object:nil];
}


-(void)btncloseAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - -------UITABLEVIEW DELEGTES & DATASOURCES

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return APPDELEGATE.arrPlanData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaymentDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PaymentDataCell"];
    if (indexPath.row==1)
    {
        cell.lblPlanName.textColor=InternalButtonColor;
        cell.lblPlanAmount.textColor=InternalButtonColor;
        cell.lblPlanValidity.textColor=InternalButtonColor;
    }
    NSLog(@"%@",APPDELEGATE.arrPlanData); cell.lblPlanName.text=[APPDELEGATE.arrPlanData[indexPath.row] valueForKey:@"subscription_title"];
     NSArray *foo=[[APPDELEGATE.arrPlanData[indexPath.row] valueForKey:@"description"] componentsSeparatedByString:PriceSymbol];
    
    cell.lblPlanAmount.text= [NSString stringWithFormat:@"%@ €",[foo objectAtIndex:0]] ;
    cell.lblPlanValidity.text=[foo objectAtIndex:1];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected IndexPath:%ld",(long)indexPath.row);
    [self dismissViewControllerAnimated:NO completion:^{
          [self.delegate paymentPlanSelected:indexPath.row];
    }];
  
}

- (IBAction)btnClosePopupAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate paymentPopupClose];
}

@end
