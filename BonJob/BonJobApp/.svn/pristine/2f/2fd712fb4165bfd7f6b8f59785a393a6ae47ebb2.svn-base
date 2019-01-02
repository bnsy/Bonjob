//
//  RecruiterChatViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 9/13/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "RecruiterChatViewController.h"
#import "Contact.h"
#import "Chat.h"
#import "LocalStorage.h"
#import "ChatCell.h"
#import "ChatViewController.h"
@interface RecruiterChatViewController ()
{
    NSMutableArray *arrResponse;
    BOOL searchActive;
     int PageNumber;
    BOOL stopReload;
    int totalUsers;
    BOOL isAdmin;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) NSMutableArray *filteredTableData;

@end


@implementation RecruiterChatViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    PageNumber=1;
    totalUsers = 0;
    [self setTableView];
    [self setTest];
    
    self.title =[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"CHAT", @"")];// NSLocalizedString(@"Chat", @"");
    _searchBar.placeholder = NSLocalizedString(@"Search Users", @"Search Users");
    
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:NSLocalizedString(@"CHAT", @"")];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    [SharedClass setBorderOnButton:self.btnGotoSearchJob];
    _lblWelcomeTitle.textColor=InternalButtonColor;
    _lblWelcomeTitle.text=NSLocalizedString(@"Welcome to the chat", @"");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMyOfferCount:) name:@"setrecruiteroffercount" object:nil];
    //_lbl1.text=NSLocalizedString(@"1.  Publiez une offre", @"");
    //_lbl2.text=NSLocalizedString(@"2.  Le candidat est intéressé et postule à l'offre", @"");
    //_lbl3.text=NSLocalizedString(@"3.  Une fois sélectionné vous pouvez débuter\n\tun chat ici avec le candidat", @"");
    
    if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"is_admin"] intValue]==1)
    {
        isAdmin = YES;
        [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        
    }
    else
    {
        isAdmin = NO;
        //Shubham Code
        self.searchBarHeightConstant.constant = 0.0;
    }
    self.filteredTableData = [[NSMutableArray alloc] init];
    
    
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getChatListData) name:@"chatStarted" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(unreadCountUpdated:) name:@"unreadCountUpdated" object:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_searchBar.text.length == 0) {
   
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _btnGotoSearchJob.frame.origin.y+_btnGotoSearchJob.frame.size.height+20)];
    [self.tableData removeAllObjects];
    [self getChatListData];
    [self.tableView reloadData];
        
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - -----------Get Chat list Data-------------

-(void)getChatListData
{
    if (totalUsers == _tableData.count && totalUsers != 0 && PageNumber != 1) {
        stopReload = NO;
        return;
    }
    [arrResponse removeAllObjects];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
    if (isAdmin) {
        NSString *page = [[NSString alloc] initWithFormat:@"%d", PageNumber];
        [params setValue:page forKey:@"page"];
    }
   
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.delegate=self;
    webhelper.methodName=@"getChatList";
    [webhelper webserviceHelper:params webServiceUrl:kGetChatList methodName:@"getChatList" showHud:YES inWhichViewController:self];
}

-(void)inProgress:(float)value
{
    
}

-(void)processSuccessful:(NSDictionary *)responseDict methodName:(NSString *)methodNameIs
{
    if ([[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"active_user"]] isEqualToString:@"0"])
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
    if ([methodNameIs isEqualToString:@"getChatList"] || [methodNameIs isEqualToString:@"getContactList"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            NSString *numStr = [NSString stringWithFormat:@"%llu", [responseDict[@"totalUsers"] unsignedLongLongValue]];
            totalUsers = numStr.intValue;
           // totalUsers = responseDict[@"totalUsers"];
            if (PageNumber == 1) {
                 arrResponse =[[NSMutableArray alloc]init];
            }
           
            NSArray *temparr=[[self validateDict:[responseDict valueForKey:@"data"]]mutableCopy];
            [arrResponse addObjectsFromArray:temparr];
            NSDictionary *dict;
            for (int i=0; i<[arrResponse count]; i++)
            {
                dict=[[arrResponse objectAtIndex:i] mutableCopy];
                [dict setValue:@"" forKey:@"last_message_date"];
                [dict setValue:@"0" forKey:@"unread_count"];
                [arrResponse replaceObjectAtIndex:i withObject:dict];
            }
                 [self.tableView reloadData];
           
            [self checkDatabase];
            if (arrResponse.count>0)
            {
                [self.scrollView setHidden:YES];
                [self.viewDefaultView setHidden:YES];
            }
            else
            {
                if(_searchBar.text.length == 0)
                {
                [self.scrollView setHidden:NO];
                [self.viewDefaultView setHidden:NO];
                }
              
            }
            stopReload=NO;
        }
        else
        {
            stopReload=NO;
           // [SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
        }
    }
    
}

