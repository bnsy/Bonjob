//
//  AppDelegate.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/15/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPManager.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UNUserNotificationCenterDelegate,UIAlertViewDelegate>
{
    CLLocation *currLocation;
    
}
@property(nonatomic) BOOL isFilterSeeker;
@property(nonatomic) BOOL isFilterRecruiter;
@property(nonatomic) BOOL isNeedLoad;
@property(nonatomic,strong)NSString *userAddress;
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
@property(nonatomic,strong)CLLocationManager *locationManager;
@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) XMPPManager *xmppManager;
@property(strong,nonatomic)NSMutableArray *arrOnlineBuddies;
@property(strong,nonatomic)NSDictionary *currentPlanDict;
@property(strong,nonatomic)NSMutableArray *arrPlanData;
@property(strong,nonatomic)NSMutableArray *arrSelContractSeeker;
@property(strong,nonatomic)NSMutableArray *arrSelEducationSeeker;
@property(strong,nonatomic)NSMutableArray *arrSelExperienceSeeker;
@property(strong,nonatomic)NSMutableArray *arrSelHoursSeeker;

@property(strong,nonatomic) NSMutableArray *arraySelSkillsRecruiter,*arraySelEducationRecruiter,*arraySelExperienceRecruiter,*arraySelStatusRecruiter,*arraySelMobilityRecruiter,*arraySelLanguageRecruiter;


+(void)changeRoot;
@end

