//
//  ExperienceViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/6/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//
#import "TabbarViewController.h"
#import "ExperienceViewController.h"
#import "ExperienceCell.h"
#import "PositionHeldViewController.h"
#import "ProfileDataModel.h"
#import "BonJob-Swift.h"

@interface ExperienceViewController ()<RemovePositionViewDelegate,ProcessDataDelegate>
{
    NSMutableArray *arrItems,*arrPositionHeld,*arrTemp;
    BOOL TablePositionTapped;
    UIView *headerView;
    UIView *bottomView;
    NSMutableDictionary *expDict;
    NSMutableArray *arrExp;
    NSMutableArray *arrCompleteExp;
    NSMutableArray *arrPositionHeldValues;
    int expSelected;
    int count;
    int postionHoldIndex;
    CGRect viewBackFrame;
    CGRect tblPopupFrame;
    NSString *industry_type;
    NSMutableArray *arrPostions;
    int selectedIndex ;
}
@end

@implementation ExperienceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",_tempArrExp);
    self.navigationController.navigationBar.tintColor = InternalButtonColor;
    arrCompleteExp = [[NSMutableArray alloc]init];
    arrPostions = [[NSMutableArray alloc]init];
    [self getPostions];
    
    expSelected=0;
    count=0;
    arrItems=[[NSMutableArray alloc]init];
    arrPositionHeldValues=[[NSMutableArray alloc]init];
    arrPositionHeld=[[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"Catering", @""),NSLocalizedString(@"Service", @""),NSLocalizedString(@"Hotel", @""), nil];
    //[arrPositionHeld addObject:];
    [arrItems addObject:@""];
    _viewBgGrey.hidden=YES;
    _viewHolderTable.hidden=YES;
    _btnPositionHeldBack.hidden=YES;
    _lblActivityArea.text=NSLocalizedString(@"Area of activity", @"");
    _lblIndicateExperience.text=NSLocalizedString(@"Indicate your experience", @"");
    arrTemp=[[NSMutableArray alloc]init];
    arrTemp=[arrPositionHeld copy];
    _viewHolderTable.layer.masksToBounds=YES;
    _viewHolderTable.layer.cornerRadius=8.0;
    
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"EXPERIENCE", @"")]; //NSLocalizedString(@"EXPERIENCE", @"");
    [self.btnSave setTitle:NSLocalizedString(@"Save", @"")];
    
    arrExp=[[NSMutableArray alloc]init];
    expDict=[[NSMutableDictionary alloc]init];
    [self getExperience];
    if (_isFromSignUp == NO)
    {
        arrExp=[[[ProfileDataModel getModel] getResponse] valueForKey:@"experience"];
    }
    else
    {
    if (_tempArrExp.count > 0) {
              arrExp = _tempArrExp;
    }
      
    }
    
    if (arrExp.count>0)
    {
        [arrItems removeAllObjects];
    }
    for (int i=0; i<[arrExp count]; i++)
    {
        [arrItems addObject:@""];
    }
    [_tblExperience reloadData];
    
    viewBackFrame=_viewHolderTable.frame;
    tblPopupFrame=_tblPositionHold.frame;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = false;
}

