//
//  NotificationsManager.m
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 30.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NotificationsManager.h"

@implementation NotificationsManager

static NSInteger dx = 0;

static NotificationsManager *sharedInstance = nil;

+ (NotificationsManager *)sharedInstance
{
    @synchronized(self)
    {
        if(!sharedInstance)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void)sinhronizeNotification:(NSArray *)clocks
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    for(Clock *clock in clocks)
    {
        [self addNotification:clock];
    }
    dx = 5;
}

- (void)addNotification:(Clock *)clock
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.timeZone  = [NSTimeZone systemTimeZone];
    notification.fireDate  = [[NSDate date] dateByAddingTimeInterval:5.0f + dx];
    notification.alertAction = clock.name;
    notification.alertBody = clock.description;
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    [notification release];
    
    dx+=2;
}

@end
