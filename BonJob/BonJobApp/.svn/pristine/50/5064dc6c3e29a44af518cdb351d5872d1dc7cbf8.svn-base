//
//  MyOffersViewController.m
//  BONJOB
//
//  Created by Infoicon Technologies on 02/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "MyOffersViewController.h"
#import "MyOffersCell.h"
#import "JobOfferDetailViewController.h"
@interface MyOffersViewController ()
{
    NSMutableArray *arrResponse;
    NSString *currentTime;
    NSDate *currentDateTime;
    NSTimer *timer;
}
@end

@implementation MyOffersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    [SharedClass setBorderOnButton:self.btnSearchForJob];
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"MY OFFERS", @"")];// NSLocalizedString(@"MY OFFERS", @"");
    [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:NSLocalizedString(@"MY OFFERS", @"")];
    [SharedClass setBorderOnButton:self.btnGotoSearchJob];
    [self getMyOffers];
    [self startCountDown];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setUserActivity:) name:@"setuseractivity" object:nil];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _btnGotoSearchJob.frame.size.height+_btnGotoSearchJob.frame.origin.y+60)];
}

-(void)setUserActivity:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
        }
        else
        {
        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeColor:InternalButtonColor];
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self getMyOffers];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [timer invalidate];
//    timer=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getMyOffers
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"getOffers";
    [webhelper webserviceHelper:params webServiceUrl:kGetSeekerMyOffer methodName:@"getOffers" showHud:YES inWhichViewController:self];
}

-(void)inProgress:(float)value
{
    
}
-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
        {
           // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
           // [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
           // [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
           // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([methodNameIs isEqualToString:@"getOffers"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            arrResponse=[[NSMutableArray alloc]init];
            
            currentTime = responseDict[@"data"][@"current_time"];
            arrResponse = responseDict[@"data"][@"appliedList"];
            
            currentDateTime =  [SharedClass getDateFromStringFormat:currentTime inputDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            // chk the response and assign the value
            if (arrResponse.count>0)
            {
                [_scrollView setHidden:YES];
                [_viewNoData setHidden:YES];
            }
            else
            {
                [_scrollView setHidden:NO];
                [_viewNoData setHidden:NO];
            }
            
            [self.tblViewMyOffer reloadData];
        }
    }
}

#pragma mark - -------Button Action----------

- (IBAction)btnSearchForJobAction:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)btnGotoJobAction:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
}

#pragma mark - ------TableView Delegates-------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrResponse.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOffersCell *cell=(MyOffersCell *)[tableView dequeueReusableCellWithIdentifier:@"MyOffersCell"];
    if (!cell)
    {
        cell=[[MyOffersCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"MyOffersCell"];
    }
    cell.imgProfilePic.layer.cornerRadius = cell.imgProfilePic.frame.size.width / 2;
    cell.imgProfilePic.clipsToBounds = YES;
    cell.imgProfilePic.layer.borderWidth=1.0;
    cell.imgProfilePic.layer.borderColor=[UIColor lightGrayColor].CGColor;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 2.5f);
    cell.progressView.transform = transform;
    //cell.progressView.frame = CGRectMake(cell.progressView.frame.origin.x, cell.progressView.frame.origin.y, cell.progressView.frame.size.width, 3);
    cell.progressView.layer.borderWidth=1.0;
    cell.progressView.layer.cornerRadius=4;
    cell.progressView.progressTintColor=TitleColor;
    cell.progressView.clipsToBounds = YES;
    cell.progressView.layer.borderColor=TitleColor.CGColor;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setdata:arrResponse[indexPath.row]currentTime:currentDateTime];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobOfferDetailViewController *jvc=[self.storyboard instantiateViewControllerWithIdentifier:@"JobOfferDetailViewController"];
    jvc.jobId=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_id"];
    jvc.jobTitle=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_title"];
    [self.navigationController pushViewController:jvc animated:YES];
}

#pragma mark - ------------Live CountDown Time----------------
-(void)startCountDown
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(reloadTableData:)
                                           userInfo:nil
                                            repeats:YES];
}
-(void)reloadTableData:(NSTimer*)timer
{
    currentDateTime      = [currentDateTime dateByAddingTimeInterval:1];
    [_tblViewMyOffer reloadData];
}

@end
