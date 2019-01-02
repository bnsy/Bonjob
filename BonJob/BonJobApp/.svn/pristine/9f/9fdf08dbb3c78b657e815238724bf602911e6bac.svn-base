//
//  RecruiterJobOffersViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/11/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterJobOffersViewController.h"
#import "RecruiterJobsCell.h"
#import "PostedJobData.h"
#import "PostaJobViewController.h"
@interface RecruiterJobOffersViewController ()
{
    BOOL sectionTapped;
    BOOL atTop;
    UIButton *btnDropDown;
    NSMutableDictionary *dictJobData;
    int Index;
}
@end

@implementation RecruiterJobOffersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lblTitle.text=NSLocalizedString(@"No job offers for the moment", @"");
    [_btnSearchCandidate setTitle:NSLocalizedString(@"Search for candidates", @"") forState:UIControlStateNormal];
    [_btnJobTemplate setTitle:NSLocalizedString(@"Post a Job", @"") forState:UIControlStateNormal];
    [_lblTitle setTextColor:InternalButtonColor];
    [SharedClass setBorderOnButton:_btnSearchCandidate];
    [SharedClass setBorderOnButton:_btnJobTemplate];
    [_btnSearchCandidate setBackgroundColor:InternalButtonColor];
    [_btnJobTemplate setBackgroundColor:TitleColor];
    [self addHeaderOnBlockOfferView];
    [self addTapGestures];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMyOfferCount:) name:@"setrecruiteroffercount" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMyOffer:) name:@"PublishSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LoadNewData:) name:@"PublishSuccessLoadNewData" object:nil];
    // Do any additional setup after loading the view.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
   // self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    [self.refreshControl addTarget:self
                            action:@selector(getJobOffers)
                  forControlEvents:UIControlEventValueChanged];
    [self.tblJobOffers addSubview:_refreshControl];
}

- (void)reloadData
{
    // Reload table data
    [self.tblJobOffers reloadData];
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJobOffers) name:@"jobofferupdated" object:nil];
    [self getJobOffers];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
   // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PublishSuccess" object:nil];
}

-(void)LoadNewData:(id)sender
{
    [self getJobOffers];
}

-(void)setMyOfferCount:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:1]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"]];
    }
}

-(void)getMyOffer:(id)sender
{
    [self getJobOffers];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.viewBlockOffers.frame = CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addHeaderOnBlockOfferView
{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    header.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:0.5];
    UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, 3,200, 30)];
    [lblTitle setFont:[UIFont systemFontOfSize:17]];
    [lblTitle setTextColor:InternalButtonColor];
    [lblTitle setText:NSLocalizedString(@"Archived offers", @"")];
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
    [self.viewBlockOffers addSubview:header];
}

#pragma mark - -----:::::::::--------WebService methods for get Job Offers------:::::::::-----
-(void)getJobOffers
{
    NSMutableDictionary *params=[NSMutableDictionary new];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"getMyOffers";
    webHelper.delegate=self;
    NSString *url=[NSString stringWithFormat:@"%@",kGetPostedJob];
    [webHelper webserviceHelper:params webServiceUrl:url methodName:@"getMyOffers" showHud:YES inWhichViewController:self];
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
    if ([methodNameIs isEqualToString:@"getMyOffers"])
    {
        if ([[responseDict valueForKey:@"success"]intValue]==1)
        {
            if ([[responseDict valueForKey:@"ActiveJobs"] count]>0)
            {
                [_viewNoData setHidden:YES];
            }
            else
            {
                [_viewNoData setHidden:NO];
            }
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[NSString stringWithFormat:@"%lu",[[responseDict valueForKey:@"ActiveJobs"] count]] forKey:@"count"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ActiveOfferCount" object:self userInfo:dict];
            
            
            [[PostedJobData getData]setJobData:[responseDict mutableCopy]];
             dictJobData=[[NSMutableDictionary alloc]init];
             dictJobData=[[PostedJobData getData]getJobData];
            [_tblJobOffers reloadData];
            [_tblBlockOffers reloadData];
            [self reloadData];
        }
        else
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:@"0" forKey:@"count"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ActiveOfferCount" object:self userInfo:dict];
            [self reloadData];
        }
    }
    else if ([methodNameIs isEqualToString:@"closeJob"])
    {
        if ([[responseDict valueForKey:@"success"] intValue]==1)
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            NSDictionary *dict=[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:Index];
            [[PostedJobData getData]changesActivetoClose:dict atIndex:Index];
            dictJobData = [[PostedJobData getData]getJobData];
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setValue:[NSString stringWithFormat:@"%lu",[[dictJobData valueForKey:@"ActiveJobs"] count]] forKey:@"count"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ActiveOfferCount" object:self userInfo:dictt];
            [_tblJobOffers reloadData];
            [_tblBlockOffers reloadData];
        }
    }
    else if ([methodNameIs isEqualToString:@"reOpenJob"])
    {
        if ([[responseDict valueForKey:@"success"] intValue]==1)
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            NSDictionary *dict=[[dictJobData valueForKey:@"closedJobs"] objectAtIndex:Index];
            [[PostedJobData getData]changesClosetoActive:dict atIndex:Index];
            dictJobData = [[PostedJobData getData]getJobData];
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setValue:[NSString stringWithFormat:@"%lu",[[dictJobData valueForKey:@"ActiveJobs"] count]] forKey:@"count"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ActiveOfferCount" object:self userInfo:dictt];
            [_tblJobOffers reloadData];
            [_tblBlockOffers reloadData];
        }
    }
}

