//
//  DataManager.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface DataManager : NSObject

@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) NSNumber *idx;

+ (DataManager *)sharedInstance;

- (void)getNotesWithSucces:(void (^)(NSArray *notes))success
                  failture:(void (^)(NSError *error))failture;

+(void)saveNewRemember:(Note*)note;
+(void)updateNewRemember:(Note *)note;


@end
