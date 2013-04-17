//
//  Clock.m
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 27.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "Clock.h"

@implementation Clock

- (void)dealloc
{
    [_name release];
    [_description release];
    [_hour release];
    [_min release];
    [_active release];
    [_mon release];
    [_tue release];
    [_wed release];
    [_thu release];
    [_fri release];
    [_sat release];
    [_sun release];
    [super dealloc];
}

@end
