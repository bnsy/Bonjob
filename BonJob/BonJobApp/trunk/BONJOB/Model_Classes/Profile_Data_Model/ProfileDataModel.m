//
//  ProfileDataModel.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/3/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "ProfileDataModel.h"

@implementation ProfileDataModel
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
    return self;
}

-(NSMutableDictionary *)getResponse
{
    return _responseDict;
}
-(void)updateGallery:(NSString *)dict atIndex:(int)index
{
    if ([[_responseDict valueForKey:@"gallery"] count]>0)
    {
        NSMutableDictionary *temp=[[[_responseDict valueForKey:@"gallery"] objectAtIndex:index] mutableCopy];
        [temp setValue:dict forKey:@"description"];
        [[_responseDict valueForKey:@"gallery"] replaceObjectAtIndex:index withObject:temp];
    }
}
-(void)deleteGalleryatIndex:(int)index
{
    if ([[_responseDict valueForKey:@"gallery"] count]>0)
    {
        [[_responseDict valueForKey:@"gallery"]removeObjectAtIndex:index];
    }
}
-(void)addObjectToGallery:(NSDictionary *)dict;
{
    [[_responseDict valueForKey:@"gallery"]addObject:dict];
}
@end
