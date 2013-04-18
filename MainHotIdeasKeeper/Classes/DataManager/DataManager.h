//
//  DataManager.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) NSNumber *idx;

+ (DataManager *)sharedInstance;

- (void)getNotesWithSucces:(void (^)(NSArray *notes))success
                  failture:(void (^)(NSError *error))failture;

+(void)saveNewRemember:(NSString*)noteText ;
+(void)updateNewRemember:(NSString *)noteText;


@end
