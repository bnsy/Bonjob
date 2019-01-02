//
//  SelectedCandidate.m
//  BONJOB
//
//  Created by VISHAL-SETH on 9/8/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "SelectedCandidate.h"

@implementation SelectedCandidate
+ (id)getCandidate
{
    static SelectedCandidate *sharedInstance = nil;
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

-(void)setCandidateResponse:(NSMutableDictionary *)responceDict
{
    self.dictJobData=[[NSMutableDictionary alloc]init];
    self.dictJobData=responceDict;
    
}

-(NSMutableDictionary *)getCandidateResponse
{
    return _dictJobData;
}


-(void)deleteCandidateFromSelected:(int)index
{
    [[_dictJobData valueForKey:@"selectedData"] removeObjectAtIndex:index];
}

-(void)changesSelecttoArchieve:(NSDictionary *)dict atIndex:(int)index
{
    [[_dictJobData valueForKey:@"selectedData"] removeObjectAtIndex:index];
    [[_dictJobData valueForKey:@"notSelectedData"] addObject:dict];
}
-(void)changesArcheivetoSelected:(NSDictionary *)dict atIndex:(int)index
{
    [[_dictJobData valueForKey:@"notSelectedData"] removeObjectAtIndex:index];
    [[_dictJobData valueForKey:@"selectedData"] addObject:dict];
}

@end
