//
//  DataManager.h
//  TaskNotifier
//
//  Created by Evgeniy Tka4enko on 12.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Remember.h"
#import "Clock.h"

@interface DataManager : NSObject

@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) NSMutableArray *remembers;

+ (DataManager *)sharedInstance;

- (void)getRemembersWithSucces:(void (^)(NSArray *notes))success
                  failture:(void (^)(NSError *error))failture;

- (void)getClocksWithSucces:(void (^)(NSArray *notes))success
                   failture:(void (^)(NSError *error))failture;

- (void)getNotesWithSucces:(void (^)(NSArray *notes))success
                      failture:(void (^)(NSError *error))failture;

+(NSInteger)initWithActiveNote :(NSInteger) activate;
+(void)saveNewRemember:(NSString *)name description:(NSString*)decription proritet:(NSInteger)prioritet;
+(BOOL)updateNewClock  :(NSString*)name description:(NSString*)description hour:(int)hours min:(int)min mon:(int)mon tue:(int)tue wen:(int)wen th:(int)th fri:(int)fri sut:(int)sut sun:(int)sun remind:(int)remind idx:(NSString*)idx;
@end