-(NSMutableArray*)validateDict:(NSMutableArray *)arr
{
    NSMutableArray *temparr=[arr mutableCopy];
    for (NSDictionary *dict in arr)
    {
        NSArray *tempKey =[dict allKeys];
        NSMutableDictionary *tempdic =[dict mutableCopy];
        for (NSString *str in tempKey)
        {
            if ([tempdic objectForKey:str]==[NSNull null])
            {
                [tempdic setValue:@"" forKey:str];
            }
            
        }
        [temparr replaceObjectAtIndex:[arr indexOfObject:dict] withObject:tempdic];
    }
    return temparr;
}


-(void)unreadCountUpdated:(NSNotification *)notification
{
    if (PageNumber == 1) {
        self.tableData = [[NSMutableArray alloc] init];
        
    }
   
    [self checkDatabase];
}

-(void)checkDatabase
{
    int count=0;
    NSDictionary *dict;//=[[arrResponse objectAtIndex:0] mutableCopy];
    for (int i=0; i<[arrResponse count]; i++)
    {
        NSString *from=[NSString stringWithFormat:@"bonjob_%@", [[arrResponse objectAtIndex:i] valueForKey:@"user_id"]];
        DBManager *dataManager=[[DBManager alloc]initWithDB:DATABASE_NAME];
        NSString* dialogId=[self getNickNameFromUserName:from];
        
        NSString* queryLastChatDate=[NSString stringWithFormat:@"select last_message_date from DIALOG_HISTORY where dialog_id=\"%@\"",dialogId];
        NSString* creationDate=[dataManager getCreationDate:queryLastChatDate];
        if (creationDate==nil)
        {
            creationDate=@"";
        }
        NSString* queryUnread=[NSString stringWithFormat:@"select unread_count from DIALOG_HISTORY where dialog_id=\"%@\"",dialogId];
        int unread=[dataManager getUnreadCount:queryUnread];
        count=count+unread;
        dict=[[arrResponse objectAtIndex:i] mutableCopy];
        [dict setValue:[NSString stringWithFormat:@"%d",unread] forKey:@"unread_count"];
        [dict setValue:creationDate forKey:@"last_message_date"];
        [arrResponse replaceObjectAtIndex:i withObject:dict];
    }
    if (count>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:[NSString stringWithFormat:@"%d",count]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
        }
        else
        {
        [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeColor:InternalButtonColor];
        }
    }
    else
    {
        [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:nil];
    }
    
    [self setTest];
    [self.tableView reloadData];
    
}

-(NSString*)getNickNameFromUserName:(NSString*)name
{
    NSArray* myArray = [name  componentsSeparatedByString:@"@"];
    
    NSString* firstString = myArray.count==2 ?[myArray objectAtIndex:0]:name;
    return firstString;
    
}



