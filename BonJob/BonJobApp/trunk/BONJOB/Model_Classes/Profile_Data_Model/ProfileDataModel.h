//
//  ProfileDataModel.h
//  BONJOB
//
//  Created by VISHAL-SETH on 7/3/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileDataModel : NSObject
+(id)getModel;
@property(nonatomic,strong)NSMutableDictionary *responseDict;
-(NSMutableDictionary *)getResponse;
-(void)updateGallery:(NSString *)dict atIndex:(int)index;
-(void)deleteGalleryatIndex:(int)index;
-(void)addObjectToGallery:(NSDictionary *)dict;
@end
