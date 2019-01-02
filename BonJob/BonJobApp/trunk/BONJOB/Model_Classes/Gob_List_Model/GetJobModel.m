//
//  GetJobModel.m
//  BONJOB
//
//  Created by VISHAL-SETH on 8/22/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "GetJobModel.h"

@implementation GetJobModel

+ (id)getModel
{
    static ProfileDataModel *sharedInstance = nil;
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
    _responseDict=[[NSMutableArray alloc]init];
    return self;
}

-(void)setResponseDict:(NSMutableArray *)responseDictt
{
    
    _responseDict = [responseDictt mutableCopy];
}

-(NSMutableArray *)getResponse
{
    return _responseDict;
}

@end