-(void)setTableView
{
    self.tableData = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,self.view.frame.size.width, 10.0f)];
    //self.tableView.backgroundColor = [UIColor clearColor];
}
-(void)setTest
{
    if (PageNumber == 1) {
        [self.tableData removeAllObjects];
    }
 
    for (int i=0; i<[arrResponse count]; i++)
    {
        Contact *contact=[[Contact alloc]init];
        contact.name=[[arrResponse objectAtIndex:i] valueForKey:@"first_name"];
        contact.lastName=[[arrResponse objectAtIndex:i] valueForKey:@"last_name"];
        contact.identifier=[[arrResponse objectAtIndex:i] valueForKey:@"user_id"];
        contact.image_id=[[arrResponse objectAtIndex:i] valueForKey:@"user_pic"];
        contact.job_Name=[[arrResponse objectAtIndex:i] valueForKey:@"job_title"];
        contact.lastMesageDate=[[arrResponse objectAtIndex:i] valueForKey:@"last_message_date"];
        contact.unreadCount=[[arrResponse objectAtIndex:i] valueForKey:@"unread_count"];
        Chat *chat = [[Chat alloc] init];
        chat.contact = contact;
        [self.tableData addObject:chat];
        
    }
    
    
//    Contact *contact = [[Contact alloc] init];
//    contact.name = @"Player 1";
//    contact.identifier = @"12345";
//    Chat *chat = [[Chat alloc] init];
//    chat.contact = contact;
//    
//    Contact *contact1 = [[Contact alloc] init];
//    contact1.name = @"Player 1";
//    contact1.identifier = @"12345";
//    Chat *chat1 = [[Chat alloc] init];
//    chat1.contact = contact1;
//    
//    Contact *contact2 = [[Contact alloc] init];
//    contact2.name = @"Player 1";
//    contact2.identifier = @"12345";
//    Chat *chat2 = [[Chat alloc] init];
//    chat2.contact = contact2;
    
    NSArray *texts; /*= @[@"Hello!",
                     @"This project try to implement a chat UI similar to Whatsapp app.",
                     @"Is it close enough?"]; */
    
    texts=@[@"",@"",@""];
    
//    Message *last_message = nil;
//    for (NSString *text in texts)
//    {
//        Message *message = [[Message alloc] init];
//        message.text = text;
//        message.sender = MessageSenderSomeone;
//        message.status = MessageStatusReceived;
//        message.chat_id = chat.identifier;
//        
//        [[LocalStorage sharedInstance] storeMessage:message];
//        last_message = message;
//    }
//    
//    chat.numberOfUnreadMessages = texts.count;
//    chat.last_message = last_message;
    
//    [self.tableData addObject:chat];
//    [self.tableData addObject:chat1];
//    [self.tableData addObject:chat2];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChatListCell";
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[ChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    if(searchActive){
//      cell.chat = [self.filteredTableData objectAtIndex:indexPath.row];
//    }
//    else{
    cell.chat = [self.tableData objectAtIndex:indexPath.row];
 //   }
    
    cell.imageView.layer.borderWidth=0.8;
    cell.imageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    cell.imageView.clipsToBounds=YES;
    return cell;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 if (isAdmin)
 {
    if (arrResponse.count>=4)
    {
        if (stopReload==NO)
        {
            if (self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
             {
           // if (indexPath.row == [arrResponse count] - 1 )
            //{
                stopReload = YES;
                NSLog(@"Calling.................");
                
                PageNumber=PageNumber+1;
                 if (_searchBar.text.length != 0) {
                    [self apiGetContactListData:_searchBar.text];
                 }
                 else
                 {
                  [self getChatListData];
                 }
                
            }
        }
        
    }
 }
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *userid=[NSString stringWithFormat:@"bonjob_%@@%@",[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"user_id"],kDefaultChatServer];
    //NSString *userId = @"bonjob_42@172.104.8.51";//arrayUsers[indexPath.row];
    
    ChatViewController* vc=[[ChatViewController alloc]initWithUser:userid andNameOfUser:[NSString stringWithFormat:@"%@ %@",[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"first_name"],[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"last_name"]]  andUserImage:[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"user_pic"]];
    vc.jobTitle=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_title"];
    vc.JobDesc=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_description"];
    vc.jobImage=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_image"];
    vc.identifier=@"fromrecruiter";
    vc.current_User_Id = [[arrResponse objectAtIndex:indexPath.row] valueForKey:@"user_id"];
    UINavigationController *navc=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:nil];
//    [self.navigationController pushViewController:navc animated:YES];
    
    //    MessageController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Message"];
    //    controller.chat = [self.tableData objectAtIndex:indexPath.row];
    //    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)btnGotoJobAction:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
}
#pragma mark - UISearchBarDelegate

 -(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchActive = YES;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchActive = NO;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchActive = NO;
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if(searchText.length == 0)
    {
        searchActive = NO;
        PageNumber = 1;
      [self getChatListData];
       //
    }
    else
    {
        searchActive = YES;
    }
    
   
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     [searchBar resignFirstResponder];
      PageNumber = 1;
    if (searchBar.text.length == 0) {
        [self getChatListData];
    }
    else
    {
        [self apiGetContactListData:searchBar.text];
    }
    
  
}

#pragma mark - API For Search Users

-(void)apiGetContactListData:(NSString*)searchText
{
    if (totalUsers == _tableData.count && totalUsers != 0) {
         stopReload = NO;
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@"1" forKey:@"user_id"];
    NSString *page = [[NSString alloc] initWithFormat:@"%d", PageNumber];
    [params setValue:page forKey:@"page"];
    [params setValue:searchText forKey:@"search_name"];
    WebserviceHelper *webhelper=[[WebserviceHelper alloc]init];
    webhelper.methodName=@"getContactList";
    webhelper.delegate=self;
    [webhelper webserviceHelper:params webServiceUrl:kGetContactList methodName:@"getContactList" showHud:YES inWhichViewController:self];
}

@end