#pragma mark - ------TableView Delegates & DataSources------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblExperience)
    {
        return 370;
    }
    else
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblPositionHold)
    {
        if (TablePositionTapped) {
            PositionDropDown *obj =[arrPostions objectAtIndex:selectedIndex];
            return [obj.area_of_activities count];
        }
        else{
            return [arrPostions count];
        }
        
    }
    else
    return [arrItems count];;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tblPositionHold)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        if (TablePositionTapped)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            PositionDropDown *obj =[arrPostions objectAtIndex:selectedIndex];
            cell.textLabel.text = [obj.area_of_activities objectAtIndex:indexPath.row].position_name ;
            
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            PositionDropDown *obj =[arrPostions objectAtIndex:indexPath.row];
            cell.textLabel.text= obj.position_name;
        }
        return cell;
    }
    else
    {
        ExperienceCell *cell=(ExperienceCell *)[tableView dequeueReusableCellWithIdentifier:@"ExperienceCell"];
       
        if (!cell)
        {
            cell=(ExperienceCell *)[[ExperienceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExperienceCell"];
        }
        if (indexPath.row==0)
        {
            [cell.btnRemove setHidden:YES];
           
        }
        else
        {
            [cell.btnRemove setHidden:NO];
            
        }
        
       // cell.expSegment.selectedSegmentIndex = expSelected;
        NSLog(@"%ld",(long)cell.expSegment.selectedSegmentIndex);
        
        cell.txtViewDescription.layer.cornerRadius=5.0;
        cell.txtViewDescription.layer.borderColor=[UIColor lightGrayColor].CGColor;
        cell.txtViewDescription.layer.borderWidth=1.0;
        cell.btnAdd.layer.cornerRadius=20;
        cell.btnRemove.layer.cornerRadius=20;
        cell.btnRemove.layer.borderWidth=1.5;
        cell.btnRemove.layer.borderColor=ButtonTitleColor.CGColor;
        [cell.btnAdd addTarget:self action:@selector(addMoreItems:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnRemove addTarget:self action:@selector(removeItems:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnPositionHeld addTarget:self action:@selector(btnPositionHeldTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnCompanyName addTarget:self action:@selector(btnCompanyNameAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.lblCompanyName.delegate=self;
        cell.lblCompanyName.userInteractionEnabled=FALSE;
        [cell.btnCompanyName setTag:indexPath.row];
        [cell.btnAdd setTag:indexPath.row];
        [cell.btnRemove setTag:indexPath.row];
        [cell.expSegment setTag:indexPath.row];
        [cell.txtViewDescription setTag:indexPath.row];
        [cell.lblCompanyName setTag:indexPath.row];
        [cell.lblPositionHeld setTag:indexPath.row];
        [cell.btnPositionHeld setTag:indexPath.row];
        
//        expSelected =[NS] [cell.expSegment titleForSegmentAtIndex:cell.expSegment.selectedSegmentIndex];
        
        
        /*[expDict setValue:cell.lblPositionHeld.text forKey:@"position_held"];
        [expDict setValue:cell.lblCompanyName.text forKey:@"company_name"];
        [expDict setValue:cell.txtViewDescription.text forKey:@"description"];
        [expDict setValue:cell.lblPositionHeld.text forKey:@"experience"];*/
        
        cell.txtViewDescription.tintColor=ButtonTitleColor;
        
        [cell.btnAdd setTitle:NSLocalizedString(@"+ Add experience", @"") forState:UIControlStateNormal];
        [cell.btnRemove setTitle:NSLocalizedString(@"X Delete", @"") forState:UIControlStateNormal];
        [cell.expSegment setTitle:NSLocalizedString(@"None", @"") forSegmentAtIndex:0];
        [cell.expSegment setTitle:NSLocalizedString(@"< 1 year", @"") forSegmentAtIndex:1];
        [cell.expSegment setTitle:NSLocalizedString(@"1-2 years", @"") forSegmentAtIndex:2];
        [cell.expSegment setTitle:NSLocalizedString(@"3-4 years", @"") forSegmentAtIndex:3];
        [cell.expSegment setTitle:NSLocalizedString(@"5 years+", @"") forSegmentAtIndex:4];
        [cell.expSegment addTarget:self
                             action:@selector(expSegmentAction:)
                   forControlEvents:UIControlEventValueChanged];
        [cell.expSegment setTag:indexPath.row];
        cell.txtViewDescription.delegate=self;
        [cell.txtViewDescription setTag:1000+indexPath.row];
        [cell.lblCharacterCount setTag:indexPath.row];
        [cell.lblCompanyName setTag:indexPath.row];
        
        if (arrExp.count>0)
        {
            expSelected = [[[arrExp objectAtIndex:indexPath.row] valueForKey:@"experience"] intValue];
            if(expSelected != 1)
            {
            cell.lblPositionHeld.text = NSLocalizedString([[arrExp objectAtIndex:indexPath.row] valueForKey:@"position_held_name"], @"") ;
            cell.lblCompanyName.text=[[arrExp objectAtIndex:indexPath.row] valueForKey:@"company_name"];
            }
            else{
            }
            cell.txtViewDescription.text=[[arrExp objectAtIndex:indexPath.row] valueForKey:@"description"];
            cell.lblCharacterCount.text=[NSString stringWithFormat:@"%lu/%@",[[[arrExp objectAtIndex:indexPath.row] valueForKey:@"description"]length],@"200"];
            [cell.expSegment setSelectedSegmentIndex:[[[arrExp objectAtIndex:indexPath.row] valueForKey:@"experience"] intValue] - 1];
            
            expSelected = expSelected - 1;
            cell.lblIndustryType.text=[[arrExp objectAtIndex:indexPath.row] valueForKey:@"industry_type_name"];
            
            if ([cell.txtViewDescription.text isEqualToString:NSLocalizedString(@"DESCRIPTION", @"")])
            {
                cell.txtViewDescription.text=@"";
                cell.lblCharacterCount.text= @"0/200";
            }
            
            if ([[[arrExp objectAtIndex:indexPath.row] valueForKey:@"experience"] intValue] - 1 > 0)
            {
                [cell.viewNoExp setHidden:YES];
            }
            else
            {
                [cell.viewNoExp setHidden:NO];
            }
            
        }
        else
        {
        cell.lblPositionHeld.text=NSLocalizedString(@"POSITION HELD", @"");
            cell.lblCompanyName.text=NSLocalizedString(@"COMPANY NAME", @"");
            cell.txtViewDescription.text=@"";
            cell.lblCharacterCount.text= @"0/200";
            [cell.expSegment setSelectedSegmentIndex:0];
            [cell.viewNoExp setHidden:YES];
            expSelected = 0;
        }
        
        if(cell.expSegment.selectedSegmentIndex == 0)
        {
            cell.imgViewSearch.hidden = YES;
            cell.imgViewEdit.hidden = YES;
            cell.expSegment.selectedSegmentIndex = cell.expSegment.selectedSegmentIndex;
        }
        else
        {
            cell.imgViewSearch.hidden = NO;
            cell.imgViewEdit.hidden = NO;
            cell.expSegment.selectedSegmentIndex = cell.expSegment.selectedSegmentIndex;
        }
        
//        if (arrPositionHeldValues.count==indexPath.row+1 && arrPositionHeldValues.count>0)
//        {
//            cell.lblPositionHeld.text=[arrPositionHeldValues objectAtIndex:indexPath.row];
//        }
//        else
//        {
//            cell.lblPositionHeld.text=NSLocalizedString(@"POSITION HELD", @"");
//        }
        
        
        
        // ------------ By CS Rai ----------
        if(expSelected == 0) {
            
            cell.lblPositionHeld.hidden = YES;
            cell.lblCompanyName.hidden = YES;
            cell.btnPositionHeld.hidden = YES;
            cell.lblDescription.hidden = YES;
            cell.txtViewDescription.hidden = YES;
            cell.lblCharacterCount.hidden = YES;
            cell.btnAdd.hidden = YES;
            cell.btnRemove.hidden = YES;
            cell.lblIndustryType.hidden = YES;
            cell.labelSepratorSearch.hidden = YES;
            cell.labelSepratorPencil.hidden = YES;
            cell.btnCompanyName.hidden = YES;
            cell.btnPositionHeld.hidden = YES;
        } else {
            
            cell.lblPositionHeld.hidden = NO;
            cell.lblCompanyName.hidden = NO;
            cell.btnPositionHeld.hidden = NO;
            cell.lblDescription.hidden = NO;
            cell.txtViewDescription.hidden = NO;
            cell.lblCharacterCount.hidden = NO;
            cell.btnAdd.hidden = NO;
            cell.btnRemove.hidden = NO;
            cell.lblIndustryType.hidden = YES;
            cell.labelSepratorSearch.hidden = NO;
            cell.labelSepratorPencil.hidden = NO;
            cell.btnCompanyName.hidden = NO;
            cell.btnPositionHeld.hidden = NO;
        }
        // ------------ End of code By CS Rai ----------

        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tblPositionHold)
    {
        
//        //[arrPositionHeld removeAllObjects];
//        if (indexPath.row==0 && count == 0)
//        {
//            if(arrPositionHeld.count<4)
//            {
//                industry_type =[arrPositionHeld objectAtIndex:indexPath.row];
//            }
//            [arrPositionHeld removeAllObjects];
//            [arrPositionHeld addObjectsFromArray:[SharedClass getCuisineService]];
//        }
//        else if (indexPath.row==1 && count == 0)
//        {
//            if(arrPositionHeld.count<4)
//            {
//                industry_type =[arrPositionHeld objectAtIndex:indexPath.row];
//            }
//            [arrPositionHeld removeAllObjects];
//            [arrPositionHeld addObjectsFromArray:[SharedClass getSelleService]];
//        }
//        else if (indexPath.row==2 && count == 0)
//        {
//            if(arrPositionHeld.count<4)
//            {
//                industry_type =[arrPositionHeld objectAtIndex:indexPath.row];
//            }
//            [arrPositionHeld removeAllObjects];
//            [arrPositionHeld addObjectsFromArray:[SharedClass getHotelService]];
//        }
      //  [self.tblPositionHold reloadData];
        _btnPositionHeldBack.hidden=NO;
        TablePositionTapped=YES;
        count=count+1;
        if (count != 2) {
            
            selectedIndex = indexPath.row;
            [self.tblPositionHold reloadData];
            
        }
        viewBackFrame=_viewHolderTable.frame;
        tblPopupFrame=_tblPositionHold.frame;
        
        _viewHolderTable.translatesAutoresizingMaskIntoConstraints=YES;
        _tblPositionHold.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect newFrameOfMyView = CGRectMake(_viewHolderTable.frame.origin.x, 90, _viewHolderTable.frame.size.width,self.view.frame.size.height-150);
        
        CGRect newTableFrame=CGRectMake(_tblPositionHold.frame.origin.x,60, _tblPositionHold.frame.size.width,self.view.frame.size.height-210);
        
        /*
         * Alternatively you could just set the width/height or whatever you'd like with this:
         * CGRect newFrameOfMyView = myView.frame;
         * newFrameOfMyView.size.height = 200.0f;
         * newFrameOfMyView.size.width = 200.0f;
         */
        [UIView animateWithDuration:0.3f
                         animations:^{
                             _viewHolderTable.frame = newFrameOfMyView;
                             
                         }
                         completion:^(BOOL finished){
                             NSLog( @"woo! Finished animating the frame of myView!" );
                         }];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             _tblPositionHold.frame = newTableFrame;
                             
                         }
                         completion:^(BOOL finished)
                        {
                             NSLog(@"woo! Finished animating the frame of myView!");
                         }];
    }
    if (count==2)
    {
         TablePositionTapped=NO;
        _viewBgGrey.hidden=YES;
        _viewHolderTable.hidden=YES;
        _btnPositionHeldBack.hidden=YES;
        [headerView removeFromSuperview];
        [bottomView removeFromSuperview];
        
       // [arrPositionHeldValues addObject:[arrPositionHeld objectAtIndex:indexPath.row]];
       // [self.tblExperience reloadData];
        count=0;
        PositionDropDown * obj = [arrPostions objectAtIndex:selectedIndex];
        if (arrExp.count>postionHoldIndex)
        {
            ExperienceCell *cell =[_tblExperience cellForRowAtIndexPath:[NSIndexPath indexPathForRow:postionHoldIndex inSection:0]];
            expDict = [[NSMutableDictionary alloc]init];
            [expDict setValue:[obj.area_of_activities objectAtIndex:indexPath.row].position_id forKey:@"position_held"];
             [expDict setValue:[obj.area_of_activities objectAtIndex:indexPath.row].position_name forKey:@"position_held_name"];
            [expDict setValue:cell.lblCompanyName.text forKey:@"company_name"];
            [expDict setValue:cell.txtViewDescription.text forKey:@"description"];
            [expDict setValue:[NSString stringWithFormat:@"%ld",(long)cell.expSegment.selectedSegmentIndex + 1] forKey:@"experience"];
          //  [expDict setValue:cell.lblIndustryType.text forKey:@"industry_type"];
            //[expDict setValue:[[arrExp objectAtIndex:postionHoldIndex] valueForKey:@"experience_id"] forKey:@"experience_id"];
            [expDict setValue:obj.position_id forKey:@"industry_type"];
            [expDict setValue:obj.position_name forKey:@"industry_type_name"];
            [arrExp replaceObjectAtIndex:postionHoldIndex withObject:expDict];
        [_tblExperience reloadData];
        }
        else
        {
            ExperienceCell *cell =[_tblExperience cellForRowAtIndexPath:[NSIndexPath indexPathForRow:postionHoldIndex inSection:0]];
            expDict = [[NSMutableDictionary alloc]init];
            [expDict setValue:[obj.area_of_activities objectAtIndex:indexPath.row].position_id forKey:@"position_held"];
             [expDict setValue:[obj.area_of_activities objectAtIndex:indexPath.row].position_name forKey:@"position_held_name"];
            [expDict setValue:cell.lblCompanyName.text forKey:@"company_name"];
            [expDict setValue:cell.txtViewDescription.text forKey:@"description"];
           // [expDict setValue:cell.lblIndustryType.text forKey:@"industry_type"];
            [expDict setValue:[NSString stringWithFormat:@"%ld",(long)cell.expSegment.selectedSegmentIndex + 1] forKey:@"experience"];
            //[expDict setValue:[[arrExp objectAtIndex:postionHoldIndex] valueForKey:@"experience_id"] forKey:@"experience_id"];
            [expDict setValue:obj.position_id forKey:@"industry_type"];
            [expDict setValue:obj.position_name forKey:@"industry_type_name"];
            [arrExp addObject:expDict];
          [_tblExperience reloadData];
        }
        
        
        _viewHolderTable.translatesAutoresizingMaskIntoConstraints=YES;
        _tblPositionHold.translatesAutoresizingMaskIntoConstraints=YES;
        CGRect newFrameOfMyView =viewBackFrame;
        
        CGRect newTableFrame=tblPopupFrame;
        
        /*
         * Alternatively you could just set the width/height or whatever you'd like with this:
         * CGRect newFrameOfMyView = myView.frame;
         * newFrameOfMyView.size.height = 200.0f;
         * newFrameOfMyView.size.width = 200.0f;
         */
        [UIView animateWithDuration:0.3f
                         animations:^{
                             _viewHolderTable.frame = newFrameOfMyView;
                             
                         }
                         completion:^(BOOL finished){
                             NSLog( @"woo! Finished animating the frame of myView!" );
                         }];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             _tblPositionHold.frame = newTableFrame;
                             
                         }
                         completion:^(BOOL finished)
         {
             NSLog(@"woo! Finished animating the frame of myView!");
         }];

        
    }
    
}

-(void)showOtherTable:(id)sender
{
    
}

#pragma mark - -------TextView Delegates-------
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    ExperienceCell *cell =[_tblExperience cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    if (textField==cell.lblCompanyName)
    {
        if (arrExp.count>textField.tag)
        {
            expDict = [[NSMutableDictionary alloc]init];
            [expDict setValue:cell.lblPositionHeld.text forKey:@"position_held_name"];
            [expDict setValue:textField.text forKey:@"company_name"];
            [expDict setValue:cell.txtViewDescription.text forKey:@"description"];
            [expDict setValue:cell.lblIndustryType.text forKey:@"industry_type_name"];
            [expDict setValue:[NSString stringWithFormat:@"%ld",(long)cell.expSegment.selectedSegmentIndex + 1] forKey:@"experience"];
           // [expDict setValue:[[arrExp objectAtIndex:textField.tag] valueForKey:@"experience_id"] forKey:@"experience_id"];
            [arrExp replaceObjectAtIndex:textField.tag withObject:expDict];
        }
        
    }
    
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    ExperienceCell *cell =[_tblExperience cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    if (textField==cell.lblCompanyName)
    {
        if (arrExp.count>textField.tag)
        {
            expDict = [[NSMutableDictionary alloc]init];
            [expDict setValue:cell.lblPositionHeld.text forKey:@"position_held_name"];
            [expDict setValue:textField.text forKey:@"company_name"];
            [expDict setValue:cell.txtViewDescription.text forKey:@"description"];
            [expDict setValue:cell.lblIndustryType.text forKey:@"industry_type_name"];
            [expDict setValue:[NSString stringWithFormat:@"%ld",(long)cell.expSegment.selectedSegmentIndex + 1] forKey:@"experience"];
      //      [expDict setValue:[[arrExp objectAtIndex:textField.tag] valueForKey:@"experience_id"] forKey:@"experience_id"];
            [arrExp replaceObjectAtIndex:textField.tag withObject:expDict];
        }
        
    }

    [textField resignFirstResponder];
    
    return true;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    ExperienceCell *cell =[_tblExperience cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textView.tag-1000 inSection:0]];
    
    if (arrExp.count>textView.tag-1000)
    {
        if (textView==cell.txtViewDescription)
        {
            
            if ([text isEqualToString:@" "]) {
                if (!textView.text.length)
                    return NO;
                if ([[textView.text stringByReplacingCharactersInRange:range withString:text] rangeOfString:@"  "].length)
                    return NO;
            }
            else
            {
            
            
            expDict = [[NSMutableDictionary alloc]init];
            [expDict setValue:cell.lblPositionHeld.text forKey:@"position_held_name"];
            [expDict setValue:cell.lblCompanyName.text forKey:@"company_name"];
            [expDict setValue:textView.text forKey:@"description"];
            [expDict setValue:cell.lblIndustryType.text forKey:@"industry_type_name"];
            [expDict setValue:[NSString stringWithFormat:@"%ld",(long)cell.expSegment.selectedSegmentIndex + 1] forKey:@"experience"];
         //   [expDict setValue:[[arrExp objectAtIndex:textView.tag-1000] valueForKey:@"experience_id"] forKey:@"experience_id"];
            [arrExp replaceObjectAtIndex:textView.tag-1000 withObject:expDict];
            }
        }
    }
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
//    NSString *temp=textView.text;
//
//        if ([cell.txtViewDescription.text length]+ (text.length - range.length) >=101)
//        {
//            textView.text=[temp substringToIndex:[temp length]-1];
//        }
//        else
//           cell.lblCharacterCount.text=[NSString stringWithFormat:@"%lu/100",(unsigned long)[cell.txtViewDescription.text length]+ (text.length - range.length)];
    if(range.length + range.location > textView.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    if(newLength <= 200)
    {
        cell.lblCharacterCount.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)newLength];
    }
    return newLength <= 200;
    
    return true;
}


#pragma mark - --------Buttons Actions--------

-(void)btnCompanyNameAction:(UIButton *)btn
{
    ExperienceCell *cell =[_tblExperience cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    cell.lblCompanyName.text=@"";
    cell.lblCompanyName.userInteractionEnabled=YES;
    cell.lblCompanyName.tintColor=ButtonTitleColor;
    [cell.lblCompanyName becomeFirstResponder];
    
    
}

-(void)expSegmentAction:(UISegmentedControl *)sender
{
    ExperienceCell *cell =[_tblExperience cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
     expSelected =(int)cell.expSegment.selectedSegmentIndex;
   
    // ------------ By CS Rai ----------

    if(expSelected == 0) {
        
        cell.lblPositionHeld.hidden = YES;
        cell.lblCompanyName.hidden = YES;
        cell.btnPositionHeld.hidden = YES;
        cell.lblDescription.hidden = YES;
        cell.txtViewDescription.hidden = YES;
        cell.lblCharacterCount.hidden = YES;
        cell.btnAdd.hidden = YES;
        cell.btnRemove.hidden = YES;
        cell.lblIndustryType.hidden = YES;
        cell.lblIndustryType.hidden = YES;
        cell.labelSepratorSearch.hidden = YES;
        cell.labelSepratorPencil.hidden = YES;
        cell.btnCompanyName.hidden = YES;
        cell.btnPositionHeld.hidden = YES;
        [cell.imgViewEdit setHidden:YES];
        [cell.imgViewSearch setHidden:YES];
    } else {
        [cell.imgViewEdit setHidden:NO];
        [cell.imgViewSearch setHidden:NO];
        cell.lblPositionHeld.hidden = NO;
        cell.lblCompanyName.hidden = NO;
        cell.btnPositionHeld.hidden = NO;
        cell.lblDescription.hidden = NO;
        cell.txtViewDescription.hidden = NO;
        cell.lblCharacterCount.hidden = NO;
        cell.btnAdd.hidden = NO;
        cell.btnRemove.hidden = NO;
        cell.lblIndustryType.hidden = NO;
        cell.lblIndustryType.hidden = YES;
        cell.labelSepratorSearch.hidden = NO;
        cell.labelSepratorPencil.hidden = NO;
        cell.btnCompanyName.hidden = NO;
        cell.btnPositionHeld.hidden = NO;
    }
        // ------------ End Of Code By CS Rai ----------

    //expSelected = [sender titleForSegmentAtIndex:cell.expSegment.selectedSegmentIndex];
    if (arrExp.count>sender.tag)
    {
        expDict = [[NSMutableDictionary alloc]init];
        [expDict setValue:cell.lblPositionHeld.text forKey:@"position_held_name"];
        [expDict setValue:cell.lblCompanyName.text forKey:@"company_name"];
        [expDict setValue:cell.txtViewDescription.text forKey:@"description"];
        [expDict setValue:[[arrExp objectAtIndex:sender.tag]valueForKey:@"industry_type_name"] forKey:@"industry_type_name"];
        [expDict setValue:[NSString stringWithFormat:@"%ld",(long)cell.expSegment.selectedSegmentIndex + 1] forKey:@"experience"];
       // [expDict setValue:[[arrExp objectAtIndex:sender.tag] valueForKey:@"experience_id"] forKey:@"experience_id"];
        [arrExp replaceObjectAtIndex:sender.tag withObject:expDict];
        
        [_tblExperience reloadData];
    }
    
    }

-(void)btnPositionHeldTapped:(UIButton *)btn
{
    postionHoldIndex=(int)btn.tag;
     count=0;
//    PositionHeldViewController *presentedVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PositionHeldViewController"];
//    presentedVC.providesPresentationContextTransitionStyle = YES;
//    presentedVC.definesPresentationContext = YES;
//    [presentedVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
//    [presentedVC.view setAlpha:1.0];
//    presentedVC.delegate=self;
//    presentedVC.view.backgroundColor=[UIColor darkGrayColor];
//    //[self.view.window setRootViewController:presentedVC];
//    [self.tabBarController presentViewController:presentedVC animated:YES completion:nil];
    
    headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    headerView.backgroundColor=[UIColor darkGrayColor];
    [headerView setAlpha:0.5];
    
    bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    bottomView.backgroundColor=[UIColor darkGrayColor];
    [bottomView setAlpha:0.5];
    [self.tabBarController.view addSubview:bottomView];
//    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
//    [currentWindow addSubview:headerView];
    [self.navigationController.view addSubview:headerView];
    _viewBgGrey.hidden=NO;
    _viewHolderTable.hidden=NO;
    
    arrPositionHeld=[[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"Catering", @""),NSLocalizedString(@"Service", @""),NSLocalizedString(@"Hotel", @""), nil];
    [_tblPositionHold reloadData];
    
}

-(void)removeCurrentView:(UIViewController *)viewController
{
    //[viewController.view.window removeFromSuperview];
//    [[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:nil];
//    //[[UIApplication sharedApplication] keyWindow].rootViewController = newController;
//    [viewController removeFromParentViewController];
//     [viewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)addMoreItems:(UIButton *)sender
{
    TablePositionTapped = NO;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[arrItems count]-1         inSection:0];
    
    ExperienceCell *cell = [_tblExperience cellForRowAtIndexPath:indexPath];
//    ExperienceCell *cell =(ExperienceCell*)[[sender superview] superview];
    //NSIndexPath *indexpath=[_tblExperience indexPathForCell:cell];
    if ([cell.lblPositionHeld.text isEqualToString:NSLocalizedString(@"POSITION HELD", @"")])
    {
       [SharedClass MakeAlertonLabel:cell.lblPositionHeld];
    }
    else if ([cell.lblCompanyName.text isEqualToString:NSLocalizedString(@"COMPANY NAME", @"")])
    {
        [SharedClass MakeAlert:cell.lblCompanyName];
    }
    else if (cell.txtViewDescription.text.length==0)
    {
        [SharedClass MakeAlertTextView:cell.txtViewDescription];
    }

    else
    {
        if (arrItems.count>0)
        {
            
            //NSInteger row =sender.tag+1; //specify a row where you need to add new row
            //NSInteger section =0; //specify the section where the new row to be added,
            //section = 1 here since you need to add row at second section
            
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
//            [self.tblExperience beginUpdates];
//            [self.tblExperience insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//            [self.tblExperience endUpdates];
            [arrExp removeAllObjects];
            for (int i=0; i<[arrItems count]; i++)
            {
                NSIndexPath *indexpath=[NSIndexPath indexPathForRow:i inSection:0];
                ExperienceCell *cell = [_tblExperience cellForRowAtIndexPath:indexpath];
                expDict = [[NSMutableDictionary alloc]init];
                [expDict setValue:cell.lblPositionHeld.text forKey:@"position_held_name"];
                [expDict setValue:cell.lblCompanyName.text forKey:@"company_name"];
                [expDict setValue:cell.txtViewDescription.text forKey:@"description"];
                [expDict setValue:cell.lblIndustryType.text forKey:@"industry_type_name"];
                [expDict setValue:[NSString stringWithFormat:@"%ld",(long)cell.expSegment.selectedSegmentIndex + 1] forKey:@"experience"];
                //[expDict setValue:[NSString stringWithFormat:@"%d",expSelected] forKey:@"experience"];
                [arrExp addObject:expDict];
            }

            expDict = [[NSMutableDictionary alloc]init];
            [expDict setValue:NSLocalizedString(@"POSITION HELD", @"") forKey:@"position_held_name"];
            [expDict setValue:NSLocalizedString(@"COMPANY NAME", @"") forKey:@"company_name"];
            [expDict setValue:NSLocalizedString(@"DESCRIPTION", @"") forKey:@"description"];
            [expDict setValue:[NSString stringWithFormat:@"%d",1] forKey:@"experience"];
            [arrExp addObject:expDict];
            [arrItems addObject:@""];
            [self.tblExperience reloadData];
        }
        else
        {
            
        }
        
        
    }
    
    
    
    
}

-(void)removeItems:(UIButton *)sender
{
    TablePositionTapped = NO;
    if (arrItems.count>1)
    {
        [arrItems removeObjectAtIndex:sender.tag];
        if (arrExp.count>sender.tag)
        {
        //    NSString *expid=[[arrExp objectAtIndex:sender.tag] valueForKey:@"experience_id"];
          //  [self removeExperience:expid];
        }
        [arrExp removeObjectAtIndex:sender.tag];
        [self.tblExperience reloadData];

    }
}




- (IBAction)btnSaveAction:(id)sender
{
    [self.view endEditing:true];
    [arrCompleteExp removeAllObjects];
    if (arrExp.count==0)
    {
        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
        ExperienceCell *cell = [_tblExperience cellForRowAtIndexPath:indexpath];
        expDict = [[NSMutableDictionary alloc]init];
        NSLog(@"%d",cell.expSegment.selectedSegmentIndex);
        if (([cell.lblPositionHeld.text isEqualToString:NSLocalizedString(@"POSITION HELD", @"")]||[cell.lblCompanyName.text isEqualToString:NSLocalizedString(@"COMPANY NAME", @"")]||([cell.txtViewDescription.text length]==0)) && cell.expSegment.selectedSegmentIndex != 0)
        {
            [Alerter.sharedInstance showWarningWithMsg:NSLocalizedString(@"Please fill all the details", @"")];
            return;
        }
        else
        {
            [expDict setValue:cell.lblCompanyName.text forKey:@"company_name"];
            [expDict setValue:cell.txtViewDescription.text forKey:@"description"];
            [expDict setValue:[NSString stringWithFormat:@"%d",cell.expSegment.selectedSegmentIndex + 1] forKey:@"experience"];
            NSUInteger index = 0;
            BOOL isCheck = false;
            for (PositionDropDown *obj in arrPostions) {
                NSLog(@"%@",obj.position_name);
                if ([cell.lblIndustryType.text isEqualToString:obj.position_name]) {
                    [expDict setValue:obj.position_id forKey:@"industry_type"];
                    [expDict setValue:obj.position_name forKey:@"industry_type_name"];
                    isCheck = true;
                }
                if (isCheck == true) {
                    for (AreaOfActivities *objed in obj.area_of_activities) {
                        if ([cell.lblPositionHeld.text isEqualToString:objed.position_name]) {
                            [expDict setValue:objed.position_id forKey:@"position_held"];
                            [expDict setValue:objed.position_name forKey:@"position_held_name"];
                            break;
                        }
                    }
                    
                }
                
                index++;
            }
            
            if(cell.expSegment.selectedSegmentIndex == 0)
            {
                [expDict setValue:@"0" forKey:@"industry_type"];
                [expDict setValue:@"" forKey:@"industry_type_name"];
                [expDict setValue:@"0" forKey:@"position_held"];
                [expDict setValue:@"" forKey:@"position_held_name"];
                [expDict setValue:@"" forKey:@"company_name"];
            }
            
            
            [arrCompleteExp addObject:expDict];
            
            [self.delegate ExperienceSelected:arrCompleteExp];
            if(_isFromSignUp == NO)
            {
            [self editExperience];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        
        }
        
    }
    else
    {
        
        [arrCompleteExp removeAllObjects];
        for (int i=0; i<[arrExp count]; i++)
        {
            NSIndexPath *indexpath=[NSIndexPath indexPathForRow:i inSection:0];
            ExperienceCell *cell = (ExperienceCell *)[_tblExperience cellForRowAtIndexPath:indexpath];
            expDict = [[NSMutableDictionary alloc]init];
            //position, COmpany, Description
            if (([[[arrExp objectAtIndex:i] valueForKey:@"industry_type_name"]  isEqual: @""] ||[[[arrExp objectAtIndex:i] valueForKey:@"company_name"] isEqual: @""] ||[[[arrExp objectAtIndex:i] valueForKey:@"description"] isEqual: @""]) && ([[[arrExp objectAtIndex:i] valueForKey:@"experience"] intValue] != 1))
            {
              [Alerter.sharedInstance showWarningWithMsg:NSLocalizedString(@"Please fill all the details", @"")];
                return;
            }
            else
            {
                NSUInteger index = 0;
                BOOL isCheck = false;
                for (PositionDropDown *obj in arrPostions) {
                    NSLog(@"%@",obj.position_name);
                    if ([[[arrExp objectAtIndex:i] valueForKey:@"industry_type_name"] isEqualToString:obj.position_name]) {
                        [expDict setValue:obj.position_id forKey:@"industry_type"];
                        [expDict setValue:obj.position_name forKey:@"industry_type_name"];
                        isCheck = true;
                    }
                    if (isCheck == true) {
                        for (AreaOfActivities *objed in obj.area_of_activities) {
                            if ([[[arrExp objectAtIndex:i] valueForKey:@"position_held_name"] isEqualToString:objed.position_name]) {
                                [expDict setValue:objed.position_id forKey:@"position_held"];
                                [expDict setValue:objed.position_name forKey:@"position_held_name"];
                                 break;
                            }
                        }
                        
                    }
                    
                    index++;
                }
                
                
                
              //  [expDict setValue:cell.lblPositionHeld.text forKey:@"position_held_name"];
                
                [expDict setValue:[[arrExp objectAtIndex:i] valueForKey:@"company_name"] forKey:@"company_name"];
              
                [expDict setValue:[[arrExp objectAtIndex:i] valueForKey:@"description"] forKey:@"description"];
                [expDict setValue:[NSString stringWithFormat:@"%@",[[arrExp objectAtIndex:i] valueForKey:@"experience"]] forKey:@"experience"];
                
                if ([[[arrExp objectAtIndex:i] valueForKey:@"experience"] intValue] == 1) {
                    [expDict setValue:@"0" forKey:@"industry_type"];
                    [expDict setValue:@"" forKey:@"industry_type_name"];
                    [expDict setValue:@"0" forKey:@"position_held"];
                    [expDict setValue:@"" forKey:@"position_held_name"];
                    [expDict setValue:@"" forKey:@"company_name"];
                    [expDict setValue:@"" forKey:@"description"];
                }
                [arrCompleteExp addObject:expDict];

            }
        }
        if (arrCompleteExp.count>0)
        {
            NSLog(@"%@", arrCompleteExp);
            [self.delegate ExperienceSelected:arrCompleteExp];
            if(_isFromSignUp == false)
            {
                [self editExperience];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    }
    
    //{"user_id":"1","experience":"array(position_held,company_name,description,experience)"}
    //[self editExperience];
}

#pragma mark - ------WebService Methods-----

-(void)getPostions
{
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"postionDropDowns";
    [webhelper webserviceHelper:kGetPostionDropDowns showHud:YES];
    
}

-(void)getExperience
{
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
//    [params setValue:arrExp forKey:@"experience"];
//    
//    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
//    webHelper.methodName=@"editExperience";
//    webHelper.delegate=self;
//    [webHelper webserviceHelper:params webServiceUrl:kEditExperience methodName:@"editExperience" showHud:YES inWhichViewController:self];
    
}

-(void)editExperience
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    [params setValue:arrCompleteExp forKey:@"experience"];
    //[params setValue:industry_type forKey:@"industry_type"];
    
    
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"editExperience";
    webHelper.delegate=self;
    [webHelper webserviceHelper:params webServiceUrl:kEditExperience methodName:@"editExperience" showHud:YES inWhichViewController:self];
}

-(void)removeExperience:(NSString *)expid
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
  //  [params setValue:expid forKey:@"experience_id"];
    //[params setValue:arrExp forKey:@"experience_id"];
    
    
    WebserviceHelper *webHelper=[[WebserviceHelper alloc]init];
    webHelper.methodName=@"deleteExperience";
    webHelper.delegate=self;
    [webHelper webserviceHelper:params webServiceUrl:kDeleteExperience methodName:@"deleteExperience" showHud:YES inWhichViewController:self];
}

//-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
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
    if ([methodNameIs isEqualToString:@"editExperience"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
            NSMutableDictionary *tempDict=[[ProfileDataModel getModel] getResponse];
            [tempDict setObject:arrExp forKey:@"experience"];
        }
        else
        {
            
        }
    }
    else if([methodNameIs isEqualToString:@"deleteExperience"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([methodNameIs isEqualToString:@"postionDropDowns"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==1)
        {
            
            for (NSDictionary *dict in [responseDict valueForKey:@"positions"]) {
                
                PositionDropDown *obj = [[PositionDropDown alloc]init];
                [arrPostions addObject:[obj initWithDict:dict]];
            }
        }
    }
}
-(void)inProgress:(float)value
{
    
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnPositionHeldBackAction:(id)sender
{
    TablePositionTapped=NO;
    [arrPositionHeld removeAllObjects];
    arrPositionHeld=[arrTemp mutableCopy];
    [self.tblPositionHold reloadData];
    _btnPositionHeldBack.hidden=YES;
    
    count=count-1;
    
    CGRect newFrameOfMyView =viewBackFrame;
    
    CGRect newTableFrame=tblPopupFrame;
    
    
    /*
     * Alternatively you could just set the width/height or whatever you'd like with this:
     * CGRect newFrameOfMyView = myView.frame;
     * newFrameOfMyView.size.height = 200.0f;
     * newFrameOfMyView.size.width = 200.0f;
     */
    [UIView animateWithDuration:0.3f
                     animations:^{
                         //_viewHolderTable.translatesAutoresizingMaskIntoConstraints=YES;
                     //    _viewHolderTable.frame = newFrameOfMyView;
                         
                     }
                     completion:^(BOOL finished){
                         NSLog( @"woo! Finished animating the frame of myView!" );
                     }];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         //_tblPositionHold.translatesAutoresizingMaskIntoConstraints=YES;
                        // _tblPositionHold.frame = newTableFrame;
                         
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"woo! Finished animating the frame of myView!");
     }];
}

- (IBAction)btnClosePositionHeldValue:(id)sender
{
    TablePositionTapped=NO;
    _viewBgGrey.hidden=YES;
    _viewHolderTable.hidden=YES;
    _btnPositionHeldBack.hidden=YES;
    [headerView removeFromSuperview];
    [bottomView removeFromSuperview];
    postionHoldIndex=0;
    count=0;
    _viewHolderTable.translatesAutoresizingMaskIntoConstraints=YES;
    _tblPositionHold.translatesAutoresizingMaskIntoConstraints=YES;
    CGRect newFrameOfMyView =viewBackFrame;
    
    CGRect newTableFrame=tblPopupFrame;
    
    /*
     * Alternatively you could just set the width/height or whatever you'd like with this:
     * CGRect newFrameOfMyView = myView.frame;
     * newFrameOfMyView.size.height = 200.0f;
     * newFrameOfMyView.size.width = 200.0f;
     */
    [UIView animateWithDuration:0.3f
                     animations:^{
                         _viewHolderTable.frame = newFrameOfMyView;
                         
                     }
                     completion:^(BOOL finished){
                         NSLog( @"woo! Finished animating the frame of myView!" );
                     }];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         _tblPositionHold.frame = newTableFrame;
                         
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"woo! Finished animating the frame of myView!");
     }];
    
}



@end
