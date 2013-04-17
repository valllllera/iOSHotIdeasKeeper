//
//  DateManager.h
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 21.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    january = 1,
    february,
    march,
    april,
    may,
    june,
    july,
    august,
    september,
    october,
    november,
    december,
} Month;

@interface DateManager : NSObject

@property (nonatomic, retain, readonly) NSArray *years;
@property (nonatomic, retain, readonly) NSArray *daysArray;
@property (nonatomic, retain, readonly) NSArray *monthArray;
@property (nonatomic, retain, readonly) NSArray *minutesArray;
@property (nonatomic, retain, readonly) NSArray *hoursArray;


+ (DateManager *)sharedInstance;
-(NSArray *)generateDays:(NSInteger)days withCurrentYear:(NSInteger)currentYear;
+(NSArray *)generateRemindValues;
+(BOOL)insertNewClock  :(NSString*)name description:(NSString*)description hour:(int)hours min:(int)min mon:(int)mon tue:(int)tue wen:(int)wen th:(int)th fri:(int)fri sut:(int)sut sun:(int)sun remind:(int)remind;


@end