-(void)inProgress:(float)value
{
    
}

#pragma mark - ----------Cell Buttons Actions------------

-(void)btnModifyOfferAction:(UIButton *)btn
{
    if ([[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] length]==0||[[APPDELEGATE.currentPlanDict  valueForKey:@"subscription_id"] length]==0)
    {
        if ([[APPDELEGATE.currentPlanDict valueForKey:@"job_post_count"] intValue]>=1)
        {
         
                
                [self openPaymentData];
                
            
        }
    }
    else
    {
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)btn.tag] forKey:@"selectedIndex"];
    [dict setValue:@"update" forKey:@"identifier"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"visitPostJobVIewController" object:self userInfo:dict];
    }
    
//    Index=(int)btn.tag;
//    //[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:Index]
//    PostajobViewController *psb=[self.storyboard instantiateViewControllerWithIdentifier:@"PostajobViewController"];
//    psb.index=[NSString stringWithFormat:@"%d",Index];
//    psb.identifier=@"update";
//    [self.navigationController pushViewController:psb animated:YES];
    
}
-(void)openPaymentData
{
    
    // By Cs Rai....
    // Dismiss overview popup first if it is already appearing
    
    
    // Show Payment data Popup
    PaymentDataViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDataViewController"];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)btnCloseOfferACtion:(UIButton *)btn
{
    Index=(int)btn.tag;
    NSMutableDictionary *params=[NSMutableDictionary new];
    [params setValue:[[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:btn.tag] valueForKey:@"job_id"] forKey:@"job_id"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"closeJob";
    webHelper.delegate=self;
    NSString *url=[NSString stringWithFormat:@"%@",kClosePostedJob];
    [webHelper webserviceHelper:params webServiceUrl:url methodName:@"closeJob" showHud:YES inWhichViewController:self];
}
-(void)btnReNewOfferAction:(UIButton *)btn
{
    Index=(int)btn.tag;
    NSMutableDictionary *params=[NSMutableDictionary new];
    [params setValue:[[[dictJobData valueForKey:@"closedJobs"] objectAtIndex:btn.tag] valueForKey:@"job_id"] forKey:@"job_id"];
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"reOpenJob";
    webHelper.delegate=self;
    NSString *url=[NSString stringWithFormat:@"%@",kReopenJob];
    [webHelper webserviceHelper:params webServiceUrl:url methodName:@"reOpenJob" showHud:YES inWhichViewController:self];
}


#pragma mark - ----------TableView Delegates------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tblJobOffers)
    {
        return [[dictJobData valueForKey:@"ActiveJobs"] count];
    }
    {
        return [[dictJobData valueForKey:@"closedJobs"] count];
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 222;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecruiterJobsCell *cell=(RecruiterJobsCell *)[tableView dequeueReusableCellWithIdentifier:@"RecruiterJobsCell"];
    if (!cell)
    {
        cell=[[RecruiterJobsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecruiterJobsCell"];
    }
    [cell setCells];
    
    if (tableView==_tblJobOffers)
    {
        [cell.btnCloseOffer setHidden:NO];
        [cell setValues:[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:indexPath.row]];
        [cell.btnModifyOffer addTarget:self action:@selector(btnModifyOfferAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnModifyOffer setTag:indexPath.row];
        [cell.btnCloseOffer setTitle:NSLocalizedString(@"Close the offer", @"") forState:UIControlStateNormal];
        [cell.btnModifyOffer setTitle:NSLocalizedString(@"Modify the offer", @"") forState:UIControlStateNormal];
    }
    else
    {
        
        [cell.btnCloseOffer setHidden:YES];
        [cell setValues:[[dictJobData valueForKey:@"closedJobs"] objectAtIndex:indexPath.row]];
        [cell.btnModifyOffer addTarget:self action:@selector(btnReNewOfferAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnModifyOffer setTag:indexPath.row];
        [cell.btnModifyOffer setTitle:NSLocalizedString(@"Renew", @"") forState:UIControlStateNormal];
    }
    [cell.btnCloseOffer setTag:indexPath.row];
    [cell.btnCloseOffer addTarget:self action:@selector(btnCloseOfferACtion:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - ----------Animate Blockedview and Button Actions Here------------

-(void)btnToggleTapped:(UIButton *)btn
{

    if (atTop)
    {
        atTop=NO;
        [self animateView:NO];
        if ([[dictJobData valueForKey:@"ActiveJobs"] count] == 0) {
            [self.viewNoData setHidden:NO];
        }
    }
    else
    {
        atTop=YES;
        [self animateView:YES];
        if ([[dictJobData valueForKey:@"ActiveJobs"] count] == 0) {
           [self.viewNoData setHidden:YES];
        }
       
    }
    
    
}

-(void)animateView:(BOOL)B
{
    if (B)
    {
        [self.viewBlockOffers setAlpha:0.0f];
        [UIView animateWithDuration:1.0f animations:^{
            
            [self.viewBlockOffers setAlpha:1.0f];
            
            [UIView animateWithDuration:0.5
                                  delay:0.1
                                options: UIViewAnimationCurveEaseIn
                             animations:^{
                                 self.viewBlockOffers.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                                 self.tblBlockOffers.frame= CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height-25);
                                 
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
            
            [self.viewBlockOffers setAlpha:0.8f];
        
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.viewBlockOffers.frame = CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, self.view.frame.size.height);
                             self.tblBlockOffers.frame= CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, self.view.frame.size.height-20);;
                             
                             [self.viewBlockOffers setAlpha:1.0f];
                             
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
    [self.viewBlockOffers addGestureRecognizer:letterTapRecognizer];

}
- (void)highlightLetter:(UITapGestureRecognizer*)sender
{
    if (atTop)
    {
        atTop=NO;
        [self animateView:NO];
        if ([[dictJobData valueForKey:@"ActiveJobs"] count] == 0) {
            [self.viewNoData setHidden:NO];
        }
    }
    else
    {
        atTop=YES;
        [self animateView:YES];
        if ([[dictJobData valueForKey:@"ActiveJobs"] count] == 0) {
            [self.viewNoData setHidden:YES];
        }
    }
}
- (IBAction)btnSearchCandidateAction:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)btnJobTemplateAction:(id)sender
{
    [self.tabBarController setSelectedIndex:3];
}
#pragma mark - ---------PAYMENT MODULE CALLBACKS-------

- (void)paymentDone:(BOOL)value
{
    if (!value)
    {
        PaymentRejectViewController *pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentRejectViewController"];
        pvc.delegate=self;
        [pvc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        [pvc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self presentViewController:pvc animated:YES completion:nil];
    }
    else
    {
        PaymentAcceptViewController *pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentAcceptViewController"];
        pvc.delegate=self;
        [pvc setModalPresentationStyle:UIModalPresentationOverFullScreen];
        [pvc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self presentViewController:pvc animated:YES completion:nil];
    }
}

-(void)paymentPlanSelected:(long)index
{
    PaymentDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"PaymentDetailsViewController"];
    vc.planDict=[APPDELEGATE.arrPlanData objectAtIndex:index];
    vc.delegate=self;
    [vc setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)openEditProfile
{
    [self.tabBarController setSelectedIndex:4];
}

- (void)openPostJobController {
    [self.tabBarController setSelectedIndex:3];
}

- (void)openSearchCandidateController
{
    [self.tabBarController setSelectedIndex:0];
}

#pragma mark - ---------Validate Data Before Submit-------------
-(void)paymentPopupClose
{
    if ([[APPDELEGATE.currentPlanDict valueForKey:@"expiredOn"] length]==0||[[APPDELEGATE.currentPlanDict  valueForKey:@"subscription_id"] length]==0)
    {
        if ([[APPDELEGATE.currentPlanDict valueForKey:@"job_post_count"] intValue]>=1)
        {
            [self.tabBarController setSelectedIndex:1];
        }
    }
}
@end
