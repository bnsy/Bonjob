//
//  ActiveViewController.m
//  BONJOB
//
//  Created by Infoicon Technologies on 02/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "ActiveViewController.h"
#import "ActivityCell.h"
#import "JobOfferDetailViewController.h"
#import "SharedClass.h"
@interface ActiveViewController ()
{
    NSMutableArray *arrResponse;
    NSString *currentTime;
}
@end

@implementation ActiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    [SharedClass setBorderOnButton:self.btnSearchForJob];
    self.title = [SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"ACTIVITY", @"")];// NSLocalizedString(@"ACTIVITY", @"");
    [[self.tabBarController.tabBar.items objectAtIndex:3] setTitle:NSLocalizedString(@"ACTIVITY", @"")];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setUserActivity:) name:@"setuseractivity" object:nil];
    [SharedClass setLabelOnTableviewBackground:_tblActivity title:NSLocalizedString(@"Aucune activité pour l'instant.", @"Aucune activité pour l'instant.") ];
  //  [SharedClass ]
//[Shared]
    
}
-(void)setUserActivity:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"] intValue]>0)
    {
//        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeValue:nil];
//        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"useractivitycount"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeColor:InternalButtonColor];
        [self getActivity];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeValue:nil];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"useractivitycount"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else
    {
    [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeColor:InternalButtonColor];
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self getActivity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getActivity
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"getactivity";
    [webhelper webserviceHelper:params webServiceUrl:kGetSeekerActivity methodName:@"getactivity" showHud:YES inWhichViewController:self];
}
-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[responseDict valueForKey:@"active_user"] isEqualToString:@"0"])
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"] isEqualToString:@"S"])
        {
            //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
            //[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
            //[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
            //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([methodNameIs isEqualToString:@"getactivity"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            arrResponse =[[NSMutableArray alloc]init];
            
            currentTime = responseDict[@"current_time"];
            arrResponse = responseDict[@"data"];
            
            // chk the response and assign the value
            if (arrResponse.count>0)
            {
                [_viewNoData setHidden:YES];
            }
            else
            {
                [_viewNoData setHidden:NO];
            }
            [_tblActivity reloadData];
        }
    }
    else if ([methodNameIs isEqualToString:@"acceptjob"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==YES)
        {
            [self getActivity];
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        else
        {
            [Alerter.sharedInstance showWarningWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"rejectjob"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==YES)
        {
            [self getActivity];
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
        else
        {
            [Alerter.sharedInstance showWarningWithMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}

#pragma mark - --------TableView Delegates------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"selectedByEmployer"] length]>0)
    {
        return 152;
    }
    else
    {
        return 100;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrResponse.count == 0)
    {
        
        return 0;
    }
    else
    {
        self.tblActivity.backgroundView = nil;
         return arrResponse.count;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell *cell;
    if ([[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"selectedByEmployer"] length]>0)
    {
       cell= [tableView dequeueReusableCellWithIdentifier:@"ActivityCellJobOffer"];
    }
    else
    {
       cell= [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    }
    if (!cell)
    {
        cell=(ActivityCell *)[[ActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityCell"];
    }
    //cell.imgProfilePic.contentMode=UIViewContentModeScaleAspectFit;
    cell.imgProfilePic.layer.cornerRadius = cell.imgProfilePic.frame.size.width / 2;
    cell.imgProfilePic.clipsToBounds = YES;
    cell.imgProfilePic.layer.borderWidth=1.0;
    cell.imgProfilePic.layer.borderColor=[UIColor lightGrayColor].CGColor;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setdata:arrResponse[indexPath.row] currentTime:currentTime];
    cell.btnAccept.backgroundColor=TitleColor;
    cell.btnReject.backgroundColor=InternalButtonColor;
    cell.btnAccept.layer.cornerRadius=18;
    cell.btnReject.layer.cornerRadius=18;
    [cell.btnReject addTarget:self action:@selector(btnRejectJobAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAccept addTarget:self action:@selector(btnAcceptJobAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnAccept setTitle:NSLocalizedString(@"Accpet", @"") forState:UIControlStateNormal];
    [cell.btnReject setTitle:NSLocalizedString(@"Reject", @"") forState:UIControlStateNormal];
    [cell.btnAccept setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cell.btnReject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cell.btnReject.tag=indexPath.row;
    cell.btnAccept.tag=indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobOfferDetailViewController *jvc=[self.storyboard instantiateViewControllerWithIdentifier:@"JobOfferDetailViewController"];
    jvc.jobId=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_id"];
//    jvc.employer_id=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"user_id"];
//    jvc.job_id=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_id"];
//    jvc.SelectedJobIndex = [NSString stringWithFormat:@"%ld", indexPath.row];
//    jvc.CompanyName=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"enterprise_name"];
    [self.navigationController pushViewController:jvc animated:YES];
}


- (IBAction)btnSearchForJobAction:(id)sender
{
     [self.tabBarController setSelectedIndex:0];
}

#pragma mark - ---------ACCEPT/REJECT JOB OFFER-------

-(void)btnRejectJobAction:(UIButton *)sender
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[arrResponse objectAtIndex:sender.tag]valueForKey:@"selectedByEmployer"] forKey:@"selected_id"];
    [params setValue:[[arrResponse objectAtIndex:sender.tag]valueForKey:@"activity_id"] forKey:@"activity_id"];
    [params setValue:[[arrResponse objectAtIndex:sender.tag]valueForKey:@"job_id"] forKey:@"job_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"rejectjob";
    [webhelper webserviceHelper:params webServiceUrl:kRejectJobByCandidate methodName:@"rejectjob" showHud:YES inWhichViewController:self];
}
-(void)btnAcceptJobAction:(UIButton *)sender
{
    //{"selected_id":"3","activity_id":"42","job_id":"21"}

    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[arrResponse objectAtIndex:sender.tag]valueForKey:@"selectedByEmployer"] forKey:@"selected_id"];
    [params setValue:[[arrResponse objectAtIndex:sender.tag]valueForKey:@"activity_id"] forKey:@"activity_id"];
    [params setValue:[[arrResponse objectAtIndex:sender.tag]valueForKey:@"job_id"] forKey:@"job_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"acceptjob";
    [webhelper webserviceHelper:params webServiceUrl:kAcceptJobByCandidate methodName:@"acceptjob" showHud:YES inWhichViewController:self];
}



@end
