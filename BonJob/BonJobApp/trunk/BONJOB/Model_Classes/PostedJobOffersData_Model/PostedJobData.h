//
//  PostedJobData.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/21/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostedJobData : NSObject
+(id)getData;
@property(nonatomic,strong)NSMutableDictionary *dictJobData;
-(void)setJobData:(NSMutableDictionary *)dictJobData;
-(NSMutableDictionary *)getJobData;
-(void)changesActivetoClose:(NSDictionary *)dict atIndex:(int)index;
-(void)changesClosetoActive:(NSDictionary *)dict atIndex:(int)index;
@end
