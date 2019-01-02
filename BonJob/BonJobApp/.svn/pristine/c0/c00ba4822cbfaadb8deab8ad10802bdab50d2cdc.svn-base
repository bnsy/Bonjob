//
//  GetCandidate.m
//  BONJOB
//
//  Created by VISHAL-SETH on 9/4/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import "GetCandidate.h"

@implementation GetCandidate
+ (id)getModel
{
    static GetCandidate *sharedInstance = nil;
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

-(void)setResponseArray:(NSMutableArray *)responseDictt
{
    _responseDict=[[NSMutableArray alloc]init];
    _responseDict =[responseDictt mutableCopy];
}

-(NSMutableArray *)getResponseArray
{
    return _responseDict;
}

@end
