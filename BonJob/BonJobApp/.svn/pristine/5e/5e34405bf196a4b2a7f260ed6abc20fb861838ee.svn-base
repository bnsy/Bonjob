//
//  ChatListController.m
//  Whatsapp
//
//  Created by Rafael Castro on 7/24/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import "ChatController.h"
#import "MessageController.h"
#import "ChatCell.h"
#import "Chat.h"
#import "LocalStorage.h"
#import "ChatViewController.h"
@interface ChatController() <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arrResponse;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@end


@implementation ChatController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTableView];
    [self setTest];
    self.title =[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"CHAT", @"")];// NSLocalizedString(@"CHAT", @"");
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:NSLocalizedString(@"CHAT", @"")];
    self.navigationController.navigationBar.tintColor =ButtonTitleColor;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:TitleColor}];
    _lblWelcomeTitle.textColor=InternalButtonColor;
    _lblWelcomeTitle.text=NSLocalizedString(@"Welcome to the chat", @"");
    [SharedClass setBorderOnButton:self.btnGotoSearchJob];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setUserActivity:) name:@"setuseractivity" object:nil];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _btnGotoSearchJob.frame.origin.y+_btnGotoSearchJob.frame.size.height+60)];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableData removeAllObjects];
    [self getChatListData];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(unreadCountUpdated:) name:@"unreadCountUpdated" object:nil];
}
-(void)setUserActivity:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"useractivitycount"]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
        }
        else
        {
        [[self.tabBarController.tabBar.items objectAtIndex:3]setBadgeColor:InternalButtonColor];
        }
    }
    
}

#pragma mark - -----------Get Chat list Data-------------

-(void)getChatListData
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"] valueForKey:@"user_id"] forKey:@"user_id"];
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
    if ([methodNameIs isEqualToString:@"getChatList"])
    {
        if ([[responseDict valueForKey:@"success"] boolValue]==YES)
        {
            arrResponse =[[NSMutableArray alloc]init];
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
            [self checkDatabase];
            
            if (arrResponse.count>0)
            {
                [self.scrollView setHidden:YES];
                [self.viewDefaultView setHidden:YES];
            }
            else
            {
                [self.scrollView setHidden:NO];
                [self.viewDefaultView setHidden:NO];
            }
            
            [self.tableView reloadData];
        }
        else
        {
           // [Alerter.sharedInstance showErrorWithMsg:[responseDict valueForKey:@"msg"]];
            //[SharedClass showToast:self toastMsg:[responseDict valueForKey:@"msg"]];
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
    self.tableData = [[NSMutableArray alloc] init];
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
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
        }
        else
        {
        [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:nil];
        }
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

//-(void)setTest
//{
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
//    
//    NSArray *texts; /*= @[@"Hello!",
//                       @"This project try to implement a chat UI similar to Whatsapp app.",
//                       @"Is it close enough?"]; */
//    
//    texts=@[@"",@"",@""];
//    
//    Message *last_message = nil;
//    for (NSString *text in texts)
//    {
//        Message *message = [[Message alloc] init];
//        message.text = text;
//        message.sender = MessageSenderSomeone;
//        message.status = MessageStatusReceived;
//        message.chat_id = chat.identifier;
//        [[LocalStorage sharedInstance] storeMessage:message];
//        last_message = message;
//    }
//    
//    chat.numberOfUnreadMessages = texts.count;
//    chat.last_message = last_message;
//
//    [self.tableData addObject:chat];
//    [self.tableData addObject:chat1];
//    [self.tableData addObject:chat2];
//}


-(void)setTest
{
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
    
    cell.chat = [self.tableData objectAtIndex:indexPath.row];
    cell.imageView.layer.borderWidth=0.8;
    cell.imageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    cell.imageView.clipsToBounds=YES;
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *userid=[NSString stringWithFormat:@"bonjob_%@@%@",[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"user_id"],kDefaultChatServer];
    //NSString *userId = @"bonjob_54@172.104.8.51";//arrayUsers[indexPath.row];
    
    ChatViewController* vc=[[ChatViewController alloc]initWithUser:userid andNameOfUser:[NSString stringWithFormat:@"%@ %@",[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"first_name"],[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"last_name"]]  andUserImage:[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"user_pic"]];
    vc.jobTitle=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_title"];
    vc.JobDesc=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_description"];
    vc.jobImage=[[arrResponse objectAtIndex:indexPath.row] valueForKey:@"job_image"];
    vc.identifier=@"fromuser";
    
    
    UINavigationController *navc=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:nil];
    
//    MessageController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Message"];
//    controller.chat = [self.tableData objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btnGotoJobAction:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
}
@end
