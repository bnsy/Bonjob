//
//  FaqViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/16/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "FaqViewController.h"
#import "FaqCell.h"
@interface FaqViewController ()
{
    BOOL isCellTappedTouched;
    int indexOfReadMoreButton;
    NSMutableDictionary *cellHeightDict;
    NSMutableArray *arrCellHeight;
    NSMutableArray *arrFaqData;
}
@end

@implementation FaqViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    isCellTappedTouched = NO;
    indexOfReadMoreButton = -1;
    
    arrCellHeight =[[NSMutableArray alloc]init];
    
    _lblFaqHeader.text=NSLocalizedString(@"Find answers to your questions below", @"");
    [self getFaqData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getFaqData
{
   // {"lang_id":"1"}
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSArray *foo= [language componentsSeparatedByString:@"-"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    if ([[foo objectAtIndex:0] isEqualToString:@"en"])
    {
        [params setValue:@"2" forKey:@"lang_id"];
    }
    else
    {
        [params setValue:@"2" forKey:@"lang_id"];
    }
    
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.delegate=self;
    webHelper.methodName=@"getFaq";
    [webHelper webserviceHelper:params webServiceUrl:kGetFaq methodName:@"getFaq" showHud:YES inWhichViewController:self];
    
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
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
        }
        else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"]isEqualToString:@"E"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userType"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userData"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    }
    
    if ([methodNameIs isEqualToString:@"getFaq"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            NSMutableArray *temp=[[NSMutableArray alloc]init];
            temp=[responseDict valueForKey:@"data"];
            arrFaqData=[[NSMutableArray alloc]init];
            //arrFaqData=[responseDict valueForKey:@"data"];
            
            NSString *userType=[[NSUserDefaults standardUserDefaults] valueForKey:@"userType"];
            if ([userType isEqualToString:@"E"])
            {
                for (int i=0; i<[temp count]; i++)
                {
                    if ([[[temp objectAtIndex:i] valueForKey:@"user_type"] isEqualToString:@"employer"])
                    {
                        [arrFaqData addObject:[temp objectAtIndex:i]];
                    }

                }
            }
            else
            {
                for (int i=0; i<[temp count]; i++)
                {
                    if ([[[temp objectAtIndex:i] valueForKey:@"user_type"] isEqualToString:@"seeker"])
                    {
                        [arrFaqData addObject:[temp objectAtIndex:i]];
                    }
                    
                }
            }
            
            for (int i=0; i<[arrFaqData count]; i++)
            {
                cellHeightDict=[[NSMutableDictionary alloc]init];
                [cellHeightDict setValue:@"50" forKey:[NSString stringWithFormat:@"%d",i]];
                [arrCellHeight addObject:cellHeightDict];
            }
            [_tblFaq reloadData];
        }
        else
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
}

#pragma mark - TableView Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrFaqData count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = [[[arrCellHeight objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] intValue];
//    if(isCellTappedTouched && [indexPath row]== indexOfReadMoreButton)
//    {
//        return 250;
//    }
//    else
//    {
//        return 50;
//    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FaqCell *cell;
    
    if ([[[arrCellHeight objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] intValue]>50)
    {
        // design your read more label here
        cell = (FaqCell *)[tableView dequeueReusableCellWithIdentifier:@"FaqCellOpen" forIndexPath:indexPath];
        cell.lblTitle.text=[[arrFaqData objectAtIndex:indexPath.row] valueForKey:@"page_title"];
        cell.lblAnswer.text=[[arrFaqData objectAtIndex:indexPath.row] valueForKey:@"page_content"];
        [cell.btnExpand setTitle:@"-" forState:UIControlStateNormal];
        
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FaqCell" forIndexPath:indexPath];
        cell.lblTitle.text=[[arrFaqData objectAtIndex:indexPath.row] valueForKey:@"page_title"];
        //[cell.btnExpand setTitle:@"-" forState:UIControlStateNormal];
    }
    cell.viewHolder.layer.cornerRadius=12;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    // Detail cell
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellHeightDict =[arrCellHeight objectAtIndex:indexPath.row];
    if ([[[arrCellHeight objectAtIndex:indexPath.row] valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] intValue]>50)
    {
        [cellHeightDict setValue:@"50" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }
    else
    {
        [cellHeightDict setValue:@"200" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }
    
    [arrCellHeight replaceObjectAtIndex:indexPath.row withObject:cellHeightDict];
    indexOfReadMoreButton=(double)indexPath.row;
    isCellTappedTouched=YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self expendCell:nil];
}

-(void)expendCell:(id)sender
{
    [[self tblFaq] beginUpdates];
    [[self tblFaq] reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem: indexOfReadMoreButton inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[self tblFaq] endUpdates];
}

@end
