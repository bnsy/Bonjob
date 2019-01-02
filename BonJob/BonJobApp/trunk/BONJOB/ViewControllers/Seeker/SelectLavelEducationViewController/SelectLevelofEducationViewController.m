//
//  SelectLevelofEducationViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/9/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "SelectLevelofEducationViewController.h"
#import "BonJob-Swift.h"

@implementation EducationCell


@end


@interface SelectLevelofEducationViewController ()
{
    NSString *educationLevel;
    NSString *educationTitle;
    long selectedIndex;
    NSMutableArray *arrayEducationLevel;
}
@end

@implementation SelectLevelofEducationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    if([self.titled isEqualToString:@"LEVEL OF EDUCATION"])
    {
         arrayEducationLevel = [[NSMutableArray alloc]init];
        [self getLevelOfEducations];
        self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"LEVEL OF EDUCATION", @"")];// NSLocalizedString(@"LEVEL OF EDUCATION", @"");
        _lblLevelEducation.text=NSLocalizedString(@"LEVEL OF EDUCATION", @"");
    }
    else
    {
        arrayEducationLevel = [[NSMutableArray alloc]init];
        [self getCandidateSeeks];
        self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"CANDIDATE SEEKS", @"")];
        _lblLevelEducation.text=NSLocalizedString(@"CANDIDATE SEEKS", @"");
    }
    
    
    selectedIndex=-1;
    _lblLevelEducation.textColor=TitleColor;
   
    [self.btnSaveEducation setTitle:NSLocalizedString(@"Save", @"")];
      self.navigationController.navigationBarHidden = false;
    self.navigationController.navigationBar.tintColor = InternalButtonColor;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ------WebService Methods-----

-(void)getLevelOfEducations
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"levelofEducation";
    [webhelper webserviceHelper:kGetLevelOfEducationDropDowns showHud:YES];
    
}

-(void)getCandidateSeeks
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"candidateSeeks";
    [webhelper webserviceHelper:kGetCandidateSeeksDropDowns showHud:YES];
    
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
    else if ([methodNameIs isEqualToString:@"levelofEducation"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            
            for (NSDictionary *dict in [responseDict valueForKey:@"educationLevels"]) {
                
                LevelOfEducationModel *obj = [[LevelOfEducationModel alloc]init];
                [arrayEducationLevel addObject:[obj initWithDict:dict]];
            }
            [self.tblEducation reloadData];
        }
    }
    else if ([methodNameIs isEqualToString:@"candidateSeeks"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            
            for (NSDictionary *dict in [responseDict valueForKey:@"candidateSeeks"]) {
                
                LevelOfEducationModel *obj = [[LevelOfEducationModel alloc]init];
                [arrayEducationLevel addObject:[obj initWithCandidateSeeksDict:dict]];
            }
            [self.tblEducation reloadData];
        }
    }
}


#pragma mark - -------------TableView Delegates---------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayEducationLevel count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EducationCell *cell=(EducationCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell=[[EducationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (indexPath.row==selectedIndex)
    {
        [cell.btnSelectEducation setSelected:YES];
    }
    else
    {
        [cell.btnSelectEducation setSelected:NO];
    }
    LevelOfEducationModel *obj = [arrayEducationLevel objectAtIndex:indexPath.row];
    [cell.btnSelectEducation addTarget:self action:@selector(btnSelectEducationAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.lblTitle.text=obj.education_title;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex=indexPath.row;
    LevelOfEducationModel *obj = [arrayEducationLevel objectAtIndex:indexPath.row];
    educationLevel=obj.education_id;
    educationTitle = obj.education_title;
    [tableView reloadData];
}

-(void)btnSelectEducationAction:(UIButton *)btn
{
    EducationCell *cell=(EducationCell *)[[btn superview]superview];
    NSIndexPath *indexPath=[_tblEducation indexPathForCell:cell];
    selectedIndex=indexPath.row;
    LevelOfEducationModel *obj = [arrayEducationLevel objectAtIndex:indexPath.row];
    educationLevel=obj.education_id;
    educationTitle = obj.education_title;
    [_tblEducation reloadData];
    
}
- (IBAction)btnSaveEducationAction:(id)sender
{
  
        [self.delegate levelofEducationSelected:educationLevel title:educationTitle screenTitle:self.titled];
        [self.navigationController popViewControllerAnimated:YES];
    
}
@end
