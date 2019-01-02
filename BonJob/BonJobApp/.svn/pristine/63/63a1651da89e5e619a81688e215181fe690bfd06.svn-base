//
//  RecruiterAvailabelCandidateViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterAvailabelCandidateViewController.h"
#import "RecruiterLookCandateProfileViewController.h"
#import "RecruiterAvailableCandidateCell.h"
#import "GetAppliedCandidate.h"
@interface RecruiterAvailabelCandidateViewController ()
{
    BOOL sectionTapped;
    BOOL atTop;
    UIButton *btnDropDown;
    NSMutableDictionary *dictJobData;
    NSDate *currentDateTime;
    NSTimer *timer;
    
}
@end

@implementation RecruiterAvailabelCandidateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addHeaderOnBlockOfferView];
    [self addTapGestures];
   
    _lblTitle.text=NSLocalizedString(@"No candidates waiting for the moment", @"");
    [_btnSearchCandidate setTitle:NSLocalizedString(@"Search for candidates", @"") forState:UIControlStateNormal];
    [_btnJobTemplate setTitle:NSLocalizedString(@"Post a Job", @"") forState:UIControlStateNormal];
    [_lblTitle setTextColor:InternalButtonColor];
    [SharedClass setBorderOnButton:_btnSearchCandidate];
    [SharedClass setBorderOnButton:_btnJobTemplate];
    [_btnSearchCandidate setBackgroundColor:InternalButtonColor];
    [_btnJobTemplate setBackgroundColor:TitleColor];
    [_btnJobTemplate addTarget:self action:@selector(btnJobTemplateAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSearchCandidate addTarget:self action:@selector(btnSearchCandidateAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //self.viewBlockCandidate.frame = CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, self.view.frame.size.height);
    // Do any additional setup after loading the view.
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCandidate) name:@"AvailableCandidate" object:nil];
    
    int count=[[[NSUserDefaults standardUserDefaults] valueForKey:@"offercount"] intValue];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%d",count]];
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"offercount"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
    [self startCountDown];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setUserActivity:) name:@"setuseractivity" object:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
  //  self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    [self.refreshControl addTarget:self
                            action:@selector(getCandidate)
                  forControlEvents:UIControlEventValueChanged];
    [self.tblAvilableCandidate addSubview:_refreshControl];
}

- (void)reloadData
{
    // Reload table data
    [self.tblAvilableCandidate reloadData];
    
    // End the refreshing
    if (self.refreshControl)
    {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:SET_FORMAT_TYPE4];
        NSString *title = [NSString stringWithFormat:@"Dernière mise à jour: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        [self.refreshControl endRefreshing];
    }
}

-(void)setMyOfferCount:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"] intValue]>0)
    {
        [self getCandidate];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Recruteroffercount"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[self.tabBarController.tabBar.items objectAtIndex:1]setBadgeValue:nil];
     [self getCandidate];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.viewBlockCandidate.frame = CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, self.view.frame.size.height);
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

-(void)btnJobTemplateAction:(UIButton *)button
{
    [self.tabBarController setSelectedIndex:3];
}

-(void)btnSearchCandidateAction:(UIButton *)button
{
    [self.tabBarController setSelectedIndex:0];
}

#pragma mark - -----------Get Candidate List-------------

-(void)getCandidate
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"getCandidate";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:kAppliedCandidate methodName:@"getCandidate" showHud:YES inWhichViewController:self];
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
            //[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
           // [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
           // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([methodNameIs isEqualToString:@"getCandidate"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==1)
        {
            if ([[[responseDict valueForKey:@"data"] valueForKey:@"appliedList"] count]>0)
            {
                [_viewNoData setHidden:YES];
            }
            else
            {
                [_viewNoData setHidden:NO];
                
            }
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[NSString stringWithFormat:@"%lu",[[[responseDict valueForKey:@"data"] valueForKey:@"appliedList"] count]] forKey:@"count"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"availableCandidateCount" object:nil userInfo:dict];
            
            [[GetAppliedCandidate getCandidate]setResponseData:[responseDict valueForKey:@"data"]];
            dictJobData=[[NSMutableDictionary alloc]init];
            dictJobData=[[GetAppliedCandidate getCandidate]getResponseData];
            [_tblAvilableCandidate reloadData];
            [_tblBlockedCandidate reloadData];
            NSString *currentTime = responseDict[@"data"][@"current_date"];
            currentDateTime =  [SharedClass getDateFromStringFormat:currentTime inputDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            [self reloadData];
        }
        else
        {
            
            [[GetAppliedCandidate getCandidate]setResponseData:[responseDict valueForKey:@"data"]];
            dictJobData=[[NSMutableDictionary alloc]init];
            dictJobData=[[GetAppliedCandidate getCandidate]getResponseData];
            [_tblAvilableCandidate reloadData];
            [_tblBlockedCandidate reloadData];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:@"0" forKey:@"count"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"availableCandidateCount" object:nil userInfo:dict];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [self reloadData];
        }
    }
}

