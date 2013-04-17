//
//  NotificationsManager.h
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 30.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationsManager : NSObject

+ (NotificationsManager *)sharedInstance;

- (void)sinhronizeNotification:(NSArray *)clocks;

@end
