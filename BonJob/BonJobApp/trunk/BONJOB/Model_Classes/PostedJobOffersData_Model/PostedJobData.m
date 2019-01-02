//
//  PostedJobData.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/21/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "PostedJobData.h"


@implementation PostedJobData
+ (id)getData
{
    static PostedJobData *sharedInstance = nil;
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

-(void)setJobData:(NSMutableDictionary *)responceDict
{
    self.dictJobData=[[NSMutableDictionary alloc]init];
    self.dictJobData=responceDict;
    
}

-(NSMutableDictionary *)getJobData
{
    return _dictJobData;
}

-(void)changesActivetoClose:(NSDictionary *)dict atIndex:(int)index
{
    [[_dictJobData valueForKey:@"ActiveJobs"] removeObjectAtIndex:index];
    [[_dictJobData valueForKey:@"closedJobs"] addObject:dict];
}
-(void)changesClosetoActive:(NSDictionary *)dict atIndex:(int)index
{
    [[_dictJobData valueForKey:@"closedJobs"] removeObjectAtIndex:index];
    [[_dictJobData valueForKey:@"ActiveJobs"] addObject:dict];
}

@end