#pragma mark - ----------TableView Delegates and DataSources------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tblAvilableCandidate)
    {
        return [[dictJobData valueForKey:@"appliedList"] count];
    }
    else
        return [[dictJobData valueForKey:@"archivedList"] count];;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecruiterAvailableCandidateCell *cell=(RecruiterAvailableCandidateCell *)[tableView dequeueReusableCellWithIdentifier:@"RecruiterAvailableCandidateCell"];
    if (!cell)
    {
        cell=[[RecruiterAvailableCandidateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecruiterAvailableCandidateCell"];
    }
    if (tableView==_tblAvilableCandidate)
    {
        [cell setData:[[dictJobData valueForKey:@"appliedList"]objectAtIndex:indexPath.row] currentTime:currentDateTime];
    }
    else if(tableView == _tblBlockedCandidate)
    {
        [cell setArchievedData:[[dictJobData valueForKey:@"archivedList"]objectAtIndex:indexPath.row]];
    }
    [cell setCells];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict=[[dictJobData valueForKey:@"appliedList"]objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"visitCandidateProfile" object:nil userInfo:dict];

    //visitCandidateProfile
}

-(void)addHeaderOnBlockOfferView
{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    header.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:0.5];
    
    UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, 3,200, 30)];
    [lblTitle setFont:[UIFont systemFontOfSize:17]];
    [lblTitle setTextColor:InternalButtonColor];
    [lblTitle setText:NSLocalizedString(@"Archived candidates", @"")];
    lblTitle.textAlignment=NSTextAlignmentCenter;
    [header addSubview:lblTitle];
    
    btnDropDown =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50, 10, 25, 15)];
    if (sectionTapped)
    {
        [btnDropDown setImage:[UIImage imageNamed:@"toggle_down"] forState:UIControlStateNormal];
    }
    else
    {
        [btnDropDown setImage:[UIImage imageNamed:@"toggle_up"] forState:UIControlStateNormal];
    }
    
    [btnDropDown addTarget:self action:@selector(btnToggleTapped:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btnDropDown];
    [self.viewBlockCandidate addSubview:header];
}

#pragma mark - ----------Animate Blockedview and Button Actions Here------------

-(void)btnToggleTapped:(UIButton *)btn
{
    
    if (atTop)
    {
        atTop=NO;
        [self animateView:NO];
        if ([[dictJobData valueForKey:@"appliedList"] count] == 0) {
            [self.viewNoData setHidden:NO];
        }
    }
    else
    {
        atTop=YES;
        [self animateView:YES];
        if ([[dictJobData valueForKey:@"appliedList"] count] == 0) {
            [self.viewNoData setHidden:YES];
        }
    }
}

-(void)animateView:(BOOL)B
{
    if (B)
    {
        [self.viewBlockCandidate setAlpha:0.0f];
        [UIView animateWithDuration:1.0f animations:^{
            
            [self.viewBlockCandidate setAlpha:1.0f];
            
            [UIView animateWithDuration:0.5
                                  delay:0.1
                                options: UIViewAnimationCurveEaseIn
                             animations:^{
                                 self.viewBlockCandidate.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                                 self.tblBlockedCandidate.frame=CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height-25);
                                 
                                 
                             }
                             completion:^(BOOL finished)
             {
                 [UIView animateWithDuration:0.3f animations:^{
                     CGAffineTransform transform = btnDropDown.imageView.transform;
                     CGAffineTransform transform_new = CGAffineTransformRotate(transform, M_PI);
                     btnDropDown.imageView.transform = transform_new;
                     
                 }];
                 
             }];
            
        } completion:^(BOOL finished) {
            
            //fade out
            
            
        }];
        
    }
    else
    {
        [UIView animateWithDuration:1.0f animations:^{
            
            [self.viewBlockCandidate setAlpha:0.8f];
            
            [UIView animateWithDuration:0.5
                                  delay:0.1
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.viewBlockCandidate.frame = CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, self.view.frame.size.height);
                                 
                                 self.tblBlockedCandidate.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, self.view.frame.size.height-20);
                                 [self.viewBlockCandidate setAlpha:1.0f];
                             }
                             completion:^(BOOL finished)
             {
                 [UIView animateWithDuration:0.3f animations:^{
                     CGAffineTransform transform = btnDropDown.imageView.transform;
                     CGAffineTransform transform_new = CGAffineTransformRotate(transform, M_PI);
                     btnDropDown.imageView.transform = transform_new;
                     
                 }];
             }];
        } completion:^(BOOL finished) {
            
            //fade out
            
            
        }];
    }
    
}

-(void)addShadow:(UIView *)demoView
{
    demoView.layer.cornerRadius = 2;
    demoView.layer.shadowColor = [UIColor blackColor].CGColor;
    demoView.layer.shadowOffset = CGSizeMake(0.5, 4.0); //Here your control your spread
    demoView.layer.shadowOpacity = 0.5;
    demoView.layer.shadowRadius = 5.0;
}
-(void)addTapGestures
{
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highlightLetter:)];
    [self.viewBlockCandidate addGestureRecognizer:letterTapRecognizer];
    
}
- (void)highlightLetter:(UITapGestureRecognizer*)sender
{
    if (atTop)
    {
        atTop=NO;
        [self animateView:NO];
    }
    else
    {
        atTop=YES;
        [self animateView:YES];
    }
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
    [_tblAvilableCandidate reloadData];
}


@end
