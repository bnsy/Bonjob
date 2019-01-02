//
//  NotificationHelper.h
//  BONJOB
//
//  Created by VISHAL-SETH on 11/3/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationHelper : NSObject
+ (id)sharedInstance;

-(void)SetDataForNotification:(NSDictionary *)userDict andType:(NSString *)type;
-(void)SetDataForLiveActivity:(NSDictionary *)userDict andType:(NSString *)type;



@end
