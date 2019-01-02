//
//  GetJobModel.h
//  BONJOB
//
//  Created by VISHAL-SETH on 8/22/17.
//  Copyright © 2017 Infoicon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetJobModel : NSObject
+(id)getModel;
@property(nonatomic,strong)NSMutableArray *responseDict;
-(NSMutableArray *)getResponse;
@end
