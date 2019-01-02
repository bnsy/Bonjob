//
//  RecruiterHiredCandidateViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterHiredCandidateViewController.h"
#import "RecruiterHiredCandidateCell.h"
@interface RecruiterHiredCandidateViewController ()
{
    NSMutableArray *arrResponse;
}
@end

@implementation RecruiterHiredCandidateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lblTitle.text=NSLocalizedString(@"No candidates hired for the moment", @"");
    [_btnSearchCandidate setTitle:NSLocalizedString(@"Search for candidates", @"") forState:UIControlStateNormal];
    [_btnJobTemplate setTitle:NSLocalizedString(@"Post a Job", @"") forState:UIControlStateNormal];
    [_lblTitle setTextColor:InternalButtonColor];
    [SharedClass setBorderOnButton:_btnSearchCandidate];
    [SharedClass setBorderOnButton:_btnJobTemplate];
    [_btnSearchCandidate setBackgroundColor:InternalButtonColor];
    [_btnJobTemplate setBackgroundColor:TitleColor];
    [self getHired];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHired) name:@"HiredCandidate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHired) name:@"GetHiredCandidate" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMyOfferCount:) name:@"setrecruiteroffercount" object:nil];

    
    
    // Do any additional setup after loading the view.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
  //  self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    [self.refreshControl addTarget:self
                            action:@selector(getHired)
                  forControlEvents:UIControlEventValueChanged];
    [self.tblCandidateHired addSubview:_refreshControl];
}

- (void)reloadData
{
    // Reload table data
    [self.tblCandidateHired reloadData];
    
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
        [[self.tabBarController.tabBar.items objectAtIndex:1]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"]];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tblCandidateHired reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ----------WebService Methods---------

-(void)getHired
{
    //{"user_id":"71"}
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]valueForKey:@"user_id"] forKey:@"user_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"hireCandidateList";
    [webhelper webserviceHelper:params webServiceUrl:kHiredCandidateList methodName:@"hireCandidateList" showHud:YES inWhichViewController:self];
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
    if ([methodNameIs isEqualToString:@"hireCandidateList"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==YES)
        {
            arrResponse=[[NSMutableArray alloc]init];
            arrResponse = [responseDict valueForKey:@"data"];
            if (arrResponse.count>0)
            {
                [_viewNoData setHidden:YES];
            }
            else
            {
                [_viewNoData setHidden:NO];
            }
            
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[NSString stringWithFormat:@"%lu",[arrResponse count]] forKey:@"count"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiredCandidateCount" object:self userInfo:dict];
            
            [_tblCandidateHired reloadData];
            [self reloadData];
        }
        else
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:@"0" forKey:@"count"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"hiredCandidateCount" object:self userInfo:dict];
            [self reloadData];
           // [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}

#pragma mark - ----------Tableview Delegates-------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrResponse count];;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecruiterHiredCandidateCell *cell=(RecruiterHiredCandidateCell*)[tableView dequeueReusableCellWithIdentifier:@"RecruiterHiredCandidateCell"];
    if (!cell)
    {
        cell=[[RecruiterHiredCandidateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecruiterHiredCandidateCell"];
    }
    [cell setdata:[arrResponse objectAtIndex:indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)btnSearchCandidate:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)btnJobTemplateAction:(id)sender
{
    [self.tabBarController setSelectedIndex:3];
}
@end
