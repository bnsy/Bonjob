//
//  RecruiterSelectedCandidateViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterSelectedCandidateViewController.h"
#import "RecruiterCandidateSelectedCell.h"
#import "SelectedCandidate.h"
@interface RecruiterSelectedCandidateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL sectionTapped;
    BOOL atTop;
    UIButton *btnDropDown;
    int Index;
}
@end

@implementation RecruiterSelectedCandidateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addHeaderOnBlockOfferView];
    _lblTitle.text=NSLocalizedString(@"No candidates selected for the moment", @"");
    [_btnSearchCandidate setTitle:NSLocalizedString(@"Search for candidates", @"") forState:UIControlStateNormal];
    [_btnJobTemplate setTitle:NSLocalizedString(@"Post a Job", @"") forState:UIControlStateNormal];
    [_lblTitle setTextColor:InternalButtonColor];
    [SharedClass setBorderOnButton:_btnSearchCandidate];
    [SharedClass setBorderOnButton:_btnJobTemplate];
    [_btnSearchCandidate setBackgroundColor:InternalButtonColor];
    [_btnJobTemplate setBackgroundColor:TitleColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSelectedCandidateList) name:@"AvailableCandidate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getSelectedCandidateList) name:@"HiredCandidate" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMyOfferCount:) name:@"setrecruiteroffercount" object:nil];

    //[self addTapGestures];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    //self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    [self.refreshControl addTarget:self
                            action:@selector(getSelectedCandidateList)
                  forControlEvents:UIControlEventValueChanged];
    [self.tblCandidateList addSubview:_refreshControl];
}

- (void)reloadData
{
    // Reload table data
    [self.tblCandidateList reloadData];
    
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


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.viewNotSelected.frame = CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, self.view.frame.size.height);
    [self getSelectedCandidateList];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ----------Get CandidateList---------------

-(void)btnArchieveAction:(UIButton *)button
{
    // not select candidate
    //{"aplied_id","8"}
    Index=(int)button.tag;
    NSString *str=[[[[[SelectedCandidate getCandidate]getCandidateResponse] valueForKey:@"selectedData"] objectAtIndex:Index] valueForKey:@"aplied_id"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:str forKey:@"aplied_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"ArcheivedCandidate";
    [webhelper webserviceHelper:params webServiceUrl:kNotSelecteCandidate methodName:@"ArcheivedCandidate" showHud:YES inWhichViewController:self];
}

-(void)btnHiredAction:(UIButton *)button
{
    Index=(int)button.tag;
    NSString *str=[[[[[SelectedCandidate getCandidate]getCandidateResponse] valueForKey:@"selectedData"] objectAtIndex:Index] valueForKey:@"aplied_id"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:str forKey:@"aplied_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"HireCandidate";
    [webhelper webserviceHelper:params webServiceUrl:kHireCandidate methodName:@"HireCandidate" showHud:YES inWhichViewController:self];
    
}


-(void)getSelectedCandidateList
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"getSelectedCandidate";
    [webhelper webserviceHelper:params webServiceUrl:kSelectNotSelectCand methodName:@"getSelectedCandidate" showHud:YES inWhichViewController:self];
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
    if ([methodNameIs isEqualToString:@"getSelectedCandidate"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==YES)
        {
            if ([[responseDict valueForKey:@"selectedData"] count]>0)
            {
                [_viewNoData setHidden:YES];
            }
            else
            {
                [_viewNoData setHidden:NO];
            }
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[NSString stringWithFormat:@"%lu",[[responseDict valueForKey:@"selectedData"] count]] forKey:@"count"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedCandidateCount" object:self userInfo:dict];
            [[SelectedCandidate getCandidate]setCandidateResponse:[responseDict mutableCopy]];
            [_tblCandidateList reloadData];
            [_tblArcheivedCandidate reloadData];
            [self reloadData];
        }
        else
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:@"0" forKey:@"count"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedCandidateCount" object:self userInfo:dict];
            [self reloadData];
            // [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"HireCandidate"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==YES)
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            //NSDictionary *dict=[[[[SelectedCandidate getCandidate]getCandidateResponse]valueForKey:@"selectedData"] objectAtIndex:Index];
            [[SelectedCandidate getCandidate]deleteCandidateFromSelected:Index];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:self];
            [_tblCandidateList reloadData];
            [_tblArcheivedCandidate reloadData];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[NSString stringWithFormat:@"%lu",[[[[SelectedCandidate getCandidate]getCandidateResponse]valueForKey:@"selectedData"] count]] forKey:@"count"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedCandidateCount" object:self userInfo:dict];
            
        }
        else
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:@"0" forKey:@"count"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedCandidateCount" object:self userInfo:dict];
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"ArcheivedCandidate"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==YES)
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            NSDictionary *dict=[[[[SelectedCandidate getCandidate]getCandidateResponse]valueForKey:@"selectedData"] objectAtIndex:Index];
            [[SelectedCandidate getCandidate]changesSelecttoArchieve:dict atIndex:Index];
            [_tblCandidateList reloadData];
            [_tblArcheivedCandidate reloadData];
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setValue:[NSString stringWithFormat:@"%lu",[[[[SelectedCandidate getCandidate]getCandidateResponse]valueForKey:@"selectedData"] count]] forKey:@"count"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedCandidateCount" object:self userInfo:dictt];
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}

