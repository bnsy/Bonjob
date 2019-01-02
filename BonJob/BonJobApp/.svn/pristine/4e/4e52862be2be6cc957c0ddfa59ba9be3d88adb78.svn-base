//
//  GetAppliedCandidate.m
//  BONJOB
//
//  Created by VISHAL-SETH on 9/6/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "GetAppliedCandidate.h"

@implementation GetAppliedCandidate

+(id)getCandidate
{
    static GetAppliedCandidate *sharedInstance = nil;
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

-(void)setResponseData:(NSMutableDictionary *)responseData
{
    self.dictJobData =[[NSMutableDictionary alloc]init];
    self.dictJobData=responseData;
}
-(NSMutableDictionary *)getResponseData
{
    return _dictJobData;
}
-(void)changesArchievetoClose:(NSDictionary *)dict atIndex:(int)index
{
    [[_dictJobData valueForKey:@"ActiveJobs"] removeObjectAtIndex:index];
    [[_dictJobData valueForKey:@"closedJobs"] addObject:dict];

}
-(void)changesClosetoArchieve:(NSDictionary *)dict atIndex:(int)index
{
    [[_dictJobData valueForKey:@"closedJobs"] removeObjectAtIndex:index];
    [[_dictJobData valueForKey:@"ActiveJobs"] addObject:dict];
}
@end
