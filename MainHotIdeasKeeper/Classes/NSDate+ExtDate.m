//
//  NSDate+ExtDate.m
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 19.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSDate+ExtDate.h"

@implementation NSDate (ExtDate)

-(NSString*)formatStringFromDb
{
    NSDateFormatter *dateFromatterThird = [[NSDateFormatter alloc] init];
    [dateFromatterThird setDateFormat:@"yyyy.MM.dd   HH:mm"];
    return [dateFromatterThird stringFromDate:self];
}

-(NSString *)saveStringToDb
{
    NSDateFormatter *dateFromatterThird = [[NSDateFormatter alloc] init];
    [dateFromatterThird setDateFormat:@"yyyyMMddHHmm"];
    return [dateFromatterThird stringFromDate:self];
}
@end
