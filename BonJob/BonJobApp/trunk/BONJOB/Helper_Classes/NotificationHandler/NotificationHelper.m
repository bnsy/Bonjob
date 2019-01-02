//
//  NotificationHelper.m
//  BONJOB
//
//  Created by VISHAL-SETH on 11/3/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "NotificationHelper.h"
#import "ActiveViewController.h"
#import "TabbarViewController.h"
#import "Constant.h"
@implementation NotificationHelper
+ (id)sharedInstance
{
    static NotificationHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}




-(void)SetDataForLiveActivity:(NSDictionary *)userDict andType:(NSString *)type
{
    NSString *isLogined=[[NSUserDefaults standardUserDefaults] valueForKey:@"logined"];
    if ([isLogined isEqualToString:@"YES"])
    {
        if ([type isEqualToString:@"chat"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshchat" object:nil];
        }
        else if([type isEqualToString:@"Apply Job"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"AvailableCandidate" object:nil];
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"E"])
            {
                int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Recruteroffercount"]intValue];
                count=count+1;
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Recruteroffercount"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"setrecruiteroffercount" object:nil];
                
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                //[self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if([type isEqualToString:@"selectCandidate"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"AvailableCandidate" object:nil];
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                //[self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if([type isEqualToString:@"hireCandidate"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                //[self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                }
            }
        }
        else if([type isEqualToString:@"notSelectCandidate"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                //[self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if([type isEqualToString:@"jobexpired"])
        {
            //[[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                //[self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        //SelectedByRecruiter
        else if([type isEqualToString:@"SelectedByRecruiter"])
        {
            //[[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                //[self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                }
            }
        }
        else if([type isEqualToString:@"acceptRequest"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"AvailableCandidate" object:nil];
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"E"])
            {
                int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Recruteroffercount"]intValue];
                count=count+1;
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Recruteroffercount"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"setrecruiteroffercount" object:nil];
                
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                //[self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if([type isEqualToString:@"rejectRequest"])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"AvailableCandidate" object:nil];
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"E"])
            {
                int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Recruteroffercount"]intValue];
                count=count+1;
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Recruteroffercount"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"setrecruiteroffercount" object:nil];
                
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                //[self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        
        else
        {
            // new
        }
    }
    else
    {
        [self gotoLoginScreen];
    }
}


-(void)SetDataForNotification:(NSDictionary *)userDict andType:(NSString *)type
{
    NSString *isLogined=[[NSUserDefaults standardUserDefaults] valueForKey:@"logined"];
    if ([isLogined isEqualToString:@"YES"])
    {
        if ([type isEqualToString:@"chat"])
        {
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                [self gotoSeekerChatScreen];
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"E"])
            {
                [self gotoRecruiterChatScreen];
            }
            else
            {
                [self gotoLoginScreen];
            }
        }
        else if ([type isEqualToString:@"Apply Job"])
        {
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"E"])
            {
                int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Recruteroffercount"]intValue];
                count=count+1;
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Recruteroffercount"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"setrecruiteroffercount" object:nil];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"AvailableCandidate" object:nil];
                
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                [self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if ([type isEqualToString:@"selectCandidate"])
        {
            // select
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                [self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"AvailableCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
                
            }
            
        }
        else if ([type isEqualToString:@"hireCandidate"])
        {
            // hire
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                [self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if([type isEqualToString:@"notSelectCandidate"])
        {
            //unselect
            //[self gotoSeekerMyOffers];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                [self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if([type isEqualToString:@"jobexpired"])
        {
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                [self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if([type isEqualToString:@"SelectedByRecruiter"])
        {
            //[[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                [self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                }
            }
        }
        else if ([type isEqualToString:@"acceptRequest"])
        {
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"E"])
            {
                int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Recruteroffercount"]intValue];
                count=count+1;
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Recruteroffercount"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"setrecruiteroffercount" object:nil];
                
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                [self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
        else if ([type isEqualToString:@"rejectRequest"])
        {
            
            if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"E"])
            {
                int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"Recruteroffercount"]intValue];
                count=count+1;
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"Recruteroffercount"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"setrecruiteroffercount" object:nil];
                
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"] isEqualToString:@"S"])
            {
                
                [self gotoSeekerMyOffers];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"GetHiredCandidate" object:nil];
                if ([self isUserActivityView])
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"useractivitycount"]intValue];
                    count=count+1;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:@"useractivitycount"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setuseractivity" object:nil];
                    
                }
            }
        }
    }
    else
    {
        [self gotoLoginScreen];
    }
    
}

-(void)gotoSeekerChatScreen
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    TabbarViewController *tab = (TabbarViewController *)[mainStoryboard
                                                         instantiateViewControllerWithIdentifier:@"TabbarViewController"];
    [tab setSelectedIndex:2];
    [tab.selectedViewController viewDidLoad];
    APPDELEGATE.window.rootViewController = tab;
}
-(void)gotoRecruiterChatScreen
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    RecruiterTabarViewController *tab = (RecruiterTabarViewController *)[mainStoryboard
                                                                         instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
    [tab setSelectedIndex:2];
    [tab.selectedViewController viewDidAppear:YES];
    APPDELEGATE.window.rootViewController = tab;
}
-(void)gotoLoginScreen
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    HomeViewController *tab = (HomeViewController *)[mainStoryboard
                                                     instantiateViewControllerWithIdentifier:@"HomeViewController"];
    APPDELEGATE.window.rootViewController = tab;
}
-(void)gotoRecruiterMyOffers
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    RecruiterTabarViewController *tab = (RecruiterTabarViewController *)[mainStoryboard
                                                                         instantiateViewControllerWithIdentifier:@"RecruiterTabarViewController"];
    [tab setSelectedIndex:1];
    [tab.selectedViewController viewWillAppear:YES];
    APPDELEGATE.window.rootViewController = tab;
}
-(void)gotoSeekerMyOffers
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    TabbarViewController *tab = (TabbarViewController *)[mainStoryboard
                                                         instantiateViewControllerWithIdentifier:@"TabbarViewController"];
    [tab setSelectedIndex:3];
    [tab.selectedViewController viewWillAppear:YES];
    APPDELEGATE.window.rootViewController = tab;
}

-(BOOL)isUserActivityView
{
    NSArray *viewControllers = ((UINavigationController *)Appdelegate.window.rootViewController).viewControllers;
    UIViewController* vc=[viewControllers lastObject];
    if([vc isKindOfClass:[ActiveViewController class]])
    {
        return YES;
    }
    return NO;
}

@end

