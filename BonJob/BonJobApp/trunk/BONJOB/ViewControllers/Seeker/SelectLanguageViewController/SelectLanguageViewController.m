//
//  SelectLanguageViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/9/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "SelectLanguageViewController.h"
#import "BonJob-Swift.h"

@interface SelectLanguageViewController ()
{
   
    NSArray *filteredArrLanguage;
    BOOL isFilter;
    NSMutableArray *arrayLanguageLevel;
}
@end

@implementation SelectLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayLanguageLevel= [[NSMutableArray alloc]init];
    [self getLevelOfLanguages];
    filteredArrLanguage = [[NSArray alloc]init];
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"LANGUAGES", @"")]; //NSLocalizedString(@"LANGUAGES", @"");
    [SharedClass setShadowOnView:self.viewSearch];
    // Do any additional setup after loading the view.
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!isFilter) {
          return [arrayLanguageLevel count];
    }
    else{
          return [filteredArrLanguage count];
    }
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (!isFilter) {
        LevelOfLanguageModel *obj =[arrayLanguageLevel objectAtIndex:indexPath.row];
        cell.textLabel.text= obj.job_language_title;
    }
    else
    {
        LevelOfLanguageModel *obj =[filteredArrLanguage objectAtIndex:indexPath.row];
          cell.textLabel.text= obj.job_language_title;
    }
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isFilter) {
         LevelOfLanguageModel *obj =[arrayLanguageLevel objectAtIndex:indexPath.row];
        [self.delegate languageSelected:obj.job_language_title selectedid:obj.job_language_id];
    }
    else{
          LevelOfLanguageModel *obj =[filteredArrLanguage objectAtIndex:indexPath.row];
         [self.delegate languageSelected:obj.job_language_title selectedid:obj.job_language_id];
    }
   
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0) {
        isFilter = true;
        filteredArrLanguage = [[NSArray alloc]init];
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.job_language_title contains[c] %@",textField.text]; // if you need case sensitive search avoid '[c]' in the predicate
        
        filteredArrLanguage = [arrayLanguageLevel filteredArrayUsingPredicate:predicate];
     //   NSLog(@"%@",results);
        
    }
    else{
        isFilter = false;
    }
    [textField resignFirstResponder];
    [_tblLanguage reloadData];
    return TRUE;
}
#pragma mark - ------WebService Methods-----

-(void)getLevelOfLanguages
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"levelofLanguage";
    [webhelper webserviceHelper:kGetLevelOfLanguageDropDowns showHud:YES];
    
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
    else if ([methodNameIs isEqualToString:@"levelofLanguage"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            
            for (NSDictionary *dict in [responseDict valueForKey:@"jobLanguages"]) {
                
                LevelOfLanguageModel *obj = [[LevelOfLanguageModel alloc]init];
                [arrayLanguageLevel addObject:[obj initWithDict:dict]];
            }
             [self.tblLanguage reloadData];
        }
    }
}


@end