#pragma mark - ----------Tableview Delegates----------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblCandidateList)
    {
        NSString *applyid=[[[[[SelectedCandidate getCandidate]getCandidateResponse]valueForKey:@"selectedData"] objectAtIndex:indexPath.row] valueForKey:@"aplied_id"];
        
        if ([applyid isEqualToString:@""]||[applyid length]==0)
        {
            return 120;
        }
        else
            return 154;
    }
    return 154;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tblCandidateList)
    {
        return [[[[SelectedCandidate getCandidate] getCandidateResponse] valueForKey:@"selectedData"]count];
    }
    else
        return [[[[SelectedCandidate getCandidate] getCandidateResponse] valueForKey:@"notSelectedData"]count];;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecruiterCandidateSelectedCell *cell=(RecruiterCandidateSelectedCell *)[tableView dequeueReusableCellWithIdentifier:@"RecruiterCandidateSelectedCell"];
    if (!cell)
    {
        cell=[[RecruiterCandidateSelectedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecruiterCandidateSelectedCell"];
    }
    [cell setCells];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (tableView==_tblCandidateList)
    {
        [cell.btnHired setHidden:NO];
        [cell setData:[[[[SelectedCandidate getCandidate]getCandidateResponse]valueForKey:@"selectedData"] objectAtIndex:indexPath.row]];
        [cell.btnArchieve setUserInteractionEnabled:YES];
    }
    else
    {
        [cell setData:[[[[SelectedCandidate getCandidate]getCandidateResponse]valueForKey:@"notSelectedData"] objectAtIndex:indexPath.row]];
        [cell.btnHired setHidden:YES];
        [cell.btnArchieve setUserInteractionEnabled:NO];
    }
    [cell.btnHired setTag:indexPath.row];
    [cell.btnArchieve setTag:indexPath.row];
    [cell.btnArchieve addTarget:self action:@selector(btnArchieveAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnHired addTarget:self action:@selector(btnHiredAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnHired setTitle:NSLocalizedString(@"Hired", @"") forState:UIControlStateNormal];
    [cell.btnArchieve setTitle:NSLocalizedString(@"Not selected", @"") forState:UIControlStateNormal];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblCandidateList)
    {
        NSDictionary *dict=[[[[SelectedCandidate getCandidate]getCandidateResponse]valueForKey:@"selectedData"] objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"visitSelectedCandidateProfile" object:self userInfo:dict];
    }
    
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
    [self.viewNotSelected addSubview:header];
}


#pragma mark - ----------Animate Blockedview and Button Actions Here------------

-(void)btnToggleTapped:(UIButton *)btn
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

-(void)animateView:(BOOL)B
{
    if (B)
    {
        [self.viewNotSelected setAlpha:0.0f];
        [UIView animateWithDuration:1.0f animations:^{
            
            [self.viewNotSelected setAlpha:1.0f];
            
            [UIView animateWithDuration:0.5
                                  delay:0.1
                                options: UIViewAnimationCurveEaseIn
                             animations:^{
                                 self.viewNotSelected.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                                 self.tblArcheivedCandidate.frame=CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height-25);
                                 
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
            
            [self.viewNotSelected setAlpha:0.8f];
            
            [UIView animateWithDuration:0.5
                                  delay:0.1
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.viewNotSelected.frame = CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, self.view.frame.size.height);
                                 self.tblArcheivedCandidate.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, self.view.frame.size.height-20);
                                 [self.viewNotSelected setAlpha:1.0f];
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
    [self.viewNotSelected addGestureRecognizer:letterTapRecognizer];
    
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


- (IBAction)btnJobTemplateAction:(id)sender
{
    [self.tabBarController setSelectedIndex:3];
}

- (IBAction)btnSearchCandidateAction:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
}
@end
