//
//  Note.m
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 17.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "Remember.h"

@implementation Remember

- (void)dealloc
{
    [_name release];
    [_description release];
    [_date release];
    [_hour release];
    [_min release];
    [_prioritet release];
    [_active release];
    [super dealloc];
}

@end
