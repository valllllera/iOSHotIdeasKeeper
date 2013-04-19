//
//  NSString+ExtString.m
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 19.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSString+ExtString.h"

@implementation NSString (ExtString)

- (NSDate *)dateDB
{
    NSDateFormatter *dateFromatterTwo = [[NSDateFormatter alloc] init];
    [dateFromatterTwo setDateFormat:@"yyyyMMddHHmm"];
    
    return [dateFromatterTwo dateFromString:self];
}


@end
