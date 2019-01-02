//
//  RecruiterFilterCandidateVC.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/12/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterFilterCandidateVC.h"
#import "GetCandidate.h"
#import "SharedClass.h"
#import "BonJob-Swift.h"

@implementation DimplomaCell



@end


@interface RecruiterFilterCandidateVC ()
{
    NSString *strEducationLevel,*strSkills,*strExperience,*strStatus,*strMobility,*strLanguages;
    NSString *strCurrentSelectedValue;
    NSMutableArray *arrEducationLevel;
    long selectedIndex,currentButtonIndex;
    NSMutableArray *arrTemp;
    NSMutableArray *arrResponse;
    NSMutableArray *arrSelectedEducations;
    
    //-------------for multile selections-----
    
    NSMutableArray *arraySkills,*arrayEducation,*arrayExperience,*arrayStatus,*arrayMobility,*arrayLanguage;
    NSMutableArray *arraySelSkills,*arraySelEducation,*arraySelExperience,*arraySelStatus,*arraySelMobility,*arraySelLanguage;
}
@end

@implementation RecruiterFilterCandidateVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentButtonIndex = 10.0;
    arraySkills = [[NSMutableArray alloc]init];
    arrayEducation = [[NSMutableArray alloc]init];
    arrayExperience = [[NSMutableArray alloc]init];
    arrayStatus = [[NSMutableArray alloc]init];
    arrayMobility = [[NSMutableArray alloc]init];
    arrayLanguage = [[NSMutableArray alloc]init];
    
    arraySelSkills = [[NSMutableArray alloc]init];
    arraySelEducation = [[NSMutableArray alloc]init];
    arraySelExperience = [[NSMutableArray alloc]init];
    arraySelStatus = [[NSMutableArray alloc]init];
    arraySelMobility = [[NSMutableArray alloc]init];
    arraySelLanguage = [[NSMutableArray alloc]init];
    
    [self getCandidateSearchDropDowns];
    
    self.mainTblView.tableFooterView = [UIView new];
   
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    self.btnFind.layer.cornerRadius=23.0;
    self.btnFind.layer.borderColor=[UIColor whiteColor].CGColor;
    self.btnFind.layer.borderWidth=0.8;
    self.btnFind.backgroundColor=TitleColor;
    [_btnCancel setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    _viewTxtFieldHolder.layer.cornerRadius=20.0;
    _viewTxtFieldHolder.layer.borderWidth=1.0;
    _viewTxtFieldHolder.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    
    arrEducationLevel =[[NSMutableArray alloc]init];
    [_viewBackgroundPopup setHidden:YES];
    [_viewPopup setHidden:YES];
    _viewPopup.layer.cornerRadius=15;
    selectedIndex=-1;
    
    
    arrTemp =[[NSMutableArray alloc]init];
    for (int i=0; i<6; i++)
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[NSString stringWithFormat:@"%d",-1] forKey:[NSString stringWithFormat:@"%d",-1]];
        [dict setValue:@"" forKey:@"value"];
        [arrTemp addObject:dict];
    }
    
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"Targeted search", @"")];// NSLocalizedString(@"Targeted search", @"");
    _lblMsg.text=NSLocalizedString(@"Search by keywords", @"");
    _txtSearch.placeholder=NSLocalizedString(@"Ex: apprentice, waiter, cook ...", @"");
    _lblLocationOfCandidate.text=NSLocalizedString(@"Location of the candidate", @"");
    _lblChooseCategory.text=NSLocalizedString(@"Click to select your criteria", @"");
    
    
    strSkills =@"";
    strEducationLevel = @"";
    strExperience = @"";
    strStatus = @"";
    strMobility = @"";
    strLanguages = @"";
    
    _lblLocation.text=APPDELEGATE.userAddress;
  
    
    arrSelectedEducations=[[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.viewPopup.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(15.0, 15.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.viewPopup.layer.mask = maskLayer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
-(void)addDoneButton
{
    UIView *viewFooter=[[UIView alloc]initWithFrame:CGRectMake(0,_viewPopup.frame.size.height-60, self.view.frame.size.width, 60)];
    [viewFooter setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnOk=[[UIButton alloc]initWithFrame:CGRectMake(_tblEducation.frame.size.width/2-70, 10, 150, 48)];
    [btnOk setBackgroundColor:InternalButtonColor];
    [btnOk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOk setTitle:NSLocalizedString(@"Ok", @"") forState:UIControlStateNormal];
    
    btnOk.clipsToBounds=YES;
    [SharedClass setBorderOnButton:btnOk];
    [btnOk addTarget:self action:@selector(btnClosePopupAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewFooter addSubview:btnOk];
    [viewFooter setTag:1005];
    [_viewPopup addSubview:viewFooter];
}

-(void)removeDoneButton
{
    UIView *vw=[_tblEducation viewWithTag:1005];
    [vw removeFromSuperview];
}

#pragma mark - -------------TableView Delegates---------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (currentButtonIndex == 0) {
        return arraySkills.count;
    }
    else if (currentButtonIndex == 1)
    {
        return arrayEducation.count;
    }
    else if (currentButtonIndex == 2)
    {
        return arrayExperience.count;
    }
    else if (currentButtonIndex == 3)
    {
        return arrayStatus.count;
    }
    else if (currentButtonIndex == 4)
    {
        return arrayMobility.count;
    }
    else if (currentButtonIndex == 5)
    {
        return arrayLanguage.count;
    }
    else{
        return 0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DimplomaCell *cell=(DimplomaCell *)[tableView dequeueReusableCellWithIdentifier:@"DimplomaCell"];
    if (!cell)
    {
        cell=[[DimplomaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DimplomaCell"];
    }

        if (currentButtonIndex==0) {
            SkillsModel *obj = [arraySkills objectAtIndex:indexPath.row];
            cell.lblTitle.text=obj.skill_title;

            if ([arraySelSkills containsObject:arraySkills[indexPath.row]])
            {
                [cell.btnSelectEducation setSelected:YES];
            }
            else
            {
                [cell.btnSelectEducation setSelected:NO];
            }
            
        }
       else if (currentButtonIndex==1)
        {
            LevelOfEducationModel *obj = [arrayEducation objectAtIndex:indexPath.row];
            cell.lblTitle.text=obj.education_title;
            if ([arraySelEducation containsObject:arrayEducation[indexPath.row]])
            {
               [cell.btnSelectEducation setSelected:YES];
            }
            else
            {
                [cell.btnSelectEducation setSelected:NO];
            }
        }
        else if (currentButtonIndex==2)
        {
            ExperienceModel *obj = [arrayExperience objectAtIndex:indexPath.row];
            cell.lblTitle.text=obj.experience_title;
            
            if ([arraySelExperience containsObject:arrayExperience[indexPath.row]])
            {
                [cell.btnSelectEducation setSelected:YES];
            }
            else
            {
                [cell.btnSelectEducation setSelected:NO];
            }
        }
        else if (currentButtonIndex==3)
        {
            StatusModel *obj = [arrayStatus objectAtIndex:indexPath.row];
            cell.lblTitle.text=obj.seeker_current_status_title;
            
            if ([arraySelStatus containsObject:arrayStatus[indexPath.row]])
            {
                [cell.btnSelectEducation setSelected:YES];
            }
            else
            {
                [cell.btnSelectEducation setSelected:NO];
            }
        }
        else if (currentButtonIndex==4)
        {
            MobilityModel *obj = [arrayMobility objectAtIndex:indexPath.row];
            cell.lblTitle.text=obj.mobility_title;
            
            if ([arraySelMobility containsObject:arrayMobility[indexPath.row]])
            {
                [cell.btnSelectEducation setSelected:YES];
            }
            else
            {
                [cell.btnSelectEducation setSelected:NO];
            }
        }
        else if(currentButtonIndex == 5)
        {
            LevelOfLanguageModel *obj = [arrayLanguage objectAtIndex:indexPath.row];
            cell.lblTitle.text=obj.job_language_title;
            
            if ([arraySelLanguage containsObject:arrayLanguage[indexPath.row]])
            {
                [cell.btnSelectEducation setSelected:YES];
            }
            else
            {
                [cell.btnSelectEducation setSelected:NO];
            }
        }
   // }
    else
    {
        [cell.btnSelectEducation setSelected:NO];
    }

    [cell.btnSelectEducation addTarget:self action:@selector(btnCellRadioButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex=indexPath.row;
    //strCurrentSelectedValue=[arrEducationLevel objectAtIndex:indexPath.row];
    
  //  NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//    [dict setValue:[NSString stringWithFormat:@"%ld",(long)selectedIndex] forKey:[NSString stringWithFormat:@"%ld",currentButtonIndex]];
//    [dict setValue:strCurrentSelectedValue forKey:@"value"];
//    [arrTemp replaceObjectAtIndex:currentButtonIndex withObject:dict];
    if (currentButtonIndex==0)
    {
   
        if ([arraySelSkills containsObject:arraySkills[indexPath.row]])
        {
            [arraySelSkills removeObjectIdenticalTo:arraySkills[indexPath.row]];
        }
        else
        {
            [arraySelSkills addObject:arraySkills[indexPath.row]];
        }
    }
    else if (currentButtonIndex==1)
    {
        if ([arraySelEducation containsObject:arrayEducation[indexPath.row]])
        {
            [arraySelEducation removeObjectIdenticalTo:arrayEducation[indexPath.row]];
        }
        else
        {
            [arraySelEducation addObject:arrayEducation[indexPath.row]];
        }
    }
    else if (currentButtonIndex==2)
    {
        if ([arraySelExperience containsObject:arrayExperience[indexPath.row]])
        {
            [arraySelExperience removeObjectIdenticalTo:arrayExperience[indexPath.row]];
        }
        else
        {
            [arraySelExperience addObject:arrayExperience[indexPath.row]];
        }
    }
    else if (currentButtonIndex==3)
    {
        if ([arraySelStatus containsObject:arrayStatus[indexPath.row]])
        {
            [arraySelStatus removeObjectIdenticalTo:arrayStatus[indexPath.row]];
        }
        else
        {
            [arraySelStatus addObject:arrayStatus[indexPath.row]];
        }
    }
    else if (currentButtonIndex==4)
    {
        if ([arraySelMobility containsObject:arrayMobility[indexPath.row]])
        {
            [arraySelMobility removeObjectIdenticalTo:arrayMobility[indexPath.row]];
        }
        else
        {
            [arraySelMobility addObject:arrayMobility[indexPath.row]];
        }
    }
    else if (currentButtonIndex==5)
    {
        if ([arraySelLanguage containsObject:arrayLanguage[indexPath.row]])
        {
            [arraySelLanguage removeObjectIdenticalTo:arrayLanguage[indexPath.row]];
        }
        else
        {
            [arraySelLanguage addObject:arrayLanguage[indexPath.row]];
        }
    }
    
    
//    if (currentButtonIndex==1)
//    {
//
//    }
//    else
//    {
//        [self btnClosePopupAction:nil];
//    }
    
    [tableView reloadData];
}

#pragma mark - ---------Buttons Actions Here-----------

- (IBAction)btnLocationAction:(id)sender
{
    SelectLocationViewController *locationVc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectLocationViewController"];
    locationVc.delegate=self;
    [self.navigationController pushViewController:locationVc animated:YES];
}

-(void)btnCellRadioButtonAction:(UIButton *)btn
{
    EducationCell *cell=(EducationCell *)[[btn superview]superview];
    NSIndexPath *indexPath=[_tblEducation indexPathForCell:cell];
    selectedIndex=indexPath.row;
    strCurrentSelectedValue=[arrEducationLevel objectAtIndex:indexPath.row];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)selectedIndex] forKey:[NSString stringWithFormat:@"%ld",currentButtonIndex]];
    [dict setValue:strCurrentSelectedValue forKey:@"value"];
    [arrTemp replaceObjectAtIndex:currentButtonIndex withObject:dict];
    if (currentButtonIndex==0)
    {
        strSkills=strCurrentSelectedValue;
    }
    else if (currentButtonIndex==1)
    {
        strEducationLevel=strCurrentSelectedValue;
    }
    else if (currentButtonIndex==2)
    {
        strExperience=strCurrentSelectedValue;
    }
    else if (currentButtonIndex==3)
    {
        strStatus=strCurrentSelectedValue;
    }
    else if (currentButtonIndex==4)
    {
        strMobility=strCurrentSelectedValue;
    }
    else if (currentButtonIndex==5)
    {
        strLanguages=strCurrentSelectedValue;
    }
    [_tblEducation reloadData];
}

- (IBAction)btnCompetencesAction:(id)sender
{
    currentButtonIndex=0;
    _lblPopupTitle.text=NSLocalizedString(@"Skills", @"");
    self.viewBackgroundPopup.hidden=FALSE;
    self.viewPopup.hidden=FALSE;
    [SharedClass showPopupView:self.viewBackgroundPopup];
    [SharedClass showPopupView:self.viewPopup];
    [arrEducationLevel removeAllObjects];
    [arrEducationLevel addObject:NSLocalizedString(@"Kitchen - Catering", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Service in restaurants (host, waiter)", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Hotels - Accommodation", @"")];
    [self addDoneButton];
    [_tblEducation reloadData];
}

- (IBAction)btnDiplomaAction:(id)sender
{
    currentButtonIndex=1;
    _lblPopupTitle.text=NSLocalizedString(@"Diploma", @"");
    self.viewBackgroundPopup.hidden=FALSE;
    self.viewPopup.hidden=FALSE;
    [SharedClass showPopupView:self.viewBackgroundPopup];
    [SharedClass showPopupView:self.viewPopup];
    [arrEducationLevel removeAllObjects];
    [arrEducationLevel addObject:NSLocalizedString(@"No diploma", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Youth training", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Vocational training", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"BP", @"BP")];
    [arrEducationLevel addObject:NSLocalizedString(@"High-School", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"High-School (professional training)", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Higher Diploma / 12th Grade", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Higher Education / Associates's Degree", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Bachelor", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Master and above", @"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Other", @"")];
    [self addDoneButton];
    [_tblEducation reloadData];
    
//    UIView *viewFooter=[[UIView alloc]initWithFrame:CGRectMake(0,_tblEducation.frame.size.height-60, self.view.frame.size.width, 60)];
//    [viewFooter setBackgroundColor:[UIColor whiteColor]];
//    UIButton *btnOk=[[UIButton alloc]initWithFrame:CGRectMake(_tblEducation.frame.size.width/2-75, 10, 150, 40)];
//    [btnOk setBackgroundColor:InternalButtonColor];
//    [btnOk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btnOk setTitle:NSLocalizedString(@"Ok", @"") forState:UIControlStateNormal];
//    btnOk.layer.cornerRadius=10;
//    btnOk.clipsToBounds=YES;
//
//    [btnOk addTarget:self action:@selector(btnClosePopupAction:) forControlEvents:UIControlEventTouchUpInside];
//    [viewFooter addSubview:btnOk];
//    [viewFooter setTag:1005];
//    [_tblEducation addSubview:viewFooter];
}

- (IBAction)btnExperinceAction:(id)sender
{
    currentButtonIndex=2;
    _lblPopupTitle.text=NSLocalizedString(@"Experience", @"");
    self.viewBackgroundPopup.hidden=FALSE;
    self.viewPopup.hidden=FALSE;
    [SharedClass showPopupView:self.viewBackgroundPopup];
    [SharedClass showPopupView:self.viewPopup];
    [arrEducationLevel removeAllObjects];
    [arrEducationLevel addObject:NSLocalizedString(@"No experience",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Less than 1 year",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"1-2 years",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"3-4 years",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"5 years and +",@"")];
    [self addDoneButton];
    [_tblEducation reloadData];
}

- (IBAction)btnStatusActualAction:(id)sender
{
    currentButtonIndex=3;
    _lblPopupTitle.text=NSLocalizedString(@"Status", @"");
    self.viewBackgroundPopup.hidden=FALSE;
    self.viewPopup.hidden=FALSE;
    [SharedClass showPopupView:self.viewBackgroundPopup];
    [SharedClass showPopupView:self.viewPopup];
    [arrEducationLevel removeAllObjects];
    [arrEducationLevel addObject:NSLocalizedString(@"Student",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Apprentice",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Employed",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Jobseeker",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Inactive",@"")];
    [self addDoneButton];
    [_tblEducation reloadData];
}

- (IBAction)btnMobilityAction:(id)sender
{
    currentButtonIndex=4;
    _lblPopupTitle.text=NSLocalizedString(@"MOBILITY", @"");
    self.viewBackgroundPopup.hidden=FALSE;
    self.viewPopup.hidden=FALSE;
    [SharedClass showPopupView:self.viewBackgroundPopup];
    [SharedClass showPopupView:self.viewPopup];
    [arrEducationLevel removeAllObjects];
    [arrEducationLevel addObject:NSLocalizedString(@"Yes",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"No",@"")];
    [self addDoneButton];
    [_tblEducation reloadData];
}

- (IBAction)btnLanguagesAction:(id)sender
{
    currentButtonIndex=5;
    _lblPopupTitle.text=NSLocalizedString(@"Languages", @"");
    self.viewBackgroundPopup.hidden=FALSE;
    self.viewPopup.hidden=FALSE;
    [SharedClass showPopupView:self.viewBackgroundPopup];
    [SharedClass showPopupView:self.viewPopup];
    [arrEducationLevel removeAllObjects];
    [arrEducationLevel addObject:NSLocalizedString(@"French",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"English",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Spanish",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"German",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Portuguese",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Chinese",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Japanese",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Arab",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Russian",@"")];
    [arrEducationLevel addObject:NSLocalizedString(@"Hindi",@"")];
    [self addDoneButton];
    [_tblEducation reloadData];
}

- (IBAction)btnFindAction:(id)sender
{
    /*
     strSkills
     strEducationLevel
     strExperience
     strStatus
     strMobility
     strLanguages
    */
    // send above value to webservice afetr validation
    [self getCandidateList];
    
}

- (IBAction)btnCancelTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma - ----------Textfields Delegate----------
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return true;
}

#pragma mark - ----------Get Candidate List WebService--------------
-(void)removeAllSelectedArrays
{
    APPDELEGATE.arraySelSkillsRecruiter.removeAllObjects;
    APPDELEGATE.arraySelStatusRecruiter.removeAllObjects;
    APPDELEGATE.arraySelSkillsRecruiter.removeAllObjects;
    APPDELEGATE.arraySelLanguageRecruiter.removeAllObjects;
    APPDELEGATE.arraySelMobilityRecruiter.removeAllObjects;
    APPDELEGATE.arraySelEducationRecruiter.removeAllObjects;
}

-(void)getCandidateSearchDropDowns
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"candidateSearchDropDowns";
    [webhelper webserviceHelper:kGetCandidateSearchDropDowns showHud:YES];
    
}

-(void)getCandidateList
{
    /*
    strSkills
    strEducationLevel
    strExperience
    strStatus
    strMobility
    strLanguages
    */
    //{"user_id":"1","search_key":"","city":"New Delhi","current_status":"Apprentice","education_level":"Bac Pro","mobility":"Yes","skills":"service","language":"","industry_type":"","experience":"","start":"0/10/20"}
   // [[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"]
    NSMutableArray *temp =[[NSMutableArray alloc]init];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:_txtSearch.text forKey:@"search_key"];
    [params setValue:_lblLocation.text forKey:@"city"];
    
    for (StatusModel * obj  in arraySelStatus) {
        [temp addObject:obj.seeker_current_status_id];
    }
    [params setValue:temp forKey:@"current_status"];
    temp =[[NSMutableArray alloc]init];
    
    for (LevelOfEducationModel * obj  in arraySelEducation) {
        [temp addObject:obj.education_id];
    }
    [params setValue:temp forKey:@"education_level"];
     temp =[[NSMutableArray alloc]init];
    
    for (MobilityModel * obj  in arraySelMobility) {
        [temp addObject:obj.mobility_id];
    }
    [params setValue:temp forKey:@"mobility"];
    temp =[[NSMutableArray alloc]init];
    
    for (SkillsModel * obj  in arraySelSkills) {
        [temp addObject:obj.skill_id];
    }
    [params setValue:temp forKey:@"skills"];
    [params setValue:temp forKey:@"industry_type"];
    temp =[[NSMutableArray alloc]init];
    
    for (LevelOfLanguageModel * obj  in arraySelLanguage) {
        [temp addObject:obj.job_language_id];
    }
    [params setValue:temp forKey:@"language"];
    temp =[[NSMutableArray alloc]init];
    
    for (ExperienceModel * obj  in arraySelExperience) {
        [temp addObject:obj.experience_id];
    }
    [params setValue:temp forKey:@"experience"];
    temp =[[NSMutableArray alloc]init];
   
    [params setValue:@"0" forKey:@"start"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"getCandidate";
    [webhelper webserviceHelper:params webServiceUrl:kSearchCandidate methodName:@"getCandidate" showHud:YES inWhichViewController:self];
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
   else if ([methodNameIs isEqualToString:@"getCandidate"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==1)
        {
            [[GetCandidate getModel]setResponseArray:[responseDict valueForKey:@"allCandidates"]];
            [self.delegate showProgress];
            [self removeAllSelectedArrays];
            APPDELEGATE.arraySelSkillsRecruiter = arraySelSkills;
            APPDELEGATE.arraySelStatusRecruiter = arraySelStatus;
            APPDELEGATE.arraySelExperienceRecruiter = arraySelExperience;
            APPDELEGATE.arraySelLanguageRecruiter = arraySelLanguage;
            APPDELEGATE.arraySelMobilityRecruiter = arraySelMobility;
            APPDELEGATE.arraySelEducationRecruiter = arraySelEducation;
            APPDELEGATE.isFilterRecruiter = YES;
            
            
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            dict=[APPDELEGATE.currentPlanDict mutableCopy];
            APPDELEGATE.currentPlanDict=dict;
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"candidateSearchDropDowns"])
    {
        if ([[responseDict valueForKey:@"success"]boolValue]==1)
        {
            for (NSDictionary *dict in [responseDict valueForKey:@"currentStatuses"]) {
                
                StatusModel *obj = [[StatusModel alloc]init];
                [arrayStatus addObject:[obj initWithDict:dict]];
            }
            
            for (NSDictionary *dict in [responseDict valueForKey:@"educationLevels"]) {
                
                LevelOfEducationModel *obj = [[LevelOfEducationModel alloc]init];
                [arrayEducation addObject:[obj initWithDict:dict]];
            }
            for (NSDictionary *dict in [responseDict valueForKey:@"experiences"]) {
                
                ExperienceModel *obj = [[ExperienceModel alloc]init];
                [arrayExperience addObject:[obj initWithDict:dict]];
            }
            for (NSDictionary *dict in [responseDict valueForKey:@"jobLanguages"]) {
                
                LevelOfLanguageModel *obj = [[LevelOfLanguageModel alloc]init];
                [arrayLanguage addObject:[obj initWithDict:dict]];
            }
            for (NSDictionary *dict in [responseDict valueForKey:@"mobilities"]) {
                
                MobilityModel *obj = [[MobilityModel alloc]init];
                [arrayMobility addObject:[obj initWithDict:dict]];
            }
            for (NSDictionary *dict in [responseDict valueForKey:@"skills"]) {
                
                SkillsModel *obj = [[SkillsModel alloc]init];
                [arraySkills addObject:[obj initWithDict:dict]];
            }
             [_tblEducation reloadData];
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}


- (IBAction)btnClosePopupAction:(id)sender
{
    [SharedClass hidePopupView:self.viewBackgroundPopup];
    [SharedClass hidePopupView:self.viewPopup];

    
    if (currentButtonIndex==0 && arraySelSkills.count > 0)
    {
        _imgCompetences.image=[UIImage imageNamed:@"contanerCheck_blue.png"];
        for (int i =0;i<arraySelSkills.count;i++) {
            SkillsModel * obj = [arraySelSkills objectAtIndex:i];
            if (i ==0) {
              _lblCompetences.text = obj.skill_title;
            }
            else{
                _lblCompetences.text = [_lblCompetences.text stringByAppendingString:[NSString stringWithFormat:@",%@",obj.skill_title]];
            }
           
        }
       
        _lblCompetences.textColor=TitleColor;
    }
    if (currentButtonIndex==0 && arraySelSkills.count == 0)
    {
        _imgCompetences.image=[UIImage imageNamed:@"pink_like"];
        _lblCompetences.text= @"Compétences";
        _lblCompetences.textColor=ButtonTitleColor;
    }
    if (currentButtonIndex==1 && arraySelEducation.count > 0)
    {
        _imgDiploma.image=[UIImage imageNamed:@"contanerCheck_blue.png"];
        for (int i =0;i<arraySelEducation.count;i++) {
            LevelOfEducationModel * obj = [arraySelEducation objectAtIndex:i];
            if (i ==0) {
                _lblDiploma.text = obj.education_title;
            }
            else{
                _lblDiploma.text = [_lblDiploma.text stringByAppendingString:[NSString stringWithFormat:@",%@",obj.education_title]];
            }
            
        }
        _lblDiploma.textColor=TitleColor;
       
    }
    if (currentButtonIndex == 1 && arraySelEducation.count == 0)
    {
        _imgDiploma.image=[UIImage imageNamed:@"pink_hat"];
        _lblDiploma.text= @"Diplôme";
        _lblDiploma.textColor=ButtonTitleColor;
    }
    if (currentButtonIndex==2 && arraySelExperience.count > 0)
    {
        _imgExp.image=[UIImage imageNamed:@"contanerCheck_blue.png"];
        _lblExp.textColor=TitleColor;
        
        for (int i =0;i<arraySelExperience.count;i++) {
            ExperienceModel * obj = [arraySelExperience objectAtIndex:i];
            if (i ==0) {
                _lblExp.text = obj.experience_title;
            }
            else{
                _lblExp.text = [_lblExp.text stringByAppendingString:[NSString stringWithFormat:@",%@",obj.experience_title]];
            }
            
        }
        
        
        
    }
    if (currentButtonIndex==2 && arraySelExperience.count == 0)
    {
         _imgExp.image=[UIImage imageNamed:@"pink_note.png"];
         _lblExp.text = @"Expérience";
         _lblExp.textColor = ButtonTitleColor;
     }
     if (currentButtonIndex==3 &&  arraySelStatus.count > 0)
    {
        _imgStatus.image=[UIImage imageNamed:@"contanerCheck_blue.png"];
        _lblStatus.textColor=TitleColor;
        
        for (int i =0;i<arraySelStatus.count;i++) {
            StatusModel * obj = [arraySelStatus objectAtIndex:i];
            if (i ==0) {
                _lblStatus.text = obj.seeker_current_status_title;
            }
            else{
                _lblStatus.text = [_lblStatus.text stringByAppendingString:[NSString stringWithFormat:@",%@",obj.seeker_current_status_title]];
            }
            
        }
        
    }
    if (currentButtonIndex==3 &&  arraySelStatus.count == 0)
    {
        _imgStatus.image=[UIImage imageNamed:@"pink_user.png"];
        _lblStatus.text = @"Statut actuel";
        _lblStatus.textColor = ButtonTitleColor;
    }
     if (currentButtonIndex==4 && arraySelMobility.count > 0)
    {
        _imgMobility.image=[UIImage imageNamed:@"contanerCheck_blue.png"];
        _lblMobility.textColor=TitleColor;
        
        for (int i =0;i<arraySelMobility.count;i++) {
            MobilityModel * obj = [arraySelMobility objectAtIndex:i];
            if (i ==0) {
                _lblMobility.text = obj.mobility_title;
            }
            else{
                _lblMobility.text = [_lblMobility.text stringByAppendingString:[NSString stringWithFormat:@",%@",obj.mobility_title]];
            }
            
        }
        
    }
     if (currentButtonIndex==4 && arraySelMobility.count == 0)
     {
         _imgMobility.image=[UIImage imageNamed:@"pink_plane.png"];
         _lblMobility.text= @"Mobilité";
         _lblMobility.textColor=ButtonTitleColor;
     }
    if (currentButtonIndex==5 && arraySelLanguage.count > 0)
    {
        _imgGlobe.image=[UIImage imageNamed:@"contanerCheck_blue.png"];
        _lblLanguage.textColor=TitleColor;
        
        for (int i =0;i<arraySelLanguage.count;i++) {
            LevelOfLanguageModel * obj = [arraySelLanguage objectAtIndex:i];
            if (i ==0) {
                _lblLanguage.text = obj.job_language_title;
            }
            else{
                _lblLanguage.text = [_lblLanguage.text stringByAppendingString:[NSString stringWithFormat:@",%@",obj.job_language_title]];
            }
            
        }
        
    }
     if (currentButtonIndex==5 && arraySelLanguage.count == 0)
    {
         _imgGlobe.image=[UIImage imageNamed:@"pink_globe.png"];
         _lblLanguage.text= @"Langues";
         _lblLanguage.textColor=ButtonTitleColor;
     }
    
//    if (currentButtonIndex==1)
//    {
//        UIView *vw=[_tblEducation viewWithTag:1005];
//        [vw removeFromSuperview];
//    }

}

#pragma mark - ---------Location Selection Delegate---------
-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute
{
    _lblLocation.text=address;
    APPDELEGATE.userAddress = address;
}

@end